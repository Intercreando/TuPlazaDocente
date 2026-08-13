/**
 * Repara clones fs-ped-* (enunciado de caso sin caso; opciones fragmentadas).
 * Cinco familias × variantes rotadas por el número del id.
 */
function nFromId(id) {
  const m = String(id).match(/-(\d+)$/);
  return m ? Number(m[1]) : 0;
}

const FAMILIES = {
  d1290: {
    explanation:
      "El Decreto 1290 concibe la evaluación como integral, flexible y formativa, al servicio del aprendizaje, no solo de la certificación.",
    variants: [
      {
        caseContext:
          "El periodo se cierra con quizzes secretos y un ranking en cartelera. No hubo rúbricas previas. Padres piden “más rigor”; un colega dice que socializar criterios “regala la respuesta”. El SIEE habla de evaluación formativa.",
        stem:
          "¿Qué decisión articula el Decreto 1290 sin caer en rigor vacío ni en flexibilidad sin evidencia?",
        options: [
          "Mantener los quizzes secretos y el ranking, y entregar la rúbrica el día de los resultados.",
          "Socializar criterios, recoger evidencias diversas y devolver un siguiente paso; el promedio es un insumo más del SIEE.",
          "Sustituir toda evidencia por un concepto cualitativo acordado con las familias, sin rúbrica conocida por la comunidad.",
          "Repetir el mismo quiz hasta que el promedio suba, sin reenseñar ni otra forma de demostrar el aprendizaje.",
        ],
        correctIndex: 1,
      },
      {
        caseContext:
          "Un área evalúa solo un examen acumulativo sorpresa. Estudiantes que avanzaron en talleres no tienen esas evidencias en la promoción. Coordinación defiende el examen “porque es igual para todos”.",
        stem:
          "Según el carácter formativo del Decreto 1290, ¿qué práctica es la más defendible?",
        options: [
          "Conservar el examen sorpresa como único insumo, para garantizar homogeneidad.",
          "Triangular evidencias de proceso y de producto, con criterios conocidos, y usar el examen como una evidencia más.",
          "Promover por asistencia y “actitud”, sin evidencias de aprendizaje esencial.",
          "Publicar solo el promedio del curso, sin devolución individual.",
        ],
        correctIndex: 1,
      },
    ],
  },
  d1421: {
    explanation:
      "El Decreto 1421 exige PIAR y ajustes razonables: se cambia acceso y forma de demostrar, no se elimina la meta esencial ni se homogeneiza “por equidad”.",
    variants: [
      {
        caseContext:
          "Una estudiante con baja visión presenta la misma prueba cronometrada en fotocopia densa. La familia pide nota mínima automática. Un colega dice que cualquier ajuste “rompe la equidad del grupo”.",
        stem:
          "¿Qué decisión es coherente con ajustes razonables (Decreto 1421) y evaluación formativa?",
        options: [
          "Aplicar idéntico formato y tiempo a todo el grupo, porque equidad sería tratar a todos igual.",
          "Acordar en PIAR materiales, tiempo y forma de evidencia, manteniendo los aprendizajes esenciales del grado.",
          "Sustituir de forma permanente las evidencias del área por una actividad recreativa, para evitar reclamos.",
          "Aceptar de palabra una nota mínima, sin registro en el PIAR ni revisión con el equipo de apoyo.",
        ],
        correctIndex: 1,
      },
      {
        caseContext:
          "El PIAR prevé base diez en la evaluación de matemáticas. El día de la prueba se niega el material “para que sea justo”. El estudiante comprende con esa representación y se bloquea en el algoritmo solo.",
        stem:
          "¿Qué decisión sostiene el ajuste razonable sin bajar la meta esencial?",
        options: [
          "Negar el material previsto, para que la evidencia sea comparable con el resto.",
          "Permitir la representación acordada en el PIAR y valorar el aprendizaje esencial del grado.",
          "Cambiar el DBA del grado de forma informal, sin actualizar el PIAR.",
          "Sustituir matemáticas por una actividad recreativa permanente.",
        ],
        correctIndex: 1,
      },
    ],
  },
  piaget: {
    explanation:
      "En inicial, el pensamiento se construye por acción y representación según el desarrollo (Piaget) y las orientaciones MEN de educación inicial, no por escolarización prematura.",
    variants: [
      {
        caseContext:
          "En transición exigen planas y un promedio numérico semanal. Castigan el juego simbólico por “perder tiempo”. Familias piden “que se vea como primero”.",
        stem:
          "¿Qué decisión alinea desarrollo, juego y evaluación cualitativa en inicial?",
        options: [
          "Sustituir el juego por planas y ranking semanal, para evidenciar rigor.",
          "Mediar el juego y las rutinas como espacio de lenguaje y pensamiento, y documentar procesos con devolución a las familias.",
          "Aplicar un examen escrito estandarizado para homologar con primaria.",
          "Eliminar toda evidencia y dejar solo cuidado asistencial.",
        ],
        correctIndex: 1,
      },
    ],
  },
  bruner: {
    explanation:
      "Bruner propone transitar enactivo → icónico → simbólico. Saltar al símbolo o quedarse solo en lo concreto sin formalizar rompe la mediación.",
    variants: [
      {
        caseContext:
          "En 3° pasan de material concreto a la ecuación en un solo paso. Quienes no simbolizan de inmediato se etiquetan como “sin lógica”. Un colega propone más hojas de algoritmos.",
        stem:
          "¿Qué secuencia de representación es la más defendible para mediar el aprendizaje?",
        options: [
          "Insistir de inmediato en el símbolo, con más ejercicios idénticos.",
          "Transitar concreto → pictórico → simbólico, conectando cada modo con la meta del grado.",
          "Quedarse indefinidamente en el concreto, sin formalizar.",
          "Evaluar solo la respuesta final del algoritmo, sin representaciones.",
        ],
        correctIndex: 1,
      },
    ],
  },
  ebc: {
    explanation:
      "Los EBC describen lo que el estudiante debe saber y saber hacer por grupos de grados; no son el índice de un libro ni un instrumento administrativo.",
    variants: [
      {
        caseContext:
          "El plan de área copia el índice del libro y un recurso viral. No hay metas de “saber hacer” por grupos de grados. La visita de calidad pregunta por EBC/DBA.",
        stem:
          "¿Qué decisión alinea la planeación con los Estándares Básicos de Competencias?",
        options: [
          "Seguir el libro y el recurso viral, porque ya “cubren contenidos”.",
          "Definir desempeños de saber y saber hacer por grupos de grados, y evaluar procesos no solo productos memorísticos.",
          "Usar los EBC como lista de supervisión de asistencia docente.",
          "Reemplazar el PEI por el índice del texto escolar.",
        ],
        correctIndex: 1,
      },
    ],
  },
};

function repairFsPed(item) {
  const m = String(item.id || "").match(/^fs-ped-([a-z0-9]+)-/i);
  if (!m) return item;
  const fam = FAMILIES[m[1]];
  if (!fam) return item;
  const variants = fam.variants;
  const v = variants[nFromId(item.id) % variants.length];
  return {
    ...item,
    ...v,
    isCaseStudy: true,
    difficulty: "avanzado",
    dificultad: 3,
    explanation: fam.explanation,
    normativeJustification: fam.explanation,
    theoreticalJustification: fam.explanation,
    distractorAnalysis: {
      0: "Simula rigor o equidad formal, pero niega mediación, criterios o acceso.",
      2: "Flexibiliza hasta eliminar evidencia o meta esencial.",
      3: "Reduce el referente a trámite, exclusión o producto vacío.",
    },
    qualityHardened: true,
  };
}

module.exports = {repairFsPed};
