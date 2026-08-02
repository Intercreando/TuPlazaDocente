/**
 * Cloud Functions TuPlazaDocente:
 * - createPremiumCheckout: crea preferencia Mercado Pago
 * - mercadoPagoWebhook: confirma pago y activa Premium
 * - sendStreakReminders: recordatorio diario de racha (FCM)
 */
const {onCall, onRequest, HttpsError} = require("firebase-functions/v2/https");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {defineSecret} = require("firebase-functions/params");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const {MercadoPagoConfig, Preference, Payment} = require("mercadopago");
const {MsEdgeTTS, OUTPUT_FORMAT} = require("msedge-tts");

initializeApp();

const mpAccessToken = defineSecret("MP_ACCESS_TOKEN");

const PREMIUM_PRICE_COP = 89900;
const APP_URL = "https://tuplazadocente.com";
const TTS_VOICE = "es-CO-SalomeNeural";
const TTS_MAX_CHARS = 1800;
const VALID_PREMIUM_CODES = new Set([
  "PLAZA2026",
  "DOCENTE-REY",
  "TUPLAZA-PREMIUM",
  "DEMO-LOCAL",
]);

/**
 * @param {string} token
 * @return {MercadoPagoConfig}
 */
function mpClient(token) {
  return new MercadoPagoConfig({accessToken: token, options: {timeout: 8000}});
}

/**
 * Crea checkout Premium autenticado.
 */
exports.createPremiumCheckout = onCall(
    {
      region: "southamerica-east1",
      secrets: [mpAccessToken],
      cors: true,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión para pagar.");
      }

      const uid = request.auth.uid;
      const email = request.auth.token.email || null;
      const token = mpAccessToken.value();
      if (!token) {
        throw new HttpsError(
            "failed-precondition",
            "Mercado Pago no está configurado (MP_ACCESS_TOKEN).",
        );
      }

      try {
        const preference = new Preference(mpClient(token));
        const result = await preference.create({
          body: {
            items: [
              {
                id: "premium-convocatoria",
                title: "TuPlazaDocente Premium — Convocatoria",
                description:
                  "Acceso Premium por convocatoria: banco ilimitado, simulacros y radar avanzado.",
                quantity: 1,
                currency_id: "COP",
                unit_price: PREMIUM_PRICE_COP,
              },
            ],
            payer: email ? {email} : undefined,
            external_reference: uid,
            metadata: {
              uid,
              product: "premium_convocatoria",
            },
            back_urls: {
              success: `${APP_URL}/premium?status=success`,
              failure: `${APP_URL}/premium?status=failure`,
              pending: `${APP_URL}/premium?status=pending`,
            },
            auto_return: "approved",
            notification_url:
              `https://southamerica-east1-tuplazadocente-9334d.cloudfunctions.net/mercadoPagoWebhook`,
            statement_descriptor: "TUPLAZADOCENTE",
          },
        });

        const initPoint = result.init_point || result.sandbox_init_point;
        if (!initPoint) {
          throw new HttpsError("internal", "Mercado Pago no devolvió URL de pago.");
        }

        await getFirestore().collection("payments").doc(String(result.id)).set({
          uid,
          preferenceId: result.id,
          status: "created",
          amount: PREMIUM_PRICE_COP,
          currency: "COP",
          createdAt: FieldValue.serverTimestamp(),
        }, {merge: true});

        return {
          preferenceId: result.id,
          initPoint,
          sandboxInitPoint: result.sandbox_init_point || null,
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
 * Webhook Mercado Pago: activa isPremium al confirmar pago.
 */
exports.mercadoPagoWebhook = onRequest(
    {
      region: "southamerica-east1",
      secrets: [mpAccessToken],
      cors: false,
    },
    async (req, res) => {
      try {
        if (req.method !== "POST" && req.method !== "GET") {
          res.status(405).send("Method not allowed");
          return;
        }

        const type = req.query.type || req.body?.type || req.query.topic;
        const dataId = req.query["data.id"] ||
          req.body?.data?.id ||
          req.query.id;

        // Mercado Pago hace ping; respondemos 200 rápido si no hay pago.
        if (!dataId || (type && !String(type).includes("payment"))) {
          res.status(200).send("OK");
          return;
        }

        const token = mpAccessToken.value();
        const paymentApi = new Payment(mpClient(token));
        const payment = await paymentApi.get({id: String(dataId)});
        const status = payment.status;
        const uid = payment.external_reference || payment.metadata?.uid;

        await getFirestore().collection("payments").doc(String(dataId)).set({
          uid: uid || null,
          paymentId: dataId,
          status,
          amount: payment.transaction_amount || null,
          currency: payment.currency_id || "COP",
          rawStatusDetail: payment.status_detail || null,
          updatedAt: FieldValue.serverTimestamp(),
        }, {merge: true});

        if (status === "approved" && uid) {
          await getFirestore().collection("users").doc(String(uid)).set({
            isPremium: true,
            premiumActivatedAt: FieldValue.serverTimestamp(),
            premiumSource: "mercadopago",
            premiumPaymentId: String(dataId),
          }, {merge: true});
        }

        res.status(200).send("OK");
      } catch (error) {
        console.error("mercadoPagoWebhook error", error);
        // 200 para evitar reintentos infinitos agresivos; logueamos el fallo.
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
