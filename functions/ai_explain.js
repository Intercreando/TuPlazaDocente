/**
 * Explicador de texto (Vertex / Gemini Flash-Lite) para un ítem fallado.
 * Cupo: 8/día por uid (America/Bogota). Sin voz.
 */
const crypto = require("crypto");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {generateExplanation} = require("./lib/gemini_vertex");

const DAILY_QUOTA = 8;
const GLOBAL_DAY_CAP = 2500;

/**
 * Fecha civil en Colombia (YYYY-MM-DD).
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
 * @param {string} text
 * @return {number}
 */
function wordCount(text) {
  const plain = String(text || "").replace(/\*+/g, " ").trim();
  if (!plain) return 0;
  return plain.split(/\s+/).filter(Boolean).length;
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} uid
 * @return {Promise<{remaining: number, day: string}>}
 */
async function reserveQuota(db, uid) {
  const day = bogotaDay();
  const ref = db.doc(`users/${uid}/usage/aiExplain`);
  let remaining = 0;
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? snap.data() : {};
    const count = data.day === day ? Number(data.count || 0) : 0;
    if (count >= DAILY_QUOTA) {
      throw new HttpsError(
          "resource-exhausted",
          `Ya usaste las ${DAILY_QUOTA} ampliaciones de hoy. Vuelven mañana.`,
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
  const ref = db.doc(`users/${uid}/usage/aiExplain`);
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
    console.error("ai_explain releaseQuota", err);
  }
}

/**
 * Reserva 1 llamada Gemini en el tope diario global (transacción).
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} day
 * @return {Promise<void>}
 */
async function reserveGlobalCall(db, day) {
  const ref = db.doc("aiExplainMeta/daily");
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? snap.data() : {};
    const calls = data.day === day ? Number(data.geminiCalls || 0) : 0;
    if (calls >= GLOBAL_DAY_CAP) {
      throw new HttpsError(
          "resource-exhausted",
          "El tutor llegó al tope del día. Vuelve mañana.",
      );
    }
    tx.set(ref, {
      day,
      geminiCalls: calls + 1,
      updatedAt: FieldValue.serverTimestamp(),
    });
  });
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} day
 * @return {Promise<void>}
 */
async function releaseGlobalCall(db, day) {
  const ref = db.doc("aiExplainMeta/daily");
  try {
    await db.runTransaction(async (tx) => {
      const snap = await tx.get(ref);
      if (!snap.exists) return;
      const data = snap.data() || {};
      if (data.day !== day) return;
      const calls = Math.max(0, Number(data.geminiCalls || 0) - 1);
      tx.set(ref, {
        day,
        geminiCalls: calls,
        updatedAt: FieldValue.serverTimestamp(),
      });
    });
  } catch (err) {
    console.error("ai_explain releaseGlobalCall", err);
  }
}

exports.explainPracticeItem = onCall(
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
            "Inicia sesión para ampliar la explicación.",
        );
      }
      const provider = request.auth.token?.firebase?.sign_in_provider;
      if (provider === "anonymous") {
        throw new HttpsError(
            "permission-denied",
            "Crea una cuenta (Google o correo) para usar el tutor.",
        );
      }

      const uid = request.auth.uid;
      const db = getFirestore();
      const userSnap = await db.doc(`users/${uid}`).get();
      if (userSnap.data()?.isPremium !== true) {
        throw new HttpsError(
            "permission-denied",
            "La ampliación con tutor es una función Premium.",
        );
      }

      const data = request.data || {};
      const questionId = clipText(data.questionId, 80);
      const stem = clipText(data.stem, 4000);
      const caseContext = clipText(data.caseContext, 4000);
      const correctOption = clipText(data.correctOption, 600);
      const chosenOption = clipText(data.chosenOption, 600);
      if (!questionId || stem.length < 12 || !correctOption || !chosenOption) {
        throw new HttpsError("invalid-argument", "Faltan datos del ítem.");
      }
      if (correctOption.toLowerCase() === chosenOption.toLowerCase()) {
        throw new HttpsError(
            "failed-precondition",
            "La ampliación es para cuando la opción marcada no es la mejor.",
        );
      }

      const day = bogotaDay();

      const cacheSeed =
        `${questionId}|${stem}|${correctOption}|${chosenOption}`;
      const cacheId = crypto.createHash("sha256")
          .update(cacheSeed)
          .digest("hex")
          .slice(0, 40);
      const cacheRef = db.doc(`aiExplainCache/${cacheId}`);
      const cacheSnap = await cacheRef.get();
      const cachedText = clipText(cacheSnap.data()?.text, 2000);

      const quota = await reserveQuota(db, uid);

      if (cachedText && wordCount(cachedText) > 8) {
        return {
          text: cachedText,
          remaining: quota.remaining,
          cached: true,
        };
      }

      const caso = caseContext ? `${caseContext}\n\n${stem}` : stem;
      const userPrompt =
        `[El Caso]\n${caso}\n\n` +
        `[La Opción Correcta]\n${correctOption}\n\n` +
        `[La Opción Incorrecta que eligió]\n${chosenOption}`;

      try {
        await reserveGlobalCall(db, day);
      } catch (err) {
        await releaseQuota(db, uid, quota.day);
        throw err;
      }

      try {
        const text = await generateExplanation(userPrompt);
        if (wordCount(text) < 8) {
          throw new HttpsError(
              "unavailable",
              "La ampliación salió vacía. Intenta de nuevo.",
          );
        }
        await cacheRef.set({
          questionId,
          text,
          createdAt: FieldValue.serverTimestamp(),
        });
        return {text, remaining: quota.remaining, cached: false};
      } catch (err) {
        await releaseGlobalCall(db, day);
        await releaseQuota(db, uid, quota.day);
        if (err instanceof HttpsError || err?.httpErrorCode) throw err;
        console.error("ai_explain generate", err);
        throw new HttpsError(
            "unavailable",
            "No pudimos generar la ampliación. Intenta de nuevo en un momento.",
        );
      }
    },
);
