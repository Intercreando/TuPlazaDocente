/**
 * Recordatorio de rescate: oferta 24 h de pauta a punto de caducar.
 * Solo corre si la caducidad está entre 3 h y 4 h en el futuro y el
 * candado reminderOfferSent sigue en false. Resend confirma y luego se sella.
 */
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {defineSecret} = require("firebase-functions/params");
const {getAuth} = require("firebase-admin/auth");
const {getFirestore, FieldValue, Timestamp} = require("firebase-admin/firestore");
const {Resend} = require("resend");

const resendApiKey = defineSecret("RESEND_API_KEY");

const APP_URL = "https://www.tuplazadocente.com";
/** Hash routing de la PWA: /premium sin #/ no abre la pantalla. */
const PREMIUM_CTA_URL = `${APP_URL}/#/premium`;
const FROM_EMAIL = "Equipo TuPlazaDocente <soporte@tuplazadocente.com>";
const LIST_PRICE_COP = 89900;
const WELCOME_PRICE_COP = 69900;
const WINDOW_MIN_MS = 3 * 60 * 60 * 1000;
const WINDOW_MAX_MS = 4 * 60 * 60 * 1000;
const MAX_DOCS_PER_RUN = 80;

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
 * Caducidad estricta: entre 3 h y 4 h desde `nowMs`, nunca fechas pasadas.
 * @param {Date|null} exp
 * @param {number} nowMs
 * @return {boolean}
 */
function isExpirationInReminderWindow(exp, nowMs) {
  if (!exp || !(exp instanceof Date) || Number.isNaN(exp.getTime())) {
    return false;
  }
  const t = exp.getTime();
  return t >= nowMs + WINDOW_MIN_MS && t <= nowMs + WINDOW_MAX_MS;
}

/**
 * @param {FirebaseFirestore.DocumentData} data
 * @return {boolean}
 */
function alreadyReminded(data) {
  return data.reminderOfferSent === true ||
      data.rescueEmailSent === true ||
      data.reminderOfferSentAt != null;
}

/**
 * @param {string} displayName
 * @return {string}
 */
function buildHtml(displayName) {
  const name = escapeHtml((displayName || "").trim() || "docente");
  const welcome = "$69.900";
  const list = "$89.900";
  return `<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Tu oferta de bienvenida está por caducar</title>
</head>
<body style="margin:0;padding:0;background-color:#F5F8F6;font-family:Georgia,'Times New Roman',serif;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color:#F5F8F6;padding:24px 12px;">
    <tr>
      <td align="center">
        <table role="presentation" width="560" cellspacing="0" cellpadding="0" style="max-width:560px;width:100%;background-color:#ffffff;border:1px solid #D5E3DE;border-radius:16px;overflow:hidden;">
          <tr>
            <td style="background-color:#0C2F2B;padding:28px 32px;">
              <p style="margin:0;color:#E3A008;font-family:Arial,Helvetica,sans-serif;font-size:12px;letter-spacing:0.08em;text-transform:uppercase;">
                TuPlazaDocente
              </p>
              <h1 style="margin:10px 0 0;color:#ffffff;font-size:26px;line-height:1.25;">
                Tu diagnóstico y el 22 % de descuento caducan en 4 horas
              </h1>
            </td>
          </tr>
          <tr>
            <td style="padding:28px 32px 8px;color:#12201E;font-size:16px;line-height:1.55;">
              <p style="margin:0 0 14px;">Hola ${name},</p>
              <p style="margin:0 0 14px;">
                Completaste el registro de campaña. El precio de bienvenida de
                <strong>${welcome} COP</strong> (en lugar de ${list}) y el acceso
                a tu mapa de resultados cierran cuando se vence el reloj de 24 horas.
                No se reinicia al recargar.
              </p>
              <p style="margin:0 0 22px;">
                Si dejas pasar esta ventana, Premium queda en precio de lista.
                El simulacro cronometrado (Examen Real) sigue siendo Premium.
              </p>
              <table role="presentation" cellspacing="0" cellpadding="0" style="margin:0 0 22px;">
                <tr>
                  <td style="background-color:#1F6B5C;border-radius:10px;">
                    <a href="${PREMIUM_CTA_URL}"
                       style="display:inline-block;padding:14px 22px;color:#ffffff;text-decoration:none;font-family:Arial,Helvetica,sans-serif;font-size:16px;font-weight:bold;">
                      Asegurar Premium a ${welcome}
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
              Recibes este correo porque te registraste desde un anuncio y aún no
              has activado Premium. Si ya pagaste, ignóralo: el acceso se activa
              al confirmar Wompi.
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
    console.warn("offer_reminder auth email", uid, e.message || e);
    return null;
  }
}

/**
 * Sella el candado solo después de un envío exitoso de Resend.
 * @param {FirebaseFirestore.DocumentReference} userRef
 * @return {Promise<void>}
 */
async function markReminderSent(userRef) {
  await userRef.set({
    reminderOfferSent: true,
    reminderOfferSentAt: FieldValue.serverTimestamp(),
    rescueEmailSent: true,
  }, {merge: true});
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {number} nowMs
 * @return {Promise<FirebaseFirestore.QueryDocumentSnapshot[]>}
 */
async function loadReminderCandidates(db, nowMs) {
  const startMs = nowMs + WINDOW_MIN_MS;
  const endMs = nowMs + WINDOW_MAX_MS;
  const startTs = Timestamp.fromMillis(startMs);
  const endTs = Timestamp.fromMillis(endMs);
  const startIso = new Date(startMs).toISOString();
  const endIso = new Date(endMs).toISOString();
  const base = db.collection("users")
      .where("acquiredViaPaid", "==", true)
      .where("reminderOfferSent", "==", false);
  const [tsSnap, isoSnap] = await Promise.all([
    base.where("welcomeOfferExpiresAt", ">=", startTs)
        .where("welcomeOfferExpiresAt", "<=", endTs)
        .limit(MAX_DOCS_PER_RUN)
        .get(),
    base.where("welcomeOfferExpiresAt", ">=", startIso)
        .where("welcomeOfferExpiresAt", "<=", endIso)
        .limit(MAX_DOCS_PER_RUN)
        .get(),
  ]);
  const byId = new Map();
  for (const doc of [...tsSnap.docs, ...isoSnap.docs]) {
    byId.set(doc.id, doc);
  }
  return [...byId.values()];
}

/**
 * Cron cada hora: oferta que vence entre 3 h y 4 h, sin Premium, un solo correo.
 */
exports.sendUrgentOfferReminder = onSchedule(
    {
      schedule: "every 1 hours",
      timeZone: "America/Bogota",
      region: "southamerica-east1",
      secrets: [resendApiKey],
      timeoutSeconds: 120,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 1,
      // Un fallo no debe reencolar el cron (evita ráfagas de invocaciones).
      retryCount: 0,
    },
    async () => {
      const apiKey = String(resendApiKey.value() || process.env.RESEND_API_KEY || "")
          .trim();
      if (!apiKey) {
        console.error("RESEND_API_KEY vacío: no se envían recordatorios.");
        return;
      }

      const now = Date.now();
      const db = getFirestore();

      let candidates;
      try {
        candidates = await loadReminderCandidates(db, now);
      } catch (e) {
        console.error("offer_reminder query", e);
        return;
      }

      if (!candidates.length) {
        console.log("offer_reminder: nadie en ventana 3–4 h.");
        return;
      }

      const resend = new Resend(apiKey);
      let sent = 0;
      let skipped = 0;
      let failed = 0;

      for (const doc of candidates) {
        const data = doc.data() || {};
        if (data.isPremium === true || alreadyReminded(data)) {
          skipped += 1;
          continue;
        }
        if (data.acquiredViaPaid !== true) {
          skipped += 1;
          continue;
        }
        const exp = toDate(data.welcomeOfferExpiresAt);
        if (!isExpirationInReminderWindow(exp, now)) {
          skipped += 1;
          continue;
        }

        const email = await resolveEmail(doc.id, data);
        if (!email) {
          skipped += 1;
          console.warn("offer_reminder sin correo", doc.id);
          continue;
        }

        const displayName = String(data.displayName || "");
        try {
          const result = await resend.emails.send({
            from: FROM_EMAIL,
            to: email,
            subject: "⚠️ Tu diagnóstico y descuento del 22% expiran en 4 horas",
            html: buildHtml(displayName),
            text:
              `Hola,\n\nTu precio de bienvenida de $${WELCOME_PRICE_COP.toLocaleString("es-CO")} ` +
              `COP (lista $${LIST_PRICE_COP.toLocaleString("es-CO")}) caduca en unas 4 horas. ` +
              `Activa Premium aquí: ${PREMIUM_CTA_URL}\n`,
          });
          if (result.error) {
            failed += 1;
            console.error("offer_reminder resend", doc.id, result.error);
            await doc.ref.set({
              reminderOfferLastError: String(
                  result.error.message || result.error,
              ).slice(0, 300),
            }, {merge: true}).catch(() => {});
            continue;
          }
          try {
            await markReminderSent(doc.ref);
          } catch (e) {
            console.error("offer_reminder flag", doc.id, e);
          }
          sent += 1;
        } catch (e) {
          failed += 1;
          console.error("offer_reminder send", doc.id, e);
          await doc.ref.set({
            reminderOfferLastError: String(e.message || e).slice(0, 300),
          }, {merge: true}).catch(() => {});
        }
      }

      console.log("offer_reminder done", {
        candidates: candidates.length,
        sent,
        skipped,
        failed,
        listPriceCop: LIST_PRICE_COP,
        welcomePriceCop: WELCOME_PRICE_COP,
      });
    },
);
