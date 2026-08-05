/**
 * Panel admin de códigos promocionales (solo emails allowlist).
 */
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");

/** Correos con acceso al panel (minúsculas). */
const ADMIN_EMAILS = new Set([
  "elkinoswa@gmail.com",
]);

function assertAdmin(request) {
  if (!request.auth?.uid) {
    throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
  }
  const email = String(request.auth.token?.email || "").trim().toLowerCase();
  if (!ADMIN_EMAILS.has(email)) {
    throw new HttpsError("permission-denied", "No autorizado.");
  }
  return email;
}

function normalizeCode(raw) {
  return String(raw || "").trim().toUpperCase();
}

/**
 * Crea o actualiza un código promocional.
 * type: "grant" (Premium gratis) | "discount" (% off en Wompi)
 */
exports.adminUpsertPromoCode = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      const adminEmail = assertAdmin(request);
      const code = normalizeCode(request.data?.code);
      if (!/^[A-Z0-9_-]{4,32}$/.test(code)) {
        throw new HttpsError(
            "invalid-argument",
            "Código inválido (4–32: letras, números, _ o -).",
        );
      }

      let type = String(request.data?.type || "grant").toLowerCase();
      let discountPercent = Number(request.data?.discountPercent) || 0;
      if (type === "discount") {
        if (discountPercent < 1 || discountPercent > 100) {
          throw new HttpsError(
              "invalid-argument",
              "El descuento debe estar entre 1 y 100.",
          );
        }
        if (discountPercent >= 100) {
          type = "grant";
          discountPercent = 0;
        }
      } else {
        type = "grant";
        discountPercent = 0;
      }

      const maxRedemptions = Number(request.data?.maxRedemptions);
      const max = Number.isFinite(maxRedemptions) && maxRedemptions > 0 ?
        Math.floor(maxRedemptions) :
        0;
      const note = request.data?.note ?
        String(request.data.note).slice(0, 200) :
        null;

      const db = getFirestore();
      const ref = db.collection("promoCodes").doc(code);
      const snap = await ref.get();

      // En actualización, conservar active si no viene en el request.
      let active;
      if (request.data?.active === false) {
        active = false;
      } else if (request.data?.active === true) {
        active = true;
      } else if (snap.exists) {
        active = snap.data()?.active === true;
      } else {
        active = true;
      }

      let expiresAt = null;
      if (request.data?.expiresAtMs) {
        const ms = Number(request.data.expiresAtMs);
        if (Number.isFinite(ms) && ms > Date.now()) {
          expiresAt = new Date(ms);
        }
      }

      const payload = {
        code,
        type,
        discountPercent,
        active,
        maxRedemptions: max,
        note,
        updatedAt: FieldValue.serverTimestamp(),
        updatedBy: adminEmail,
      };
      if (expiresAt) {
        payload.expiresAt = expiresAt;
      }
      if (!snap.exists) {
        payload.redeemedCount = 0;
        payload.createdAt = FieldValue.serverTimestamp();
      }
      await ref.set(payload, {merge: true});

      return {
        ok: true,
        code,
        type,
        discountPercent,
        maxRedemptions: max,
        active,
        created: !snap.exists,
      };
    },
);

/** Lista códigos (más recientes primero). */
exports.adminListPromoCodes = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      assertAdmin(request);
      const snap = await getFirestore()
          .collection("promoCodes")
          .limit(120)
          .get();

      const items = snap.docs.map((doc) => {
        const d = doc.data() || {};
        return {
          code: d.code || doc.id,
          type: d.type || "grant",
          discountPercent: Number(d.discountPercent) || 0,
          active: d.active === true,
          maxRedemptions: Number(d.maxRedemptions) || 0,
          redeemedCount: Number(d.redeemedCount) || 0,
          note: d.note || null,
          expiresAtMs: d.expiresAt && typeof d.expiresAt.toMillis === "function" ?
            d.expiresAt.toMillis() :
            null,
          updatedAtMs: d.updatedAt && typeof d.updatedAt.toMillis === "function" ?
            d.updatedAt.toMillis() :
            0,
        };
      });
      items.sort((a, b) => (b.updatedAtMs || 0) - (a.updatedAtMs || 0));
      return {ok: true, items: items.slice(0, 80)};
    },
);

/** Activa o desactiva un código. */
exports.adminSetPromoCodeActive = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      assertAdmin(request);
      const code = normalizeCode(request.data?.code);
      if (!code) {
        throw new HttpsError("invalid-argument", "Código inválido.");
      }
      const active = request.data?.active === true;
      const ref = getFirestore().collection("promoCodes").doc(code);
      const snap = await ref.get();
      if (!snap.exists) {
        throw new HttpsError("not-found", "Código no encontrado.");
      }
      await ref.set({
        active,
        updatedAt: FieldValue.serverTimestamp(),
        updatedBy: String(request.auth.token.email || "").toLowerCase(),
      }, {merge: true});
      return {ok: true, code, active};
    },
);

/**
 * Elimina un código. Solo permite borrar códigos desactivados (active=false).
 */
exports.adminDeletePromoCode = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
    },
    async (request) => {
      assertAdmin(request);
      const code = normalizeCode(request.data?.code);
      if (!code) {
        throw new HttpsError("invalid-argument", "Código inválido.");
      }
      const ref = getFirestore().collection("promoCodes").doc(code);
      const snap = await ref.get();
      if (!snap.exists) {
        throw new HttpsError("not-found", "Código no encontrado.");
      }
      if (snap.data()?.active === true) {
        throw new HttpsError(
            "failed-precondition",
            "Desactiva el código antes de borrarlo.",
        );
      }
      await ref.delete();
      return {ok: true, code, deleted: true};
    },
);

module.exports.ADMIN_EMAILS = ADMIN_EMAILS;
