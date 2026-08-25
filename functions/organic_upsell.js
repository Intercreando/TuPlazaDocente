/**
 * Upsell orgánico: Premium ~3 días después del registro con correo.
 * Reloj: organicWelcomeSentAt. No corre para pauta, Premium ni invitados.
 * Solo envía si ya entrenó (reto, práctica o diagnóstico).
 * Al enviar, sella welcomeOfferExpiresAt +48 h ($69.900).
 */
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {defineSecret} = require("firebase-functions/params");
const {getAuth} = require("firebase-admin/auth");
const {getFirestore, FieldValue, Timestamp} = require("firebase-admin/firestore");
const {Resend} = require("resend");

const resendApiKey = defineSecret("RESEND_API_KEY");

const APP_URL = "https://www.tuplazadocente.com";
/** Sin #/: Resend pierde el fragmento en el clic. /premium lo reescribe la PWA. */
const PREMIUM_CTA_URL = `${APP_URL}/premium`;
const FROM_EMAIL = "Equipo TuPlazaDocente <soporte@tuplazadocente.com>";
const SUBJECT = "Tienes 48 horas: Premium a $69.900 COP";
const OFFER_HOURS = 48;
const WINDOW_MAX_AGE_MS = 96 * 60 * 60 * 1000;
const WINDOW_MIN_AGE_MS = 72 * 60 * 60 * 1000;
const MAX_DOCS_PER_RUN = 120;

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
 * @param {string} raw
 * @return {string}
 */
function escapeHtml(raw) {
  return String(raw)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
}

/**
 * @param {unknown} value
 * @return {string|null}
 */
function normalizeEmail(value) {
  const email = String(value || "").trim().toLowerCase();
  if (!email.includes("@") || email.length > 160) return null;
  if (email.endsWith(".invalid") || email.includes(" ")) return null;
  return email;
}

/**
 * @param {unknown} raw
 * @return {string}
 */
function greetingName(raw) {
  const name = String(raw || "").trim();
  if (!name || name.toLowerCase() === "aspirante") return "docente";
  return name;
}

/**
 * @param {FirebaseFirestore.DocumentData} data
 * @return {boolean}
 */
function alreadyUpsold(data) {
  return data.upsellEmailSent === true || data.upsellEmailSentAt != null;
}

/**
 * Entrenó al menos una prueba gratis (reto, ítems o diagnóstico).
 * @param {FirebaseFirestore.DocumentData} data
 * @return {boolean}
 */
function hasFreeActivity(data) {
  if (data.diagnosticCompleted === true) return true;
  if (toDate(data.lastStreakDate)) return true;
  const totals = data.pillarTotal;
  if (!totals || typeof totals !== "object" || Array.isArray(totals)) {
    return false;
  }
  for (const value of Object.values(totals)) {
    const n = Number(value);
    if (Number.isFinite(n) && n > 0) return true;
  }
  return false;
}

/**
 * @param {FirebaseFirestore.DocumentData} data
 * @return {Date|null}
 */
function registrationClock(data) {
  return toDate(data.createdAt) || toDate(data.organicWelcomeSentAt);
}

/**
 * @param {string} displayName
 * @return {string}
 */
function buildHtml(displayName) {
  const name = escapeHtml(greetingName(displayName));
  return `<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${SUBJECT}</title>
</head>
<body style="margin:0;padding:0;background-color:#F5F8F6;font-family:Georgia,'Times New Roman',serif;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color:#F5F8F6;padding:24px 12px;">
    <tr>
      <td align="center">
        <table role="presentation" width="560" cellspacing="0" cellpadding="0" style="max-width:560px;width:100%;background-color:#ffffff;border:1px solid #D5E3DE;border-radius:16px;overflow:hidden;">
          <tr>
            <td style="background-color:#0C2F2B;padding:28px 32px;">
              <p style="margin:0;color:#E3A008;font-family:Arial,Helvetica,sans-serif;font-size:12px;letter-spacing:0.08em;text-transform:uppercase;">
                Oferta 48 horas
              </p>
              <h1 style="margin:10px 0 0;color:#ffffff;font-size:26px;line-height:1.25;">
                Premium a $69.900 COP, solo por 48 horas
              </h1>
            </td>
          </tr>
          <tr>
            <td style="padding:28px 32px 8px;color:#12201E;font-size:16px;line-height:1.55;">
              <p style="margin:0 0 14px;">Hola ${name},</p>
              <p style="margin:0 0 14px;">
                Ya diste el primer paso con el Reto Diario o tu práctica libre.
                Para seguir subiendo, te otorgamos un descuento especial:
                <strong>Premium a $69.900 COP</strong> (precio de lista $89.900 COP),
                válido únicamente durante las próximas <strong>48 horas</strong>.
              </p>
              <p style="margin:0 0 22px;">
                Con Premium desbloqueas las
                <strong>explicaciones normativas y teóricas</strong>,
                <strong>simulacros cronometrados</strong> y
                <strong>casos de aula por especialidad</strong>.
              </p>
              <table role="presentation" cellspacing="0" cellpadding="0" style="margin:0 0 22px;">
                <tr>
                  <td style="background-color:#1F6B5C;border-radius:10px;">
                    <a href="${PREMIUM_CTA_URL}"
                       style="display:inline-block;padding:14px 22px;color:#ffffff;text-decoration:none;font-family:Arial,Helvetica,sans-serif;font-size:16px;font-weight:bold;">
                      Activar Premium a $69.900
                    </a>
                  </td>
                </tr>
              </table>
              <p style="margin:0 0 8px;color:#4A5C58;font-size:14px;">
                Si el botón no abre, copia este enlace:<br>
                <a href="${PREMIUM_CTA_URL}" style="color:#1F6B5C;">${PREMIUM_CTA_URL}</a>
              </p>
            </td>
          </tr>
          <tr>
            <td style="padding:8px 32px 28px;color:#6E807C;font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:1.5;">
              Pasadas las 48 horas, el precio vuelve a $89.900 COP.
              El reto diario y una práctica libre al día siguen disponibles.
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`;
}

/**
 * @return {string}
 */
function buildText() {
  return [
    "Hola,",
    "",
    "Ya diste el primer paso con el Reto Diario o tu práctica libre.",
    "Te otorgamos Premium a $69.900 COP (precio de lista $89.900 COP)",
    "válido únicamente durante las próximas 48 horas.",
    "",
    "Activa tu oferta aquí:",
    PREMIUM_CTA_URL,
    "",
    "Pasadas las 48 horas, el precio vuelve a $89.900 COP.",
  ].join("\n");
}

/**
 * @param {string} uid
 * @param {FirebaseFirestore.DocumentData} data
 * @return {Promise<string|null>}
 */
async function resolveEmail(uid, data) {
  const fromDoc = normalizeEmail(data.email);
  if (fromDoc) return fromDoc;
  try {
    const user = await getAuth().getUser(uid);
    return normalizeEmail(user.email);
  } catch (e) {
    console.warn("organic_upsell auth email", uid, e.message || e);
    return null;
  }
}

/**
 * Reserva el envío y sella la oferta $69.900 por 48 h.
 * @param {FirebaseFirestore.DocumentReference} userRef
 * @param {number} nowMs
 * @return {Promise<{ok: boolean, data?: object}>}
 */
async function claimSendSlot(userRef, nowMs) {
  const db = getFirestore();
  const expiresAt = Timestamp.fromMillis(nowMs + OFFER_HOURS * 60 * 60 * 1000);
  return db.runTransaction(async (tx) => {
    const snap = await tx.get(userRef);
    if (!snap.exists) return {ok: false};
    const data = snap.data() || {};
    if (data.acquiredViaPaid === true) return {ok: false};
    if (data.isPremium === true) return {ok: false};
    if (alreadyUpsold(data)) return {ok: false};
    if (data.authProvider === "anonymous") return {ok: false};
    if (!hasFreeActivity(data)) return {ok: false};
    const existing = toDate(data.welcomeOfferExpiresAt);
    const keepLonger = existing && existing.getTime() > expiresAt.toMillis();
    tx.set(userRef, {
      upsellEmailSent: true,
      upsellEmailSentAt: FieldValue.serverTimestamp(),
      welcomeOfferExpiresAt: keepLonger
        ? Timestamp.fromDate(existing)
        : expiresAt,
    }, {merge: true});
    return {ok: true, data};
  });
}

/**
 * Cron 10:00 Colombia: orgánicos activos con ~3 días desde el correo en la cuenta.
 */
exports.sendOrganicUpsellEmail = onSchedule(
    {
      schedule: "every day 10:00",
      timeZone: "America/Bogota",
      secrets: [resendApiKey],
      region: "southamerica-east1",
      timeoutSeconds: 120,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 1,
      retryCount: 0,
    },
    async () => {
      const apiKey = String(resendApiKey.value() || process.env.RESEND_API_KEY || "")
          .trim();
      if (!apiKey) {
        console.error("RESEND_API_KEY vacío: no se envía upsell orgánico.");
        return;
      }

      const now = Date.now();
      const windowStart = Timestamp.fromMillis(now - WINDOW_MAX_AGE_MS);
      const windowEnd = Timestamp.fromMillis(now - WINDOW_MIN_AGE_MS);
      const db = getFirestore();

      let snap;
      try {
        snap = await db.collection("users")
            .where("organicWelcomeSentAt", ">=", windowStart)
            .where("organicWelcomeSentAt", "<", windowEnd)
            .limit(MAX_DOCS_PER_RUN)
            .get();
      } catch (e) {
        console.error("organic_upsell query", e);
        return;
      }

      if (snap.empty) {
        console.log("organic_upsell: nadie en ventana 72–96 h.");
        return;
      }

      const resend = new Resend(apiKey);
      let sent = 0;
      let skipped = 0;
      let skippedInactive = 0;
      let failed = 0;

      for (const doc of snap.docs) {
        const data = doc.data() || {};
        if (data.acquiredViaPaid === true || data.isPremium === true) {
          skipped += 1;
          continue;
        }
        if (alreadyUpsold(data) || data.authProvider === "anonymous") {
          skipped += 1;
          continue;
        }
        if (!hasFreeActivity(data)) {
          skippedInactive += 1;
          continue;
        }
        if (!registrationClock(data)) {
          skipped += 1;
          continue;
        }

        const email = await resolveEmail(doc.id, data);
        if (!email) {
          skipped += 1;
          console.warn("organic_upsell sin correo", doc.id);
          continue;
        }

        let claimed;
        try {
          claimed = await claimSendSlot(doc.ref, now);
        } catch (e) {
          failed += 1;
          console.error("organic_upsell claim", doc.id, e);
          continue;
        }
        if (!claimed.ok) {
          skipped += 1;
          continue;
        }

        const displayName = String(
            (claimed.data && claimed.data.displayName) || data.displayName || "",
        );
        try {
          const result = await resend.emails.send({
            from: FROM_EMAIL,
            to: email,
            subject: SUBJECT,
            html: buildHtml(displayName),
            text: buildText(),
          });
          if (result.error) {
            failed += 1;
            console.error("organic_upsell resend", doc.id, result.error);
            continue;
          }
          sent += 1;
        } catch (e) {
          failed += 1;
          console.error("organic_upsell send", doc.id, e);
        }
      }

      console.log("organic_upsell done", {
        candidates: snap.size,
        sent,
        skipped,
        skippedInactive,
        failed,
      });
    },
);

exports.hasFreeActivity = hasFreeActivity;
exports.PREMIUM_CTA_URL = PREMIUM_CTA_URL;
