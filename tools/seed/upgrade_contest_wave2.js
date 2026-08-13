/**
 * Ola 2: reparar fs-ped, envolver definiciones, endurecer
 * comportamental / numérica / lectura.
 *
 *   node tools/seed/upgrade_contest_wave2.js
 */
const fs = require("fs");
const path = require("path");
const {repairFsPed} = require("./fs_ped_cases");
const {
  isCartoonOption,
  isNamedEntityAnswer,
  isDefinitionStem,
  nearMisses,
  uniqueOptions,
} = require("./cns_c_near_miss");

const SEED = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");

const HAND = {
  "dir-apt-ges-162": {
    caseContext:
      "Un alcalde de municipio no certificado anuncia que nombrará toda la planta docente “porque el colegio está en su territorio”. El rector duda entre acatar, pedir aval al departamento o esperar al MEN.",
    stem:
      "Según la Ley 715 de 2001, ¿quién administra el servicio educativo en esa jurisdicción?",
    options: [
      "El colegio, si supera 1.000 estudiantes, porque el tamaño equivale a certificación.",
      "La entidad territorial certificada (departamento, distrito o municipio que asumió la administración del servicio).",
      "La universidad más cercana con acreditación, por convenio de práctica.",
      "El colegio privado con convenio, que puede absorber la planta oficial.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-62": {
    caseContext:
      "El rector quiere adoptar un nuevo manual de convivencia esta semana por circular. El Consejo Académico dice que le corresponde porque toca disciplina de aula. Padres piden votarlo en asamblea general.",
    stem:
      "Según la Ley 115 y el Decreto 1860, ¿qué instancia adopta el manual de convivencia?",
  },
  "dir-apt-ges-63": {
    caseContext:
      "Un rector publica el SIEE en la página web sin pasar por instancias. Docentes reclaman que no participaron. La secretaría pide el acto de adopción.",
    stem:
      "Según el Decreto 1290, ¿quién debe aprobar el SIEE tras su construcción participativa?",
  },
  "dir-apt-ges-67": {
    caseContext:
      "Llega un rector nuevo y encuentra tres documentos vigentes: un manual de convivencia actualizado, un POA de caja y un SIEE. Falta claridad sobre qué orienta la organización pedagógica, administrativa y de gestión.",
    stem:
      "Según la Ley 115, ¿cuál es el instrumento que orienta esa organización institucional?",
  },
  "dir-apt-ges-69": {
    caseContext:
      "El personero estudiaantil es presionado para “defender al rector en Secretaría” y para “aprobar el presupuesto”. Estudiantes le piden que los represente en derechos y deberes.",
    stem:
      "Según la Ley 115, ¿cuál es la función principal del personero estudiantil?",
  },
  "dir-apt-ges-73": {
    caseContext:
      "Van a revisar el plan de estudios. El Consejo Directivo quiere decidir solo. El académico pide ser consultado. El consejo de padres exige veto.",
    stem:
      "Según el Decreto 1860, ¿qué instancia es órgano consultivo en la revisión del currículo?",
  },
  "dir-apt-ges-75": {
    caseContext:
      "Al reportar valoración para homologación, un área usa 1–100 y otra cinco niveles propios. Coordinación pide una escala nacional común en el SIEE.",
    stem:
      "Según el Decreto 1290, ¿qué escala nacional debe incluir el SIEE para homologación?",
  },
  "dir-apt-ped-94": {
    caseContext:
      "Se inicia “fracción” con el algoritmo y un quiz el mismo día, sin explorar ideas de parte-todo que los estudiantes ya traen del contexto. Un colega defiende “primero la fórmula, luego el sentido”.",
    stem:
      "Según Ausubel, ¿qué decisión hace significativo el aprendizaje de ese contenido?",
    options: [
      "Memorizar el algoritmo aislado y evaluar de inmediato para clasificar al grupo.",
      "Diagnosticar saberes previos de parte-todo y anclar el algoritmo a esa comprensión.",
      "Exponer el contenido sin interacción, para no “contaminar” con errores.",
      "Dejar toda la valoración para el examen final del periodo.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-95": {
    caseContext:
      "Tras resolver problemas, nunca se pide a los estudiantes explicar cómo pensaron. Solo se califica la respuesta. Un docente propone verbalizar estrategias y criterios de éxito.",
    stem:
      "¿Qué práctica desarrolla metacognición de forma coherente con evaluación formativa?",
    options: [
      "Incluir verbalización de estrategias y criterios de éxito, contrastados con la evidencia del trabajo.",
      "Sustituir el trabajo por una nota global del grupo, sin reflexión del estudiante.",
      "Usar solo herramientas digitales, aunque no haya criterio de calidad.",
      "Pedir memorizar definiciones de “metacognición” para el quiz.",
    ],
    correctIndex: 0,
  },
  "dir-apt-dis-274": {
    caseContext:
      "En ciencias, un equipo clasifica carbón, petróleo y gas como “renovables porque salen de la tierra”. Otro clasifica la solar como renovable. La rúbrica pide argumentar con el criterio de reposición en tiempos humanos.",
    stem:
      "¿Qué clasificación debe orientarse como aprendizaje esencial y cuál error conceptual hay que reenseñar?",
    options: [
      "Validar carbón como renovable, porque es un recurso natural.",
      "Validar la energía solar como renovable y reenseñar que fósiles no se reponen a escala humana.",
      "Validar petróleo como renovable, por su origen orgánico.",
      "Validar gas natural como renovable, por emitirse “más limpio”.",
    ],
    correctIndex: 1,
  },
  "dir-apt-dis-376": {
    caseContext:
      "Un estudiante afirma que el PIB es “lo que gana en promedio cada habitante”. Otro lo explica como el valor de bienes y servicios finales producidos en un periodo, con un ejemplo de cosecha local. La evaluación pide argumentar, no recitar.",
    stem:
      "¿Qué evidencia demuestra el aprendizaje esencial del concepto de PIB?",
    options: [
      "Identificar el PIB con la deuda externa acumulada.",
      "Identificar el PIB con el número de empresas registradas.",
      "Identificar el PIB con el ingreso personal promedio (PIB per cápita confundido con PIB).",
      "Explicar el PIB como valor de bienes y servicios finales producidos en un periodo, con ejemplo situado.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-82": {
    caseContext:
      "Un área solo califica al final del periodo. Durante las semanas no hay devolución. Estudiantes repiten los mismos errores. El SIEE describe evaluación formativa.",
    stem:
      "¿Qué práctica de evaluación es la más defendible para ajustar la enseñanza a tiempo?",
    options: [
      "Asignar una sola calificación final, sin retroalimentación de proceso.",
      "Brindar retroalimentación continua con criterios, para ajustar enseñanza y aprendizaje durante el periodo.",
      "Aplicar evaluación únicamente el último día, “para que estudien todo”.",
      "Comparar estudiantes entre sí (ranking) como principal devolución.",
    ],
    correctIndex: 1,
  },
};

function wrapDefinition(item) {
  const ci = Number(item.correctIndex);
  const correct = (item.options || [])[ci];
  if (!isDefinitionStem(item.stem) && !isNamedEntityAnswer(correct)) return item;
  if (String(item.caseContext || "").length >= 120) return item;
  return {
    ...item,
    caseContext:
      `En el gobierno escolar o en el aula hay desacuerdo sobre competencias o sentido de un referente. ` +
      `${item.stem} Un actor pide resolverlo por circular o por costumbre, sin instancia.`,
    stem:
      "En este desacuerdo, ¿cuál lectura es la más precisa según el marco vigente?",
    isCaseStudy: true,
    difficulty: item.difficulty === "basico" ? "intermedio" : item.difficulty,
    dificultad: Math.max(Number(item.dificultad || 2), 2),
    qualityHardened: true,
  };
}

function upgradeComportamental(item) {
  if (item.pillar !== "comportamental") return item;
  const next = {...item, options: [...(item.options || [])]};
  const ci = Number(next.correctIndex);
  if (!Array.isArray(next.options) || next.options.length < 4) return item;
  const core = String(next.caseContext || next.stem || "").trim();
  next.caseContext =
    `En una IE oficial, con presión de tiempo y varios actores, ocurre: ${core} ` +
    `Hay riesgo de escalar el conflicto, de simular o de vulnerar confidencialidad.`;
  next.stem =
    "En este conflicto de intereses, ¿qué conducta es la más defendible ética e institucionalmente?";
  next.isCaseStudy = true;
  const cartoonCount = next.options.filter((o, i) => i !== ci && isCartoonOption(o)).length;
  if (cartoonCount >= 1) {
    const misses = [
      "Aplazar la decisión con un acta genérica, sin acuerdos, responsables ni fecha de seguimiento.",
      "Imponer una salida visible “para que se note liderazgo”, aunque rompa el debido proceso o la confidencialidad.",
      "Delegar el conflicto a familias o chats, sin canal institucional ni registro.",
    ];
    let m = 0;
    const dist = {};
    for (let i = 0; i < next.options.length; i++) {
      if (i === ci) continue;
      next.options[i] = misses[m % misses.length];
      dist[i] = "Parece práctica o prudente, pero evade integridad, evidencia o canal institucional.";
      m += 1;
    }
    next.distractorAnalysis = dist;
  }
  next.options = uniqueOptions(next.options);
  next.difficulty = "avanzado";
  next.dificultad = 3;
  next.qualityHardened = true;
  return next;
}

function upgradeNumerica(item) {
  if (item.pillar !== "aptitudNumerica") return item;
  const stem = String(item.stem || "");
  const pct = stem.match(/(\d+(?:\.\d+)?)%\s+de\s+(\d+)/i);
  if (pct) {
    const p = pct[1];
    const base = pct[2];
    return {
      ...item,
      caseContext:
        `Una IE oficial tiene ${base} estudiantes en básica. El SIEE identifica que el ${p}% requiere plan de apoyo académico este periodo. Coordinación necesita el número exacto para organizar docentes de apoyo y no inflar ni subestimar la carga.`,
      stem: "¿Cuántos estudiantes deben entrar al plan de apoyo?",
      isCaseStudy: true,
      difficulty: "intermedio",
      dificultad: 2,
      qualityHardened: true,
    };
  }
  if (/simulacros dieron/i.test(stem)) {
    return {
      ...item,
      caseContext:
        `El comité de calidad revisa resultados de simulacros para el PMI. ${stem} Un docente propone “redondear hacia arriba por clima”; otro insiste en el cálculo exacto del promedio meta.`,
      stem:
        "Si la meta institucional es ese promedio, ¿qué puntaje se necesita en la evidencia que falta?",
      isCaseStudy: true,
      qualityHardened: true,
    };
  }
  if (/docentes elaboran/i.test(stem)) {
    return {
      ...item,
      caseContext:
        `En una jornada de construcción de rúbricas se trabaja a ritmo constante. ${stem} Coordinación debe estimar el producto sin asumir horas extra.`,
      stem:
        "A igual ritmo, ¿cuál es la cantidad coherente con una proporción directa?",
      isCaseStudy: true,
      qualityHardened: true,
    };
  }
  return item;
}

function upgradeLectura(item) {
  if (item.pillar !== "lecturaCritica") return item;
  const ci = Number(item.correctIndex);
  const opts = item.options || [];
  if (!opts.some((o, i) => i !== ci && isCartoonOption(o))) return item;
  const misses = nearMisses({...item, pillar: "pedagogico", knowledgeTags: [{code: "lineamientos"}]});
  const next = {...item, options: [...opts]};
  let m = 0;
  for (let i = 0; i < next.options.length; i++) {
    if (i === ci) continue;
    if (isCartoonOption(next.options[i])) {
      next.options[i] = misses[m % misses.length];
      m += 1;
    }
  }
  next.options = uniqueOptions(next.options);
  next.qualityHardened = true;
  return next;
}

const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
let touched = 0;
payload.items = payload.items.map((item) => {
  const before = JSON.stringify(item);
  let next = item;
  if (HAND[item.id]) {
    next = {...item, ...HAND[item.id], isCaseStudy: true, qualityHardened: true};
    if (HAND[item.id].difficulty) next.difficulty = HAND[item.id].difficulty;
    else next.difficulty = "avanzado";
    next.dificultad = 3;
  } else {
    next = repairFsPed(next);
    next = wrapDefinition(next);
    next = upgradeComportamental(next);
    next = upgradeNumerica(next);
    next = upgradeLectura(next);
  }
  if (JSON.stringify(next) !== before) touched += 1;
  return next;
});
payload.version = 3.7;
payload.generatedAt = new Date().toISOString();
payload.contestUpgradeWave2 = {at: payload.generatedAt, itemsTouched: touched};
fs.writeFileSync(SEED, JSON.stringify(payload, null, 2), "utf8");
console.log(`OK: ${touched} ítems ola 2 → ${SEED}`);
