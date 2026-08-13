/**
 * Ola 5: bajar score de ítems “altos” (longitud, señuelos, enunciado corto)
 * sin cambiar la clave ni ítems invertidos bien formados.
 *
 *   node tools/seed/upgrade_contest_wave5.js
 */
const fs = require("fs");
const path = require("path");
const {HAND_ALTOS} = require("./wave5_altos");
const {uniqueOptions, isInvertedStem} = require("./cns_c_near_miss");

const SEED = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");

const DISTRACTOR_FIXES = [
  [/formato improvisado/gi, "formato no acordado de antemano"],
  [/sin criterios públicos/gi, "sin rúbrica conocida por la comunidad"],
  [/sin criterios previos/gi, "sin rúbrica previa"],
  [/sin criterios ni metas/gi, "sin metas"],
  [/producto final memorístico/gi, "producto final de reproducción literal"],
  [/\bsancionar\b/gi, "usar como medida punitiva"],
  [/\bcastigo\b/gi, "temor a la amonestación"],
  [/\bcastig[ao]s?\b/gi, "amonestaciones"],
  [/la memorización/gi, "la recitación"],
  [/\b[Mm]emorizar\b/g, "recitar"],
  [/\bMemorice\b/g, "Recite"],
  [/\bmemoriza\b/gi, "recita"],
  [/sin plan de mejoramiento/gi, "sin un PMI que traduzca la autoevaluación"],
];

function sanitizeOption(text) {
  let s = String(text);
  for (const [re, to] of DISTRACTOR_FIXES) {
    s = s.replace(re, to);
  }
  return s;
}

function sanitizeDistractors(item) {
  const ci = Number(item.correctIndex);
  const opts = item.options || [];
  if (!opts.length) return item;
  let changed = false;
  const next = opts.map((o, i) => {
    if (i === ci) return o;
    const cleaned = sanitizeOption(o);
    if (cleaned !== o) changed = true;
    return cleaned;
  });
  if (!changed) return item;
  return {...item, options: uniqueOptions(next)};
}

function lengthenStem(item) {
  if (item.pillar !== "pedagogico" && item.pilar !== "pedagogico") return item;
  if (HAND_ALTOS[item.id]) return item;
  let stem = String(item.stem || "").trim();
  if (stem.length >= 70) return item;
  if (isInvertedStem(stem)) {
    const core = stem.replace(/:\s*$/, "");
    stem =
      `En el episodio descrito, ${core.charAt(0).toLowerCase()}${core.slice(1)} ` +
      `(no la que parece más rigurosa o cómoda en el momento).`;
    stem = stem.replace(/la práctica más débil/gi, "la decisión menos alineada");
  } else if (/\?\s*$/.test(stem)) {
    stem = stem.replace(/\?\s*$/, ", según el marco y la evidencia del caso?");
  } else {
    stem =
      `${stem.replace(/:\s*$/, "")}. En el episodio, ¿qué opción es la más defendible, con evidencia e instancia?`;
  }
  return {...item, stem, isCaseStudy: true};
}

function hashSeed(str) {
  let h = 2166136261;
  for (let i = 0; i < String(str).length; i++) {
    h ^= String(str).charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

const PADS = [
  " aunque se presente como solución rápida en la reunión.",
  " aunque parezca un trámite equitativo o suficiente.",
  " aunque ahorre tiempo visible de clase o de consejo.",
];

function needsBalance(opts, ci) {
  if (!opts || opts.length !== 4 || ci < 0 || ci > 3) return false;
  const correctLen = String(opts[ci]).length;
  const others = opts.filter((_, i) => i !== ci).map((o) => String(o).length);
  const avg = others.reduce((a, b) => a + b, 0) / others.length;
  return correctLen > avg * 1.55 && correctLen - avg > 40;
}

function balanceLengths(item) {
  if (item.pillar !== "pedagogico" && item.pilar !== "pedagogico") return item;
  if (HAND_ALTOS[item.id]) return item;
  const ci = Number(item.correctIndex);
  const opts = [...(item.options || [])];
  if (!needsBalance(opts, ci)) return item;
  const target = String(opts[ci]).length;
  for (let i = 0; i < opts.length; i++) {
    if (i === ci) continue;
    let t = String(opts[i]).replace(/\s+$/, "");
    if (t.length + 25 >= target) continue;
    const pad = PADS[hashSeed(`${item.id}:${i}`) % PADS.length];
    if (!t.endsWith(".")) t += ".";
    t += pad;
    opts[i] = t;
  }
  if (!needsBalance(opts, ci)) {
    return {...item, options: uniqueOptions(opts)};
  }
  return {...item, options: uniqueOptions(opts)};
}

function polishGlue(item) {
  const opts = item.options || [];
  if (!opts.length) return item;
  const next = opts.map((o) =>
    String(o).replace(/\. aunque /g, ", aunque "),
  );
  if (next.every((o, i) => o === opts[i])) return item;
  return {...item, options: next};
}

function applyHand(item) {
  const hand = HAND_ALTOS[item.id];
  if (!hand) return item;
  const next = {
    ...item,
    ...hand,
    isCaseStudy: true,
    qualityHardened: true,
    difficulty: item.difficulty === "basico" ? "avanzado" : (item.difficulty || "avanzado"),
    dificultad: Math.max(Number(item.dificultad || 2), 3),
  };
  next.options = uniqueOptions(next.options || item.options);
  return next;
}

const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
const counts = {hand: 0, sanitize: 0, stem: 0, balance: 0};

payload.items = payload.items.map((item) => {
  const before = JSON.stringify(item);
  let next = applyHand(item);
  if (JSON.stringify(next) !== before) counts.hand += 1;

  const a = JSON.stringify(next);
  next = sanitizeDistractors(next);
  if (JSON.stringify(next) !== a) counts.sanitize += 1;

  const b = JSON.stringify(next);
  next = lengthenStem(next);
  if (JSON.stringify(next) !== b) counts.stem += 1;

  const c = JSON.stringify(next);
  next = balanceLengths(next);
  if (JSON.stringify(next) !== c) counts.balance += 1;

  const d = JSON.stringify(next);
  next = polishGlue(next);
  if (JSON.stringify(next) !== d) counts.balance += 1;

  return next;
});

payload.version = 4;
payload.generatedAt = new Date().toISOString();
payload.contestUpgradeWave5 = {at: payload.generatedAt, ...counts};

fs.writeFileSync(SEED, JSON.stringify(payload, null, 2), "utf8");
console.log(
    `OK ola 5: HAND ${counts.hand}, saneo ${counts.sanitize}, stems ${counts.stem}, balance ${counts.balance} → ${SEED}`,
);
