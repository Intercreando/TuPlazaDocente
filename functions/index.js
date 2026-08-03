/**
 * Cloud Functions TuPlazaDocente:
 * - createPremiumCheckout: crea checkout Wompi (Colombia)
 * - wompiWebhook: confirma pago y activa Premium
 * - sendStreakReminders: recordatorio diario de racha (FCM)
 */
const crypto = require("crypto");
const {onCall, onRequest, HttpsError} = require("firebase-functions/v2/https");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {defineSecret} = require("firebase-functions/params");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const {MsEdgeTTS, OUTPUT_FORMAT} = require("msedge-tts");

initializeApp();

/** Llave pública Wompi (pub_test_… / pub_prod_…). */
const wompiPublicKey = defineSecret("WOMPI_PUBLIC_KEY");
/** Secreto de integridad para firma del checkout. */
const wompiIntegritySecret = defineSecret("WOMPI_INTEGRITY_SECRET");
/** Secreto de eventos para validar webhooks. */
const wompiEventsSecret = defineSecret("WOMPI_EVENTS_SECRET");

const PREMIUM_PRICE_COP = 89900;
/** Wompi cobra en centavos: $89.900 COP → 8.990.000 centavos. */
const PREMIUM_AMOUNT_CENTS = PREMIUM_PRICE_COP * 100;
const APP_URL = "https://www.tuplazadocente.com";
const WOMPI_CHECKOUT_BASE = "https://checkout.wompi.co/p/";
const TTS_VOICE = "es-CO-SalomeNeural";
const TTS_MAX_CHARS = 1800;
const VALID_PREMIUM_CODES = new Set([
  "PLAZA2026",
  "DOCENTE-REY",
  "TUPLAZA-PREMIUM",
  "DEMO-LOCAL",
]);

/**
 * Firma de integridad del Web Checkout Wompi.
 * SHA256(reference + amountInCents + currency + integritySecret)
 * @param {string} reference
 * @param {number} amountInCents
 * @param {string} currency
 * @param {string} integritySecret
 * @return {string}
 */
function wompiIntegritySignature(reference, amountInCents, currency, integritySecret) {
  const raw = `${reference}${amountInCents}${currency}${integritySecret}`;
  return crypto.createHash("sha256").update(raw).digest("hex");
}

/**
 * Lee ruta tipo "transaction.id" dentro de un objeto.
 * @param {object} root
 * @param {string} path
 * @return {*}
 */
function readPath(root, path) {
  return String(path).split(".").reduce(
      (acc, key) => (acc == null ? undefined : acc[key]),
      root,
  );
}

/**
 * Valida checksum del evento Wompi (SHA256 de properties + timestamp + eventsSecret).
 * @param {object} eventBody
 * @param {string} eventsSecret
 * @return {boolean}
 */
function verifyWompiEvent(eventBody, eventsSecret) {
  const checksum = eventBody?.signature?.checksum ||
    null;
  const properties = eventBody?.signature?.properties;
  const timestamp = eventBody?.timestamp;
  if (!checksum || !Array.isArray(properties) || timestamp == null) {
    return false;
  }
  let concat = "";
  for (const prop of properties) {
    const value = readPath(eventBody.data, prop);
    if (value === undefined || value === null) return false;
    concat += String(value);
  }
  concat += String(timestamp);
  concat += eventsSecret;
  const computed = crypto.createHash("sha256").update(concat).digest("hex");
  return computed.toUpperCase() === String(checksum).toUpperCase();
}

/**
 * Crea checkout Premium autenticado (Wompi Web Checkout).
 */
exports.createPremiumCheckout = onCall(
    {
      region: "southamerica-east1",
      secrets: [wompiPublicKey, wompiIntegritySecret],
      cors: true,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión para pagar.");
      }

      const uid = request.auth.uid;
      const email = request.auth.token.email || null;
      const publicKey = wompiPublicKey.value();
      const integritySecret = wompiIntegritySecret.value();
      if (!publicKey || !integritySecret) {
        throw new HttpsError(
            "failed-precondition",
            "Wompi no está configurado (WOMPI_PUBLIC_KEY / WOMPI_INTEGRITY_SECRET).",
        );
      }

      try {
        const reference = `TPD_${uid}_${Date.now()}`;
        const currency = "COP";
        const integrity = wompiIntegritySignature(
            reference,
            PREMIUM_AMOUNT_CENTS,
            currency,
            integritySecret,
        );

        const params = new URLSearchParams({
          "public-key": publicKey,
          currency,
          "amount-in-cents": String(PREMIUM_AMOUNT_CENTS),
          reference,
          "signature:integrity": integrity,
          "redirect-url": `${APP_URL}/premium?status=pending`,
        });
        if (email) {
          params.set("customer-data:email", email);
        }

        const initPoint = `${WOMPI_CHECKOUT_BASE}?${params.toString()}`;

        await getFirestore().collection("payments").doc(reference).set({
          uid,
          reference,
          provider: "wompi",
          status: "created",
          amount: PREMIUM_PRICE_COP,
          amountInCents: PREMIUM_AMOUNT_CENTS,
          currency,
          email: email || null,
          createdAt: FieldValue.serverTimestamp(),
        }, {merge: true});

        return {
          preferenceId: reference,
          reference,
          initPoint,
          amountInCents: PREMIUM_AMOUNT_CENTS,
        };
      } catch (error) {
        console.error("createPremiumCheckout error", error);
        if (error instanceof HttpsError) throw error;
        throw new HttpsError(
            "internal",
            "No pudimos crear el checkout. Intenta de nuevo en unos minutos.",
        );
      }
    },
);

/**
 * Webhook Wompi (URL de eventos): activa isPremium al confirmar pago APPROVED.
 * Configura en el Dashboard Wompi (Sandbox y Producción por separado):
 * https://southamerica-east1-tuplazadocente-9334d.cloudfunctions.net/wompiWebhook
 */
exports.wompiWebhook = onRequest(
    {
      region: "southamerica-east1",
      secrets: [wompiEventsSecret],
      cors: false,
    },
    async (req, res) => {
      try {
        if (req.method !== "POST") {
          res.status(405).send("Method not allowed");
          return;
        }

        const body = typeof req.body === "string" ?
          JSON.parse(req.body) :
          (req.body || {});

        const eventsSecret = wompiEventsSecret.value();
        if (!eventsSecret) {
          console.error("WOMPI_EVENTS_SECRET vacío");
          res.status(500).send("misconfigured");
          return;
        }

        const headerChecksum = req.get("X-Event-Checksum");
        if (headerChecksum && body.signature) {
          body.signature.checksum = body.signature.checksum || headerChecksum;
        }

        if (!verifyWompiEvent(body, eventsSecret)) {
          console.warn("wompiWebhook: firma inválida");
          res.status(401).send("invalid signature");
          return;
        }

        if (body.event !== "transaction.updated") {
          res.status(200).send("OK");
          return;
        }

        const tx = body.data?.transaction;
        if (!tx?.id) {
          res.status(200).send("OK");
          return;
        }

        const status = String(tx.status || "").toUpperCase();
        const reference = String(tx.reference || "");
        const amountInCents = tx.amount_in_cents ?? null;

        let uid = null;
        if (reference) {
          const payRef = getFirestore().collection("payments").doc(reference);
          const paySnap = await payRef.get();
          if (paySnap.exists) {
            uid = paySnap.data()?.uid || null;
          }
          // Fallback: TPD_{uid}_{timestamp}
          if (!uid && reference.startsWith("TPD_")) {
            const parts = reference.split("_");
            if (parts.length >= 3) {
              uid = parts.slice(1, -1).join("_");
            }
          }

          await payRef.set({
            uid: uid || null,
            reference,
            provider: "wompi",
            transactionId: tx.id,
            status,
            amountInCents,
            currency: tx.currency || "COP",
            paymentMethodType: tx.payment_method_type || null,
            customerEmail: tx.customer_email || null,
            updatedAt: FieldValue.serverTimestamp(),
          }, {merge: true});
        }

        const amountOk = amountInCents == null ||
          Number(amountInCents) === PREMIUM_AMOUNT_CENTS;

        if (status === "APPROVED" && uid && amountOk) {
          await getFirestore().collection("users").doc(String(uid)).set({
            isPremium: true,
            premiumActivatedAt: FieldValue.serverTimestamp(),
            premiumSource: "wompi",
            premiumPaymentId: String(tx.id),
            premiumReference: reference || null,
          }, {merge: true});
        }

        res.status(200).send("OK");
      } catch (error) {
        console.error("wompiWebhook error", error);
        res.status(200).send("ERROR_LOGGED");
      }
    },
);

/**
 * Activa Premium con código (servidor). El cliente no puede auto-asignarse Premium.
 */
exports.activatePremiumCode = onCall(
    {
      region: "southamerica-east1",
      cors: true,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
      }
      const code = String(request.data?.code || "").trim().toUpperCase();
      if (!VALID_PREMIUM_CODES.has(code)) {
        throw new HttpsError("invalid-argument", "Código inválido.");
      }

      await getFirestore().collection("users").doc(request.auth.uid).set({
        isPremium: true,
        premiumActivatedAt: FieldValue.serverTimestamp(),
        premiumSource: code === "DEMO-LOCAL" ? "demo" : "code",
        premiumCode: code,
      }, {merge: true});

      return {ok: true, code};
    },
);

/**
 * Cron diario 19:00 America/Bogota: recuerda completar la racha.
 */
exports.sendStreakReminders = onSchedule(
    {
      schedule: "0 19 * * *",
      timeZone: "America/Bogota",
      region: "southamerica-east1",
    },
    async () => {
      const db = getFirestore();
      const snap = await db.collection("users")
          .where("streakRemindersEnabled", "==", true)
          .where("dailyCompletedToday", "==", false)
          .limit(200)
          .get();

      if (snap.empty) {
        console.log("Sin usuarios para recordar racha.");
        return;
      }

      const messaging = getMessaging();
      const tokens = [];
      snap.forEach((doc) => {
        const token = doc.data().fcmToken;
        if (typeof token === "string" && token.length > 10) {
          tokens.push(token);
        }
      });

      if (tokens.length === 0) {
        console.log("Usuarios con recordatorio, pero sin fcmToken.");
        return;
      }

      const response = await messaging.sendEachForMulticast({
        tokens,
        notification: {
          title: "TuPlazaDocente — Racha del día",
          body: "Te faltan 5 preguntas para no romper tu racha. Son ~10 minutos.",
        },
        webpush: {
          fcmOptions: {
            link: `${APP_URL}/app`,
          },
        },
      });

      console.log(
          `Recordatorios enviados: success=${response.successCount} failure=${response.failureCount}`,
      );
    },
);

/**
 * Escapa texto para SSML/XML.
 * @param {string} value
 * @return {string}
 */
function escapeXml(value) {
  return String(value)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&apos;");
}

/**
 * Suaviza el texto para una prosodia más natural.
 * @param {string} value
 * @return {string}
 */
function humanizeForSpeech(value) {
  return String(value)
      .replace(/\s+/g, " ")
      .replace(/·/g, ",")
      .replace(/\s*\|\s*/g, ". ")
      .replace(/\s*\/\s*/g, ", ")
      .replace(/\s{2,}/g, " ")
      .trim();
}

/**
 * Sintetiza voz neural (Edge Read Aloud) en español colombiano.
 * Requiere Auth (incluye anónimo). Devuelve MP3 en base64.
 */
exports.synthesizeSpeech = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 60,
      memory: "512MiB",
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError(
            "unauthenticated",
            "Debes tener sesión (invitado o cuenta) para usar la voz.",
        );
      }

      const raw = humanizeForSpeech(request.data?.text || "");
      if (!raw) {
        throw new HttpsError("invalid-argument", "No hay texto para leer.");
      }
      if (raw.length > TTS_MAX_CHARS) {
        throw new HttpsError(
            "invalid-argument",
            `El texto supera ${TTS_MAX_CHARS} caracteres.`,
        );
      }

      const voice = typeof request.data?.voice === "string" &&
        request.data.voice.includes("Neural")
        ? request.data.voice
        : TTS_VOICE;

      try {
        const tts = new MsEdgeTTS();
        await tts.setMetadata(
            voice,
            OUTPUT_FORMAT.AUDIO_24KHZ_48KBITRATE_MONO_MP3,
        );

        const safeText = escapeXml(raw);
        const {audioStream} = tts.toStream(safeText, {
          // Un poco más pausado y cálido que el default robótico.
          rate: "-8%",
          pitch: "-2Hz",
        });

        const chunks = [];
        for await (const chunk of audioStream) {
          chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk));
        }
        const audio = Buffer.concat(chunks);
        if (audio.length < 64) {
          throw new HttpsError("internal", "La síntesis no devolvió audio.");
        }

        return {
          contentType: "audio/mpeg",
          voice,
          base64: audio.toString("base64"),
        };
      } catch (e) {
        console.error("synthesizeSpeech error:", e);
        if (e instanceof HttpsError) throw e;
        throw new HttpsError(
            "internal",
            "No se pudo generar la voz neural. Intenta de nuevo.",
        );
      }
    },
);
