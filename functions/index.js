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
const VALID_PREMIUM_CODES = new Set([
  "PLAZA2026",
  "DOCENTE-REY",
  "TUPLAZA-PREMIUM",
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
      timeoutSeconds: 30,
      memory: "256MiB",
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión para pagar.");
      }

      const uid = request.auth.uid;
      const email = request.auth.token.email || null;
      const publicKey = String(wompiPublicKey.value() || "").trim();
      const integritySecret = String(wompiIntegritySecret.value() || "").trim();
      if (!publicKey || !integritySecret) {
        throw new HttpsError(
            "failed-precondition",
            "Wompi no está configurado (WOMPI_PUBLIC_KEY / WOMPI_INTEGRITY_SECRET).",
        );
      }
      if (!publicKey.startsWith("pub_")) {
        throw new HttpsError(
            "failed-precondition",
            "WOMPI_PUBLIC_KEY no parece una llave pública (debe iniciar con pub_test_ o pub_prod_).",
        );
      }

      try {
        // Referencia única; incluye uid para recuperar Premium si falla el doc payments.
        const reference = `TPD_${uid}_${Date.now()}`;
        const currency = "COP";
        const integrity = wompiIntegritySignature(
            reference,
            PREMIUM_AMOUNT_CENTS,
            currency,
            integritySecret,
        );

        const params = new URLSearchParams();
        params.set("public-key", publicKey);
        params.set("currency", currency);
        params.set("amount-in-cents", String(PREMIUM_AMOUNT_CENTS));
        params.set("reference", reference);
        params.set("signature:integrity", integrity);
        params.set("redirect-url", `${APP_URL}/premium?status=pending`);
        if (email) {
          params.set("customer-data:email", email);
        }

        const initPoint = `${WOMPI_CHECKOUT_BASE}?${params.toString()}`;
        console.log("createPremiumCheckout ok", {uid, reference, hasEmail: Boolean(email)});

        // No bloqueamos el checkout si falla el registro (permisos / latencia).
        try {
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
        } catch (persistError) {
          console.error("createPremiumCheckout persist warning", persistError);
        }

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
 * Webhook Wompi: activa isPremium si status APPROVED.
 * Resuelve uid desde payments/{reference} o desde referencia TPD_{uid}_{timestamp}.
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

        const eventsSecret = String(wompiEventsSecret.value() || "").trim();
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
          try {
            const paySnap = await payRef.get();
            if (paySnap.exists) {
              uid = paySnap.data()?.uid || null;
            }
          } catch (e) {
            console.error("wompiWebhook read payment", e);
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
          }, {merge: true}).catch((e) => {
            console.error("wompiWebhook persist payment", e);
          });
        }

        // Fallback: buscar usuario por email del comprobante.
        if (!uid && tx.customer_email) {
          try {
            const users = await getFirestore().collection("users")
                .where("email", "==", String(tx.customer_email))
                .limit(1)
                .get();
            if (!users.empty) uid = users.docs[0].id;
          } catch (e) {
            console.error("wompiWebhook email lookup", e);
          }
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
          console.log("wompiWebhook premium activated", {uid, reference});
        } else {
          console.log("wompiWebhook skip activate", {status, uid, amountOk, reference});
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
        premiumSource: "code",
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
