/**
 * Auditoría de ítems obvios / memorísticos (pilar pedagógico).
 * No modifica el banco: solo reporta.
 *
 *   node tools/audit_obvious_items.js
 */
const fs = require("fs");
const path = require("path");

const SEED = path.join(__dirname, "..", "assets", "seed", "questions_v1.json");
const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
const items = payload.items || [];

const GIVEAWAY_BAD = [
  "eximir",
  "prohibir",
  "sancionar",
  "trasladar",
  "ignorar",
  "memoriz",
  "castig",
  "expuls",
  "improvis",
  "sin plan",
  "sin criterio",
  "homogeneiz",
  "para todos igual",
  "repetir la explicación",
  "guías individuales de la casa",
  "activismo",
];

const GIVEAWAY_GOOD = [
  "ajustes razonables",
  "piar",
  "andamiaje",
  "zona de desarrollo próximo",
  "zdp",
  "evaluación formativa",
  "retroaliment",
  "dba",
  "pei",
  "ruta de atención",
  "ley 1620",
];

const MEMO_STEM = [
  /se define/i,
  /se entiende por/i,
  /es el proceso/i,
  /según el decreto \d+/i,
  /según la ley \d+/i,
  /la práctica más débil/i,
  /cuál de las siguientes es/i,
  /corresponde a la definición/i,
];

function score(item) {
  const opts = (item.options || []).map((o) => String(o));
  const stem = String(item.stem || "");
  const ctx = String(item.caseContext || "");
  const flags = [];
  let s = 0;

  if (!ctx || ctx.length < 80) {
    s += 3;
    flags.push("caso_corto_o_ausente");
  }
  if (stem.length < 70) {
    s += 2;
    flags.push("enunciado_corto");
  }
  if (MEMO_STEM.some((re) => re.test(stem))) {
    s += 4;
    flags.push("enunciado_memoristico");
  }
  if (item.isCaseStudy !== true && item.is_case_study !== true) {
    s += 1;
    flags.push("no_marcado_caso");
  }

  const lens = opts.map((o) => o.length);
  const ci = Number(item.correctIndex);
  if (opts.length === 4 && ci >= 0 && ci < 4) {
    const correctLen = lens[ci];
    const others = lens.filter((_, i) => i !== ci);
    const avgOthers = others.reduce((a, b) => a + b, 0) / others.length;
    if (correctLen > avgOthers * 1.55 && correctLen - avgOthers > 40) {
      s += 3;
      flags.push("correcta_mucho_mas_larga");
    }
  }

  const low = opts.map((o) => o.toLowerCase());
  let badHits = 0;
  let goodOnlyInCorrect = 0;
  low.forEach((o, i) => {
    const bad = GIVEAWAY_BAD.some((w) => o.includes(w));
    const good = GIVEAWAY_GOOD.some((w) => o.includes(w));
    if (i !== ci && bad) {
      badHits += 1;
    }
    if (i === ci && good) goodOnlyInCorrect += 1;
    if (i !== ci && good) goodOnlyInCorrect -= 1;
  });
  if (badHits >= 2) {
    s += 4;
    flags.push("distractores_caricaturescos");
  } else if (badHits === 1) {
    s += 2;
    flags.push("un_distractor_extremo");
  }
  if (goodOnlyInCorrect >= 1 && badHits >= 1) {
    s += 3;
    flags.push("se_resuelve_solo_con_opciones");
  }

  const dif = String(item.difficulty || item.dificultad || "");
  if (dif === "basico" || dif === "1" || dif === "facil") {
    s += 1;
    flags.push("dificultad_baja");
  }

  return {s, flags};
}

const ped = items.filter((i) => i.pillar === "pedagogico" || i.pilar === "pedagogico");
const scored = ped
    .map((item) => {
      const r = score(item);
      return {id: item.id, topic: item.topic || item.subtopic, score: r.s, flags: r.flags, stem: item.stem, options: item.options, correctIndex: item.correctIndex, caseContext: item.caseContext};
    })
    .sort((a, b) => b.score - a.score);

const byFlag = {};
for (const row of scored) {
  for (const f of row.flags) byFlag[f] = (byFlag[f] || 0) + 1;
}

const crit = scored.filter((r) => r.score >= 8);
const high = scored.filter((r) => r.score >= 5);
const mid = scored.filter((r) => r.score >= 3 && r.score < 5);

const report = {
  totalBanco: items.length,
  pedagogico: ped.length,
  criticos_score8plus: crit.length,
  altos_score5plus: high.length,
  medios_score3a4: mid.length,
  flags: byFlag,
  top40: scored.slice(0, 40).map((r) => ({
    id: r.id,
    score: r.score,
    flags: r.flags,
    topic: r.topic,
    stem: r.stem,
    options: r.options,
    correctIndex: r.correctIndex,
    caseContext: r.caseContext,
  })),
};

const out = path.join(__dirname, "audit_pedagogico_report.json");
fs.writeFileSync(out, JSON.stringify(report, null, 2), "utf8");
console.log(JSON.stringify({
  pedagogico: ped.length,
  criticos: crit.length,
  altos: high.length,
  medios: mid.length,
  flags: byFlag,
  reporte: out,
}, null, 2));
