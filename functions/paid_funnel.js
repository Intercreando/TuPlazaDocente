/**
 * Embudo de pauta: marca la cuenta y calcula el precio de bienvenida.
 * El cliente no puede alargar la oferta ni quitarse la cohorte.
 */
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getAuth} = require("firebase-admin/auth");
const {getFirestore, FieldValue, Timestamp} = require("firebase-admin/firestore");

const LIST_PRICE_COP = 89900;
const WELCOME_PRICE_COP = 69900;
const WELCOME_HOURS = 24;
const MAX_ACCOUNT_AGE_MS = 48 * 60 * 60 * 1000;

/**
 * @param {unknown} value
 * @return {Date|null}
 */
function toDate(value) {
  if (!value) return null;
  if (value instanceof Date) return value;
  if (typeof value.toDate === "function") return value.toDate();
  if (typeof value === "string") {
    const d = new Date(value);
    return Number.isNaN(d.getTime()) ? null : d;
  }
  if (typeof value.seconds === "number") {
    return new Date(value.seconds * 1000);
  }
  return null;
}

/**
 * Precio Wompi: bienvenida 24 h o código promo, el menor.
 * @param {FirebaseFirestore.DocumentData|undefined} userData
 * @return {{priceCop: number, source: string, welcomeActive: boolean}}
 */
function resolvePremiumPrice(userData) {
  const data = userData || {};
  let priceCop = LIST_PRICE_COP;
  let source = "list";
  const exp = toDate(data.welcomeOfferExpiresAt);
  const welcomeActive = !!exp && exp.getTime() > Date.now();
  if (welcomeActive) {
    priceCop = WELCOME_PRICE_COP;
    source = data.acquiredViaPaid === true ? "welcome_24h" : "founder_48h";
  }

  const pending = data.pendingPromoDiscount || null;
  if (pending && pending.type === "discount") {
    const pct = Math.min(99, Math.max(1, Number(pending.percent) || 0));
    if (pct > 0) {
      let promoPrice = Math.round(LIST_PRICE_COP * (100 - pct) / 100);
      if (promoPrice < 1000) promoPrice = 1000;
      if (promoPrice < priceCop) {
        priceCop = promoPrice;
        source = "promo";
      }
    }
  }
  return {priceCop, source, welcomeActive};
}

exports.resolvePremiumPrice = resolvePremiumPrice;
exports.LIST_PRICE_COP = LIST_PRICE_COP;

/** Tope barato por uid: evita spam, no reintenta ni se llama a sí misma. */
const RATE_WINDOW_MS = 10 * 60 * 1000;
const RATE_MAX_PER_UID = 8;
/** @type {Map<string, {t: number, n: number}>} */
const claimHits = new Map();

/**
 * @param {string} uid
 * @return {boolean}
 */
function isClaimRateLimited(uid) {
  const key = uid || "unknown";
  const now = Date.now();
  if (claimHits.size > 2000) claimHits.clear();
  const rec = claimHits.get(key);
  if (!rec || now - rec.t > RATE_WINDOW_MS) {
    claimHits.set(key, {t: now, n: 1});
    return false;
  }
  rec.n += 1;
  return rec.n > RATE_MAX_PER_UID;
}

/**
 * Marca la cuenta como adquirida por pauta (idempotente).
 * Solo cuentas nuevas (< 48 h) y no anónimas.
 */
exports.claimPaidAcquisition = onCall(
    {
      region: "southamerica-east1",
      timeoutSeconds: 15,
      memory: "128MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError(
            "unauthenticated",
            "Inicia sesión para continuar.",
        );
      }
      const provider = request.auth.token.firebase?.sign_in_provider;
      if (provider === "anonymous") {
        throw new HttpsError(
            "failed-precondition",
            "Crea tu cuenta (Google o correo) para la oferta de bienvenida.",
        );
      }

      const uid = request.auth.uid;
      if (isClaimRateLimited(uid)) {
        throw new HttpsError(
            "resource-exhausted",
            "Demasiados intentos. Espera un momento.",
        );
      }
      try {
        const user = await getAuth().getUser(uid);
        const createdMs = Date.parse(user.metadata.creationTime || "");
        const db = getFirestore();
        const ref = db.collection("users").doc(uid);
        const snap = await ref.get();
        const data = snap.exists ? (snap.data() || {}) : {};

        if (data.acquiredViaPaid === true && data.welcomeOfferExpiresAt) {
          const exp = toDate(data.welcomeOfferExpiresAt);
          return {
            ok: true,
            already: true,
            acquiredViaPaid: true,
            welcomeOfferExpiresAt: exp ? exp.toISOString() : null,
          };
        }

        if (!Number.isFinite(createdMs) ||
            (Date.now() - createdMs) > MAX_ACCOUNT_AGE_MS) {
          throw new HttpsError(
              "failed-precondition",
              "Esta cuenta no corresponde a un registro nuevo de campaña.",
          );
        }

        const expires = Timestamp.fromDate(
            new Date(Date.now() + WELCOME_HOURS * 60 * 60 * 1000),
        );
        await ref.set({
          acquiredViaPaid: true,
          welcomeOfferExpiresAt: expires,
          paidAcquisitionAt: FieldValue.serverTimestamp(),
          reminderOfferSent: false,
        }, {merge: true});

        return {
          ok: true,
          already: false,
          acquiredViaPaid: true,
          welcomeOfferExpiresAt: expires.toDate().toISOString(),
        };
      } catch (e) {
        if (e instanceof HttpsError) throw e;
        console.error("claimPaidAcquisition", e);
        throw new HttpsError(
            "internal",
            "No se pudo registrar la oferta de bienvenida. Intenta de nuevo.",
        );
      }
    },
);
