/**
 * Audita el banco buscando ítems que hablan de un caso que no existe.
 *
 * Síntoma en la app: el enunciado dice “en este caso”, “según esta
 * situación”… pero no hay `caseContext` que mostrar, así que la pregunta
 * llega sin el texto al que se refiere.
 *
 * Uso: node tools/audit_case_context.js [--json]
 */
const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..");
const seedPath = path.join(root, "assets", "seed", "questions_v1.json");
const dartBankDir = path.join(root, "lib", "data");

/// Frases que solo tienen sentido si antes hubo un caso o situación.
const REFERENCES = [
  /\ben (este|el) caso\b/i,
  /\bel caso (descrito|planteado|anterior|expuesto|presentado)\b/i,
  /\bdel caso (descrito|planteado|anterior|expuesto|presentado)\b/i,
  /\b(seg[uú]n|ante|frente a) (esta|la) situaci[oó]n\b/i,
  /\bla situaci[oó]n (descrita|planteada|anterior|expuesta|presentada)\b/i,
  /\ben (esta|la) situaci[oó]n\b/i,
  /\beste escenario\b/i,
  /\bel escenario (descrito|planteado|anterior)\b/i,
  /\bseg[uú]n el texto\b/i,
  /\bdel texto (anterior|le[íi]do)\b/i,
  /\bel fragmento (anterior|le[íi]do|citado)\b/i,
  /\bla docente del caso\b/i,
  /\bel docente del caso\b/i,
];

function hasCase(item) {
  const value = item.caseContext;
  return typeof value === "string" && value.trim().length > 0;
}

function referenceIn(text) {
  for (const pattern of REFERENCES) {
    const found = pattern.exec(text);
    if (found) return found[0];
  }
  return null;
}

/// Extrae el texto de literales Dart adyacentes: stem: 'a' 'b' → "ab".
function dartString(block, field) {
  const pattern = new RegExp(`${field}:\\s*((?:'(?:[^'\\\\]|\\\\.)*'\\s*)+)`);
  const found = pattern.exec(block);
  if (!found) return "";
  return found[1]
      .split(/'\s*'/)
      .join("")
      .replace(/^'|'\s*$/g, "")
      .replace(/\\'/g, "'")
      .replace(/\\n/g, " ");
}

/// Misma revisión sobre los bancos escritos en Dart (lib/data/*_bank.dart),
/// que se suman al seed cuando la app arma las sesiones.
function auditDartBanks() {
  const orphans = [];
  if (!fs.existsSync(dartBankDir)) return orphans;

  for (const name of fs.readdirSync(dartBankDir).sort()) {
    if (!name.endsWith(".dart")) continue;
    const source = fs.readFileSync(path.join(dartBankDir, name), "utf8");
    const blocks = source.split(/\bQuestion\(/).slice(1);
    for (const block of blocks) {
      if (/caseContext:/.test(block)) continue;
      const stem = dartString(block, "stem");
      const match = referenceIn(stem);
      if (!match) continue;
      orphans.push({
        id: dartString(block, "id") || "(sin id)",
        file: name,
        match,
        stem: stem.slice(0, 140),
      });
    }
  }
  return orphans;
}

function main() {
  const raw = JSON.parse(fs.readFileSync(seedPath, "utf8"));
  const items = Array.isArray(raw.items) ? raw.items : [];
  const orphans = [];
  const emptyCases = [];

  for (const item of items) {
    if (typeof item.caseContext === "string" && !item.caseContext.trim()) {
      emptyCases.push(item.id);
    }
    if (hasCase(item)) continue;
    const texts = [item.stem || ""].concat(
        Array.isArray(item.options) ? item.options : []);
    for (const text of texts) {
      const match = referenceIn(String(text));
      if (match) {
        orphans.push({
          id: item.id,
          pillar: item.pillar,
          topic: item.topic,
          dificultad: item.dificultad ?? item.difficulty ?? null,
          match,
          stem: String(item.stem || "").slice(0, 140),
        });
        break;
      }
    }
  }

  const dartOrphans = auditDartBanks();

  if (process.argv.includes("--json")) {
    console.log(JSON.stringify({ orphans, dartOrphans, emptyCases }, null, 2));
    return;
  }

  console.log(`Ítems del seed revisados: ${items.length}`);
  console.log(`Seed sin caso pero citándolo: ${orphans.length}`);
  console.log(`Bancos Dart sin caso pero citándolo: ${dartOrphans.length}`);
  if (emptyCases.length) {
    console.log(`Con caseContext vacío: ${emptyCases.join(", ")}`);
  }

  const byDifficulty = new Map();
  for (const item of orphans) {
    const key = String(item.dificultad);
    byDifficulty.set(key, (byDifficulty.get(key) || 0) + 1);
  }
  if (byDifficulty.size) {
    const summary = [...byDifficulty.entries()]
        .map(([level, total]) => `nivel ${level}: ${total}`)
        .join(", ");
    console.log(`Por dificultad → ${summary}`);
  }

  for (const item of orphans) {
    console.log(
        `\n- ${item.id} [${item.pillar} | nivel ${item.dificultad}] («${item.match}»)`);
    console.log(`  ${item.stem}`);
  }

  const byFile = new Map();
  for (const item of dartOrphans) {
    byFile.set(item.file, (byFile.get(item.file) || 0) + 1);
  }
  for (const [file, total] of byFile) {
    console.log(`\n${file}: ${total}`);
    for (const item of dartOrphans.filter((o) => o.file === file)) {
      console.log(`  - ${item.id} («${item.match}») ${item.stem}`);
    }
  }

  if (orphans.length + dartOrphans.length > 0) process.exitCode = 1;
}

main();
