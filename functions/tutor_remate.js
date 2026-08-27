/**
 * Remate Vertex del Tutor Inteligente: 1 o 2 réplicas tras elegir postura.
 * El caso y el contraste viven en el cliente (banco). Aquí solo el extra.
 */
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {generateText} = require("./lib/gemini_vertex");

const DAILY_QUOTA = 2;
const GLOBAL_DAY_CAP = 1200;
const MAX_WORDS = 80;
const CHIPS = {
  rector:
    "El docente pregunta qué haría si el rector o la coordinación " +
    "insisten en la postura que eligió. Responde solo ese giro.",
  norma:
    "El docente pide qué exige la norma o el referente MEN en ESTE caso, " +
    "en concreto. No resumas el decreto entero.",
};

const SYSTEM_PROMPT =
  "Eres un tutor breve de pedagogía y normativa educativa colombiana. " +
  "El docente ya vio el caso y el contraste del banco. Tú solo rematas. " +
  "Máximo 80 palabras. Cero saludos. Hasta 2 negritas **concepto**. " +
  "No inventes artículos. Si dudas, apóyate en la opción correcta del caso.";

/**
 * @return {string}
 */
function bogotaDay() {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "America/Bogota",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
}

/**
 * @param {unknown} raw
 * @param {number} max
 * @return {string}
 */
function clipText(raw, max) {
  const text = String(raw || "").replace(/\s+/g, " ").trim();
  if (!text) return "";
  return text.length > max ? text.slice(0, max) : text;
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} uid
 * @return {Promise<{remaining: number, day: string}>}
 */
async function reserveQuota(db, uid) {
  const day = bogotaDay();
  const ref = db.doc(`users/${uid}/usage/tutorRemate`);
  let remaining = 0;
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? snap.data() : {};
    const count = data.day === day ? Number(data.count || 0) : 0;
    if (count >= DAILY_QUOTA) {
      throw new HttpsError(
          "resource-exhausted",
          `Ya usaste los ${DAILY_QUOTA} remates de hoy. El caso sigue arriba.`,
      );
    }
    remaining = DAILY_QUOTA - count - 1;
    tx.set(ref, {
      day,
      count: count + 1,
      updatedAt: FieldValue.serverTimestamp(),
    }, {merge: true});
  });
  return {remaining, day};
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} uid
 * @param {string} day
 * @return {Promise<void>}
 */
async function releaseQuota(db, uid, day) {
  const ref = db.doc(`users/${uid}/usage/tutorRemate`);
  try {
    await db.runTransaction(async (tx) => {
      const snap = await tx.get(ref);
      if (!snap.exists) return;
      const data = snap.data() || {};
      if (data.day !== day) return;
      const count = Math.max(0, Number(data.count || 0) - 1);
      tx.set(ref, {
        day,
        count,
        updatedAt: FieldValue.serverTimestamp(),
      }, {merge: true});
    });
  } catch (err) {
    console.error("tutor_remate releaseQuota", err);
  }
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} day
 * @return {Promise<void>}
 */
async function reserveGlobalCall(db, day) {
  const ref = db.doc("tutorRemateMeta/daily");
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? snap.data() : {};
    const calls = data.day === day ? Number(data.geminiCalls || 0) : 0;
    if (calls >= GLOBAL_DAY_CAP) {
      throw new HttpsError(
          "resource-exhausted",
          "El remate llegó al tope del día. El caso del banco sigue válido.",
      );
    }
    tx.set(ref, {
      day,
      geminiCalls: calls + 1,
      updatedAt: FieldValue.serverTimestamp(),
    });
  });
}

exports.tutorConvoRemate = onCall(
    {
      region: "southamerica-east1",
      timeoutSeconds: 45,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 8,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError(
            "unauthenticated",
            "Inicia sesión para el remate del tutor.",
        );
      }
      const provider = request.auth.token?.firebase?.sign_in_provider;
      if (provider === "anonymous") {
        throw new HttpsError(
            "permission-denied",
            "Crea una cuenta (Google o correo) para el remate.",
        );
      }

      const uid = request.auth.uid;
      const db = getFirestore();
      const userSnap = await db.doc(`users/${uid}`).get();
      if (userSnap.data()?.isPremium !== true) {
        throw new HttpsError(
            "permission-denied",
            "El remate del tutor es una función Premium.",
        );
      }

      const data = request.data || {};
      const chipId = clipText(data.chipId, 24);
      const chipHint = CHIPS[chipId];
      if (!chipHint) {
        throw new HttpsError("invalid-argument", "Ese seguimiento no existe.");
      }
      const stem = clipText(data.stem, 4000);
      const caseContext = clipText(data.caseContext, 4000);
      const correctOption = clipText(data.correctOption, 600);
      const chosenOption = clipText(data.chosenOption, 600);
      if (stem.length < 12 || !correctOption || !chosenOption) {
        throw new HttpsError("invalid-argument", "Faltan datos del caso.");
      }

      const quota = await reserveQuota(db, uid);
      const day = quota.day;
      try {
        await reserveGlobalCall(db, day);
      } catch (err) {
        await releaseQuota(db, uid, day);
        throw err;
      }

      const caso = caseContext ? `${caseContext}\n\n${stem}` : stem;
      const userPrompt =
        `[El Caso]\n${caso}\n\n` +
        `[La Opción Correcta]\n${correctOption}\n\n` +
        `[La Postura que eligió]\n${chosenOption}\n\n` +
        `[Seguimiento]\n${chipHint}`;

      // Tras llamar a Vertex no se devuelve el cupo: un 200 vacío o un
      // 429 ya se pudo cobrar; reintentar inflaría la factura.
      try {
        const text = await generateText(SYSTEM_PROMPT, userPrompt, {
          maxOutputTokens: 400,
          maxWords: MAX_WORDS,
        });
        if (!text || text.split(/\s+/).length < 8) {
          console.error("tutor_remate texto corto (cupo conservado)");
          throw new HttpsError(
              "unavailable",
              "El remate salió vacío. El contraste del caso sigue arriba.",
          );
        }
        return {text, remaining: quota.remaining};
      } catch (err) {
        if (err instanceof HttpsError || err?.httpErrorCode) throw err;
        console.error("tutor_remate generate", err);
        throw new HttpsError(
            "unavailable",
            "No pudimos generar el remate. El caso y el contraste siguen.",
        );
      }
    },
);
