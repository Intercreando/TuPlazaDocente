/**
 * Helper compartido para construir ítems oro CNSC/ICFES.
 */

function letterIndex(letter) {
  return {A: 0, B: 1, C: 2, D: 3}[letter];
}

/**
 * @param {object} p
 * @return {object}
 */
function gold(p) {
  const correctIndex = letterIndex(p.correct);
  const distractors = {};
  for (const [letter, text] of Object.entries(p.wrong || {})) {
    distractors[letterIndex(letter)] = text;
  }
  const dificultad = p.dif ?? 2;
  return {
    id: p.id,
    pillar: "pedagogico",
    topic: p.subtema,
    module: p.module || "Pedagogía y evaluación formativa",
    subtopic: p.subtema,
    targetCargo: p.cargo || "primaria",
    specialtyTags: p.tagsCargo || [p.cargo || "primaria"],
    caseContext: p.caso || null,
    stem: p.stem,
    options: p.options,
    correctIndex,
    explanation: `${p.norma} ${p.theory}`,
    normativeJustification: p.norma,
    theoreticalJustification: p.theory,
    distractorAnalysis: distractors,
    knowledgeTags: p.tags || [],
    normativeRefs: (p.tags || []).map((t) => t.code),
    difficulty: dificultad === 1 ? "basico" : dificultad === 3 ? "avanzado" : "intermedio",
    dificultad,
    recommendedSeconds: p.secs || (dificultad === 1 ? 60 : dificultad === 3 ? 120 : 90),
    isCaseStudy: Boolean(p.caso),
    published: true,
    schemaVersion: 1,
  };
}

module.exports = {gold, letterIndex};
