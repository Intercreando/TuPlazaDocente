/**
 * Ola 3: numéricas directivo aún “de cuaderno” y disciplinares de
 * primaria envueltos en caso genérico.
 *
 *   node tools/seed/upgrade_contest_wave3.js
 *
 * No cambia correctIndex ni el resultado numérico: solo el caso.
 * No mezcla distractores pedagógicos de aula en hechos de ciencia/historia.
 */
const fs = require("fs");
const path = require("path");
const {HAND_DIS} = require("./wave3_dis_cases");

const SEED = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");

function factsFromStem(stem) {
  const raw = String(stem || "").trim();
  let cut = raw.replace(/¿[^¿]*\?\s*$/u, "").trim();
  cut = cut.replace(/[,:;]\s*$/u, ".");
  if (cut && !/[.!?]$/.test(cut)) cut += ".";
  return cut || raw;
}

/** Repara cortes del enunciado original (coma colgante, «Si» sin apódosis, a.m..). */
function repairNumericCasePunctuation(item) {
  if (!String(item.id).startsWith("dir-apt-num-")) return item;
  const ctx = String(item.caseContext || "");
  const marker = " Un docente propone";
  const idx = ctx.indexOf(marker);
  if (idx < 0) return item;
  let head = ctx.slice(0, idx).replace(/,\s*$/u, ".").trim();
  const tail = ctx.slice(idx);
  head = head.replace(/\bSi\s+([\s\S]+)$/u, (_, rest) => {
    const r = String(rest).replace(/[.]+$/u, "").trim();
    if (!r) return _;
    return r.charAt(0).toUpperCase() + r.slice(1) + ".";
  });
  head = head.replace(/a\.m\.\.+/gi, "a.m.");
  head = head.replace(/p\.m\.\.+/gi, "p.m.");
  head = head.replace(/\.\.+$/u, ".");
  if (head && !/[.!?]$/.test(head)) head += ".";
  let next = head + tail;
  next = next.replace(/a\.m\.\.+/gi, "a.m.");
  next = next.replace(/p\.m\.\.+/gi, "p.m.");
  if (next === ctx) return item;
  return {...item, caseContext: next};
}

function distractorAnalysisFor(item, message) {
  const dist = {};
  const ci = Number(item.correctIndex);
  (item.options || []).forEach((_, i) => {
    if (i === ci) return;
    dist[String(i)] = message;
  });
  return dist;
}

function wrapNumericDirectivo(item) {
  if (item.pillar !== "aptitudNumerica") return item;
  if (item.qualityHardened) return item;
  if (!String(item.id).startsWith("dir-apt-num-")) return item;
  const ci = Number(item.correctIndex);
  const opts = item.options || [];
  if (opts.length < 4 || ci < 0 || ci >= opts.length) return item;
  const wrong = opts.filter((_, i) => i !== ci).map((o) => String(o).replace(/\.+$/u, ""));
  const facts = factsFromStem(item.stem);
  return {
    ...item,
    caseContext:
      `En el comité de calidad de una IE oficial se arma el informe para el PMI y el SIMAT. ` +
      `${facts} ` +
      `Un docente propone reportar ${wrong[0]} (otra base, redondeo o indicador distinto); ` +
      `otro insiste en ${wrong[1]}. Secretaría pide la cifra exacta, sin mezclar jornadas, ` +
      `periodos ni porcentajes de otro proceso.`,
    stem:
      "Para el acta institucional, ¿qué cifra es coherente con los datos del caso y la operación que se pide, sin redondear ni cambiar la base?",
    isCaseStudy: true,
    qualityHardened: true,
    difficulty: item.difficulty === "basico" ? "intermedio" : (item.difficulty || "intermedio"),
    dificultad: Math.max(Number(item.dificultad || 2), 2),
    distractorAnalysis: distractorAnalysisFor(
        item,
        "Cifra plausible si se cambia la base, se redondea o se opera un indicador distinto al del caso.",
    ),
  };
}

function applyDisHand(item) {
  const hand = HAND_DIS[item.id];
  if (!hand) return item;
  const next = {
    ...item,
    ...hand,
    isCaseStudy: true,
    qualityHardened: true,
    difficulty: "avanzado",
    dificultad: 3,
  };
  next.normativeJustification = next.explanation;
  next.theoreticalJustification = next.explanation;
  next.distractorAnalysis = distractorAnalysisFor(
      next,
      "Concepción plausible (sentido cotidiano, anacronismo o magnitud vecina) que no corresponde al aprendizaje esencial.",
  );
  return next;
}

const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
let numeric = 0;
let disciplinar = 0;

payload.items = payload.items.map((item) => {
  const before = JSON.stringify(item);
  let next = wrapNumericDirectivo(item);
  next = repairNumericCasePunctuation(next);
  if (JSON.stringify(next) !== before && next.pillar === "aptitudNumerica") {
    numeric += 1;
  }
  const afterNum = JSON.stringify(next);
  next = applyDisHand(next);
  if (JSON.stringify(next) !== afterNum) disciplinar += 1;
  return next;
});

payload.version = 3.8;
payload.generatedAt = new Date().toISOString();
payload.contestUpgradeWave3 = {
  at: payload.generatedAt,
  numericWrapped: numeric,
  disciplinarRewritten: disciplinar,
};

fs.writeFileSync(SEED, JSON.stringify(payload, null, 2), "utf8");
console.log(
    `OK ola 3: ${numeric} numéricas envueltas, ${disciplinar} disciplinares reescritas → ${SEED}`,
);
