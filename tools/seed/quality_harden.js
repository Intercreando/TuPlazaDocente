/**
 * Pase de calidad CNSC/ICFES:
 * - Baraja la posición de la correcta (A/B/C/D equilibrado, determinista por id).
 * - Endurece plantillas con stems genéricos y distractores obvios.
 * - Sube dificultad cuando el ítem era demasiado predecible.
 */

function hashSeed(str) {
  let h = 2166136261;
  for (let i = 0; i < str.length; i++) {
    h ^= str.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

function mulberry32(seed) {
  let a = seed >>> 0;
  return function next() {
    a |= 0;
    a = (a + 0x6d2b79f5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function shuffleInPlace(arr, rng) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(rng() * (i + 1));
    const tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }
  return arr;
}

/** Remapea opciones, correctIndex y distractorAnalysis. */
function shuffleCorrectPosition(item) {
  const options = Array.isArray(item.options) ? [...item.options] : null;
  if (!options || options.length < 4 || item.correctIndex == null) {
    return item;
  }

  const oldCorrect = Number(item.correctIndex);
  if (oldCorrect < 0 || oldCorrect >= options.length) return item;

  const order = options.map((_, i) => i);
  const rng = mulberry32(hashSeed(`${item.id}|shuffle|v3`));
  shuffleInPlace(order, rng);

  const oldDist = item.distractorAnalysis || {};
  const newOptions = order.map((oldIdx) => options[oldIdx]);
  const newCorrect = order.indexOf(oldCorrect);
  const newDist = {};
  for (let newIdx = 0; newIdx < order.length; newIdx++) {
    const oldIdx = order[newIdx];
    if (oldIdx === oldCorrect) continue;
    const analysis = oldDist[oldIdx] ?? oldDist[String(oldIdx)];
    if (analysis) newDist[newIdx] = analysis;
  }

  return {
    ...item,
    options: newOptions,
    correctIndex: newCorrect,
    distractorAnalysis: newDist,
  };
}

const WEAK_OPTION_SNIPPETS = [
  "mantener la práctica",
  "sancionar sin mediación",
  "ignorar evidencias",
  "ignorar referentes",
  "priorizar sanción o improvisación",
  "priorizar sanción, exclusión o activismo",
];

const STEM_VARIANTS = [
  (c) => `Ante este caso, ¿cuál decisión articula mejor norma vigente y teoría del aprendizaje?`,
  (c) => `Si debieras intervenir de inmediato, ¿qué acción sería la más defendible en un ítem CNSC/ICFES?`,
  (c) => `Cuál de las siguientes respuestas evita tanto el activismo vacío como la omisión normativa?`,
  (c) => `La opción más coherente con referentes MEN y mediación pedagógica es:`,
  (c) => `Para no caer en una práctica “casi correcta” pero insuficiente, conviene:`,
  (c) => `Evaluando proporcionalidad, trazabilidad y aprendizaje, la mejor decisión es:`,
];

function looksLikeTemplate(item) {
  const id = String(item.id || "");
  if (id.startsWith("oro-m-") || id.startsWith("oro-w2-") || id.startsWith("oro-x-")) {
    return true;
  }
  if (/^oro-esp-.+-m\d+/i.test(id)) return true;
  const stem = String(item.stem || "");
  if (stem.startsWith("La decisión más alineada")) return true;
  const opts = (item.options || []).map((o) => String(o).toLowerCase());
  return opts.some((o) => WEAK_OPTION_SNIPPETS.some((w) => o.includes(w)));
}

function nearMissDistractors(item, rng) {
  const tags = (item.knowledgeTags || []).map((t) => t.code || t).join(" ");
  const banks = [
    [
      "Aplicar un protocolo parcial (acta o amonestación) sin mediación ni seguimiento de aprendizajes/convivencia",
      "Priorizar cobertura de temario o imagen institucional aunque las evidencias muestren no aprendizaje o riesgo",
      "Homogeneizar la respuesta “para todos igual” omitiendo ajustes, criterios o tipificación del caso",
    ],
    [
      "Delegar la solución solo a familias o canales informales, sin instancia ni registro institucional",
      "Usar sanción visible como única estrategia, sin criterios formativos ni restauración del vínculo",
      "Documentar el caso de forma genérica sin activar SIEE, PIAR, ruta 1620 u orientación de área según corresponda",
    ],
    [
      "Adoptar una medida “flexible” que en la práctica elimina la meta esencial de aprendizaje o protección",
      "Repetir la misma estrategia didáctica/administrativa con más intensidad, sin diagnóstico ni andamiaje nuevo",
      "Resolver con criterio personal del docente/directivo, desconectado de PEI, SIEE o referentes MEN",
    ],
  ];
  if (tags.includes("decreto1421")) {
    return [
      "Mantener la misma evidencia para todos “por equidad”, sin ajustes del PIAR",
      "Eximir de toda evidencia de aprendizaje esencial “para no complicarse”",
      "Bajar la meta esencial de forma informal, sin acuerdo ni registro en el PIAR",
    ];
  }
  if (tags.includes("ley1620") || tags.includes("guiaMen49") || tags.includes("guiaMen51")) {
    return [
      "Tratar el conflicto solo como indisciplina leve sin tipificar ni activar la ruta",
      "Exponer el caso en redes o salas comunes “para prevenir”, vulnerando confidencialidad",
      "Archivar el episodio tras una charla verbal, sin seguimiento ni registro de acuerdos",
    ];
  }
  if (tags.includes("decreto1290")) {
    return [
      "Calificar con un único instrumento final y devolver solo la nota, sin criterios previos",
      "Promover por promedio aritmético aunque no haya evidencias formativas del proceso",
      "Entregar la rúbrica después de calificar “para que no se preparen”",
    ];
  }
  if (tags.includes("guiaMen50") || tags.includes("piaget")) {
    return [
      "Acelerar planas y evaluaciones escritas como en primaria, reduciendo juego y observación",
      "Usar ranking de “listos/atrasados” frente al grupo como principal devolución",
      "Sustituir el cuidado y la rutina significativa por presión escolarizante prematura",
    ];
  }
  if (tags.includes("ebc") || tags.includes("dba") || tags.includes("lineamientos")) {
    return [
      "Seguir solo el índice del libro, aunque desborde o omita DBA/EBC del grado",
      "Evaluar únicamente el producto final memorístico, sin procesos ni representaciones",
      "Integrar áreas en un proyecto sin criterios ni metas de aprendizaje por referente",
    ];
  }
  if (tags.includes("decreto1278")) {
    return [
      "Usar la evaluación de desempeño solo para ranking o sanción, sin plan de mejoramiento",
      "Omitir debido proceso o criterios previos en actuaciones que afectan al docente",
      "Confundir SIEE estudiantil (1290) con evaluación de desempeño docente (1278)",
    ];
  }
  const pick = banks[Math.floor(rng() * banks.length)];
  return pick;
}

function hardenTemplate(item) {
  if (!looksLikeTemplate(item)) {
    return item;
  }

  const rng = mulberry32(hashSeed(`${item.id}|harden|v3`));
  const next = {...item, options: [...(item.options || [])]};
  const correctIdx = Number(next.correctIndex);
  const correctText = next.options[correctIdx];

  // Stem más exigente y menos repetido.
  const stemFn = STEM_VARIANTS[Math.floor(rng() * STEM_VARIANTS.length)];
  next.stem = stemFn(next.caseContext || next.subtopic || "");

  // Distractores “casi correctos”.
  const near = nearMissDistractors(next, rng);
  const newOptions = [correctText, near[0], near[1], near[2]];
  // Dejar la correcta en índice 0 temporalmente; el shuffle global la mueve.
  next.options = newOptions;
  next.correctIndex = 0;
  next.distractorAnalysis = {
    1: "Parece institucional, pero es parcial: omite mediación, seguimiento o aprendizaje esencial.",
    2: "Privilegia cobertura, imagen o costumbre por encima de evidencia y derecho a aprender/proteger.",
    3: "Uniforma o improvisa sin tipificación, criterios o ajustes que el caso exige.",
  };

  // Subir exigencia: plantillas endurecidas ≥ 2; muchas a 3.
  const bump = rng() < 0.55 ? 3 : 2;
  next.dificultad = Math.max(Number(next.dificultad || 2), bump);
  next.difficulty =
    next.dificultad === 1 ? "basico" : next.dificultad === 3 ? "avanzado" : "intermedio";
  next.recommendedSeconds = next.dificultad === 3 ? 120 : 95;
  next.qualityHardened = true;
  return next;
}

/**
 * Retira clones débiles oro-m con el mismo caso base (mantiene 1 por familia conceptual).
 * Conserva k=1 y k=2 como máximo si el id termina en patrón alto.
 */
function retireWeakMicroClones(items) {
  const seen = new Map();
  const out = [];
  for (const item of items) {
    const id = String(item.id || "");
    // oro-m-1290-15 → familia oro-m-1290 + caso textual sin "(contexto de aula N)"
    if (id.startsWith("oro-m-")) {
      const baseCaso = String(item.caseContext || "")
          .replace(/\s*\(contexto de aula \d+\)\.?/i, "")
          .trim();
      const key = `oro-m|${baseCaso}`;
      const count = seen.get(key) || 0;
      if (count >= 2) {
        continue; // retira clones 3..12
      }
      seen.set(key, count + 1);
    }
    out.push(item);
  }
  return out;
}

function balanceReport(items) {
  const pos = {0: 0, 1: 0, 2: 0, 3: 0};
  const dif = {1: 0, 2: 0, 3: 0};
  let hardened = 0;
  for (const i of items) {
    pos[i.correctIndex] = (pos[i.correctIndex] || 0) + 1;
    const d = Number(i.dificultad || 2);
    dif[d] = (dif[d] || 0) + 1;
    if (i.qualityHardened) hardened++;
  }
  return {pos, dif, hardened, total: items.length};
}

/**
 * @param {any[]} items
 * @return {{items: any[], report: object}}
 */
function bumpEasyItems(item) {
  const rng = mulberry32(hashSeed(`${item.id}|bump|v3`));
  const d = Number(item.dificultad || 2);
  // Sube una parte de las básicas demasiado obvias a intermedio/avanzado.
  if (d === 1 && rng() < 0.45) {
    const nextDif = rng() < 0.35 ? 3 : 2;
    return {
      ...item,
      dificultad: nextDif,
      difficulty: nextDif === 3 ? "avanzado" : "intermedio",
      recommendedSeconds: nextDif === 3 ? 110 : 80,
    };
  }
  return item;
}

function applyQualityPass(items) {
  let next = retireWeakMicroClones(items);
  next = next.map((item) => hardenTemplate(item));
  next = next.map((item) => bumpEasyItems(item));
  next = next.map((item) => shuffleCorrectPosition(item));
  const report = balanceReport(next);
  return {items: next, report};
}

module.exports = {
  applyQualityPass,
  shuffleCorrectPosition,
  hardenTemplate,
  retireWeakMicroClones,
};
