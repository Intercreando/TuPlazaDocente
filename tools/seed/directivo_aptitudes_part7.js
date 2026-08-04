/**
 * Directivo aptitudes — Ola 3 (201–300).
 * Elaboración propia. Continuación de numeración del lote Directivo.
 * Eje 4: muestra de 4 áreas (Matemáticas, Lengua, Ciencias, Sociales).
 */
const {raw, push} = require("./directivo_aptitudes_part6");

// ——— Lectura crítica (201–220): texto + 2 preguntas ———
const lectura = [
  {
    caso: "Enseñar a un estudiante a comprender un texto no se limita a verificar si reconoce las palabras, sino a acompañarlo para que se haga preguntas antes, durante y después de la lectura: qué espera encontrar, si lo que está leyendo tiene sentido y qué aprendió al finalizar. Un docente que modela este tipo de preguntas en voz alta, mientras lee frente al grupo, ayuda a que los estudiantes interioricen estas estrategias y las apliquen de manera autónoma en futuras lecturas.",
    qs: [
      {
        n: 201,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Modelar preguntas metacognitivas antes, durante y después de la lectura ayuda a que los estudiantes interioricen estrategias de comprensión.",
          "La comprensión lectora se limita al reconocimiento de palabras.",
          "Los estudiantes aprenden a comprender un texto sin ninguna guía docente.",
          "Leer en voz alta frente al grupo no aporta a la comprensión lectora.",
        ],
        correct: "A",
        expl: "El texto plantea que modelar estas preguntas favorece la interiorización autónoma de estrategias de comprensión.",
      },
      {
        n: 202,
        stem: "Según el texto, ¿en qué momentos se recomienda que el estudiante se haga preguntas sobre el texto?",
        options: [
          "Únicamente después de terminar la lectura.",
          "Antes, durante y después de la lectura.",
          "Solo antes de comenzar a leer.",
          "Exclusivamente cuando el docente lo indique de forma escrita.",
        ],
        correct: "B",
        expl: "El texto lo menciona explícitamente como los tres momentos clave de la estrategia.",
      },
    ],
  },
  {
    caso: "Durante mucho tiempo, el error en matemáticas se trató como algo que debía evitarse o corregirse de inmediato. Sin embargo, distintas investigaciones en didáctica de las matemáticas sugieren que analizar el error junto con los estudiantes —entender por qué llegaron a una respuesta incorrecta— puede ser una oportunidad valiosa de aprendizaje, siempre que el docente cree un ambiente de confianza donde equivocarse no se perciba como un fracaso, sino como parte natural del proceso de construcción del conocimiento matemático.",
    qs: [
      {
        n: 203,
        stem: "Según el texto, ¿qué sugieren las investigaciones recientes sobre el error en matemáticas?",
        options: [
          "Que el error debe evitarse y corregirse de inmediato sin ningún análisis.",
          "Que los errores no tienen ningún valor pedagógico.",
          "Que analizar el error junto con los estudiantes puede ser una oportunidad valiosa de aprendizaje.",
          "Que solo los estudiantes con mejor desempeño deben analizar sus errores.",
        ],
        correct: "C",
        expl: "El texto lo plantea como la idea central derivada de la investigación en didáctica de las matemáticas.",
      },
      {
        n: 204,
        stem: "¿Qué condición señala el texto como necesaria para que el análisis del error sea productivo?",
        options: [
          "Que el docente corrija el error sin ninguna explicación.",
          "Que el estudiante repita el ejercicio de memoria.",
          "Que el error se señale públicamente frente a todo el curso.",
          "Que el docente cree un ambiente de confianza donde equivocarse no se perciba como un fracaso.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente como condición para que el error se convierta en oportunidad de aprendizaje.",
      },
    ],
  },
  {
    caso: "Cuando los estudiantes trabajan en equipo para resolver una tarea, no todos aprenden de la misma manera solo por estar agrupados: la investigación sobre aprendizaje colaborativo señala que el diseño de la actividad debe generar una verdadera necesidad de interdependencia, de modo que ningún integrante pueda completar la tarea sin el aporte de los demás. De lo contrario, el trabajo en equipo puede convertirse en una simple división de tareas individuales sin beneficio adicional para el aprendizaje.",
    qs: [
      {
        n: 205,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Para que el trabajo en equipo beneficie el aprendizaje, la actividad debe diseñarse para generar interdependencia real entre los integrantes.",
          "Agrupar a los estudiantes siempre garantiza un aprendizaje colaborativo efectivo.",
          "El trabajo en equipo nunca aporta beneficios adicionales al aprendizaje individual.",
          "La interdependencia entre estudiantes no influye en los resultados del trabajo en equipo.",
        ],
        correct: "A",
        expl: "El texto plantea que la interdependencia, y no solo el agrupamiento, es la condición para un aprendizaje colaborativo real.",
      },
      {
        n: 206,
        stem: "Según el texto, ¿qué puede ocurrir si la actividad no genera una verdadera interdependencia?",
        options: [
          "Los estudiantes aprenden automáticamente más rápido.",
          "El trabajo en equipo se convierte en una simple división de tareas individuales sin beneficio adicional.",
          "La actividad se vuelve imposible de realizar.",
          "El docente pierde el control total del grupo.",
        ],
        correct: "B",
        expl: "El texto lo señala explícitamente en la última oración.",
      },
    ],
  },
  {
    caso: "Enseñar a escribir no consiste únicamente en corregir la ortografía de un texto ya terminado, sino en acompañar al estudiante a lo largo de un proceso que incluye planificar qué va a escribir, redactar una primera versión, y revisar y reescribir a partir de la retroalimentación recibida. Cuando un docente solo evalúa el producto final, sin haber acompañado las etapas previas, pierde la oportunidad de identificar en qué momento del proceso el estudiante enfrenta mayores dificultades.",
    qs: [
      {
        n: 207,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Enseñar a escribir se reduce a corregir la ortografía del texto final.",
          "El proceso de escritura no requiere ningún acompañamiento docente.",
          "Acompañar las etapas de planificación, redacción y revisión es clave para enseñar a escribir, más allá de evaluar solo el producto final.",
          "Solo la etapa de revisión es relevante en el proceso de escritura.",
        ],
        correct: "C",
        expl: "El texto plantea la importancia de acompañar todas las etapas del proceso, no solo evaluar el resultado final.",
      },
      {
        n: 208,
        stem: "Según el texto, ¿qué pierde el docente que solo evalúa el producto final de un texto?",
        options: [
          "La posibilidad de calificar el texto.",
          "El control disciplinario del grupo.",
          "El tiempo de la clase.",
          "La oportunidad de identificar en qué momento del proceso el estudiante enfrenta mayores dificultades.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente en la última oración.",
      },
    ],
  },
  {
    caso: "En la primera infancia, el juego no es simplemente una actividad de descanso entre momentos de aprendizaje: es, en sí mismo, una de las formas privilegiadas mediante las cuales los niños exploran el mundo, resuelven problemas y desarrollan habilidades sociales. Un docente que planifica situaciones de juego con una intención pedagógica clara —sin convertirlo en una actividad completamente libre ni en un ejercicio académico disfrazado— puede potenciar aprendizajes significativos sin renunciar al placer y la espontaneidad propios de esta etapa.",
    qs: [
      {
        n: 209,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "El juego, cuando se planifica con intención pedagógica, puede potenciar aprendizajes significativos en la primera infancia.",
          "El juego es únicamente una actividad de descanso sin ningún valor pedagógico.",
          "El juego debe convertirse siempre en un ejercicio académico estructurado.",
          "La primera infancia no requiere de ningún tipo de planificación docente.",
        ],
        correct: "A",
        expl: "El texto plantea el juego como una vía privilegiada de aprendizaje cuando se planifica con intención pedagógica.",
      },
      {
        n: 210,
        stem: "Según el texto, ¿qué debe evitar el docente al planificar situaciones de juego?",
        options: [
          "Dar cualquier tipo de espacio a la espontaneidad de los niños.",
          "Convertirlo en una actividad completamente libre o en un ejercicio académico disfrazado.",
          "Incluir cualquier intención pedagógica en la actividad.",
          "Permitir que los niños resuelvan problemas durante el juego.",
        ],
        correct: "B",
        expl: "El texto lo señala explícitamente como los dos extremos que deben evitarse.",
      },
    ],
  },
  {
    caso: "En instituciones con población estudiantil diversa, un docente puede encontrarse con estudiantes que hablan una lengua materna distinta al español o que provienen de tradiciones culturales poco conocidas para el resto del grupo. Reconocer y valorar esta diversidad en el aula, por ejemplo mediante actividades que visibilicen distintas expresiones culturales, no solo fortalece la identidad de los estudiantes pertenecientes a estos grupos, sino que enriquece la experiencia educativa de todo el curso.",
    qs: [
      {
        n: 211,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La diversidad cultural en el aula debe ignorarse para mantener la homogeneidad del grupo.",
          "Solo los estudiantes de una lengua materna distinta deben participar en actividades culturales.",
          "Reconocer y valorar la diversidad cultural en el aula fortalece la identidad de los estudiantes y enriquece la experiencia de todo el curso.",
          "La diversidad cultural es un obstáculo para el aprendizaje del grupo.",
        ],
        correct: "C",
        expl: "El texto plantea el reconocimiento de la diversidad como un beneficio tanto individual como colectivo.",
      },
      {
        n: 212,
        stem: "Según el texto, ¿qué beneficio adicional tiene visibilizar distintas expresiones culturales en el aula?",
        options: [
          "Reduce el tiempo dedicado a otras áreas del currículo.",
          "Elimina la necesidad de trabajar en otras competencias.",
          "Solo beneficia a los estudiantes de origen diverso.",
          "Enriquece la experiencia educativa de todo el curso.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente en la última oración.",
      },
    ],
  },
  {
    caso: "Más allá del proyecto ambiental institucional, un docente puede integrar la dimensión ambiental en su práctica cotidiana de muchas formas: aprovechando una salida al patio para observar el entorno natural, analizando el consumo de recursos dentro del aula, o vinculando un problema ambiental local con los contenidos de su asignatura. Esta integración cotidiana, aunque no sustituye la planeación institucional, contribuye a que los estudiantes perciban la dimensión ambiental como parte de la vida diaria y no solo como un tema abordado en fechas específicas del calendario escolar.",
    qs: [
      {
        n: 213,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Integrar la dimensión ambiental en la práctica cotidiana del aula contribuye a que los estudiantes la perciban como parte de la vida diaria.",
          "La educación ambiental solo puede abordarse mediante el proyecto institucional.",
          "El consumo de recursos dentro del aula no tiene relación con la educación ambiental.",
          "La educación ambiental debe limitarse a fechas específicas del calendario escolar.",
        ],
        correct: "A",
        expl: "El texto plantea la integración cotidiana como un complemento valioso a la planeación institucional.",
      },
      {
        n: 214,
        stem: "Según el texto, ¿qué ejemplos se mencionan de integración ambiental en la práctica docente cotidiana?",
        options: [
          "Exclusivamente la lectura de un libro sobre el tema una vez al año.",
          "Observar el entorno natural, analizar el consumo de recursos y vincular problemas ambientales locales con los contenidos.",
          "Reemplazar por completo el currículo de ciencias naturales.",
          "Suspender las clases para dedicar un día exclusivo al tema.",
        ],
        correct: "B",
        expl: "El texto los menciona explícitamente como ejemplos de esta integración cotidiana.",
      },
    ],
  },
  {
    caso: "La motivación de los estudiantes hacia una asignatura no depende únicamente de su interés personal por el tema, sino también del clima que el docente logra construir en el aula: un ambiente donde los estudiantes se sientan seguros para participar, equivocarse y preguntar sin temor a la burla suele asociarse con mayores niveles de motivación, incluso en asignaturas que inicialmente generaban poco interés en el grupo.",
    qs: [
      {
        n: 215,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La motivación depende exclusivamente del interés personal de cada estudiante.",
          "El clima de aula no influye en la motivación de los estudiantes.",
          "Un clima de aula seguro, donde los estudiantes puedan participar y equivocarse sin temor, favorece la motivación.",
          "La motivación es un factor que el docente no puede influir de ninguna manera.",
        ],
        correct: "C",
        expl: "El texto plantea el clima de aula como un factor que influye en la motivación, más allá del interés personal inicial.",
      },
      {
        n: 216,
        stem: "Según el texto, ¿en qué tipo de asignaturas puede observarse el efecto de un buen clima de aula sobre la motivación?",
        options: [
          "Únicamente en las asignaturas que ya generaban mucho interés previo.",
          "Solo en asignaturas relacionadas con el arte.",
          "Exclusivamente en la educación física.",
          "Incluso en asignaturas que inicialmente generaban poco interés en el grupo.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente en la última oración.",
      },
    ],
  },
  {
    caso: "Aplicar la evaluación formativa en el día a día no siempre implica diseñar instrumentos elaborados: puede ser tan sencillo como hacer una pregunta abierta al finalizar la clase, observar el trabajo de los estudiantes mientras resuelven un ejercicio, o pedirles que expliquen con sus propias palabras lo que acaban de aprender. Lo importante no es la sofisticación del instrumento, sino que la información recogida se use realmente para ajustar la siguiente clase.",
    qs: [
      {
        n: 217,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La evaluación formativa puede aplicarse mediante estrategias sencillas, siempre que la información recogida se use para ajustar la enseñanza.",
          "La evaluación formativa siempre requiere instrumentos elaborados y sofisticados.",
          "Observar el trabajo de los estudiantes no aporta información útil para el docente.",
          "La evaluación formativa no tiene ninguna relación con la planeación de las siguientes clases.",
        ],
        correct: "A",
        expl: "El texto plantea que lo esencial no es la sofisticación del instrumento, sino el uso pedagógico de la información recogida.",
      },
      {
        n: 218,
        stem: "Según el texto, ¿qué ejemplos se mencionan de estrategias sencillas de evaluación formativa?",
        options: [
          "Exclusivamente exámenes escritos estandarizados.",
          "Una pregunta abierta al finalizar la clase, observación del trabajo de los estudiantes, y pedirles que expliquen lo aprendido.",
          "Solo la revisión de cuadernos al final del período.",
          "Únicamente pruebas externas aplicadas por el Ministerio de Educación.",
        ],
        correct: "B",
        expl: "El texto los menciona explícitamente como ejemplos de estrategias sencillas de evaluación formativa.",
      },
    ],
  },
  {
    caso: "Además de la biblioteca escolar central, muchos docentes organizan una pequeña colección de libros dentro de su propia aula, conocida como biblioteca o rincón de lectura. Esta cercanía física con los libros, sumada a la posibilidad de que los estudiantes elijan libremente qué leer en momentos específicos del día, suele asociarse con un mayor hábito de lectura autónoma, especialmente cuando el docente participa activamente recomendando títulos y conversando con los estudiantes sobre lo que están leyendo.",
    qs: [
      {
        n: 219,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La biblioteca de aula reemplaza por completo la necesidad de una biblioteca escolar central.",
          "Los estudiantes no deben elegir libremente qué leer en el aula.",
          "La cercanía a los libros y la libre elección de lectura, junto con la participación activa del docente, favorecen el hábito de lectura autónoma.",
          "La biblioteca de aula no tiene ninguna relación con el hábito de lectura.",
        ],
        correct: "C",
        expl: "El texto plantea estos elementos como favorables para el desarrollo de la lectura autónoma.",
      },
      {
        n: 220,
        stem: "Según el texto, ¿qué rol cumple el docente para potenciar el efecto de la biblioteca de aula?",
        options: [
          "Debe mantenerse completamente al margen de las elecciones de lectura de los estudiantes.",
          "Debe imponer los mismos libros a todo el curso.",
          "Debe eliminar cualquier conversación sobre los libros leídos.",
          "Participa activamente recomendando títulos y conversando con los estudiantes sobre lo que están leyendo.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente como un factor que potencia el efecto de la biblioteca de aula.",
      },
    ],
  },
];

for (const block of lectura) {
  for (const q of block.qs) {
    push({
      id: `dir-apt-lec-${String(q.n).padStart(3, "0")}`,
      pillar: "lecturaCritica",
      module: "Lectura crítica",
      topic: "Lectura crítica · Directivo (ola 3)",
      caso: block.caso,
      stem: q.stem,
      options: q.options,
      correct: q.correct,
      expl: q.expl,
      tags: q.tags || [],
      dif: 2,
      caseStudy: true,
    });
  }
}

// ——— Razonamiento cuantitativo (221–240) ———
const cuant = [
  {
    n: 221,
    stem: "Un docente tiene 32 estudiantes en su curso. Si el 25% obtuvo desempeño superior en la última evaluación, ¿cuántos estudiantes fue eso?",
    options: ["8", "6", "7", "9"],
    correct: "A",
    expl: "32 × 0.25 = 8 estudiantes.",
  },
  {
    n: 222,
    stem: "Un docente califica 28 cuadernos a un ritmo de 5 minutos cada uno. ¿Cuánto tiempo total le toma calificar todos los cuadernos?",
    options: ["2h 00min", "2h 20min", "2h 40min", "3h 00min"],
    correct: "B",
    expl: "28 × 5 = 140 minutos = 2 horas con 20 minutos.",
  },
  {
    n: 223,
    stem: "En un curso de 30 estudiantes, 18 aprobaron matemáticas y el resto no aprobó. ¿Qué porcentaje de estudiantes no aprobó?",
    options: ["30%", "35%", "40%", "45%"],
    correct: "C",
    expl: "30 − 18 = 12; 12/30 = 0.40 = 40% de estudiantes no aprobó.",
  },
  {
    n: 224,
    stem: "Un docente de primaria dedica 45 minutos diarios a la clase de matemáticas, 5 días a la semana. ¿Cuántas horas de matemáticas dicta en una semana?",
    options: ["3h 00min", "3h 15min", "3h 30min", "3h 45min"],
    correct: "D",
    expl: "45 × 5 = 225 minutos = 3 horas con 45 minutos.",
  },
  {
    n: 225,
    stem: "En una prueba de 20 preguntas, un estudiante respondió correctamente el 80%. ¿Cuántas preguntas respondió correctamente?",
    options: ["16", "14", "15", "18"],
    correct: "A",
    expl: "20 × 0.80 = 16 preguntas.",
  },
  {
    n: 226,
    stem: "Un docente organiza a sus 36 estudiantes en grupos de 4 para un trabajo colaborativo. ¿Cuántos grupos se conforman?",
    options: ["8", "9", "10", "12"],
    correct: "B",
    expl: "36 ÷ 4 = 9 grupos.",
  },
  {
    n: 227,
    stem: "De 40 estudiantes de un curso, 6 tienen un Plan Individual de Ajustes Razonables (PIAR). ¿Qué porcentaje del curso representan?",
    options: ["10%", "12%", "15%", "18%"],
    correct: "C",
    expl: "6/40 = 0.15 = 15% del curso.",
  },
  {
    n: 228,
    stem: "Un docente compra 15 cajas de material didáctico a $22.000 cada una. ¿Cuánto gasta en total?",
    options: ["$300.000", "$310.000", "$320.000", "$330.000"],
    correct: "D",
    expl: "15 × $22.000 = $330.000.",
  },
  {
    n: 229,
    stem: "En una evaluación bimestral, un curso de 25 estudiantes obtuvo un promedio de 3.6 (escala 1 a 5). Si se suma un punto adicional a cada estudiante por un trabajo extra, ¿cuál sería el nuevo promedio?",
    options: ["4.6", "4.4", "4.2", "4.8"],
    correct: "A",
    expl: "Si a cada estudiante se le suma 1 punto, el promedio del grupo también aumenta en 1 punto: 3.6 + 1 = 4.6.",
  },
  {
    n: 230,
    stem: "Un docente debe repartir 84 hojas de trabajo entre 3 grupos de estudiantes, de forma proporcional al número de integrantes: Grupo 1 tiene 7 estudiantes, Grupo 2 tiene 6 y Grupo 3 tiene 8 (total 21). ¿Cuántas hojas corresponden al Grupo 2?",
    options: ["20", "24", "28", "32"],
    correct: "B",
    expl: "84 ÷ 21 = 4 hojas por estudiante; Grupo 2: 6 × 4 = 24 hojas.",
  },
  {
    n: 231,
    stem: "Un docente dedica 12 minutos de cada clase de 50 minutos a la revisión de tareas. ¿Qué porcentaje del tiempo de clase representa esta actividad?",
    options: ["20%", "22%", "24%", "26%"],
    correct: "C",
    expl: "12/50 = 0.24 = 24% del tiempo de clase.",
  },
  {
    n: 232,
    stem: "En una biblioteca de aula hay 60 libros. Si el 30% son de literatura infantil y el 20% son de ciencias, ¿cuántos libros pertenecen a otras categorías?",
    options: ["24", "26", "28", "30"],
    correct: "D",
    expl: "30% + 20% = 50%. El resto (50%) corresponde a otras categorías: 60 × 0.50 = 30 libros.",
  },
  {
    n: 233,
    stem: "Un docente aplica una evaluación diagnóstica a sus 40 estudiantes. Si el 70% se ubicó en un nivel adecuado para iniciar el nuevo tema, ¿cuántos estudiantes necesitarían refuerzo adicional?",
    options: ["12", "10", "14", "16"],
    correct: "A",
    expl: "Adecuado: 40 × 0.70 = 28 estudiantes; Refuerzo: 40 − 28 = 12 estudiantes.",
  },
  {
    n: 234,
    stem: "Un docente destina 8 de las 40 semanas del año escolar a proyectos interdisciplinarios. ¿Qué porcentaje del año escolar representa esto?",
    options: ["15%", "20%", "25%", "30%"],
    correct: "B",
    expl: "8/40 = 0.20 = 20% del año escolar.",
  },
  {
    n: 235,
    stem: "Un docente tiene 3 cursos con 28, 32 y 30 estudiantes respectivamente. Si debe imprimir un taller para cada estudiante de los 3 cursos, a $150 por copia, ¿cuánto cuesta la impresión total?",
    options: ["$12.000", "$12.750", "$13.500", "$14.250"],
    correct: "C",
    expl: "28 + 32 + 30 = 90 estudiantes; 90 × $150 = $13.500.",
  },
  {
    n: 236,
    stem: "En una rúbrica de evaluación de 4 niveles, un docente asigna: Superior = 4 puntos, Alto = 3 puntos, Básico = 2 puntos, Bajo = 1 punto. Si un estudiante obtiene Alto en 3 criterios y Superior en 2 criterios, ¿cuál es su puntaje total?",
    options: ["13", "14", "15", "17"],
    correct: "D",
    expl: "3 criterios en Alto: 3 × 3 = 9; 2 criterios en Superior: 2 × 4 = 8; Total: 9 + 8 = 17 puntos.",
  },
  {
    n: 237,
    stem: "Un docente de matemáticas dicta 6 clases de 55 minutos cada una durante la semana. ¿Cuántos minutos de clase dicta en total esa semana?",
    options: ["330", "320", "310", "300"],
    correct: "A",
    expl: "6 × 55 = 330 minutos.",
  },
  {
    n: 238,
    stem: "En un curso de 36 estudiantes, la relación entre estudiantes que prefieren trabajo individual y trabajo en grupo es de 1 a 3. ¿Cuántos estudiantes prefieren trabajo individual?",
    options: ["6", "9", "12", "18"],
    correct: "B",
    expl: "La relación 1:3 implica 4 partes en total; 36 ÷ 4 = 9 estudiantes prefieren trabajo individual.",
  },
  {
    n: 239,
    stem: "Un docente debe calificar 120 evaluaciones. Si ya calificó el 45%, ¿cuántas evaluaciones le faltan por calificar?",
    options: ["60", "63", "66", "70"],
    correct: "C",
    expl: "Calificadas: 120 × 0.45 = 54; Faltan: 120 − 54 = 66 evaluaciones.",
  },
  {
    n: 240,
    stem: "Un docente distribuye el tiempo de una clase de 60 minutos así: 10 minutos de repaso, 35 minutos de desarrollo del tema y el resto para cierre y evaluación. ¿Cuántos minutos se destinan al cierre y la evaluación?",
    options: ["10", "12", "13", "15"],
    correct: "D",
    expl: "60 − 10 − 35 = 15 minutos para cierre y evaluación.",
  },
];

for (const q of cuant) {
  push({
    id: `dir-apt-num-${String(q.n).padStart(3, "0")}`,
    pillar: "aptitudNumerica",
    module: "Aptitud numérica",
    topic: "Razonamiento cuantitativo · Directivo (ola 3)",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: [],
    dif: 1,
  });
}

// ——— Competencias blandas (241–260) ———
const blandas = [
  {
    n: 241,
    stem: "Un estudiante interrumpe reiteradamente la clase con comentarios y risas que distraen al resto del grupo. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Hablar con el estudiante en un momento apropiado (no necesariamente frente a todo el grupo) para entender la causa y establecer acuerdos claros de comportamiento.",
      "Ignorar la situación esperando que se resuelva sola.",
      "Expulsar al estudiante del aula de forma permanente sin ningún diálogo previo.",
      "Ridiculizar al estudiante frente al grupo para que no vuelva a interrumpir.",
    ],
    correct: "A",
    expl: "Indagar la causa y establecer acuerdos claros, evitando la exposición pública, es la respuesta más constructiva y formativa.",
  },
  {
    n: 242,
    stem: "Un estudiante no entrega las tareas de forma reiterada durante varias semanas. ¿Cuál sería la actuación más adecuada del docente antes de tomar medidas más drásticas?",
    options: [
      "Bajar la calificación de forma automática sin ninguna conversación previa.",
      "Conversar con el estudiante para entender las causas, e informar oportunamente a la familia si la situación persiste.",
      "Ignorar la situación mientras no afecte a otros estudiantes.",
      "Compararlo públicamente con estudiantes que sí cumplen con sus tareas.",
    ],
    correct: "B",
    expl: "Indagar las causas y comunicar oportunamente con la familia permite una intervención más efectiva que una sanción automática.",
  },
  {
    n: 243,
    stem: "Un padre de familia cuestiona, de manera respetuosa, una calificación asignada a su hijo en un trabajo escrito. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Negarse a explicar los criterios utilizados en la calificación.",
      "Cambiar la calificación de inmediato solo para evitar el reclamo.",
      "Explicar con claridad los criterios de evaluación utilizados y revisar objetivamente el trabajo junto con el padre si es necesario.",
      "Decirle al padre que no tiene ningún derecho a cuestionar la calificación.",
    ],
    correct: "C",
    expl: "La transparencia en los criterios y la disposición a revisar objetivamente fortalece la confianza en el proceso evaluativo.",
  },
  {
    n: 244,
    stem: "Durante un examen, el docente sorprende a un estudiante copiando las respuestas de un compañero. ¿Cuál sería la actuación más adecuada en ese momento?",
    options: [
      "Ignorar la situación para no interrumpir a los demás estudiantes.",
      "Anular la evaluación de ambos estudiantes sin ninguna indagación posterior.",
      "Sancionar públicamente al estudiante frente al resto del curso.",
      "Retirar discretamente el material irregular y abordar la situación formalmente después, según el manual de convivencia.",
    ],
    correct: "D",
    expl: "Manejar la situación con discreción en el momento y formalizarla después, respetando el debido proceso, es la actuación más adecuada.",
  },
  {
    n: 245,
    stem: "Durante la clase, el docente presencia directamente una situación de acoso entre dos estudiantes. ¿Cuál sería la actuación más adecuada en ese momento?",
    options: [
      "Intervenir de inmediato para detener la situación, y posteriormente reportarla y activar la ruta de atención institucional correspondiente.",
      "Esperar a que termine la clase para no interrumpir la actividad académica.",
      "Ignorar la situación si los estudiantes involucrados parecen estar bromeando.",
      "Resolverlo únicamente de manera informal, sin reportarlo a ninguna instancia institucional.",
    ],
    correct: "A",
    expl: "La intervención inmediata, seguida del reporte formal, es la actuación apropiada ante una situación de acoso presenciada directamente.",
  },
  {
    n: 246,
    stem: "Un estudiante con dificultades de aprendizaje se atrasa cada vez más respecto al ritmo del resto del grupo. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Aplicar exactamente las mismas actividades y tiempos que al resto del grupo, sin ningún ajuste.",
      "Comunicar la situación al equipo de apoyo pedagógico y explorar ajustes razonables en las actividades del estudiante.",
      "Reducir las expectativas académicas de todo el grupo para nivelar al estudiante.",
      "Recomendar directamente que el estudiante repita el año, sin ningún proceso previo de apoyo.",
    ],
    correct: "B",
    expl: "Activar el apoyo pedagógico y ajustar las actividades de forma razonable es la respuesta institucionalmente adecuada.",
  },
  {
    n: 247,
    stem: "Durante un trabajo en grupo, dos estudiantes tienen un conflicto por desacuerdos sobre cómo dividir las tareas. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Separar a ambos estudiantes de cualquier trabajo grupal futuro.",
      "Ignorar el conflicto mientras no se torne agresivo.",
      "Mediar el conflicto ayudándolos a comunicarse y a acordar una distribución de tareas que ambos consideren justa.",
      "Resolver la disputa asignando las tareas él mismo sin involucrar a los estudiantes.",
    ],
    correct: "C",
    expl: "La mediación que fortalece la comunicación entre los estudiantes tiene un valor formativo mayor que resolver el conflicto por ellos.",
  },
  {
    n: 248,
    stem: "Un estudiante muy tímido nunca participa voluntariamente en clase, aunque sus trabajos escritos muestran buen desempeño. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Obligarlo a participar en público de forma repentina para 'ayudarlo a superar la timidez'.",
      "Asumir que no tiene ningún interés en participar y dejar de involucrarlo.",
      "Ignorar la situación, ya que su desempeño escrito es adecuado.",
      "Generar oportunidades de participación de menor exposición (en parejas o pequeños grupos) antes de proponer una participación frente a todo el curso.",
    ],
    correct: "D",
    expl: "Generar oportunidades graduales de participación respeta el ritmo del estudiante mientras fomenta su desarrollo de habilidades comunicativas.",
  },
  {
    n: 249,
    stem: "Un colega le pide al docente que suba la nota de un estudiante en una evaluación compartida, sin ninguna justificación pedagógica de por medio. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Explicarle con respeto que la calificación debe basarse en criterios objetivos, y no acceder a la solicitud sin justificación.",
      "Acceder a la solicitud para mantener una buena relación con el colega.",
      "Reportar de inmediato al colega ante el rector sin conversar primero con él.",
      "Ignorar la solicitud sin darle ninguna respuesta.",
    ],
    correct: "A",
    expl: "Mantener la objetividad de los criterios de evaluación, explicando la negativa con respeto, protege la integridad del proceso evaluativo.",
  },
  {
    n: 250,
    stem: "Un estudiante llega nuevo a la institución a mitad de año y parece sentirse aislado del resto del grupo. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Esperar a que el estudiante se integre por sí mismo sin ninguna intervención.",
      "Diseñar actividades que favorezcan su integración social y académica con el grupo, sin exponerlo de forma incómoda.",
      "Pedirle a otro estudiante que se encargue por completo de su integración.",
      "Ignorar la situación mientras el estudiante no presente dificultades académicas.",
    ],
    correct: "B",
    expl: "Diseñar actividades intencionadas de integración, sin exponer innecesariamente al estudiante, favorece su adaptación social y académica.",
  },
  {
    n: 251,
    stem: "El docente comete un error de contenido durante la explicación de un tema y se da cuenta poco después, frente al mismo grupo. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Ignorar el error para no perder autoridad frente al grupo.",
      "Esperar a que algún estudiante lo note para corregirlo.",
      "Reconocer el error abiertamente frente al grupo y hacer la corrección correspondiente.",
      "Corregir el error únicamente de forma individual con cada estudiante.",
    ],
    correct: "C",
    expl: "Reconocer el error con transparencia modela una actitud de aprendizaje continuo y fortalece la confianza del grupo.",
  },
  {
    n: 252,
    stem: "Varios estudiantes usan el celular de forma reiterada durante la clase, a pesar de las indicaciones dadas al inicio del período. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Ignorar la situación mientras no afecte su propio desempeño como docente.",
      "Confiscar los celulares de forma permanente sin ningún proceso previo.",
      "Prohibir el ingreso de los estudiantes a clase mientras tengan el celular consigo.",
      "Recordar con firmeza los acuerdos establecidos en el manual de convivencia y aplicar las consecuencias previstas de manera consistente.",
    ],
    correct: "D",
    expl: "Aplicar de forma consistente los acuerdos previamente establecidos es más efectivo y formativo que medidas improvisadas o desproporcionadas.",
  },
  {
    n: 253,
    stem: "El docente de apoyo pedagógico y el docente de aula no logran coordinar adecuadamente los apoyos previstos para un estudiante con PIAR. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Buscar un espacio de coordinación conjunta para alinear estrategias y evitar que el estudiante reciba mensajes contradictorios.",
      "Cada docente debe aplicar sus propias estrategias sin ninguna coordinación.",
      "El docente de aula debe asumir por completo la responsabilidad, sin involucrar al docente de apoyo.",
      "Suspender los apoyos previstos hasta que surja un mejor momento para coordinarlos.",
    ],
    correct: "A",
    expl: "La coordinación conjunta entre ambos docentes es esencial para que los apoyos sean coherentes y efectivos.",
  },
  {
    n: 254,
    stem: "Un estudiante de alto rendimiento manifiesta que se aburre porque el ritmo de la clase le resulta muy lento. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Ignorar su comentario, ya que el ritmo debe ajustarse al promedio del grupo.",
      "Ofrecerle actividades de profundización o retos adicionales que enriquezcan su aprendizaje sin desatender al resto del grupo.",
      "Adelantarlo a un grado superior de inmediato, sin ningún análisis adicional.",
      "Pedirle que ayude a enseñar a sus compañeros en reemplazo del docente.",
    ],
    correct: "B",
    expl: "Ofrecer actividades de profundización responde a la necesidad del estudiante sin descuidar la atención al resto del grupo.",
  },
  {
    n: 255,
    stem: "El docente siente que la carga de tareas administrativas (registros, formatos, reportes) está afectando el tiempo disponible para la planeación pedagógica. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Dejar de realizar las tareas administrativas sin informar a nadie.",
      "Asumir la situación en silencio, sin comunicarla a ninguna instancia.",
      "Comunicar la situación de manera constructiva al coordinador o rector, y proponer, si es posible, alternativas para optimizar el tiempo.",
      "Reducir la calidad de la planeación pedagógica sin buscar ninguna alternativa.",
    ],
    correct: "C",
    expl: "Comunicar la situación de forma constructiva y proponer alternativas es más productivo que ignorarla o asumirla en silencio.",
  },
  {
    n: 256,
    stem: "Un estudiante le falta al respeto verbalmente al docente frente a todo el grupo. ¿Cuál sería la actuación más adecuada en el momento?",
    options: [
      "Responder con el mismo tono para 'poner en su lugar' al estudiante.",
      "Ignorar por completo la situación frente al grupo.",
      "Expulsar de inmediato al estudiante de la institución sin ningún proceso.",
      "Mantener la calma, establecer el límite con firmeza y respeto, y abordar la situación formalmente después según el manual de convivencia.",
    ],
    correct: "D",
    expl: "Mantener la calma y establecer límites con firmeza, sin perder el respeto, permite manejar la situación de forma profesional y formativa.",
  },
  {
    n: 257,
    stem: "Los padres de dos estudiantes que tuvieron un conflicto llegan al mismo tiempo, molestos, a buscar al docente. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Atenderlos por separado, escuchando a cada uno, antes de facilitar cualquier espacio conjunto si es pertinente.",
      "Atenderlos juntos de inmediato sin ninguna preparación previa.",
      "Pedirles que resuelvan el conflicto entre ellos sin intervención del docente.",
      "Evitar la conversación y remitirlos directamente a la rectoría sin ninguna explicación.",
    ],
    correct: "A",
    expl: "Escuchar por separado antes de cualquier encuentro conjunto permite manejar la situación con mayor calma y objetividad.",
  },
  {
    n: 258,
    stem: "El docente debe informar a un estudiante que no logró los objetivos de aprendizaje del período, a pesar de su esfuerzo visible. ¿Cuál sería la forma más adecuada de comunicarlo?",
    options: [
      "Comunicar el resultado sin ningún reconocimiento del esfuerzo realizado.",
      "Reconocer el esfuerzo realizado, explicar con claridad las áreas por fortalecer y ofrecer un plan concreto de apoyo.",
      "Evitar la conversación y solo enviar la calificación por escrito.",
      "Comparar su desempeño con el de otros estudiantes del curso.",
    ],
    correct: "B",
    expl: "Reconocer el esfuerzo y ofrecer un plan concreto de apoyo mantiene la motivación del estudiante frente a una noticia difícil.",
  },
  {
    n: 259,
    stem: "Un estudiante comparte con el docente, de manera confidencial, que está atravesando una situación familiar difícil. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Compartir la información con otros docentes sin el conocimiento del estudiante.",
      "Minimizar la situación y continuar la clase como si no hubiera pasado nada.",
      "Escuchar con respeto, mantener la confidencialidad apropiada y orientar el caso hacia el apoyo institucional pertinente si es necesario.",
      "Aconsejar directamente al estudiante sobre decisiones familiares que no le corresponden como docente.",
    ],
    correct: "C",
    expl: "Escuchar con respeto y canalizar hacia el apoyo institucional adecuado es la actuación más apropiada ante una situación de este tipo.",
  },
  {
    n: 260,
    stem: "El docente nota que un estudiante ha bajado su rendimiento académico y ha cambiado su comportamiento en las últimas semanas. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Asumir que se trata solo de falta de esfuerzo y aplicar una sanción académica.",
      "Ignorar el cambio mientras no afecte gravemente sus calificaciones.",
      "Comentarlo únicamente con otros estudiantes para obtener más información.",
      "Acercarse con empatía al estudiante para indagar qué está sucediendo, y activar los apoyos institucionales pertinentes si es necesario.",
    ],
    correct: "D",
    expl: "Acercarse con empatía para indagar la causa del cambio, antes de asumir explicaciones, permite una respuesta más adecuada y oportuna.",
  },
];

for (const q of blandas) {
  push({
    id: `dir-apt-blan-${String(q.n).padStart(3, "0")}`,
    pillar: "comportamental",
    module: "Competencias comportamentales",
    topic: "Competencias blandas · Directivo (ola 3)",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: [],
    dif: 2,
  });
}

// ——— Conocimientos disciplinares básicos (261–280) ———
const disciplinares = [
  {
    n: 261,
    area: "matematicas",
    stem: "¿Cuál es el resultado de la operación 3/4 + 1/8?",
    options: ["7/8", "4/12", "1/2", "7/12"],
    correct: "A",
    expl: "3/4 equivale a 6/8; 6/8 + 1/8 = 7/8.",
  },
  {
    n: 262,
    area: "matematicas",
    stem: "¿Cuál es el área de un rectángulo cuyos lados miden 8 cm y 5 cm?",
    options: ["26 cm²", "40 cm²", "35 cm²", "45 cm²"],
    correct: "B",
    expl: "El área de un rectángulo es base × altura: 8 × 5 = 40 cm².",
  },
  {
    n: 263,
    area: "matematicas",
    stem: "En la sucesión 2, 5, 8, 11, 14, ..., ¿cuál es el siguiente término?",
    options: ["15", "16", "17", "18"],
    correct: "C",
    expl: "La sucesión aumenta de 3 en 3. El siguiente término después de 14 es 14 + 3 = 17.",
  },
  {
    n: 264,
    area: "matematicas",
    stem: "¿Cuál de las siguientes opciones representa correctamente, en palabras, el número decimal 305,7?",
    options: [
      "Trescientos cinco mil setecientos.",
      "Treinta mil quinientos setenta.",
      "Trescientos cinco con siete centésimas.",
      "Trescientos cinco con siete décimas.",
    ],
    correct: "D",
    expl: "El número 305,7 se lee como 'trescientos cinco enteros con siete décimas', ya que el 7 ocupa la primera posición decimal.",
  },
  {
    n: 265,
    area: "matematicas",
    stem: "Si un tren recorre 240 km en 3 horas a velocidad constante, ¿cuál es su velocidad promedio?",
    options: ["80 km/h", "70 km/h", "90 km/h", "60 km/h"],
    correct: "A",
    expl: "Velocidad = distancia ÷ tiempo = 240 ÷ 3 = 80 km/h.",
  },
  {
    n: 266,
    area: "lenguaje",
    stem: "¿Cuál de las siguientes palabras es un sustantivo?",
    options: ["correr", "amabilidad", "rápidamente", "muy"],
    correct: "B",
    expl: "'Amabilidad' nombra una cualidad, por lo que funciona como sustantivo; las demás son un verbo y adverbios.",
  },
  {
    n: 267,
    area: "lenguaje",
    stem: "En la oración 'El perro de mi vecino ladra fuertemente', ¿cuál es el sujeto?",
    options: ["Ladra fuertemente", "Mi vecino", "El perro de mi vecino", "Fuertemente"],
    correct: "C",
    expl: "El sujeto es quien realiza la acción del verbo 'ladra': 'el perro de mi vecino'.",
  },
  {
    n: 268,
    area: "lenguaje",
    stem: "¿Cuál de las siguientes oraciones está correctamente puntuada?",
    options: [
      "Cuando llegue a casa prepararé, la cena para toda la familia.",
      "Cuando, llegue a casa prepararé la cena para toda la familia.",
      "Cuando llegue a casa prepararé la cena, para toda la familia.",
      "Cuando llegue a casa, prepararé la cena para toda la familia.",
    ],
    correct: "D",
    expl: "La coma debe marcar la pausa tras la subordinada inicial ('Cuando llegue a casa'), no interrumpir el verbo y su complemento.",
  },
  {
    n: 269,
    area: "lenguaje",
    stem: "¿Qué tipo de texto se caracteriza principalmente por narrar una secuencia de hechos, reales o ficticios, organizados en el tiempo?",
    options: ["Texto narrativo", "Texto argumentativo", "Texto expositivo", "Texto instructivo"],
    correct: "A",
    expl: "El texto narrativo se define por presentar una secuencia de hechos organizados temporalmente, protagonizados por personajes.",
  },
  {
    n: 270,
    area: "lenguaje",
    stem: "¿Cuál es el antónimo de la palabra 'generoso'?",
    options: ["Amable", "Tacaño", "Solidario", "Bondadoso"],
    correct: "B",
    expl: "'Tacaño' expresa un significado opuesto a 'generoso'; las demás palabras son más bien sinónimos o cercanas en significado.",
  },
  {
    n: 271,
    area: "ciencias",
    stem: "¿Cuál es la función principal de las raíces en una planta?",
    options: [
      "Realizar la fotosíntesis principalmente.",
      "Producir las flores y los frutos.",
      "Absorber agua y nutrientes del suelo, y fijar la planta al terreno.",
      "Almacenar exclusivamente el polen de la planta.",
    ],
    correct: "C",
    expl: "Las raíces cumplen principalmente la función de absorción de agua y nutrientes, además de anclar la planta al suelo.",
  },
  {
    n: 272,
    area: "ciencias",
    stem: "¿Cuál de los siguientes estados de la materia se caracteriza por tener forma y volumen definidos?",
    options: ["Gaseoso", "Plasma", "Líquido", "Sólido"],
    correct: "D",
    expl: "El estado sólido se caracteriza por mantener tanto su forma como su volumen, a diferencia del líquido y el gaseoso.",
  },
  {
    n: 273,
    area: "ciencias",
    stem: "¿Qué órgano del sistema digestivo humano se encarga principalmente de absorber los nutrientes de los alimentos?",
    options: ["Intestino delgado", "Estómago", "Esófago", "Intestino grueso"],
    correct: "A",
    expl: "El intestino delgado es el principal responsable de la absorción de nutrientes hacia el torrente sanguíneo.",
  },
  {
    n: 274,
    area: "ciencias",
    stem: "¿Cuál de las siguientes es una fuente de energía renovable?",
    options: ["Carbón mineral", "Energía solar", "Petróleo", "Gas natural"],
    correct: "B",
    expl: "La energía solar proviene de una fuente prácticamente inagotable a escala humana, a diferencia de los combustibles fósiles.",
  },
  {
    n: 275,
    area: "ciencias",
    stem: "En una cadena alimentaria, ¿qué papel cumplen los organismos llamados 'productores'?",
    options: [
      "Se alimentan exclusivamente de otros animales.",
      "Descomponen la materia orgánica muerta.",
      "Producen su propio alimento mediante fotosíntesis, como las plantas.",
      "Solo se alimentan de productores.",
    ],
    correct: "C",
    expl: "Los productores, como las plantas, elaboran su propio alimento a través de la fotosíntesis, siendo la base de la cadena alimentaria.",
  },
  {
    n: 276,
    area: "sociales",
    stem: "¿Cuál es la capital de Colombia?",
    options: ["Medellín", "Cali", "Cartagena", "Bogotá"],
    correct: "D",
    expl: "Bogotá es la capital de la República de Colombia.",
  },
  {
    n: 277,
    area: "sociales",
    stem: "¿Qué océano baña las costas de la región Pacífica colombiana?",
    options: ["Océano Pacífico", "Océano Atlántico", "Mar Caribe", "Océano Índico"],
    correct: "A",
    expl: "La región Pacífica colombiana limita con el océano Pacífico.",
  },
  {
    n: 278,
    area: "sociales",
    stem: "¿En qué año se promulgó la Constitución Política de Colombia actualmente vigente?",
    options: ["1986", "1991", "1994", "1998"],
    correct: "B",
    expl: "La Constitución Política de Colombia vigente fue promulgada en 1991.",
  },
  {
    n: 279,
    area: "sociales",
    stem: "¿Cuál de las siguientes es una función principal del Congreso de la República de Colombia?",
    options: [
      "Administrar justicia en los procesos penales.",
      "Dirigir las fuerzas militares del país.",
      "Hacer, reformar y derogar las leyes.",
      "Nombrar a los gobernadores departamentales.",
    ],
    correct: "C",
    expl: "La función legislativa —hacer, reformar y derogar las leyes— corresponde principalmente al Congreso de la República.",
  },
  {
    n: 280,
    area: "sociales",
    stem: "¿Qué se entiende por 'línea del tiempo' como herramienta didáctica en el área de ciencias sociales?",
    options: [
      "Un mapa que representa la ubicación geográfica de un país.",
      "Un instrumento para medir la duración exacta de un evento en segundos.",
      "Una tabla que compara datos estadísticos entre países.",
      "Una representación gráfica que organiza cronológicamente una serie de hechos históricos.",
    ],
    correct: "D",
    expl: "La línea del tiempo es una herramienta que permite visualizar el orden cronológico de los hechos históricos estudiados.",
  },
];

const areaTopic = {
  matematicas: "Matemáticas · conocimientos básicos",
  lenguaje: "Lengua Castellana · conocimientos básicos",
  ciencias: "Ciencias Naturales · conocimientos básicos",
  sociales: "Ciencias Sociales · conocimientos básicos",
};

for (const q of disciplinares) {
  push({
    id: `dir-apt-dis-${String(q.n).padStart(3, "0")}`,
    pillar: "pedagogico",
    module: "Conocimientos disciplinares",
    topic: areaTopic[q.area],
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: [],
    specialtyTags: [q.area],
    targetCargo: q.area,
    dif: 1,
  });
}

// ——— Competencias pedagógicas (281–300) ———
const pedago = [
  {
    n: 281,
    stem: "Según la teoría de Piaget, un niño que se encuentra en la etapa de las operaciones concretas (aproximadamente entre los 7 y los 11 años) se caracteriza principalmente por:",
    options: [
      "Poder realizar operaciones lógicas sobre objetos y situaciones concretas, aunque aún con dificultad para el pensamiento abstracto.",
      "Pensar exclusivamente mediante símbolos abstractos sin ninguna referencia concreta.",
      "No poder aún distinguir su propio punto de vista del de los demás.",
      "Depender únicamente de reflejos sensoriomotores para interactuar con el entorno.",
    ],
    correct: "A",
    expl: "En la etapa de las operaciones concretas, según Piaget, el niño logra razonar lógicamente sobre situaciones concretas, aunque el pensamiento abstracto pleno se consolida en la etapa siguiente.",
    tags: ["piaget"],
  },
  {
    n: 282,
    stem: "El aprendizaje por descubrimiento, propuesto por Jerome Bruner, se caracteriza principalmente por:",
    options: [
      "Que el docente entregue toda la información ya organizada, sin ninguna exploración del estudiante.",
      "Que el estudiante explore activamente y construya sus propias conclusiones, con la guía del docente.",
      "Que el aprendizaje se limite a la memorización de fórmulas y definiciones.",
      "Que el estudiante trabaje siempre de forma individual y sin ninguna orientación.",
    ],
    correct: "B",
    expl: "Bruner propone que el estudiante descubra activamente los principios, con una guía docente que estructura la exploración, en lugar de recibir la información ya elaborada.",
    tags: ["bruner"],
  },
  {
    n: 283,
    stem: "Según el método de resolución de problemas propuesto por George Polya, ¿cuál es la primera fase que debe abordar un estudiante frente a un problema matemático?",
    options: [
      "Ejecutar inmediatamente el primer procedimiento que se le ocurra.",
      "Revisar la solución obtenida al final del proceso.",
      "Comprender el problema, identificando los datos y lo que se pide resolver.",
      "Comparar su respuesta con la de otros compañeros.",
    ],
    correct: "C",
    expl: "Polya propone comprender el problema como la primera de sus cuatro fases, antes de diseñar un plan, ejecutarlo y revisar la solución.",
  },
  {
    n: 284,
    stem: "Aplicar el método científico como estrategia didáctica en la clase de ciencias naturales implica principalmente que los estudiantes:",
    options: [
      "Memoricen las leyes científicas sin ningún proceso de indagación.",
      "Repitan experimentos exactamente como se describen en el libro de texto, sin ninguna pregunta propia.",
      "Eviten formular hipótesis propias sobre los fenómenos estudiados.",
      "Formulen preguntas, planteen hipótesis, las pongan a prueba mediante la observación o la experimentación, y analicen los resultados.",
    ],
    correct: "D",
    expl: "El método científico como estrategia didáctica busca que los estudiantes vivan un proceso de indagación activa, no solo la memorización de conclusiones ya establecidas.",
  },
  {
    n: 285,
    stem: "El uso de material concreto (como fichas, regletas o bloques) en la enseñanza inicial de las matemáticas tiene como propósito principal:",
    options: [
      "Facilitar la comprensión de conceptos abstractos a partir de una manipulación tangible previa a la representación simbólica.",
      "Reemplazar por completo la necesidad de trabajar con símbolos y números escritos.",
      "Limitar la enseñanza de las matemáticas exclusivamente a la educación inicial.",
      "Evaluar el desempeño motriz de los estudiantes, más que su comprensión matemática.",
    ],
    correct: "A",
    expl: "El material concreto sirve como puente entre la manipulación tangible y la comprensión de conceptos matemáticos abstractos.",
  },
  {
    n: 286,
    stem: "La disciplina positiva, como enfoque para el manejo del comportamiento en el aula, se caracteriza principalmente por:",
    options: [
      "Basarse en el castigo como principal herramienta de corrección.",
      "Combinar firmeza y amabilidad, buscando que el estudiante comprenda las consecuencias de sus actos y desarrolle autorregulación.",
      "Evitar establecer cualquier tipo de límite o consecuencia ante el comportamiento inadecuado.",
      "Delegar por completo el manejo del comportamiento en la familia del estudiante.",
    ],
    correct: "B",
    expl: "La disciplina positiva combina firmeza y respeto, buscando el desarrollo de la autorregulación más que la obediencia por temor al castigo.",
  },
  {
    n: 287,
    stem: "Cuando un docente construye las normas de convivencia del aula junto con sus estudiantes, en lugar de imponerlas unilateralmente, principalmente busca:",
    options: [
      "Reducir su propia responsabilidad frente al manejo del grupo.",
      "Eliminar la necesidad de cualquier consecuencia ante el incumplimiento de las normas.",
      "Que los estudiantes comprendan el sentido de las normas y se comprometan de manera más genuina con su cumplimiento.",
      "Delegar por completo la autoridad del aula en los estudiantes.",
    ],
    correct: "C",
    expl: "La construcción conjunta de normas favorece la comprensión de su sentido y un compromiso más genuino por parte de los estudiantes.",
  },
  {
    n: 288,
    stem: "A diferencia de la motivación extrínseca, la motivación intrínseca en el aprendizaje se caracteriza principalmente por:",
    options: [
      "Depender de premios o calificaciones externas para sostenerse.",
      "Requerir siempre la supervisión constante de un adulto.",
      "Estar motivada únicamente por evitar un castigo.",
      "Surgir del interés genuino o la satisfacción personal que el estudiante encuentra en la actividad misma.",
    ],
    correct: "D",
    expl: "La motivación intrínseca surge del interés o disfrute genuino de la actividad, a diferencia de la extrínseca, que depende de factores externos.",
  },
  {
    n: 289,
    stem: "Un proyecto de aula que integra contenidos de matemáticas, ciencias naturales y lengua castellana alrededor de un mismo tema es un ejemplo de:",
    options: [
      "Interdisciplinariedad o currículo integrado.",
      "Evaluación sumativa exclusiva de una sola área.",
      "Enseñanza tradicional basada en asignaturas completamente aisladas.",
      "Un modelo pedagógico exclusivo de la educación superior.",
    ],
    correct: "A",
    expl: "La articulación de contenidos de distintas áreas alrededor de un mismo tema es característica de la interdisciplinariedad o el currículo integrado.",
  },
  {
    n: 290,
    stem: "Una unidad didáctica bien formulada debe articular, como mínimo:",
    options: [
      "Únicamente la lista de contenidos a desarrollar, sin ninguna secuencia de actividades.",
      "Objetivos de aprendizaje, contenidos, actividades secuenciadas y criterios de evaluación.",
      "Solo el número de sesiones de clase que durará el tema.",
      "Exclusivamente los recursos bibliográficos que se usarán.",
    ],
    correct: "B",
    expl: "Una unidad didáctica articula de manera coherente los objetivos, contenidos, actividades y criterios de evaluación de un período de enseñanza.",
  },
  {
    n: 291,
    stem: "El uso de las TIC como herramienta de inclusión educativa implica principalmente que estas tecnologías:",
    options: [
      "Se reserven exclusivamente para estudiantes sin ninguna dificultad de aprendizaje.",
      "Reemplacen por completo la interacción del docente con los estudiantes.",
      "Se utilicen para ofrecer distintas formas de acceso a la información y de expresión, según las necesidades de cada estudiante.",
      "Se limiten al uso de un único tipo de dispositivo para todo el grupo.",
    ],
    correct: "C",
    expl: "Las TIC pueden ampliar las formas de acceso y expresión disponibles para los estudiantes, favoreciendo la atención a la diversidad en el aula.",
  },
  {
    n: 292,
    stem: "Según el ciclo de aprendizaje experiencial propuesto por David Kolb, el aprendizaje se produce principalmente a través de:",
    options: [
      "La memorización repetida de información teórica, sin ninguna experiencia práctica.",
      "La exposición pasiva del estudiante a la información.",
      "La evaluación exclusivamente mediante pruebas escritas.",
      "Un ciclo que incluye la experiencia concreta, la observación reflexiva, la conceptualización abstracta y la experimentación activa.",
    ],
    correct: "D",
    expl: "Kolb propone un ciclo de cuatro fases que articula la experiencia, la reflexión, la conceptualización y la experimentación como base del aprendizaje.",
  },
  {
    n: 293,
    stem: "Una pregunta docente como '¿por qué crees que el personaje tomó esa decisión?' se considera, en comparación con una pregunta como '¿cómo se llama el personaje principal?', una pregunta de:",
    options: [
      "Orden superior, ya que exige análisis e interpretación, en lugar de solo recuperación literal de información.",
      "Orden inferior, ya que solo requiere memorizar un dato puntual.",
      "Igual complejidad que la pregunta literal, ya que ambas tienen una única respuesta correcta.",
      "Menor exigencia cognitiva, ya que no requiere ninguna justificación por parte del estudiante.",
    ],
    correct: "A",
    expl: "Las preguntas que exigen análisis, interpretación o justificación se consideran de orden superior, frente a las preguntas de recuperación literal de información.",
  },
  {
    n: 294,
    stem: "Promover el pensamiento crítico en el aula implica principalmente que los estudiantes:",
    options: [
      "Acepten sin cuestionamiento cualquier información que reciban.",
      "Analicen, cuestionen y evalúen la información y los argumentos con los que se encuentran, antes de aceptarlos o rechazarlos.",
      "Memoricen la mayor cantidad posible de información sin ningún análisis.",
      "Eviten expresar desacuerdos con el docente en cualquier circunstancia.",
    ],
    correct: "B",
    expl: "El pensamiento crítico implica analizar y evaluar la información de forma razonada, no aceptarla ni rechazarla sin ningún análisis.",
  },
  {
    n: 295,
    stem: "Un ítem de evaluación que presenta una situación o contexto realista antes de formular la pregunta (al estilo de las pruebas Saber o PISA) busca principalmente:",
    options: [
      "Aumentar la dificultad del ítem sin ningún propósito pedagógico adicional.",
      "Evaluar exclusivamente la memoria del estudiante sobre el contexto presentado.",
      "Evaluar la capacidad del estudiante para aplicar sus conocimientos y habilidades en una situación con sentido, y no solo el contenido de forma aislada.",
      "Reemplazar por completo la necesidad de enseñar contenidos disciplinares.",
    ],
    correct: "C",
    expl: "Los ítems contextualizados buscan evaluar la aplicación de conocimientos y habilidades en situaciones con sentido, más allá de la memorización aislada.",
  },
  {
    n: 296,
    stem: "La enseñanza recíproca (reciprocal teaching), como estrategia de comprensión lectora, se caracteriza principalmente porque los estudiantes:",
    options: [
      "Leen de forma completamente individual, sin ninguna interacción con sus compañeros.",
      "Memorizan el texto de forma literal, palabra por palabra.",
      "Reciben únicamente preguntas cerradas del docente al final de la lectura.",
      "Asumen roles rotativos (como predecir, cuestionar, aclarar y resumir) para guiar colaborativamente la comprensión de un texto.",
    ],
    correct: "D",
    expl: "La enseñanza recíproca se basa en que los estudiantes asuman roles específicos que guían de forma colaborativa la comprensión del texto.",
  },
  {
    n: 297,
    stem: "El concepto de 'andamiaje' (scaffolding), estrechamente ligado a la Zona de Desarrollo Próximo, se refiere principalmente a:",
    options: [
      "El apoyo temporal y ajustado que ofrece el docente, y que se va retirando gradualmente a medida que el estudiante gana autonomía.",
      "Una estructura física utilizada exclusivamente en las clases de educación física.",
      "Un tipo de evaluación aplicada únicamente al final del año escolar.",
      "La eliminación total de cualquier apoyo docente desde el inicio del proceso de aprendizaje.",
    ],
    correct: "A",
    expl: "El andamiaje implica un apoyo ajustado y temporal, que se retira progresivamente a medida que el estudiante desarrolla mayor autonomía.",
    tags: ["vygotsky"],
  },
  {
    n: 298,
    stem: "Un currículo por proyectos de aula, aplicado especialmente en la educación primaria, se caracteriza principalmente por:",
    options: [
      "Organizar todo el año escolar exclusivamente alrededor de un examen final.",
      "Articular los aprendizajes de distintas áreas alrededor de preguntas o problemáticas significativas para los estudiantes.",
      "Prescindir por completo de cualquier tipo de planeación docente.",
      "Limitarse a una sola área del conocimiento durante todo el período académico.",
    ],
    correct: "B",
    expl: "El currículo por proyectos articula distintas áreas alrededor de preguntas o problemáticas significativas para los estudiantes, favoreciendo un aprendizaje con sentido.",
  },
  {
    n: 299,
    stem: "El agrupamiento flexible en el aula, como estrategia pedagógica, consiste principalmente en:",
    options: [
      "Mantener siempre los mismos grupos de estudiantes durante todo el año escolar, sin ninguna variación.",
      "Formar los grupos exclusivamente por orden alfabético.",
      "Variar la composición de los grupos de trabajo según el propósito de cada actividad y las necesidades de los estudiantes.",
      "Evitar cualquier tipo de trabajo grupal en el aula.",
    ],
    correct: "C",
    expl: "El agrupamiento flexible permite adaptar la composición de los grupos según el propósito pedagógico de cada actividad.",
  },
  {
    n: 300,
    stem: "La observación, como instrumento de evaluación cualitativa en el aula, permite principalmente al docente:",
    options: [
      "Sustituir por completo cualquier forma de evaluación escrita.",
      "Evaluar exclusivamente el comportamiento disciplinario de los estudiantes.",
      "Evitar la necesidad de registrar cualquier evidencia del proceso de aprendizaje.",
      "Recoger información sobre procesos, actitudes y desempeños que no siempre son visibles a través de instrumentos escritos.",
    ],
    correct: "D",
    expl: "La observación permite captar procesos, actitudes y desempeños que instrumentos exclusivamente escritos podrían no evidenciar.",
  },
];

for (const q of pedago) {
  push({
    id: `dir-apt-ped-${String(q.n).padStart(3, "0")}`,
    pillar: "pedagogico",
    module: "Competencias pedagógicas",
    topic: "Competencias pedagógicas · Directivo (ola 3)",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: q.tags || [],
    dif: 2,
  });
}

module.exports = {raw, push};
