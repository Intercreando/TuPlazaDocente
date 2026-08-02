/**
 * Genera el banco volumen en formato oro CNSC/ICFES para TuPlazaDocente.
 * Salida: ../../assets/seed/questions_v1.json
 */
const fs = require("fs");
const path = require("path");
const {handcrafted} = require("./gold_handcrafted");
const {applyQualityPass} = require("./quality_harden");

/** @type {any[]} */
const items = [];

function push(q) {
  items.push({
    published: true,
    schemaVersion: 1,
    ...q,
  });
}

function letterIndex(letter) {
  return {A: 0, B: 1, C: 2, D: 3}[letter];
}

// ——— Lote oro mano (norma + teoría) ———
for (const q of handcrafted) {
  push(q);
}

// ——— Ítems pedagógicos oro (mano, núcleo original) ———
const goldPed = [
  {
    id: "fs-gold-001",
    pilar: "pedagogico",
    modulo: "Pedagogía y evaluación formativa",
    subtema: "Decreto 1290 / Vygotsky",
    cargo_objetivo: "primaria",
    caso_contexto:
      "Un docente de 3° nota que un estudiante no logra resolver sumas con llevadas solo, pero en pareja con un compañero más avanzado comprende el procedimiento.",
    enunciado:
      "La estrategia más adecuada según teorías del aprendizaje y normativa de evaluación es:",
    opciones: [
      "Asignar solo guías individuales para la casa.",
      "Diseñar trabajo colaborativo que aproveche la ZDP para andamiar el proceso.",
      "Repetir explicación magistral hasta memorizar el algoritmo.",
      "Prohibir el trabajo en parejas para evaluar solo de forma individual.",
    ],
    respuesta_correcta: "B",
    justificacion_normativa:
      "El Decreto 1290 orienta una evaluación formativa que reconoce ritmos e intereses del estudiante para consolidar aprendizajes.",
    justificacion_teorica:
      "Vygotsky: en la Zona de Desarrollo Próximo el avance ocurre con mediación/andamiaje de un par más capaz.",
    analisis_distractores: {
      A: "Ignora la evidencia de avance con mediación social.",
      C: "Privilegia memorización mecánica.",
      D: "Bloquea el andamiaje entre pares.",
    },
    knowledge_tags: [
      {code: "decreto1290", focus: "evaluación formativa"},
      {code: "vygotsky", focus: "ZDP"},
    ],
    dificultad: 2,
    tiempo_recomendado_seg: 100,
    is_case_study: true,
  },
  {
    id: "fs-gold-002",
    pilar: "pedagogico",
    modulo: "Inclusión y convivencia escolar",
    subtema: "Decreto 1421 / PIAR",
    cargo_objetivo: "primaria",
    caso_contexto:
      "Ingresa una estudiante con discapacidad visual. El aula usa guías densas y evaluaciones cronometradas idénticas.",
    enunciado: "Según el marco de educación inclusiva, la decisión correcta es:",
    opciones: [
      "Eximirla de todas las evaluaciones.",
      "Diseñar PIAR y ajustes razonables en materiales, tiempo y forma de demostrar aprendizajes esenciales.",
      "Trasladarla sin plan a otra institución.",
      "Evaluarla oralmente sin criterios previos.",
    ],
    respuesta_correcta: "B",
    justificacion_normativa:
      "El Decreto 1421 exige PIAR y ajustes razonables para garantizar participación y aprendizaje con equidad.",
    justificacion_teorica:
      "Se adaptan condiciones de acceso y demostración, no se elimina el derecho a aprender con criterios claros.",
    analisis_distractores: {
      A: "Eximir de evaluación vulnera el derecho a ser valorado equitativamente.",
      C: "El traslado sin plan no cumple la obligación inclusiva.",
      D: "Sin criterios no hay evaluación formativa transparente.",
    },
    knowledge_tags: [
      {code: "decreto1421", focus: "PIAR"},
      {code: "decreto1290", focus: "criterios"},
    ],
    dificultad: 2,
    tiempo_recomendado_seg: 100,
    is_case_study: true,
  },
  {
    id: "fs-gold-003",
    pilar: "pedagogico",
    modulo: "Gestión institucional y PEI",
    subtema: "Ley 115 / Decreto 1860",
    cargo_objetivo: "directivos",
    caso_contexto:
      "La rectoría reescribe el PEI en una semana sin participación de la comunidad educativa.",
    enunciado: "La lectura más coherente con la norma es:",
    opciones: [
      "Es válido porque el PEI es trámite exclusivo de rectoría.",
      "Debilita la legitimidad del PEI, que se construye con la comunidad educativa.",
      "Solo importa el PMI; el PEI es opcional.",
      "La supervisión puede reemplazar al gobierno escolar.",
    ],
    respuesta_correcta: "B",
    justificacion_normativa:
      "Ley 115 y Decreto 1860 conciben PEI y gobierno escolar como construcción participativa.",
    justificacion_teorica:
      "Sin sentido compartido, el documento no orienta prácticas reales de aula ni de gestión.",
    analisis_distractores: {
      A: "El PEI no es trámite unilateral.",
      C: "El PEI no es prescindible.",
      D: "La supervisión no sustituye participación.",
    },
    knowledge_tags: [
      {code: "ley115", focus: "PEI"},
      {code: "decreto1860", focus: "gobierno escolar"},
    ],
    dificultad: 3,
    tiempo_recomendado_seg: 120,
    is_case_study: true,
  },
  {
    id: "fs-gold-004",
    pilar: "pedagogico",
    modulo: "Inclusión y convivencia escolar",
    subtema: "Ley 1620 / Guía MEN 51",
    cargo_objetivo: "primaria",
    caso_contexto:
      "Un estudiante de 8° reporta acoso reiterado; hay testigos y el agresor niega.",
    enunciado: "El primer curso de acción institucional correcto es:",
    opciones: [
      "Publicar el caso en redes del colegio.",
      "Activar ruta del Manual de Convivencia y Comité de Convivencia con debido proceso.",
      "Suspender sin investigación.",
      "Ignorar si no hay prueba física.",
    ],
    respuesta_correcta: "B",
    justificacion_normativa:
      "La Ley 1620 establece rutas de atención, registro, seguimiento y debido proceso.",
    justificacion_teorica:
      "Una respuesta institucional evita revictimización y castigo-espectáculo.",
    analisis_distractores: {
      A: "Exposición pública vulnera derechos.",
      C: "Sanción sin investigación viola debido proceso.",
      D: "La omisión no es opción ante un reporte.",
    },
    knowledge_tags: [
      {code: "ley1620", focus: "rutas"},
      {code: "guiaMen51", focus: "convivencia"},
    ],
    dificultad: 2,
    tiempo_recomendado_seg: 90,
    is_case_study: true,
  },
  {
    id: "fs-gold-005",
    pilar: "pedagogico",
    modulo: "Pedagogía y evaluación formativa",
    subtema: "Ausubel / DBA",
    cargo_objetivo: "matematicas",
    caso_contexto:
      "Antes de fracciones equivalentes, el docente indaga saberes previos con material concreto.",
    enunciado: "Esta práctica se alinea principalmente con:",
    opciones: [
      "Castigo del error y memorización del algoritmo.",
      "Aprendizaje significativo (Ausubel) anclado en saberes previos y progresión DBA/EBC.",
      "Solo exposición magistral sin activar conocimientos previos.",
      "Evaluación sumativa exclusiva al final del año.",
    ],
    respuesta_correcta: "B",
    justificacion_normativa:
      "DBA y EBC definen progresiones de saber y saber hacer; partir de previos hace viable esa progresión.",
    justificacion_teorica:
      "Ausubel: el aprendizaje es significativo cuando se relaciona de forma no arbitraria con la estructura cognitiva previa.",
    analisis_distractores: {
      A: "Memorización sin sentido = aprendizaje mecánico.",
      C: "Omitir previos dificulta el anclaje.",
      D: "Lo sumativo solo no guía el proceso.",
    },
    knowledge_tags: [
      {code: "ausubel", focus: "saberes previos"},
      {code: "dba", focus: "progresión"},
      {code: "ebc", focus: "competencias"},
    ],
    dificultad: 1,
    tiempo_recomendado_seg: 60,
    is_case_study: true,
  },
];

for (const g of goldPed) {
  push({
    id: g.id,
    pillar: g.pilar,
    topic: g.subtema,
    module: g.modulo,
    subtopic: g.subtema,
    targetCargo: g.cargo_objetivo,
    specialtyTags: [g.cargo_objetivo],
    caseContext: g.caso_contexto,
    stem: g.enunciado,
    options: g.opciones,
    correctIndex: letterIndex(g.respuesta_correcta),
    explanation: `${g.justificacion_normativa} ${g.justificacion_teorica}`,
    normativeJustification: g.justificacion_normativa,
    theoreticalJustification: g.justificacion_teorica,
    distractorAnalysis: {
      0: g.analisis_distractores.A,
      2: g.analisis_distractores.C,
      3: g.analisis_distractores.D,
    },
    knowledgeTags: g.knowledge_tags,
    normativeRefs: g.knowledge_tags.map((t) => t.code),
    difficulty: g.dificultad === 1 ? "basico" : g.dificultad === 3 ? "avanzado" : "intermedio",
    dificultad: g.dificultad,
    recommendedSeconds: g.tiempo_recomendado_seg,
    isCaseStudy: g.is_case_study,
  });
}

// ——— Generación Aptitud Numérica (volumen con explicación) ———
// Solo enteros exactos: NUNCA usar Math.round sobre el resultado correcto
// (eso marcó 9.6→10 y 7.5→8 en producción y destruye credibilidad).
function assertExactInteger(value, label) {
  if (!Number.isFinite(value) || Math.abs(value - Math.round(value)) > 1e-9) {
    throw new Error(`Aptitud numérica inválida (${label}): resultado no entero exacto = ${value}`);
  }
  return Math.round(value);
}

const numCases = [
  {a: 20, b: 150, op: "pct_of", label: "porcentaje de un total"},
  {a: 35, b: 200, op: "pct_of"},
  {a: 12.5, b: 80, op: "pct_of"},
  {a: 45, b: 320, op: "pct_of"},
  {a: 18, b: 250, op: "pct_of"},
  {a: 9, b: 6, op: "rule3", c: 12},
  {a: 6, b: 9, op: "rule3", c: 10},
  {a: 15, b: 5, op: "rule3", c: 6},
  {a: 14, b: 5, op: "rule3", c: 28},
  {a: 9, b: 6, op: "rule3", c: 15},
];

let n = 0;
for (const c of numCases) {
  n += 1;
  if (c.op === "pct_of") {
    const correct = assertExactInteger((c.a / 100) * c.b, `pct ${c.a}% de ${c.b}`);
    const opts = [correct, correct + 10, correct - 8, Math.round(correct * 1.2)]
        .map((v) => Math.abs(v))
        .filter((v, i, arr) => arr.indexOf(v) === i);
    while (opts.length < 4) opts.push(correct + opts.length * 3);
    const shuffled = [...opts].sort(() => Math.random() - 0.5);
    const correctIndex = shuffled.indexOf(correct);
    push({
      id: `fs-num-pct-${n}`,
      pillar: "aptitudNumerica",
      topic: "Porcentajes",
      module: "Aptitud numérica",
      subtopic: "Porcentajes sin calculadora",
      stem: `¿Cuánto es el ${c.a}% de ${c.b}?`,
      options: shuffled.map(String),
      correctIndex,
      explanation: `${c.a}% de ${c.b} = (${c.a}/100)×${c.b} = ${correct}.`,
      normativeJustification:
        "En la prueba de aptitud numérica se evalúa cálculo mental y proporciones sin calculadora, como en el examen real.",
      theoreticalJustification:
        "La competencia implica traducir porcentaje a fracción/decimal y operar con precisión bajo presión de tiempo.",
      distractorAnalysis: {
        [(correctIndex + 1) % 4]: "Error típico: operar el porcentaje como entero sin dividir entre 100.",
        [(correctIndex + 2) % 4]: "Confusión entre aumento porcentual y porcentaje directo.",
        [(correctIndex + 3) % 4]: "Redondeo o proporción invertida.",
      },
      knowledgeTags: [{code: "aptitud", focus: "porcentajes"}],
      difficulty: "basico",
      dificultad: 1,
      recommendedSeconds: 45,
      isCaseStudy: false,
      specialtyTags: [],
    });
  } else {
    // a trabajadores hacen b tareas; ¿cuántas hacen c trabajadores?
    const correct = assertExactInteger((c.b / c.a) * c.c, `regla3 ${c.a}->${c.b} x ${c.c}`);
    const opts = [correct, correct + 2, correct - 3, correct + 5].map((v) => Math.abs(v));
    const unique = [...new Set(opts)];
    while (unique.length < 4) unique.push(correct + unique.length);
    const shuffled = unique.sort(() => Math.random() - 0.5);
    const correctIndex = shuffled.indexOf(correct);
    push({
      id: `fs-num-r3-${n}`,
      pillar: "aptitudNumerica",
      topic: "Regla de tres",
      module: "Aptitud numérica",
      subtopic: "Proporción directa",
      stem:
        `Si ${c.a} docentes elaboran ${c.b} rúbricas en el mismo tiempo, ¿cuántas elaborarán ${c.c} docentes a igual ritmo?`,
      options: shuffled.map(String),
      correctIndex,
      explanation: `(${c.b}/${c.a})×${c.c} = ${correct}.`,
      normativeJustification:
        "La aptitud numérica del concurso privilegia proporciones directas e inversas de uso escolar cotidiano.",
      theoreticalJustification:
        "Modelar la razón unitaria y escalar es el procedimiento robusto de regla de tres simple.",
      distractorAnalysis: {
        [(correctIndex + 1) % 4]: "Sumar en lugar de proporcionalizar.",
        [(correctIndex + 2) % 4]: "Invertir la razón.",
        [(correctIndex + 3) % 4]: "Olvidar la tasa unitaria.",
      },
      knowledgeTags: [{code: "aptitud", focus: "regla de tres"}],
      difficulty: "basico",
      dificultad: 1,
      recommendedSeconds: 45,
      isCaseStudy: false,
      specialtyTags: [],
    });
  }
}

// Más numéricas: promedios y restos
for (let i = 1; i <= 40; i++) {
  const scores = [60 + (i % 7), 70 + (i % 5), 65 + (i % 9), 80 - (i % 6)];
  const needAvg = 70;
  const sum = scores.reduce((a, b) => a + b, 0);
  const correct = needAvg * 5 - sum;
  if (correct < 0 || correct > 100) continue;
  const opts = [correct, correct + 4, correct - 5, correct + 8]
      .map((v) => Math.max(0, Math.min(100, v)));
  const unique = [...new Set(opts)];
  while (unique.length < 4) unique.push((correct + unique.length * 2) % 101);
  const shuffled = unique.sort(() => Math.random() - 0.5);
  const correctIndex = shuffled.indexOf(correct);
  push({
    id: `fs-num-avg-${i}`,
    pillar: "aptitudNumerica",
    topic: "Promedios",
    module: "Aptitud numérica",
    subtopic: "Promedio aritmético",
    stem:
      `Cuatro simulacros dieron ${scores.join(", ")}. ¿Qué puntaje se necesita en el quinto para promedio ${needAvg}?`,
    options: shuffled.map(String),
    correctIndex,
    explanation: `Suma actual ${sum}. Meta 5×${needAvg}=${needAvg * 5}. Falta ${correct}.`,
    normativeJustification:
      "La gestión del puntaje en simulacros entrena cálculo rápido de metas, útil bajo temporizador.",
    theoreticalJustification:
      "El promedio aritmético es una medida de tendencia central básica en interpretación de resultados.",
    distractorAnalysis: {
      [(correctIndex + 1) % 4]: "Promediar solo los cuatro puntajes sin proyectar el quinto.",
      [(correctIndex + 2) % 4]: "Usar la mediana u otro estadístico.",
      [(correctIndex + 3) % 4]: "Error de signo al despejar.",
    },
    knowledgeTags: [{code: "aptitud", focus: "promedios"}],
    difficulty: i % 3 === 0 ? "intermedio" : "basico",
    dificultad: i % 3 === 0 ? 2 : 1,
    recommendedSeconds: i % 3 === 0 ? 60 : 45,
    isCaseStudy: false,
    specialtyTags: [],
  });
}

// ——— Lectura crítica (plantillas argumentativas) ———
const lecTemplates = [
  {
    stem:
      "“Solo si hay participación de la comunidad, el PEI es legítimo. Este PEI no tuvo participación. Por tanto, no es legítimo.” La estructura predominante es:",
    options: [
      "Inducción por analogía",
      "Deducción modus tollens",
      "Falacia de autoridad",
      "Generalización apresurada",
    ],
    correctIndex: 1,
    theory: "Modus tollens: si P→Q y no Q, entonces no P.",
    norma: "En lectura crítica se evalúa identificación de estructuras argumentativas válidas.",
  },
  {
    stem:
      "En el fragmento “la evaluación formativa retroalimenta; no obstante, muchas instituciones la reducen a notas”, “no obstante” cumple función de:",
    options: ["Adición", "Causa", "Contraste", "Temporalidad"],
    correctIndex: 2,
    theory: "Conector adversativo/concesivo de contraste.",
    norma: "La comprensión de conectores es competencia nuclear de lectura crítica.",
  },
  {
    stem:
      "Un texto sostiene que la inclusión no se agota en el acceso físico, sino que exige ajustes en evaluación y convivencia. Idea principal:",
    options: [
      "La inclusión es solo infraestructura",
      "La inclusión exige transformar prácticas pedagógicas",
      "La evaluación debe ser homogénea siempre",
      "La convivencia es ajena al currículo",
    ],
    correctIndex: 1,
    theory: "La tesis amplía inclusión más allá del acceso.",
    norma: "Identificar idea principal es un desempeño típico ICFES.",
  },
  {
    stem:
      "“Los docentes que planifican con evidencia reducen la improvisación.” Se infiere que:",
    options: [
      "La improvisación siempre es indeseable",
      "Planificar con evidencia favorece coherencia",
      "El currículo no requiere evidencia",
      "Solo directivos planifican",
    ],
    correctIndex: 1,
    theory: "La inferencia válida se limita a lo sustentado por el enunciado.",
    norma: "Se evalúa inferencia controlada, no sobreinterpretación.",
  },
  {
    stem:
      "Un autor afirma: “Sin liderazgo pedagógico no hay mejora escolar sostenible.” El supuesto implícito es:",
    options: [
      "La mejora depende solo de recursos",
      "El liderazgo pedagógico influye en la sostenibilidad del cambio",
      "Los docentes no necesitan acompañamiento",
      "Las pruebas externas miden liderazgo",
    ],
    correctIndex: 1,
    theory: "El enunciado asume relación causal liderazgo→sostenibilidad.",
    norma: "Reconocer supuestos es nivel avanzado de lectura crítica.",
  },
];

for (let i = 1; i <= 50; i++) {
  const t = lecTemplates[(i - 1) % lecTemplates.length];
  const difficulty = i % 5 === 0 ? 3 : i % 2 === 0 ? 2 : 1;
  push({
    id: `fs-lec-${i}`,
    pillar: "lecturaCritica",
    topic: "Argumentación",
    module: "Lectura crítica",
    subtopic: "Premisas, conectores e inferencias",
    stem: t.stem + (i > lecTemplates.length ? ` (variante ${i})` : ""),
    options: t.options,
    correctIndex: t.correctIndex,
    explanation: t.theory,
    normativeJustification: t.norma,
    theoreticalJustification: t.theory,
    distractorAnalysis: {
      [(t.correctIndex + 1) % 4]: "Confunde la estructura o el conector evaluado.",
      [(t.correctIndex + 2) % 4]: "Sobreinterpreta más allá del texto.",
      [(t.correctIndex + 3) % 4]: "Selecciona una categoría cercana pero incorrecta.",
    },
    knowledgeTags: [{code: "lectura", focus: "argumentación"}],
    difficulty: difficulty === 1 ? "basico" : difficulty === 3 ? "avanzado" : "intermedio",
    dificultad: difficulty,
    recommendedSeconds: difficulty === 1 ? 45 : difficulty === 3 ? 100 : 75,
    isCaseStudy: false,
    specialtyTags: [],
  });
}

// ——— Comportamental ———
const comTemplates = [
  {
    stem: "En una reunión de área hay desacuerdo fuerte sobre criterios. La conducta más alineada es:",
    options: [
      "Imponer la postura propia sin escuchar",
      "Facilitar acuerdos basados en evidencias y normas institucionales",
      "Aplazar indefinidamente la decisión",
      "Delegar el conflicto a los estudiantes",
    ],
    correctIndex: 1,
    focus: "trabajo en equipo",
  },
  {
    stem: "Dos colegas discuten frente a estudiantes. Como compañero, ¿qué haces?",
    options: [
      "Escalar en el chat de padres",
      "Intervenir con calma y reconducir a espacio privado/institucional",
      "Tomar partido públicamente",
      "Grabar para redes",
    ],
    correctIndex: 1,
    focus: "resolución de conflictos",
  },
  {
    stem: "Un acudiente llega molesto por una nota. La respuesta más profesional es:",
    options: [
      "Responder con el mismo tono",
      "Escuchar, explicar criterios con evidencia y ofrecer ruta de aclaración",
      "Prometer cambiar la nota de inmediato",
      "Evitar la conversación",
    ],
    correctIndex: 1,
    focus: "orientación al ciudadano",
  },
  {
    stem: "Te piden información confidencial de un proceso interno. Debes:",
    options: [
      "Compartirla con un amigo de confianza",
      "Negarte con respeto y seguir el conducto regular",
      "Venderla a cambio de un favor",
      "Publicarla anónimamente",
    ],
    correctIndex: 1,
    focus: "integridad",
  },
  {
    stem: "Baja apropiación del PEI en el equipo. La mejor acción inicial de liderazgo es:",
    options: [
      "Sancionar a quienes no lo citan",
      "Diagnosticar brechas, socializar sentido y acordar rutinas de apropiación",
      "Reescribir el PEI sin la comunidad",
      "Ignorar hasta la visita de supervisión",
    ],
    correctIndex: 1,
    focus: "liderazgo",
  },
];

for (let i = 1; i <= 45; i++) {
  const t = comTemplates[(i - 1) % comTemplates.length];
  const difficulty = i % 4 === 0 ? 3 : 2;
  push({
    id: `fs-com-${i}`,
    pillar: "comportamental",
    topic: t.focus,
    module: "Competencias comportamentales",
    subtopic: t.focus,
    stem: t.stem,
    options: t.options,
    correctIndex: t.correctIndex,
    explanation:
      "El perfil comportamental del servicio público valora integridad, escucha, evidencia y clima escolar.",
    normativeJustification:
      "Las competencias comportamentales del concurso priorizan servicio público, integridad y trabajo colaborativo en contextos escolares.",
    theoreticalJustification:
      `La opción correcta maximiza ${t.focus} con apego a canales institucionales y respeto.`,
    distractorAnalysis: {
      0: "Prioriza impulso o interés particular sobre el servicio.",
      2: "Evita la responsabilidad o genera una solución no institucional.",
      3: "Escala el conflicto o vulnera confidencialidad/clima.",
    },
    knowledgeTags: [{code: "comportamental", focus: t.focus}],
    difficulty: difficulty === 3 ? "avanzado" : "intermedio",
    dificultad: difficulty,
    recommendedSeconds: difficulty === 3 ? 90 : 60,
    isCaseStudy: i % 3 === 0,
    caseContext: i % 3 === 0
      ? "Situación real de colegio con presión de tiempo y múltiples actores."
      : null,
    specialtyTags: t.focus === "liderazgo" ? ["directivos"] : [],
  });
}

// ——— Más pedagógicos por norma/teoría ———
const pedNorms = [
  {
    idPrefix: "d1290",
    stem: "Según el Decreto 1290, la evaluación de estudiantes debe ser, entre otras:",
    options: [
      "Solo sumativa y secreta",
      "Integral, flexible y formativa",
      "Exclusiva de pruebas externas",
      "Homogénea sin ajustes",
    ],
    correctIndex: 1,
    norma: "Decreto 1290: evaluación integral, flexible y formativa.",
    theory: "La evaluación orienta la enseñanza y el aprendizaje, no solo certifica.",
    tags: [{code: "decreto1290", focus: "enfoque"}],
    module: "Pedagogía y evaluación formativa",
  },
  {
    idPrefix: "d1421",
    stem: "Un ajuste razonable correcto implica:",
    options: [
      "Eliminar aprendizajes esenciales",
      "Cambiar forma/tiempo/apoyos manteniendo metas esenciales",
      "Separar permanentemente al estudiante",
      "No evaluar nunca",
    ],
    correctIndex: 1,
    norma: "Decreto 1421: ajustes razonables con PIAR.",
    theory: "Equidad no es exención total; es acceso con expectativa esencial.",
    tags: [{code: "decreto1421", focus: "ajustes"}],
    module: "Inclusión y convivencia escolar",
  },
  {
    idPrefix: "piaget",
    stem: "En educación inicial, priorizar juego y acción concreta se alinea especialmente con:",
    options: [
      "Solo algoritmos abstractos prematuros",
      "Estadios del desarrollo y construcción del pensamiento (Piaget)",
      "Rankings públicos diarios",
      "Exámenes estandarizados escritos exclusivos",
    ],
    correctIndex: 1,
    norma: "Orientaciones de educación inicial MEN.",
    theory: "Piaget: el pensamiento se construye por acción sobre el medio según estadios.",
    tags: [{code: "piaget", focus: "estadios"}, {code: "guiaMen50", focus: "inicial"}],
    module: "Pedagogía y evaluación formativa",
  },
  {
    idPrefix: "bruner",
    stem: "Una secuencia concreto → pictórico → simbólico se relaciona principalmente con:",
    options: [
      "Castigo del error",
      "Representaciones de Bruner para mediar el aprendizaje",
      "Solo dictado magistral",
      "Eliminación de material manipulativo",
    ],
    correctIndex: 1,
    norma: "Didácticas de área y lineamientos privilegian mediación progresiva.",
    theory: "Bruner: modos enactivo, icónico y simbólico.",
    tags: [{code: "bruner", focus: "representación"}],
    module: "Currículo y referentes MEN",
  },
  {
    idPrefix: "ebc",
    stem: "Los EBC del MEN describen principalmente:",
    options: [
      "Solo el listado de contenidos de un libro",
      "Lo que el estudiante debe saber y saber hacer por grupos de grados",
      "El escalafón docente",
      "El calendario de supervisiones",
    ],
    correctIndex: 1,
    norma: "EBC: referentes de calidad del MEN.",
    theory: "Orientan coherencia curricular y evaluación de competencias.",
    tags: [{code: "ebc", focus: "competencias"}],
    module: "Currículo y referentes MEN",
  },
];

for (let i = 1; i <= 60; i++) {
  const t = pedNorms[(i - 1) % pedNorms.length];
  const difficulty = i % 6 === 0 ? 3 : i % 2 === 0 ? 2 : 1;
  push({
    id: `fs-ped-${t.idPrefix}-${i}`,
    pillar: "pedagogico",
    topic: t.idPrefix,
    module: t.module,
    subtopic: t.idPrefix,
    stem: t.stem,
    options: t.options,
    correctIndex: t.correctIndex,
    explanation: `${t.norma} ${t.theory}`,
    normativeJustification: t.norma,
    theoreticalJustification: t.theory,
    distractorAnalysis: {
      0: "Reduce el referente a una práctica punitiva o parcial.",
      2: "Desvía hacia un instrumento administrativo no pedagógico.",
      3: "Omite la mediación o la equidad en el aprendizaje.",
    },
    knowledgeTags: t.tags,
    difficulty: difficulty === 1 ? "basico" : difficulty === 3 ? "avanzado" : "intermedio",
    dificultad: difficulty,
    recommendedSeconds: difficulty === 1 ? 45 : difficulty === 3 ? 110 : 80,
    isCaseStudy: false,
    specialtyTags: t.idPrefix === "piaget" ? ["preescolar"] : [],
  });
}

const {items: hardenedItems, report} = applyQualityPass(items);

const outDir = path.join(__dirname, "..", "..", "assets", "seed");
fs.mkdirSync(outDir, {recursive: true});
const outFile = path.join(outDir, "questions_v1.json");
const payload = {
  version: 3,
  generatedAt: new Date().toISOString(),
  count: hardenedItems.length,
  goldHandcrafted: handcrafted.length,
  quality: report,
  items: hardenedItems,
};
fs.writeFileSync(outFile, JSON.stringify(payload, null, 2), "utf8");
console.log(`OK: ${hardenedItems.length} ítems → ${outFile}`);
console.log(
    `Calidad: pos A/B/C/D=${report.pos[0]}/${report.pos[1]}/${report.pos[2]}/${report.pos[3]} ` +
    `dif 1/2/3=${report.dif[1]}/${report.dif[2]}/${report.dif[3]} ` +
    `endurecidos=${report.hardened}`,
);
