/**
 * Exporta correos de Firebase Authentication a un CSV de audiencia Google Ads.
 *
 * Uso (desde tools/seed):
 *   npm install
 *   node export_google_ads_audience.js
 *
 * Credenciales: guarda la clave privada como serviceAccountKey.json
 * en esta carpeta (no la subas a git).
 */
const fs = require("fs");
const path = require("path");
const admin = require("firebase-admin");

const PROJECT_ID = "tuplazadocente-9334d";
const KEY_PATH = path.join(__dirname, "serviceAccountKey.json");
const LEGACY_KEY_PATH = path.join(__dirname, "serviceAccount.json");
const OUT_PATH = path.join(__dirname, "audiencia_google_ads.csv");
const PAGE_SIZE = 1000;

function initAdmin() {
  if (admin.apps.length) return;

  const keyFile = fs.existsSync(KEY_PATH)
    ? KEY_PATH
    : fs.existsSync(LEGACY_KEY_PATH)
      ? LEGACY_KEY_PATH
      : null;

  if (!keyFile) {
    console.error(`
No hay credenciales locales.

1. Abre:
   https://console.firebase.google.com/project/${PROJECT_ID}/settings/serviceaccounts/adminsdk
2. Pulsa "Generar nueva clave privada".
3. Guarda el JSON como:
   ${KEY_PATH}
4. Vuelve a correr:
   node export_google_ads_audience.js
`);
    process.exit(1);
  }

  const sa = JSON.parse(fs.readFileSync(keyFile, "utf8"));
  admin.initializeApp({
    credential: admin.credential.cert(sa),
    projectId: PROJECT_ID,
  });
  console.log(`Auth: ${path.basename(keyFile)}`);
}

/**
 * Recorre todas las páginas de listUsers (máx. 1000 por llamada).
 * @return {Promise<string[]>}
 */
async function collectEmails() {
  const emails = new Set();
  let pageToken;
  let listed = 0;
  let skipped = 0;

  do {
    const result = await admin.auth().listUsers(PAGE_SIZE, pageToken);
    listed += result.users.length;
    for (const user of result.users) {
      const raw = typeof user.email === "string" ? user.email.trim() : "";
      if (!raw) {
        skipped += 1;
        continue;
      }
      emails.add(raw.toLowerCase());
    }
    pageToken = result.pageToken;
  } while (pageToken);

  return {emails: [...emails].sort(), listed, skipped};
}

async function main() {
  try {
    initAdmin();
    const {emails, listed, skipped} = await collectEmails();
    const lines = ["Email", ...emails];
    fs.writeFileSync(OUT_PATH, `${lines.join("\n")}\n`, "utf8");

    console.log(`Usuarios leídos en Auth: ${listed}`);
    console.log(`Sin correo (anónimos u omitidos): ${skipped}`);
    console.log(`Correos únicos en el CSV: ${emails.length}`);
    console.log(`Archivo: ${OUT_PATH}`);
  } catch (err) {
    console.error(
      "No se pudo exportar la audiencia:",
      err && err.message ? err.message : err,
    );
    process.exit(1);
  }
}

main();
