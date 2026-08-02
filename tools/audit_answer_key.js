/**
 * Auditoría automática de claves de respuesta (aptitud numérica + integridad).
 * Uso: node tools/audit_answer_key.js
 * Sale con código 1 si hay errores.
 */
const fs = require("fs");
const path = require("path");

const SEED = path.join(__dirname, "..", "assets", "seed", "questions_v1.json");

function parseNum(s) {
  return Number(String(s).replace(/[^\d.-]/g, ""));
}

function auditSeedNumeric(items) {
  const errors = [];
  for (const i of items.filter((q) => q.pillar === "aptitudNumerica")) {
    const stem = i.stem || "";
    let expected = null;
    let m;
    if ((m = stem.match(/(\d+(?:\.\d+)?)%\s+de\s+(\d+(?:\.\d+)?)/i))) {
      expected = (Number(m[1]) / 100) * Number(m[2]);
    } else if (
      (m = stem.match(
        /Si (\d+) docentes elaboran (\d+) rúbricas.*elaborarán (\d+)/i,
      ))
    ) {
      expected = (Number(m[2]) / Number(m[1])) * Number(m[3]);
    } else if (
      (m = stem.match(
        /dieron ([\d,\s]+)\. ¿Qué puntaje.*promedio (\d+)/i,
      ))
    ) {
      const scores = m[1].split(/,\s*/).map(Number);
      expected = Number(m[2]) * (scores.length + 1) - scores.reduce((a, b) => a + b, 0);
    } else {
      errors.push({id: i.id, reason: "no_parseable", stem});
      continue;
    }
    const marked = parseNum(i.options[i.correctIndex]);
    if (!Number.isFinite(marked) || Math.abs(expected - marked) > 0.01) {
      errors.push({
        id: i.id,
        reason: "wrong_key",
        expected,
        marked,
        options: i.options,
        stem,
      });
    }
  }
  return errors;
}

function auditIntegrity(items) {
  const errors = [];
  for (const i of items) {
    if (!Array.isArray(i.options) || i.options.length < 2) {
      errors.push({id: i.id, reason: "options_invalid"});
      continue;
    }
    if (
      i.correctIndex < 0 ||
      i.correctIndex >= i.options.length ||
      !Number.isInteger(i.correctIndex)
    ) {
      errors.push({id: i.id, reason: "correctIndex_oob", correctIndex: i.correctIndex});
    }
    if (new Set(i.options).size !== i.options.length) {
      errors.push({id: i.id, reason: "duplicate_options"});
    }
    if (!(i.explanation || "").trim()) {
      errors.push({id: i.id, reason: "empty_explanation"});
    }
  }
  return errors;
}

function main() {
  const raw = JSON.parse(fs.readFileSync(SEED, "utf8"));
  const items = raw.items || [];
  const numeric = auditSeedNumeric(items);
  const integrity = auditIntegrity(items);
  const all = [...numeric, ...integrity];

  console.log(`Ítems auditados: ${items.length}`);
  console.log(`Errores numéricos: ${numeric.length}`);
  console.log(`Errores de integridad: ${integrity.length}`);
  if (all.length) {
    console.log(JSON.stringify(all, null, 2));
    process.exit(1);
  }
  console.log("OK: aptitud numérica del seed y integridad básica sin errores.");
}

main();
