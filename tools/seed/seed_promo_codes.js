/**
 * Crea o actualiza códigos promocionales Premium en Firestore.
 *
 * Uso:
 *   cd tools/seed
 *   node seed_promo_codes.js
 *   node seed_promo_codes.js --code PROMO-ABRIL --max 50
 *   node seed_promo_codes.js --code VIP-ELKIN --max 1 --note "cortesía"
 *
 * Requiere tools/seed/serviceAccount.json (igual que seed_firestore.js).
 */
const path = require("path");
const admin = require("firebase-admin");

const PROJECT_ID = "tuplazadocente-9334d";
const SA_PATH = path.join(__dirname, "serviceAccount.json");

function parseArgs(argv) {
  const out = {code: null, max: null, note: null, disable: false};
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === "--code" && argv[i + 1]) out.code = String(argv[++i]).toUpperCase();
    else if (a === "--max" && argv[i + 1]) out.max = Number(argv[++i]);
    else if (a === "--note" && argv[i + 1]) out.note = String(argv[++i]);
    else if (a === "--disable") out.disable = true;
  }
  return out;
}

function initAdmin() {
  if (admin.apps.length) return;
  if (require("fs").existsSync(SA_PATH)) {
    // eslint-disable-next-line import/no-dynamic-require, global-require
    const sa = require(SA_PATH);
    admin.initializeApp({
      credential: admin.credential.cert(sa),
      projectId: PROJECT_ID,
    });
    return;
  }
  admin.initializeApp({projectId: PROJECT_ID});
}

async function upsertCode(db, {code, maxRedemptions, note, active}) {
  const ref = db.collection("promoCodes").doc(code);
  const snap = await ref.get();
  const payload = {
    code,
    active: active !== false,
    maxRedemptions: maxRedemptions == null ? 0 : Number(maxRedemptions),
    note: note || null,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };
  if (!snap.exists) {
    payload.redeemedCount = 0;
    payload.createdAt = admin.firestore.FieldValue.serverTimestamp();
  }
  await ref.set(payload, {merge: true});
  console.log(
      `${snap.exists ? "Actualizado" : "Creado"}: ${code} · ` +
      `active=${payload.active} · max=${payload.maxRedemptions || "ilimitado"}`,
  );
}

async function main() {
  initAdmin();
  const db = admin.firestore();
  const args = parseArgs(process.argv.slice(2));

  if (args.code) {
    await upsertCode(db, {
      code: args.code,
      maxRedemptions: args.max,
      note: args.note,
      active: !args.disable,
    });
    return;
  }

  // Seed inicial de códigos internos (migrados del hardcode).
  const defaults = [
    {code: "PLAZA2026", maxRedemptions: 0, note: "interno / legado"},
    {code: "DOCENTE-REY", maxRedemptions: 0, note: "interno / legado"},
    {code: "TUPLAZA-PREMIUM", maxRedemptions: 0, note: "interno / legado"},
  ];
  for (const item of defaults) {
    await upsertCode(db, item);
  }
  console.log("Listo. Para crear más: node seed_promo_codes.js --code MI-PROMO --max 30");
}

main().catch((err) => {
  console.error("Error:", err.message || err);
  process.exit(1);
});
