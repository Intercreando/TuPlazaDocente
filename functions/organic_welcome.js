/**
 * Bienvenida orgánica por Resend: valor (reto diario / 1 práctica), sin venta.
 * No corre para cohorte de pauta. Un solo envío por uid.
 *
 * La app crea users/{uid} como invitado y luego escribe el correo al registrar.
 * Por eso se usa onDocumentWritten (no solo onDocumentCreated).
 */
const {onDocumentWritten} = require("firebase-functions/v2/firestore");
const {defineSecret} = require("firebase-functions/params");
const {getAuth} = require("firebase-admin/auth");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {Resend} = require("resend");

const resendApiKey = defineSecret("RESEND_API_KEY");

const APP_URL = "https://www.tuplazadocente.com";
const APP_CTA_URL = `${APP_URL}/#/app`;
const FROM_EMAIL = "Equipo TuPlazaDocente <soporte@tuplazadocente.com>";
const CLAIM_SETTLE_MS = 6000;

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
  <title>Bienvenido a TuPlazaDocente</title>
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
                Bienvenido. Empieza tu preparación hoy
              </h1>
            </td>
          </tr>
          <tr>
            <td style="padding:28px 32px 8px;color:#12201E;font-size:16px;line-height:1.55;">
              <p style="margin:0 0 14px;">Hola ${name},</p>
              <p style="margin:0 0 14px;">
                TuPlazaDocente es tu espacio para entrenar el Concurso Docente
                CNSC con casos de aula, criterio de ítem y sesiones cortas.
                Aquí practicas con método, no memorizando leyes sueltas.
              </p>
              <p style="margin:0 0 22px;">
                Hoy puedes empezar con el <strong>Reto diario</strong> (5 preguntas)
                o con tu <strong>sesión de práctica libre</strong> (1 al día).
                Diez minutos bastan para no perder el hilo.
              </p>
              <table role="presentation" cellspacing="0" cellpadding="0" style="margin:0 0 22px;">
                <tr>
                  <td style="background-color:#1F6B5C;border-radius:10px;">
                    <a href="${APP_CTA_URL}"
                       style="display:inline-block;padding:14px 22px;color:#ffffff;text-decoration:none;font-family:Arial,Helvetica,sans-serif;font-size:16px;font-weight:bold;">
                      Entrar al reto diario
                    </a>
                  </td>
                </tr>
              </table>
              <p style="margin:0 0 8px;color:#4A5C58;font-size:14px;">
                Si el botón no abre, copia este enlace:<br>
                <a href="${APP_CTA_URL}" style="color:#1F6B5C;">${APP_CTA_URL}</a>
              </p>
            </td>
          </tr>
          <tr>
            <td style="padding:8px 32px 28px;color:#6E807C;font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:1.5;">
              Recibes este correo porque creaste tu cuenta en TuPlazaDocente.
              Si no fuiste tú, puedes ignorarlo.
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
    console.warn("organic_welcome auth email", uid, e.message || e);
    return null;
  }
}

/**
 * @param {FirebaseFirestore.DocumentReference} userRef
 * @return {Promise<{ok: boolean, data?: object}>}
 */
async function claimSendSlot(userRef) {
  const db = getFirestore();
  return db.runTransaction(async (tx) => {
    const snap = await tx.get(userRef);
    if (!snap.exists) return {ok: false};
    const data = snap.data() || {};
    if (data.acquiredViaPaid === true) return {ok: false};
    if (data.organicWelcomeSent === true) return {ok: false};
    if (data.authProvider === "anonymous") return {ok: false};
    tx.set(userRef, {
      organicWelcomeSent: true,
      organicWelcomeSentAt: FieldValue.serverTimestamp(),
    }, {merge: true});
    return {ok: true, data};
  });
}

/**
 * @param {number} ms
 * @return {Promise<void>}
 */
function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

/**
 * Correo de bienvenida solo orgánico, cuando el uid ya tiene correo real.
 */
exports.sendOrganicWelcomeEmail = onDocumentWritten(
    {
      document: "users/{userId}",
      region: "southamerica-east1",
      secrets: [resendApiKey],
      timeoutSeconds: 60,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 8,
      retry: false,
    },
    async (event) => {
      const after = event.data?.after;
      if (!after || !after.exists) return null;

      let data = after.data() || {};
      if (data.acquiredViaPaid === true) return null;
      if (data.organicWelcomeSent === true) return null;
      if (data.authProvider === "anonymous") return null;

      const uid = String(event.params.userId || after.id || "");
      if (!uid) return null;

      const emailBefore = event.data?.before?.exists ?
        normalizeEmail((event.data.before.data() || {}).email) :
        null;
      let email = await resolveEmail(uid, data);
      if (!email) return null;
      // Actualizaciones de racha/progreso: no volver a evaluar.
      if (emailBefore && emailBefore === email) return null;

      const apiKey = String(resendApiKey.value() || process.env.RESEND_API_KEY || "")
          .trim();
      if (!apiKey) {
        console.error("RESEND_API_KEY vacío: no se envía bienvenida orgánica.");
        return null;
      }

      // El claim de pauta corre justo después del registro; esperar y releer.
      await sleep(CLAIM_SETTLE_MS);
      const fresh = await after.ref.get();
      if (!fresh.exists) return null;
      data = fresh.data() || {};
      if (data.acquiredViaPaid === true) return null;
      if (data.organicWelcomeSent === true) return null;
      if (data.isPremium === true) return null;
      email = await resolveEmail(uid, data);
      if (!email) return null;

      let claimed;
      try {
        claimed = await claimSendSlot(after.ref);
      } catch (e) {
        console.error("organic_welcome claim", uid, e);
        return null;
      }
      if (!claimed.ok) return null;

      const displayName = String(
          (claimed.data && claimed.data.displayName) || data.displayName || "",
      );
      try {
        const resend = new Resend(apiKey);
        const result = await resend.emails.send({
          from: FROM_EMAIL,
          to: email,
          subject: "¡Bienvenido a TuPlazaDocente! 🚀 Empieza tu preparación hoy.",
          html: buildHtml(displayName),
          text:
            `Hola,\n\nTuPlazaDocente es tu espacio para entrenar el concurso ` +
            `docente. Empieza hoy con el reto diario o tu práctica libre ` +
            `(1 sesión al día): ${APP_CTA_URL}\n`,
        });
        if (result.error) {
          console.error("organic_welcome resend", uid, result.error);
          return null;
        }
        console.log("organic_welcome sent", {uid});
      } catch (e) {
        console.error("organic_welcome send", uid, e);
      }
      return null;
    },
);
