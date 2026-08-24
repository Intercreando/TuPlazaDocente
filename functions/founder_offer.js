/**
 * Oferta 48 h a cuentas anteriores a Resend (Google o correo/contraseña).
 * No envía a quien ya tuvo organicWelcome, upsell, reminder o founderOffer.
 */
const {onCall, onRequest, HttpsError} = require("firebase-functions/v2/https");
const {defineSecret} = require("firebase-functions/params");
const {getAuth} = require("firebase-admin/auth");
const {getFirestore, FieldValue, Timestamp} = require("firebase-admin/firestore");
const {Resend} = require("resend");
const {OAuth2Client} = require("google-auth-library");

const resendApiKey = defineSecret("RESEND_API_KEY");

const ADMIN_EMAILS = new Set(["elkinoswa@gmail.com"]);
const APP_URL = "https://www.tuplazadocente.com";
const PREMIUM_CTA_URL = `${APP_URL}/#/premium`;
const FROM_EMAIL = "Elkin B · TuPlazaDocente <soporte@tuplazadocente.com>";
const SUBJECT =
  "Una ventaja exclusiva por ser de nuestros primeros usuarios 🎁";
const OFFER_HOURS = 48;
const CREDENTIAL_PROVIDERS = new Set(["google.com", "password"]);

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
 * @param {FirebaseFirestore.DocumentData} data
 * @return {boolean}
 */
function alreadyWentThroughResend(data) {
  return data.organicWelcomeSent === true ||
    data.organicWelcomeSentAt != null ||
    data.upsellEmailSent === true ||
    data.upsellEmailSentAt != null ||
    data.rescueEmailSent === true ||
    data.reminderOfferSentAt != null ||
    data.founderOfferSent === true ||
    data.founderOfferSentAt != null;
}

/**
 * @param {import("firebase-admin/auth").UserRecord} user
 * @return {string|null}
 */
function credentialProvider(user) {
  const providers = (user.providerData || []).map((p) => p.providerId);
  if (providers.includes("google.com")) return "google.com";
  if (providers.includes("password")) return "password";
  return null;
}

/**
 * @return {string}
 */
function buildHtml() {
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
                TuPlazaDocente
              </p>
              <h1 style="margin:10px 0 0;color:#ffffff;font-size:24px;line-height:1.3;">
                Una ventaja exclusiva por ser de nuestros primeros usuarios
              </h1>
            </td>
          </tr>
          <tr>
            <td style="padding:28px 32px 8px;color:#12201E;font-size:16px;line-height:1.55;">
              <p style="margin:0 0 14px;">Hola,</p>
              <p style="margin:0 0 14px;">
                Cuando iniciamos con TuPlazaDocente, fuiste una de las primeras
                personas en registrarse. Eso me demuestra que estás buscando una
                preparación seria y diferente para el concurso de la CNSC.
              </p>
              <p style="margin:0 0 14px;">
                Hoy te escribo porque acabamos de habilitar la herramienta que
                marca la diferencia entre pasar la prueba o quedarse en el
                intento: los <strong>simulacros cronometrados</strong> y los
                <strong>casos de aula por especialidad</strong>.
              </p>
              <p style="margin:0 0 14px;">
                Sabemos que el mayor reto del examen no es memorizar leyes, es
                soportar la presión del tiempo y entender cómo la CNSC estructura
                sus preguntas. Para eso necesitas entrenar en un entorno idéntico
                al real.
              </p>
              <p style="margin:0 0 22px;">
                Como agradecimiento por estar con nosotros desde los primeros
                días, he reactivado manualmente tu precio especial de bienvenida
                de <strong>$69.900 COP</strong> (sobre el precio de lista de
                $89.900 COP). Este enlace privado estará activo únicamente por
                las próximas <strong>48 horas</strong>.
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
              <p style="margin:0 0 14px;color:#4A5C58;font-size:14px;">
                Si el botón no abre, copia este enlace:<br>
                <a href="${PREMIUM_CTA_URL}" style="color:#1F6B5C;">${PREMIUM_CTA_URL}</a>
              </p>
              <p style="margin:0 0 14px;">
                Aprovecha esta ventana para llevar tu preparación al nivel que
                exige el concurso.
              </p>
              <p style="margin:0 0 4px;">Mucho éxito en tu proceso,</p>
              <p style="margin:0;">
                <strong>Elkin B</strong><br>
                Creador de TuPlazaDocente
              </p>
            </td>
          </tr>
          <tr>
            <td style="padding:8px 32px 28px;color:#6E807C;font-family:Arial,Helvetica,sans-serif;font-size:12px;line-height:1.5;">
              Recibes este correo porque te registraste en TuPlazaDocente antes
              de activar nuestros avisos automáticos. Si ya eres Premium,
              ignóralo.
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`;
}

function buildText() {
  return [
    "Hola,",
    "",
    "Cuando iniciamos con TuPlazaDocente, fuiste una de las primeras personas en registrarse. Eso me demuestra que estás buscando una preparación seria y diferente para el concurso de la CNSC.",
    "",
    "Hoy te escribo porque acabamos de habilitar la herramienta que marca la diferencia entre pasar la prueba o quedarse en el intento: los simulacros cronometrados y los casos de aula por especialidad.",
    "",
    "Sabemos que el mayor reto del examen no es memorizar leyes, es soportar la presión del tiempo y entender cómo la CNSC estructura sus preguntas. Para eso necesitas entrenar en un entorno idéntico al real.",
    "",
    "Como agradecimiento por estar con nosotros desde los primeros días, he reactivado manualmente tu precio especial de bienvenida de $69.900 COP (sobre el precio de lista de $89.900 COP). Este enlace privado estará activo únicamente por las próximas 48 horas.",
    "",
    "Activa tu cuenta Premium aquí:",
    PREMIUM_CTA_URL,
    "",
    "Aprovecha esta ventana para llevar tu preparación al nivel que exige el concurso.",
    "",
    "Mucho éxito en tu proceso,",
    "",
    "Elkin B",
    "Creador de TuPlazaDocente",
  ].join("\n");
}

/**
 * @return {Promise<{eligible: object[], skipped: object}>}
 */
async function collectAudience() {
  const skipped = {
    noEmail: 0,
    anonymousOrOther: 0,
    premium: 0,
    alreadyResend: 0,
  };
  const eligible = [];
  const seenEmails = new Set();
  const db = getFirestore();
  let pageToken;

  do {
    const page = await getAuth().listUsers(1000, pageToken);
    for (const user of page.users) {
      if (user.disabled) {
        skipped.anonymousOrOther += 1;
        continue;
      }
      const provider = credentialProvider(user);
      if (!provider) {
        skipped.anonymousOrOther += 1;
        continue;
      }
      const email = normalizeEmail(user.email);
      if (!email) {
        skipped.noEmail += 1;
        continue;
      }
      if (seenEmails.has(email)) continue;
      seenEmails.add(email);

      const snap = await db.collection("users").doc(user.uid).get();
      const data = snap.exists ? (snap.data() || {}) : {};
      if (data.isPremium === true) {
        skipped.premium += 1;
        continue;
      }
      if (alreadyWentThroughResend(data)) {
        skipped.alreadyResend += 1;
        continue;
      }
      eligible.push({
        uid: user.uid,
        email,
        provider,
      });
    }
    pageToken = page.pageToken;
  } while (pageToken);

  return {eligible, skipped};
}

/**
 * @param {object} person
 * @param {Resend} resend
 * @param {FirebaseFirestore.Timestamp} expiresAt
 * @return {Promise<void>}
 */
async function sendOne(person, resend, expiresAt) {
  const db = getFirestore();
  const userRef = db.collection("users").doc(person.uid);
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(userRef);
    const data = snap.exists ? (snap.data() || {}) : {};
    if (data.isPremium === true) {
      throw new Error("premium");
    }
    if (alreadyWentThroughResend(data)) {
      throw new Error("already_resend");
    }
    tx.set(userRef, {
      welcomeOfferExpiresAt: expiresAt,
      founderOfferSent: true,
      founderOfferSentAt: FieldValue.serverTimestamp(),
      organicWelcomeSent: true,
    }, {merge: true});
  });

  const result = await resend.emails.send({
    from: FROM_EMAIL,
    to: person.email,
    subject: SUBJECT,
    html: buildHtml(),
    text: buildText(),
  });
  if (result.error) {
    throw new Error(result.error.message || "resend_error");
  }
}

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

exports.collectAudience = collectAudience;
exports.sendOne = sendOne;
exports.SUBJECT = SUBJECT;
exports.OFFER_HOURS = OFFER_HOURS;

/**
 * @param {boolean} dryRun
 * @return {Promise<object>}
 */
async function executeFounderOffer(dryRun) {
  const {eligible, skipped} = await collectAudience();
  if (dryRun) {
    return {
      dryRun: true,
      count: eligible.length,
      skipped,
      emails: eligible.map((p) => ({
        email: p.email,
        provider: p.provider,
      })),
    };
  }

  const apiKey = String(resendApiKey.value() || process.env.RESEND_API_KEY || "")
      .trim();
  if (!apiKey) {
    throw new Error("Falta RESEND_API_KEY.");
  }
  const resend = new Resend(apiKey);
  const expiresAt = Timestamp.fromMillis(
      Date.now() + OFFER_HOURS * 60 * 60 * 1000,
  );
  const sent = [];
  const errors = [];
  for (const person of eligible) {
    try {
      await sendOne(person, resend, expiresAt);
      sent.push(person.email);
    } catch (e) {
      errors.push({email: person.email, error: e.message || String(e)});
    }
    await sleep(120);
  }
  return {
    dryRun: false,
    sent: sent.length,
    emails: sent,
    errors,
    skipped,
  };
}

exports.sendFounderOfferEmails = onCall(
    {
      region: "southamerica-east1",
      secrets: [resendApiKey],
      timeoutSeconds: 300,
      memory: "512MiB",
      minInstances: 0,
      maxInstances: 1,
    },
    async (request) => {
      if (!request.auth?.uid) {
        throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
      }
      const email = String(request.auth.token?.email || "").trim().toLowerCase();
      if (!ADMIN_EMAILS.has(email)) {
        throw new HttpsError("permission-denied", "No autorizado.");
      }
      const dryRun = request.data?.dryRun !== false;
      try {
        return await executeFounderOffer(dryRun);
      } catch (e) {
        throw new HttpsError("internal", e.message || String(e));
      }
    },
);

/**
 * Job HTTP: Bearer = ID token de Google (sesión Firebase CLI / admin).
 * GET/POST { dryRun: true|false }.
 */
exports.runFounderOfferJob = onRequest(
    {
      region: "southamerica-east1",
      secrets: [resendApiKey],
      timeoutSeconds: 300,
      memory: "512MiB",
      minInstances: 0,
      maxInstances: 1,
      cors: true,
      invoker: "public",
    },
    async (req, res) => {
      try {
        const hdr = String(req.get("authorization") || "");
        const match = hdr.match(/^Bearer\s+(.+)$/i);
        if (!match) {
          res.status(401).json({error: "Falta Authorization Bearer."});
          return;
        }
        const ticket = await new OAuth2Client().verifyIdToken({
          idToken: match[1],
        });
        const payload = ticket.getPayload() || {};
        const adminEmail = String(payload.email || "").trim().toLowerCase();
        if (payload.email_verified !== true || !ADMIN_EMAILS.has(adminEmail)) {
          res.status(403).json({error: "No autorizado."});
          return;
        }
      } catch (e) {
        res.status(401).json({error: "Token inválido."});
        return;
      }

      const body = req.body && typeof req.body === "object" ? req.body : {};
      const dryRun = body.dryRun !== false && req.query.dryRun !== "0";
      try {
        const result = await executeFounderOffer(dryRun);
        res.status(200).json(result);
      } catch (e) {
        console.error("runFounderOfferJob", e);
        res.status(500).json({error: e.message || String(e)});
      }
    },
);
