/**
 * Sube assets/seed/questions_v1.json a Firestore.
 *
 * Opción A (recomendada en Windows, sin gcloud):
 *   1. Firebase Console → Project settings → Service accounts
 *   2. "Generate new private key" → guarda el JSON en tools/seed/serviceAccount.json
 *   3. node seed_firestore.js
 *
 * Opción B (si tienes gcloud):
 *   gcloud auth application-default login
 *   node seed_firestore.js
 *
 * Antes de subir, corre validate_bank_sync (IDs únicos + lotes + Dart).
 * Omite con: SKIP_BANK_VALIDATE=1
 */
const fs = require("fs");
const path = require("path");
const {spawnSync} = require("child_process");
const admin = require("firebase-admin");

const PROJECT_ID = "tuplazadocente-9334d";
const SEED_PATH = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");
const SA_PATH = path.join(__dirname, "serviceAccount.json");
const VALIDATE_SCRIPT = path.join(__dirname, "..", "validate_bank_sync.js");

function runPreSeedValidation() {
  if (process.env.SKIP_BANK_VALIDATE === "1") {
    console.warn("SKIP_BANK_VALIDATE=1: se omite validate_bank_sync");
    return;
  }
  console.log("Pre-seed: validate_bank_sync --dart …");
  const result = spawnSync(
      process.execPath,
      [VALIDATE_SCRIPT, "--dart"],
      {stdio: "inherit"},
  );
  if (result.status !== 0) {
    console.error("Validación del banco falló. Corrige el drift antes de sembrar.");
    process.exit(result.status || 1);
  }
}

function initAdmin() {
  if (admin.apps.length) return;

  if (fs.existsSync(SA_PATH)) {
    const sa = JSON.parse(fs.readFileSync(SA_PATH, "utf8"));
    admin.initializeApp({
      credential: admin.credential.cert(sa),
      projectId: PROJECT_ID,
    });
    console.log("Auth: serviceAccount.json");
    return;
  }

  if (process.env.GOOGLE_APPLICATION_CREDENTIALS) {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
      projectId: PROJECT_ID,
    });
    console.log("Auth: GOOGLE_APPLICATION_CREDENTIALS");
    return;
  }

  console.error(`
No hay credenciales.

Haz ESTO (sin instalar gcloud):

1. Abre:
   https://console.firebase.google.com/project/tuplazadocente-9334d/settings/serviceaccounts/adminsdk

2. Pulsa "Generate new private key" / "Generar nueva clave privada"
3. Guarda el archivo descargado como:
   ${SA_PATH}

4. Vuelve a correr:
   node seed_firestore.js
`);
  process.exit(1);
}

async function main() {
  if (!fs.existsSync(SEED_PATH)) {
    console.error("No existe el seed. Corre primero: node generate_bank.js");
    process.exit(1);
  }

  runPreSeedValidation();

  initAdmin();
  const db = admin.firestore();
  const payload = JSON.parse(fs.readFileSync(SEED_PATH, "utf8"));
  const items = payload.items || [];
  console.log(`Subiendo ${items.length} ítems a ${PROJECT_ID}/questions ...`);

  const batchSize = 400;
  let written = 0;
  for (let i = 0; i < items.length; i += batchSize) {
    const chunk = items.slice(i, i + batchSize);
    const batch = db.batch();
    for (const item of chunk) {
      const ref = db.collection("questions").doc(item.id);
      batch.set(
          ref,
          {
            ...item,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          },
          {merge: true},
      );
    }
    await batch.commit();
    written += chunk.length;
    console.log(`  ${written}/${items.length}`);
  }

  // Retira clones viejos del generador (oro-/fs-) que ya no están en el seed.
  const keep = new Set(items.map((i) => i.id));
  const snap = await db.collection("questions").select().get();
  let retired = 0;
  let batch = db.batch();
  let ops = 0;
  for (const doc of snap.docs) {
    const id = doc.id;
    if (!keep.has(id) && (id.startsWith("oro-") || id.startsWith("fs-"))) {
      batch.delete(doc.ref);
      retired += 1;
      ops += 1;
      if (ops >= 400) {
        await batch.commit();
        batch = db.batch();
        ops = 0;
      }
    }
  }
  if (ops > 0) await batch.commit();
  if (retired > 0) {
    console.log(`Retirados ${retired} ítems obsoletos (oro-/fs- fuera del seed).`);
  }

  await db.collection("meta").doc("question_bank").set(
      {
        version: payload.version,
        count: items.length,
        generatedAt: payload.generatedAt,
        quality: payload.quality || null,
        seededAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      {merge: true},
  );

  console.log("Seed Firestore completado.");
}

main().catch((err) => {
  console.error("Error al sembrar Firestore:", err.message || err);
  process.exit(1);
});
