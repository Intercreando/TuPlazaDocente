/**
 * Valida sincronización del banco: seed JSON, IDs únicos, lotes clave y (opcional) Firestore/Dart.
 *
 * Uso:
 *   node tools/validate_bank_sync.js
 *   node tools/validate_bank_sync.js --firestore
 *   node tools/validate_bank_sync.js --dart
 *   node tools/validate_bank_sync.js --strict   (firestore + dart; falla si no hay SA)
 *
 * Exit 0 = OK · Exit 1 = drift / integridad rota.
 */
const fs = require("fs");
const path = require("path");

const ROOT = path.join(__dirname, "..");
const SEED_PATH = path.join(ROOT, "assets", "seed", "questions_v1.json");
const DART_DIR = path.join(ROOT, "lib", "data");
const SA_PATH = path.join(__dirname, "seed", "serviceAccount.json");
const PROJECT_ID = "tuplazadocente-9334d";

/** Conteos esperados de lotes gestionados por merge. */
const EXPECTED = {
  "dir-apt-": 200,
  "oro-cie-": 32,
  "oro-soc-": 32,
};

const args = new Set(process.argv.slice(2));
const wantFirestore = args.has("--firestore") || args.has("--strict");
const wantDart = args.has("--dart") || args.has("--strict");
const strict = args.has("--strict");

function fail(errors) {
  console.error("\nFALLO validate_bank_sync:");
  for (const e of errors) console.error(`  - ${e}`);
  process.exit(1);
}

function loadSeed() {
  if (!fs.existsSync(SEED_PATH)) {
    fail([`No existe el seed: ${SEED_PATH}`]);
  }
  const payload = JSON.parse(fs.readFileSync(SEED_PATH, "utf8"));
  const items = payload.items || [];
  if (!Array.isArray(items) || items.length === 0) {
    fail(["El seed no tiene items"]);
  }
  return {payload, items};
}

function auditUniqueIds(items) {
  const errors = [];
  const seen = new Map();
  for (const item of items) {
    const id = item && item.id != null ? String(item.id) : "";
    if (!id) {
      errors.push("Ítem sin id");
      continue;
    }
    if (seen.has(id)) {
      errors.push(`ID duplicado en seed: ${id}`);
    } else {
      seen.set(id, true);
    }
  }
  return errors;
}

function auditBatchCounts(items) {
  const errors = [];
  for (const [prefix, expected] of Object.entries(EXPECTED)) {
    const n = items.filter((i) => String(i.id).startsWith(prefix)).length;
    if (n !== expected) {
      errors.push(
          `Lote ${prefix}* esperado ${expected}, encontrado ${n} (¿faltó merge?)`,
      );
    }
  }
  return errors;
}

function auditIntegrity(items) {
  const errors = [];
  for (const i of items) {
    const id = i.id || "?";
    if (!Array.isArray(i.options) || i.options.length < 2) {
      errors.push(`${id}: options inválidas`);
      continue;
    }
    if (
      !Number.isInteger(i.correctIndex) ||
      i.correctIndex < 0 ||
      i.correctIndex >= i.options.length
    ) {
      errors.push(`${id}: correctIndex fuera de rango (${i.correctIndex})`);
    }
    if (new Set(i.options.map(String)).size !== i.options.length) {
      errors.push(`${id}: opciones duplicadas`);
    }
    if (!(i.explanation || "").trim()) {
      errors.push(`${id}: explanation vacía`);
    }
    if (!i.pillar) {
      errors.push(`${id}: pillar vacío`);
    }
  }
  return errors;
}

function auditMetaCount(payload, items) {
  const errors = [];
  if (typeof payload.count === "number" && payload.count !== items.length) {
    errors.push(
        `payload.count=${payload.count} != items.length=${items.length}`,
    );
  }
  return errors;
}

/** Extrae ids: '...' de archivos Dart del banco. */
function extractDartIds() {
  const files = fs
      .readdirSync(DART_DIR)
      .filter(
          (f) =>
            f.endsWith("_bank.dart") ||
            f.includes("brain_bank") ||
            f.includes("aptitudes"),
      );
  const ids = [];
  const re = /id:\s*'([^']+)'/g;
  for (const file of files) {
    const text = fs.readFileSync(path.join(DART_DIR, file), "utf8");
    let m;
    while ((m = re.exec(text)) !== null) {
      ids.push({id: m[1], file});
    }
  }
  return ids;
}

function auditDartVsSeed(items) {
  const errors = [];
  const seedIds = new Set(items.map((i) => String(i.id)));
  const dart = extractDartIds();
  const dartIds = dart.map((d) => d.id);
  const dartSet = new Set(dartIds);

  // Duplicados dentro de Dart
  const seen = new Set();
  for (const {id, file} of dart) {
    if (seen.has(id)) {
      errors.push(`ID duplicado en Dart: ${id} (visto en ${file})`);
    }
    seen.add(id);
  }

  // Lotes sincronizados: deben existir en seed
  const syncPrefixes = ["dir-apt-", "oro-cie-", "oro-soc-", "oro-rect-"];
  for (const id of dartSet) {
    if (!syncPrefixes.some((p) => id.startsWith(p))) continue;
    if (!seedIds.has(id)) {
      errors.push(`Dart tiene ${id} pero no está en seed JSON`);
    }
  }

  // Conteos de lotes en Dart vs EXPECTED (solo si el banco Dart incluye el lote completo)
  for (const [prefix, expected] of Object.entries(EXPECTED)) {
    const n = [...dartSet].filter((id) => id.startsWith(prefix)).length;
    if (n > 0 && n !== expected) {
      errors.push(
          `Dart ${prefix}* tiene ${n} IDs; esperado ${expected} (regenerar merge)`,
      );
    }
  }

  return errors;
}

async function auditFirestore(items) {
  const errors = [];
  if (!fs.existsSync(SA_PATH)) {
    if (strict) {
      errors.push(
          `Modo --strict: falta serviceAccount.json en ${SA_PATH}`,
      );
    } else {
      console.warn(
          "Aviso: sin serviceAccount.json; se omite comparación Firestore.",
      );
    }
    return errors;
  }

  let admin;
  try {
    admin = require(path.join(__dirname, "seed", "node_modules", "firebase-admin"));
  } catch (_) {
    try {
      admin = require("firebase-admin");
    } catch (e) {
      errors.push(
          "No se pudo cargar firebase-admin (cd tools/seed && npm i)",
      );
      return errors;
    }
  }

  if (!admin.apps.length) {
    const sa = JSON.parse(fs.readFileSync(SA_PATH, "utf8"));
    admin.initializeApp({
      credential: admin.credential.cert(sa),
      projectId: PROJECT_ID,
    });
  }

  const db = admin.firestore();
  const metaSnap = await db.collection("meta").doc("question_bank").get();
  const seedCount = items.length;

  if (!metaSnap.exists) {
    errors.push("Firestore meta/question_bank no existe (¿nunca se sembró?)");
  } else {
    const metaCount = metaSnap.data().count;
    if (metaCount !== seedCount) {
      errors.push(
          `Drift Firestore meta.count=${metaCount} vs seed=${seedCount}. Corre: node tools/seed/seed_firestore.js`,
      );
    }
  }

  // Conteo publicado (puede paginar si > límite; usamos agregación aproximada por docs)
  const pubSnap = await db
      .collection("questions")
      .where("published", "==", true)
      .count()
      .get();
  const cloudPublished = pubSnap.data().count;

  if (cloudPublished !== seedCount) {
    // seed_firestore escribe todos como published; si hay extras legacy, avisar
    errors.push(
        `Drift Firestore published=${cloudPublished} vs seed=${seedCount}`,
    );
  }

  // Sample: 5 IDs del seed deben existir en cloud con mismo correctIndex
  const sample = items.filter((i) => String(i.id).startsWith("dir-apt-")).slice(0, 3)
      .concat(items.filter((i) => String(i.id).startsWith("oro-cie-")).slice(0, 1))
      .concat(items.filter((i) => String(i.id).startsWith("oro-soc-")).slice(0, 1));

  for (const item of sample) {
    const doc = await db.collection("questions").doc(item.id).get();
    if (!doc.exists) {
      errors.push(`Firestore no tiene doc ${item.id}`);
      continue;
    }
    const data = doc.data();
    if (data.correctIndex !== item.correctIndex) {
      errors.push(
          `Drift ${item.id}: cloud correctIndex=${data.correctIndex} seed=${item.correctIndex}`,
      );
    }
    if ((data.stem || "") !== (item.stem || "")) {
      errors.push(`Drift ${item.id}: stem distinto en Firestore vs seed`);
    }
  }

  return errors;
}

async function main() {
  const {payload, items} = loadSeed();
  const errors = [];

  console.log(`Seed: ${SEED_PATH}`);
  console.log(`Ítems: ${items.length}`);

  errors.push(...auditMetaCount(payload, items));
  errors.push(...auditUniqueIds(items));
  errors.push(...auditBatchCounts(items));
  errors.push(...auditIntegrity(items));

  if (wantDart) {
    console.log("Chequeo Dart ↔ seed…");
    errors.push(...auditDartVsSeed(items));
  }

  if (wantFirestore) {
    console.log("Chequeo Firestore ↔ seed…");
    errors.push(...(await auditFirestore(items)));
  }

  // Resumen por pilar
  const byPillar = {};
  for (const i of items) {
    byPillar[i.pillar] = (byPillar[i.pillar] || 0) + 1;
  }
  console.log("Por pilar:", byPillar);
  for (const [prefix, expected] of Object.entries(EXPECTED)) {
    const n = items.filter((i) => String(i.id).startsWith(prefix)).length;
    console.log(`  ${prefix}* ${n}/${expected}`);
  }

  if (errors.length) fail(errors);

  console.log("\nOK: banco sincronizado (validación local" +
      (wantDart ? " + Dart" : "") +
      (wantFirestore ? " + Firestore" : "") +
      ").");
}

main().catch((err) => {
  console.error("Error validate_bank_sync:", err.message || err);
  process.exit(1);
});
