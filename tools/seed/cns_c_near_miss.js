/**
 * Distractores “casi correctos” para ítems de concurso (no caricaturas).
 * No inventa artículos: usa marcos ya presentes en el ítem (1290, 1421, 1620, EBC/DBA).
 */

const CARTOON_RE =
  /eximir|prohibir|sancionar|trasladar|ignorar|memoriz|castig|expuls|improvis|sin plan|sin criterio|homogeneiz|para todos igual|activismo|nota mínima|humillar|ocultar el caso|publicar en redes|culpar a la v[ií]ctima|visto bueno|ranking p[uú]blico|sin evidencia|solo nota|solo ortograf[ií]a|eliminar el (área|manual|pei)/i;

const GENERIC_STEM_RE =
  /activismo vac[ií]o|omisi[oó]n normativa|la decisi[oó]n m[aá]s alineada|lo correcto es:|la respuesta inclusiva|seg[uú]n el decreto \d+|se define|se entiende por|cu[aá]l de las siguientes es/i;

function hashSeed(str) {
  let h = 2166136261;
  for (let i = 0; i < String(str).length; i++) {
    h ^= String(str).charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

function tagBlob(item) {
  const tags = item.knowledgeTags || item.knowledge_tags || [];
  const codes = tags.map((t) => String(t.code || t).toLowerCase()).join(" ");
  const topic = `${item.topic || ""} ${item.subtopic || ""} ${item.module || ""}`.toLowerCase();
  return `${codes} ${topic}`;
}

const BANKS = {
  inclusion: [
    [
      "Aplicar a todo el grupo el mismo instrumento, tiempo y formato, argumentando que la equidad consiste en un trato idéntico y formal.",
      "Conceder de palabra un ajuste solo en esa sesión, sin registrarlo ni revisarlo con el docente de apoyo y la familia.",
      "Sustituir de forma permanente la evidencia esencial del grado por una actividad recreativa, para evitar reclamos.",
    ],
    [
      "Mantener el PIAR como documento de matrícula, sin traducirlo a materiales, tiempos y formas de demostrar el aprendizaje.",
      "Evaluar con un formato no acordado de antemano, sin rúbrica previa ni relación explícita con los aprendizajes esenciales.",
      "Remitir el caso a otra institución “mejor preparada” mientras el aula conserva las mismas barreras de acceso.",
    ],
  ],
  evaluacion: [
    [
      "Entregar la nota al cierre del periodo y ofrecer recuperación como repetición del mismo instrumento, sin nueva enseñanza.",
      "Socializar la rúbrica el mismo día de los resultados, para “no adelantar la respuesta” a los estudiantes.",
      "Decidir promoción con el promedio aritmético y un concepto cualitativo genérico, sin evidencias de proceso.",
    ],
    [
      "Aumentar el número de quizzes para “tener más notas”, sin devolver criterios ni un siguiente paso de mejora.",
      "Dejar la autoevaluación como trámite de caritas o porcentajes, sin contrastarla con el trabajo producido.",
      "Unificar la evidencia en un único examen acumulativo sorpresa, aunque el SIEE prevea carácter formativo.",
    ],
  ],
  convivencia: [
    [
      "Tratar el episodio como indisciplina de aula: amonestación y compromiso de “no repetir”, sin tipificar ni seguimiento.",
      "Pedir a las familias que “se pongan de acuerdo” por WhatsApp y archivar el caso cuando baje la tensión visible.",
      "Hacer una charla general de valores y cambiar de puesto a quien reporta, sin registro ni monitoreo del clima.",
    ],
    [
      "Centralizar la atención en rectoría con una conversación privada, sin activar el comité ni dejar trazabilidad.",
      "Aplicar de inmediato la sanción más visible del manual, sin verificar proporcionalidad ni acuerdos restaurativos.",
      "Informar el caso en orientación de grupo “para prevenir”, sin filtrar datos que permitan identificar a las partes.",
    ],
  ],
  curriculum: [
    [
      "Seguir el índice del libro o un recurso viral, aunque desborde u omita los aprendizajes esenciales del grado.",
      "Evaluar solo el producto final de reproducción literal (definición, respuesta u ortografía), sin procesos ni representaciones.",
      "Integrar un proyecto atractivo sin metas de aprendizaje ligadas a EBC, DBA o lineamientos.",
    ],
    [
      "Adelantar contenidos de grados superiores “por el concurso”, sin asegurar las bases del DBA del grado actual.",
      "Mantener una sola representación (símbolo, copia o dictado) aunque el estudiante evidencie otra vía de comprensión.",
      "Contextualizar con actividades locales sueltas, sin formalizar la competencia que el referente exige.",
    ],
  ],
  gestion: [
    [
      "Resolver por mensaje o instrucción unilateral, sin pasar por la instancia (consejo, comité o SIEE) que el caso exige.",
      "Dejar constancia genérica en un acta, sin responsables, fechas ni seguimiento de la decisión.",
      "Priorizar la imagen institucional o la rapidez visible, aunque las evidencias muestren no aprendizaje o riesgo.",
    ],
  ],
  default: [
    [
      "Repetir la misma estrategia con más intensidad, sin diagnóstico nuevo ni andamiaje distinto.",
      "Adoptar una medida flexible que, en la práctica, elimina la meta esencial de aprendizaje o de protección.",
      "Documentar de forma genérica, sin activar SIEE, PIAR, ruta de convivencia u orientación de área según corresponda.",
    ],
  ],
};

function pickBank(item) {
  const blob = tagBlob(item);
  if (/1421|piar|inclus/.test(blob)) return BANKS.inclusion;
  if (/1290|evaluaci|siie|formativ/.test(blob)) return BANKS.evaluacion;
  if (/1620|convivencia|guia.?men.?49|guia.?men.?51|acoso/.test(blob)) {
    return BANKS.convivencia;
  }
  if (/ebc|dba|lineamiento|curr[ií]culo|bruner|ausubel|piaget|vygotsky/.test(blob)) {
    return BANKS.curriculum;
  }
  if (/1278|1860|ley115|pei|gesti[oó]n|directiv/.test(blob)) return BANKS.gestion;
  return BANKS.default;
}

function nearMisses(item) {
  const families = pickBank(item);
  const idx = hashSeed(item.id || "") % families.length;
  return families[idx];
}

function isCartoonOption(text) {
  const s = String(text || "").trim();
  if (s.length < 36) return true;
  return CARTOON_RE.test(s);
}

function needsStemRewrite(stem) {
  const s = String(stem || "").trim();
  if (s.length < 72) return true;
  return GENERIC_STEM_RE.test(s);
}

function expandCase(item) {
  const core = String(item.caseContext || "").trim();
  if (core.length >= 280) return core;
  const seed = core ||
    `Hay una tensión práctica en torno a ${item.topic || "la enseñanza y la evaluación"}.`;
  return (
    `En una institución educativa oficial ocurre lo siguiente: ${seed} ` +
    `Un sector de la comunidad pide una salida inmediata y visible; un colega propone ` +
    `“tratar a todos igual” para evitar reclamos. La decisión debe ser trazable ` +
    `(criterios, evidencia e instancias) y pedagógicamente mediada, no una ocurrencia.`
  );
}

function caseAnchoredStem(item) {
  const caso = String(item.caseContext || "").replace(/\s+/g, " ").trim();
  const clip = caso.length > 110 ? `${caso.slice(0, 107).trim()}…` : caso;
  if (clip) {
    return (
      `A partir del caso —${clip}—, ¿qué decisión sostiene a la vez el derecho a aprender ` +
      `(o a la protección, si aplica), la trazabilidad institucional y la mediación pedagógica?`
    );
  }
  return (
    "Teniendo en cuenta las tensiones del caso (comunidad, equidad formal y marco vigente), " +
    "¿qué decisión es la más defendible pedagógica e institucionalmente?"
  );
}

function uniqueOptions(options) {
  const seen = new Set();
  return options.map((opt, i) => {
    let text = String(opt);
    let n = 1;
    while (seen.has(text)) {
      n += 1;
      text = `${opt} (variante ${n})`;
    }
    seen.add(text);
    return text;
  });
}

function isNamedEntityAnswer(text) {
  const s = String(text || "").trim();
  if (s.length > 96) return false;
  return /^(El|La|Los|Las|Un|Una)\s/.test(s) ||
    /^(PEI|PIAR|SIEE|CNSC|Decreto|Ley)\b/i.test(s);
}

function isDefinitionStem(stem) {
  return /se define|se entiende por|cu[aá]l de las siguientes es una fuente|qui[eé]n tiene la responsabilidad|qu[eé] instancia del gobierno|cu[aá]l es el instrumento que orienta|cu[aá]l es la funci[oó]n principal del personero/i
      .test(String(stem || ""));
}

function isInvertedStem(stem) {
  return /m[aá]s d[eé]bil|menos adecuada|es incorrecta|el error consiste|no corresponde|pr[aá]ctica m[aá]s d[eé]bil/i
      .test(String(stem || ""));
}

/**
 * Endurece un ítem pedagógico: caso denso, stem anclado y distractores plausibles.
 * Conserva la opción correcta (no reescribe su sentido).
 * No mezcla definiciones (p. ej. “El Consejo Directivo”) con distractores de aula.
 */
function upgradePedagogicalItem(item) {
  if (!item || (item.pillar !== "pedagogico" && item.pilar !== "pedagogico")) {
    return item;
  }
  const next = {
    ...item,
    options: Array.isArray(item.options) ? [...item.options] : item.options,
  };
  const ci = Number(next.correctIndex);
  if (!Array.isArray(next.options) || next.options.length < 4 || Number.isNaN(ci)) {
    return next;
  }

  const correct = String(next.options[ci] || "");
  if (
    isDefinitionStem(next.stem) ||
    isInvertedStem(next.stem) ||
    isNamedEntityAnswer(correct)
  ) {
    return item;
  }

  const originalCase = String(next.caseContext || "").trim();
  if (originalCase.length < 280 && originalCase.length > 0) {
    next.caseContext = expandCase({...next, caseContext: originalCase});
    next.isCaseStudy = true;
  }

  if (needsStemRewrite(next.stem)) {
    next.stem =
      "Con base en el episodio descrito, ¿qué decisión es la más defendible " +
      "pedagógica e institucionalmente?";
  }

  const cartoonCount = next.options.filter((o, i) => i !== ci && isCartoonOption(o)).length;
  if (cartoonCount >= 1 && correct.length >= 40) {
    const misses = nearMisses(next);
    let m = 0;
    const dist = {};
    for (let i = 0; i < next.options.length; i++) {
      if (i === ci) continue;
      next.options[i] = misses[m % misses.length];
      dist[i] =
        "Parece profesional o equitativa, pero es parcial: omite mediación, registro o el aprendizaje/protección esencial.";
      m += 1;
    }
    next.distractorAnalysis = dist;
  }

  next.options = uniqueOptions(next.options);
  const d = Number(next.dificultad || 2);
  if (d < 3 && cartoonCount >= 1) {
    next.dificultad = 3;
    next.difficulty = "avanzado";
    next.recommendedSeconds = Math.max(Number(next.recommendedSeconds || 0), 110);
  }
  next.qualityHardened = true;
  return next;
}

module.exports = {
  CARTOON_RE,
  GENERIC_STEM_RE,
  isCartoonOption,
  needsStemRewrite,
  expandCase,
  caseAnchoredStem,
  nearMisses,
  uniqueOptions,
  isNamedEntityAnswer,
  isDefinitionStem,
  isInvertedStem,
  upgradePedagogicalItem,
};
