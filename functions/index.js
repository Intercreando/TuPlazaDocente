/**
 * Cloud Functions TuPlazaDocente:
 * - createPremiumCheckout / wompiWebhook: pagos Wompi
 * - activatePremiumCode: códigos Premium
 * - registerPremiumDevice / checkPremiumDevice: cupo de dispositivos
 * - submitTestimonial: opiniones de comunidad (moderación)
 * - sendStreakReminders: recordatorio diario de racha (FCM)
 */
const crypto = require("crypto");
const {onCall, onRequest, HttpsError} = require("firebase-functions/v2/https");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {defineSecret} = require("firebase-functions/params");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {getMessaging} = require("firebase-admin/messaging");
const promoAdmin = require("./promo_admin");

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
/** Cupo de dispositivos concurrentes por cuenta Premium. */
const MAX_PREMIUM_DEVICES = 3;

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
        const db = getFirestore();
        const userSnap = await db.collection("users").doc(uid).get();
        const pending = userSnap.exists ? (userSnap.data()?.pendingPromoDiscount || null) : null;

        let priceCop = PREMIUM_PRICE_COP;
        let amountCents = PREMIUM_AMOUNT_CENTS;
        let appliedPromo = null;
        if (pending && pending.type === "discount") {
          const pct = Math.min(99, Math.max(1, Number(pending.percent) || 0));
          if (pct > 0) {
            priceCop = Math.round(PREMIUM_PRICE_COP * (100 - pct) / 100);
            if (priceCop < 1000) priceCop = 1000;
            amountCents = priceCop * 100;
            appliedPromo = {
              code: pending.code || null,
              percent: pct,
            };
          }
        }

        // Referencia única; incluye uid para recuperar Premium si falla el doc payments.
        const reference = `TPD_${uid}_${Date.now()}`;
        const currency = "COP";
        const integrity = wompiIntegritySignature(
            reference,
            amountCents,
            currency,
            integritySecret,
        );

        const params = new URLSearchParams();
        params.set("public-key", publicKey);
        params.set("currency", currency);
        params.set("amount-in-cents", String(amountCents));
        params.set("reference", reference);
        params.set("signature:integrity", integrity);
        params.set("redirect-url", `${APP_URL}/premium?status=pending`);
        if (email) {
          params.set("customer-data:email", email);
        }

        const initPoint = `${WOMPI_CHECKOUT_BASE}?${params.toString()}`;
        console.log("createPremiumCheckout ok", {
          uid,
          reference,
          amountCents,
          promo: appliedPromo?.code || null,
        });

        // No bloqueamos el checkout si falla el registro (permisos / latencia).
        try {
          await db.collection("payments").doc(reference).set({
            uid,
            reference,
            provider: "wompi",
            status: "created",
            amount: priceCop,
            amountInCents: amountCents,
            currency,
            email: email || null,
            promoCode: appliedPromo?.code || null,
            discountPercent: appliedPromo?.percent || null,
            createdAt: FieldValue.serverTimestamp(),
          }, {merge: true});
        } catch (persistError) {
          console.error("createPremiumCheckout persist warning", persistError);
        }

        return {
          preferenceId: reference,
          reference,
          initPoint,
          amountInCents: amountCents,
          amountCop: priceCop,
          listPriceCop: PREMIUM_PRICE_COP,
          discountPercent: appliedPromo?.percent || 0,
          promoCode: appliedPromo?.code || null,
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
        let expectedAmountCents = PREMIUM_AMOUNT_CENTS;
        if (reference) {
          const payRef = getFirestore().collection("payments").doc(reference);
          try {
            const paySnap = await payRef.get();
            if (paySnap.exists) {
              const payData = paySnap.data() || {};
              uid = payData.uid || null;
              if (payData.amountInCents != null) {
                expectedAmountCents = Number(payData.amountInCents);
              }
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
          Number(amountInCents) === Number(expectedAmountCents);

        if (status === "APPROVED" && uid && amountOk) {
          await getFirestore().collection("users").doc(String(uid)).set({
            isPremium: true,
            premiumActivatedAt: FieldValue.serverTimestamp(),
            premiumSource: "wompi",
            premiumPaymentId: String(tx.id),
            premiumReference: reference || null,
            pendingPromoDiscount: FieldValue.delete(),
          }, {merge: true});
          console.log("wompiWebhook premium activated", {uid, reference, amountInCents});
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
 * Activa Premium con código promocional (colección promoCodes).
 * El cliente no puede auto-asignarse Premium.
 */
exports.activatePremiumCode = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
      }
      if (request.auth.token.firebase?.sign_in_provider === "anonymous") {
        throw new HttpsError(
            "failed-precondition",
            "Guarda tu cuenta (Google o correo) antes de canjear un código.",
        );
      }

      const uid = request.auth.uid;
      const code = String(request.data?.code || "").trim().toUpperCase();
      if (!/^[A-Z0-9_-]{4,32}$/.test(code)) {
        throw new HttpsError("invalid-argument", "Código inválido.");
      }

      const db = getFirestore();
      const codeRef = db.collection("promoCodes").doc(code);
      const userRef = db.collection("users").doc(uid);
      const redemptionRef = codeRef.collection("redemptions").doc(uid);

      try {
        await db.runTransaction(async (tx) => {
          const codeSnap = await tx.get(codeRef);
          if (!codeSnap.exists) {
            throw new HttpsError("invalid-argument", "Código inválido.");
          }
          const data = codeSnap.data() || {};
          if (data.active !== true) {
            throw new HttpsError("failed-precondition", "Este código ya no está activo.");
          }
          if (data.expiresAt && typeof data.expiresAt.toMillis === "function") {
            if (data.expiresAt.toMillis() < Date.now()) {
              throw new HttpsError("failed-precondition", "Este código expiró.");
            }
          }
          const max = Number(data.maxRedemptions) || 0;
          const used = Number(data.redeemedCount) || 0;
          if (max > 0 && used >= max) {
            throw new HttpsError(
                "resource-exhausted",
                "Este código ya alcanzó el máximo de usos.",
            );
          }

          const redSnap = await tx.get(redemptionRef);
          if (redSnap.exists) {
            throw new HttpsError(
                "already-exists",
                "Ya canjeaste este código en esta cuenta.",
            );
          }

          tx.set(redemptionRef, {
            uid,
            redeemedAt: FieldValue.serverTimestamp(),
            type: (data.type === "discount" && Number(data.discountPercent) > 0 &&
              Number(data.discountPercent) < 100) ? "discount" : "grant",
            discountPercent: Number(data.discountPercent) || 0,
          });
          tx.update(codeRef, {
            redeemedCount: FieldValue.increment(1),
            lastRedeemedAt: FieldValue.serverTimestamp(),
          });

          const isDiscount = data.type === "discount" &&
            Number(data.discountPercent) > 0 &&
            Number(data.discountPercent) < 100;

          if (isDiscount) {
            const pct = Math.min(99, Math.max(1, Number(data.discountPercent)));
            tx.set(userRef, {
              pendingPromoDiscount: {
                code,
                type: "discount",
                percent: pct,
                appliedAt: FieldValue.serverTimestamp(),
              },
              premiumCode: code,
            }, {merge: true});
          } else {
            tx.set(userRef, {
              isPremium: true,
              premiumActivatedAt: FieldValue.serverTimestamp(),
              premiumSource: "promo_code",
              premiumCode: code,
              pendingPromoDiscount: FieldValue.delete(),
            }, {merge: true});
          }
        });
      } catch (error) {
        if (error instanceof HttpsError) throw error;
        console.error("activatePremiumCode transaction", error);
        throw new HttpsError(
            "internal",
            "No pudimos validar el código. Intenta de nuevo.",
        );
      }

      const finalSnap = await codeRef.get();
      const finalData = finalSnap.data() || {};
      const isDiscount = finalData.type === "discount" &&
        Number(finalData.discountPercent) > 0 &&
        Number(finalData.discountPercent) < 100;
      const percent = isDiscount ?
        Math.min(99, Math.max(1, Number(finalData.discountPercent))) :
        0;

      console.log("activatePremiumCode ok", {uid, code, isDiscount, percent});
      return {
        ok: true,
        code,
        type: isDiscount ? "discount" : "grant",
        discountPercent: percent,
      };
    },
);

/**
 * Registra un dispositivo Premium y expulsa los más antiguos si superan el cupo.
 */
exports.registerPremiumDevice = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
      }
      if (request.auth.token.firebase?.sign_in_provider === "anonymous") {
        return {ok: true, skipped: true, allowed: true, reason: "anonymous"};
      }

      const uid = request.auth.uid;
      const deviceId = String(request.data?.deviceId || "").trim();
      if (!/^[a-zA-Z0-9_-]{8,64}$/.test(deviceId)) {
        throw new HttpsError("invalid-argument", "deviceId inválido.");
      }
      const label = String(request.data?.label || "Dispositivo").slice(0, 120);
      const maxDevices = Math.min(
          Math.max(Number(request.data?.maxDevices) || MAX_PREMIUM_DEVICES, 1),
          5,
      );

      const db = getFirestore();
      const userRef = db.collection("users").doc(uid);
      const userSnap = await userRef.get();
      if (!userSnap.exists || userSnap.data()?.isPremium !== true) {
        return {ok: true, skipped: true, allowed: true, reason: "not_premium"};
      }

      const devicesCol = userRef.collection("devices");
      const deviceRef = devicesCol.doc(deviceId);
      const existing = await deviceRef.get();
      if (existing.exists) {
        await deviceRef.update({
          label,
          lastSeenAt: FieldValue.serverTimestamp(),
          revoked: false,
        });
      } else {
        await deviceRef.set({
          deviceId,
          label,
          platform: "web",
          revoked: false,
          createdAt: FieldValue.serverTimestamp(),
          lastSeenAt: FieldValue.serverTimestamp(),
        });
      }

      const all = await devicesCol.orderBy("lastSeenAt", "asc").get();
      const kicked = [];
      const overflow = all.size - maxDevices;
      if (overflow > 0) {
        const candidates = all.docs.filter((doc) => doc.id !== deviceId);
        for (let i = 0; i < overflow && i < candidates.length; i++) {
          kicked.push(candidates[i].id);
          await candidates[i].ref.delete();
        }
      }

      console.log("registerPremiumDevice", {
        uid,
        deviceId,
        kicked: kicked.length,
        maxDevices,
      });

      return {
        ok: true,
        allowed: true,
        maxDevices,
        kicked,
        activeCount: Math.min(all.size, maxDevices),
      };
    },
);

/**
 * Verifica si el dispositivo sigue activo en el cupo Premium.
 */
exports.checkPremiumDevice = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 15,
      memory: "256MiB",
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
      }
      if (request.auth.token.firebase?.sign_in_provider === "anonymous") {
        return {ok: true, skipped: true, allowed: true, reason: "anonymous"};
      }

      const uid = request.auth.uid;
      const deviceId = String(request.data?.deviceId || "").trim();
      if (!/^[a-zA-Z0-9_-]{8,64}$/.test(deviceId)) {
        throw new HttpsError("invalid-argument", "deviceId inválido.");
      }

      const db = getFirestore();
      const userRef = db.collection("users").doc(uid);
      const userSnap = await userRef.get();
      if (!userSnap.exists || userSnap.data()?.isPremium !== true) {
        return {ok: true, skipped: true, allowed: true, reason: "not_premium"};
      }

      const deviceRef = userRef.collection("devices").doc(deviceId);
      const deviceSnap = await deviceRef.get();
      if (!deviceSnap.exists || deviceSnap.data()?.revoked === true) {
        return {
          ok: true,
          allowed: false,
          reason: "revoked",
          message:
            "Esta cuenta Premium alcanzó el límite de dispositivos. " +
            "Cerramos la sesión en este equipo.",
          maxDevices: MAX_PREMIUM_DEVICES,
        };
      }

      await deviceRef.update({
        lastSeenAt: FieldValue.serverTimestamp(),
      });

      return {
        ok: true,
        allowed: true,
        maxDevices: MAX_PREMIUM_DEVICES,
      };
    },
);

/**
 * Recibe una opinión de usuario (queda pendiente de moderación).
 */
exports.submitTestimonial = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
      }
      if (request.auth.token.firebase?.sign_in_provider === "anonymous") {
        throw new HttpsError(
            "failed-precondition",
            "Guarda tu cuenta (Google o correo) para dejar una opinión.",
        );
      }

      const uid = request.auth.uid;
      const text = String(request.data?.text || "").trim();
      const displayName = String(request.data?.displayName || "").trim();
      const roleLabel = String(request.data?.roleLabel || "").trim();

      if (text.length < 20 || text.length > 400) {
        throw new HttpsError(
            "invalid-argument",
            "La opinión debe tener entre 20 y 400 caracteres.",
        );
      }
      if (displayName.length < 2 || displayName.length > 60) {
        throw new HttpsError("invalid-argument", "Nombre a mostrar inválido.");
      }

      const db = getFirestore();
      const weekAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
      const recent = await db.collection("testimonials")
          .where("uid", "==", uid)
          .where("createdAt", ">", weekAgo)
          .limit(1)
          .get();
      if (!recent.empty) {
        throw new HttpsError(
            "resource-exhausted",
            "Ya enviaste una opinión recientemente. Puedes intentar de nuevo en unos días.",
        );
      }

      await db.collection("testimonials").add({
        text,
        displayName,
        roleLabel: roleLabel || null,
        uid,
        source: "user",
        approved: false,
        createdAt: FieldValue.serverTimestamp(),
      });

      console.log("submitTestimonial ok", {uid, len: text.length});
      return {ok: true, pending: true};
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

exports.adminUpsertPromoCode = promoAdmin.adminUpsertPromoCode;
exports.adminListPromoCodes = promoAdmin.adminListPromoCodes;
exports.adminSetPromoCodeActive = promoAdmin.adminSetPromoCodeActive;
exports.adminDeletePromoCode = promoAdmin.adminDeletePromoCode;
