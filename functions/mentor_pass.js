/**
 * Pase Mentor IA: checkout Wompi de un tiro (19.900 COP / 30 días).
 * No toca isPremium. Sin débito automático.
 */
const crypto = require("crypto");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {defineSecret} = require("firebase-functions/params");
const {getFirestore, FieldValue, Timestamp} = require("firebase-admin/firestore");
const pass = require("./lib/mentor_pass_core");

const wompiPublicKey = defineSecret("WOMPI_PUBLIC_KEY");
const wompiIntegritySecret = defineSecret("WOMPI_INTEGRITY_SECRET");
const APP_URL = "https://www.tuplazadocente.com";
const WOMPI_CHECKOUT_BASE = "https://checkout.wompi.co/p/";

/**
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
 * Activa o extiende 30 días el pase. No modifica Premium de convocatoria.
 * @param {{uid: string, transactionId: string, reference: string}} args
 * @return {Promise<void>}
 */
async function applyMentorPass(args) {
  const db = getFirestore();
  const userRef = db.collection("users").doc(String(args.uid));
  const txId = String(args.transactionId || "");
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(userRef);
    const data = snap.exists ? (snap.data() || {}) : {};
    const already = String(data.mentorPassPaymentId || "");
    if (txId && already === txId) {
      return;
    }
    const expires = pass.nextPassExpiry(data.mentorPassExpiresAt);
    tx.set(userRef, {
      mentorPassExpiresAt: Timestamp.fromDate(expires),
      mentorPassActivatedAt: Timestamp.fromDate(new Date()),
      mentorPassSource: "wompi",
      mentorPassPaymentId: txId,
      mentorPassReference: args.reference || null,
    }, {merge: true});
  });
}

exports.MENTOR_AMOUNT_CENTS = pass.MENTOR_AMOUNT_CENTS;
exports.MENTOR_PRICE_COP = pass.MENTOR_PRICE_COP;
exports.isMentorReference = pass.isMentorReference;
exports.applyMentorPass = applyMentorPass;

exports.createMentorPassCheckout = onCall(
    {
      region: "southamerica-east1",
      secrets: [wompiPublicKey, wompiIntegritySecret],
      timeoutSeconds: 30,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError(
            "unauthenticated",
            "Inicia sesión para activar el Mentor IA.",
        );
      }
      if (request.auth.token?.firebase?.sign_in_provider === "anonymous") {
        throw new HttpsError(
            "permission-denied",
            "Crea una cuenta (Google o correo) para pagar el pase.",
        );
      }
      const uid = request.auth.uid;
      const userSnap = await getFirestore().collection("users").doc(uid).get();
      if (userSnap.data()?.isPremium !== true) {
        throw new HttpsError(
            "permission-denied",
            "El Mentor IA es un extra de Premium.",
        );
      }

      const publicKey = String(wompiPublicKey.value() || "").trim();
      const integritySecret = String(wompiIntegritySecret.value() || "").trim();
      if (!publicKey || !integritySecret) {
        throw new HttpsError(
            "failed-precondition",
            "Wompi no está configurado.",
        );
      }
      if (!publicKey.startsWith("pub_")) {
        throw new HttpsError(
            "failed-precondition",
            "WOMPI_PUBLIC_KEY no parece una llave pública.",
        );
      }

      const email = request.auth.token.email || null;
      const reference = `MENTOR_${uid}_${Date.now()}`;
      const currency = "COP";
      const amountCents = pass.MENTOR_AMOUNT_CENTS;
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
      params.set("redirect-url", `${APP_URL}/tutor?mentorPass=pending`);
      if (email) params.set("customer-data:email", email);

      const initPoint = `${WOMPI_CHECKOUT_BASE}?${params.toString()}`;
      try {
        await getFirestore().collection("payments").doc(reference).set({
          uid,
          reference,
          sku: "mentor_pass",
          provider: "wompi",
          status: "created",
          amount: pass.MENTOR_PRICE_COP,
          amountInCents: amountCents,
          currency,
          email: email || null,
          createdAt: FieldValue.serverTimestamp(),
        }, {merge: true});
      } catch (persistError) {
        console.error("createMentorPassCheckout persist", persistError);
      }

      return {
        preferenceId: reference,
        reference,
        initPoint,
        amountInCents: amountCents,
        amountCop: pass.MENTOR_PRICE_COP,
      };
    },
);
