/**
 * Endurece el pilar pedagógico del seed (casos densos + distractores plausibles).
 * No cambia IDs ni el sentido de la opción correcta.
 *
 *   node tools/seed/upgrade_pedagogical_difficulty.js
 */
const fs = require("fs");
const path = require("path");
const {upgradePedagogicalItem} = require("./cns_c_near_miss");

/** Reescrituras manuales de ítems bandera (no se infieren por plantilla). */
const HAND = {
  "oro-1290-01": {
    caseContext:
      "Una docente de 5° cierra el periodo con el promedio de cuatro quizzes cronometrados. No hubo rúbricas previas ni devolución durante las semanas. El consejo de padres pide “más rigor” y un colega sugiere no cambiar nada “para que sea igual para todos”. El SIEE institucional habla de evaluación formativa.",
    stem:
      "¿Qué decisión articula el Decreto 1290 con una evaluación al servicio del aprendizaje, sin caer en “rigor” vacío ni en flexibilidad sin evidencia?",
    options: [
      "Mantener los cuatro quizzes como único insumo y publicar el ranking del curso para “motivar”, entregando la rúbrica el día de los resultados.",
      "Conservar evidencias periódicas, devolver a cada estudiante su logro frente a criterios conocidos y un siguiente paso, y usar el promedio solo como un insumo más del SIEE.",
      "Sustituir los quizzes por un concepto cualitativo acordado con las familias, sin evidencias de proceso ni criterios públicos.",
      "Repetir el mismo quiz como recuperación hasta que el promedio suba, sin reenseñar ni cambiar la representación de la tarea.",
    ],
    correctIndex: 1,
    isCaseStudy: true,
    difficulty: "avanzado",
    dificultad: 3,
    explanation:
      "El Decreto 1290 concibe la evaluación como integral, flexible y formativa, al servicio del aprendizaje y la promoción, con criterios conocidos y evidencias de proceso. La retroalimentación con criterios convierte la evidencia en mejora; el promedio aislado certifica, no forma.",
    normativeJustification:
      "El Decreto 1290 concibe la evaluación como integral, flexible y formativa, al servicio del aprendizaje y la promoción, con criterios conocidos y evidencias de proceso.",
    theoreticalJustification:
      "La retroalimentación con criterios convierte la evidencia en mejora; el promedio aislado certifica, no forma.",
    distractorAnalysis: {
      0: "El ranking y la rúbrica tardía simulan rigor, pero niegan autorregulación y carácter formativo.",
      2: "La flexibilidad sin evidencia vuelve arbitraria la valoración y no cumple el SIEE.",
      3: "Repetir el mismo instrumento no es recuperación: no hay nueva enseñanza ni otra forma de demostrar el aprendizaje.",
    },
  },
  "dir-apt-ped-182": {
    caseContext:
      "En 4°, un estudiante no resuelve restas con dificultad de forma autónoma. Con la guía de un compañero que ya las comprende y con pistas decrecientes del docente, llega al procedimiento. Coordinación pide “evaluación estrictamente individual, sin ayudas”, para que el boletín sea comparable.",
    stem:
      "Si el propósito es el aprendizaje (no solo certificar), ¿qué decisión articula la Zona de Desarrollo Próximo con una evaluación formativa?",
    options: [
      "Evaluar solo en aislamiento extremo desde el primer intento, porque la autonomía se demuestra sin mediación.",
      "Diseñar andamiaje (pares y pistas) en la zona entre lo que ya hace solo y lo que logra con ayuda, y evaluar el progreso hacia la autonomía con retirada gradual.",
      "Repetir la explicación magistral al grupo hasta memorizar el algoritmo, y calificar un único quiz cronometrado.",
      "Bajar la meta esencial del grado para que el promedio no se afecte, sin mediación nueva.",
    ],
    correctIndex: 1,
    isCaseStudy: true,
    difficulty: "avanzado",
    dificultad: 3,
    explanation:
      "Vygotsky define la ZDP como la distancia entre el desempeño autónomo y el que se alcanza con mediación. El Decreto 1290 orienta evaluación formativa que reconoce ritmos y consolida aprendizajes; el andamiaje con retirada gradual materializa ambas ideas.",
    normativeJustification:
      "El Decreto 1290 orienta una evaluación formativa que reconoce ritmos e intereses para consolidar aprendizajes, no solo certificar en aislamiento.",
    theoreticalJustification:
      "La ZDP no es “el máximo sin ayuda” ni un tiempo de clase: es la distancia entre lo autónomo y lo mediado. El andamiaje opera en esa distancia.",
    distractorAnalysis: {
      0: "Confunde autonomía como punto de partida con autonomía como meta del andamiaje.",
      2: "La reiteración magistral privilegia memorización y no la mediación situada.",
      3: "Bajar la meta sin mediación evade el aprendizaje esencial.",
    },
  },
  "dir-apt-ges-171": {
    caseContext:
      "Ingresa un estudiante con discapacidad. El rector dice que el PIAR lo arma “solo orientación”. Un docente de aula sostiene que sin él no hay ajustes en clase. La familia pide ser escuchada. Un médico externo envió un diagnóstico y la secretaría aún no ha visitado la sede.",
    stem:
      "Según el Decreto 1421 de 2017, ¿quién debe liderar la elaboración del PIAR y con qué corresponsabilidad?",
    options: [
      "Exclusivamente el médico especialista, porque el PIAR es un documento clínico.",
      "Únicamente la Secretaría de Educación, porque la IE no puede ajustar sin visita previa.",
      "El docente de aula, con apoyo del docente de apoyo pedagógico y participación de la familia; el diagnóstico informa, no reemplaza el plan de aula.",
      "Exclusivamente el rector, sin el docente de aula, para unificar el criterio institucional.",
    ],
    correctIndex: 2,
    isCaseStudy: true,
    difficulty: "avanzado",
    dificultad: 3,
    explanation:
      "El Decreto 1421 sitúa el PIAR en la atención educativa del aula: lo lidera el docente con apoyo pedagógico y la familia. El diagnóstico y la secretaría aportan, no sustituyen esa corresponsabilidad.",
    normativeJustification:
      "El Decreto 1421 de 2017 concibe el PIAR como herramienta de la atención educativa, elaborada por el docente de aula con apoyo pedagógico y participación familiar.",
    theoreticalJustification:
      "Los ajustes razonables ocurren en la enseñanza y la evaluación cotidianas; por eso no pueden quedar solo en un dictamen externo ni en un acto administrativo.",
    distractorAnalysis: {
      0: "Medicaliza el PIAR y lo saca del aula.",
      1: "La secretaría apoya el sistema, pero no reemplaza el plan de aula.",
      3: "El liderazgo rectoral no elimina la responsabilidad docente sobre los ajustes.",
    },
  },
};

const SEED = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");
const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
const items = payload.items || [];

let touched = 0;
const nextItems = items.map((item) => {
  if (item.pillar !== "pedagogico" && item.pilar !== "pedagogico") return item;
  const hand = HAND[item.id];
  const upgraded = hand ? {...item, ...hand} : upgradePedagogicalItem(item);
  if (JSON.stringify(upgraded) !== JSON.stringify(item)) touched += 1;
  return upgraded;
});

payload.items = nextItems;
payload.version = 3.6;
payload.generatedAt = new Date().toISOString();
payload.pedagogicalUpgrade = {
  at: payload.generatedAt,
  itemsTouched: touched,
  note: "Pilar pedagógico: casos situacionales y distractores de alta plausibilidad (ola concurso).",
};

fs.writeFileSync(SEED, JSON.stringify(payload, null, 2), "utf8");
console.log(`OK: ${touched} ítems pedagógicos endurecidos → ${SEED}`);
