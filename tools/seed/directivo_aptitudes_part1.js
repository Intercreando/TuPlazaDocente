/**
 * 100 ítems Directivo Docente (Rector/Coordinador) — Aptitudes y competencias básicas.
 * Elaboración propia estilo CNSC/ICFES. No reproduce cuadernillos oficiales.
 */
const L = {A: 0, B: 1, C: 2, D: 3};

/** @type {{id:string, pillar:string, module:string, topic:string, caso?:string, stem:string, options:string[], correct:string, expl:string, tags:string[], dif?:number, caseStudy?:boolean}[]} */
const raw = [];

function push(p) {
  raw.push(p);
}

// ——— Lectura crítica (1–20): texto + 2 preguntas ———
const lectura = [
  {
    caso: "En la Institución Educativa El Progreso, los conflictos entre estudiantes durante el descanso habían aumentado un 30% en un semestre. El rector, con el Consejo Académico, implementó un programa de mediación liderado por estudiantes capacitados como 'gestores de convivencia'. Tras tres meses, los reportes disciplinarios disminuyeron, aunque algunos docentes señalaron que el programa exigía tiempo adicional fuera de la jornada. El rector decidió mantenerlo, ajustando los horarios de capacitación para no interferir con las clases.",
    qs: [
      {
        n: 1,
        stem: "¿Cuál es la idea central del texto?",
        options: [
          "Los estudiantes deben resolver solos todos los conflictos escolares",
          "Un programa de mediación estudiantil redujo los conflictos, pero requirió ajustes de tiempo institucional",
          "El aumento de conflictos se debió a la falta de docentes",
          "El Consejo Académico eliminó el programa por falta de resultados",
        ],
        correct: "B",
        expl: "El texto describe la implementación del programa, sus resultados positivos y el ajuste realizado ante una dificultad señalada.",
      },
      {
        n: 2,
        stem: "¿Qué se puede inferir sobre la actitud del rector frente a las críticas de los docentes?",
        options: [
          "Ignoró las críticas y mantuvo el programa sin cambios",
          "Canceló el programa para evitar quejas",
          "Reconoció la dificultad señalada y ajustó la implementación sin abandonar la estrategia",
          "Delegó la decisión únicamente al Consejo Académico",
        ],
        correct: "C",
        expl: "El rector ajustó los horarios tras escuchar la observación docente, sin eliminar el programa.",
      },
    ],
  },
  {
    caso: "El Decreto 1290 de 2009 otorgó a las instituciones educativas colombianas autonomía para definir su Sistema Institucional de Evaluación de Estudiantes (SIEE), dentro de unos criterios mínimos fijados por el MEN. Esto generó diversidad de escalas de valoración entre colegios, lo que ha dificultado, en algunos casos, la homologación de calificaciones cuando un estudiante se traslada de institución. Por eso, muchos rectores consideran prioritario revisar y actualizar el SIEE periódicamente, con participación de toda la comunidad educativa.",
    qs: [
      {
        n: 3,
        stem: "Según el texto, ¿qué otorgó el Decreto 1290 de 2009?",
        options: [
          "Una escala numérica única obligatoria a nivel nacional",
          "Autonomía institucional para definir el SIEE, dentro de unos criterios mínimos",
          "La eliminación de la evaluación por competencias",
          "La centralización de la evaluación en el MEN",
        ],
        correct: "B",
        expl: "El texto lo afirma directamente: autonomía para definir el SIEE dentro de criterios mínimos del MEN.",
        tags: ["decreto1290"],
      },
      {
        n: 4,
        stem: "¿Cuál ha sido una consecuencia de la diversidad de escalas de valoración?",
        options: [
          "Una mejora generalizada en los resultados académicos",
          "Dificultades para homologar calificaciones entre instituciones",
          "La desaparición del SIEE en varios colegios",
          "Una reducción en la autonomía institucional",
        ],
        correct: "B",
        expl: "El texto menciona explícitamente dificultades de homologación entre instituciones.",
        tags: ["decreto1290"],
      },
    ],
  },
  {
    caso: "La implementación de la Jornada Única busca aumentar el tiempo de permanencia de los estudiantes en la institución educativa, con el fin de fortalecer el aprendizaje y reducir su exposición a riesgos del entorno. Sin embargo, su viabilidad depende de condiciones como la disponibilidad de infraestructura, el número de docentes y, de manera crítica, la cobertura del Programa de Alimentación Escolar (PAE), pues una jornada más extensa exige garantizar como mínimo un complemento alimentario adicional para los estudiantes.",
    qs: [
      {
        n: 5,
        stem: "Según el texto, ¿cuál es uno de los propósitos principales de la Jornada Única?",
        options: [
          "Reducir el número de docentes requeridos por institución",
          "Aumentar el tiempo de permanencia escolar para fortalecer el aprendizaje",
          "Eliminar la necesidad del Programa de Alimentación Escolar",
          "Disminuir la infraestructura educativa requerida",
        ],
        correct: "B",
        expl: "El propósito enunciado es aumentar el tiempo de permanencia para fortalecer el aprendizaje.",
      },
      {
        n: 6,
        stem: "¿Qué condición señala el texto como crítica para la viabilidad de la Jornada Única?",
        options: [
          "La reducción del número de estudiantes matriculados",
          "La cobertura adecuada del Programa de Alimentación Escolar",
          "La eliminación de la evaluación docente",
          "La reducción de la jornada de los docentes",
        ],
        correct: "B",
        expl: "El texto marca como crítica la cobertura del PAE ante una jornada más extensa.",
      },
    ],
  },
  {
    caso: "Durante la pandemia, muchas instituciones educativas rurales evidenciaron una marcada brecha digital: mientras algunos estudiantes contaban con conectividad y dispositivos propios, otros dependían de guías impresas entregadas periódicamente. Superada la emergencia, varios rectores optaron por mantener estrategias híbridas, combinando el uso de plataformas digitales cuando había conectividad con materiales físicos como respaldo, en lugar de asumir que toda la comunidad educativa contaba con acceso permanente a internet.",
    qs: [
      {
        n: 7,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La pandemia eliminó por completo la brecha digital en las zonas rurales",
          "La conectividad rural es igual de estable que la urbana",
          "Ante la desigualdad de acceso digital, varios rectores mantuvieron estrategias híbridas combinando medios digitales y físicos",
          "Los materiales impresos dejaron de usarse tras la pandemia",
        ],
        correct: "C",
        expl: "El texto describe la brecha digital y la respuesta institucional de mantener una estrategia híbrida.",
      },
      {
        n: 8,
        stem: "¿Qué se puede inferir sobre la decisión de mantener estrategias híbridas?",
        options: [
          "Buscaba no dejar en desventaja a los estudiantes sin conectividad permanente",
          "Buscaba reducir costos de impresión de guías",
          "Respondía a una exigencia normativa nacional",
          "Se tomó exclusivamente por preferencia de los docentes",
        ],
        correct: "A",
        expl: "La decisión evita asumir acceso permanente a internet para toda la comunidad.",
      },
    ],
  },
  {
    caso: "La Ley 1620 de 2013 creó el Sistema Nacional de Convivencia Escolar y estableció que cada institución educativa debe conformar un Comité Escolar de Convivencia, integrado por el rector, un docente por cada nivel, el personero estudiantil y el presidente del consejo de padres, entre otros. Este comité tiene la función de activar la ruta de atención integral ante situaciones que afecten la convivencia escolar, clasificándolas según su gravedad y orientando la respuesta institucional correspondiente.",
    qs: [
      {
        n: 9,
        stem: "Según el texto, ¿qué estableció la Ley 1620 de 2013?",
        options: [
          "La eliminación del manual de convivencia",
          "La obligación de conformar un Comité Escolar de Convivencia en cada institución",
          "La creación del Sistema Institucional de Evaluación de Estudiantes",
          "La centralización de la disciplina escolar en la Secretaría de Educación",
        ],
        correct: "B",
        expl: "El texto indica explícitamente la obligación de conformar el Comité Escolar de Convivencia.",
        tags: ["ley1620"],
      },
      {
        n: 10,
        stem: "¿Cuál es la función principal del Comité Escolar de Convivencia según el texto?",
        options: [
          "Sancionar directamente a los estudiantes sin debido proceso",
          "Activar la ruta de atención integral según la gravedad de la situación",
          "Reemplazar al Consejo Directivo en todas sus funciones",
          "Evaluar el desempeño académico de los docentes",
        ],
        correct: "B",
        expl: "El comité activa la ruta de atención integral según la gravedad.",
        tags: ["ley1620", "guiaMen49"],
      },
    ],
  },
  {
    caso: "El Decreto 1421 de 2017 reglamentó la atención educativa a la población con discapacidad, estableciendo el Plan Individual de Ajustes Razonables (PIAR) como herramienta para identificar las barreras que enfrenta un estudiante y definir los apoyos necesarios para su participación plena. A diferencia de un currículo paralelo, el PIAR parte del currículo general de la institución y propone ajustes específicos, evitando así procesos de exclusión disfrazados de atención especializada.",
    qs: [
      {
        n: 11,
        stem: "Según el texto, ¿qué propósito tiene el PIAR?",
        options: [
          "Crear un currículo completamente distinto para el estudiante con discapacidad",
          "Identificar barreras y definir ajustes razonables a partir del currículo general",
          "Trasladar automáticamente al estudiante a educación especial",
          "Eliminar la evaluación para estudiantes con discapacidad",
        ],
        correct: "B",
        expl: "El PIAR identifica barreras y define apoyos a partir del currículo general.",
        tags: ["decreto1421"],
      },
      {
        n: 12,
        stem: "¿Qué distingue al PIAR de un 'currículo paralelo', según el texto?",
        options: [
          "El PIAR no tiene relación con el currículo institucional",
          "El PIAR parte del currículo general y propone ajustes, evitando exclusión disfrazada",
          "El PIAR solo aplica a estudiantes sin discapacidad",
          "El PIAR reemplaza completamente la planeación docente regular",
        ],
        correct: "B",
        expl: "El texto contrasta el PIAR con un currículo paralelo: parte del currículo general.",
        tags: ["decreto1421"],
      },
    ],
  },
  {
    caso: "La evaluación anual de desempeño laboral de los docentes, contemplada en el Decreto 1278 de 2002 para quienes ingresaron por concurso bajo ese régimen, tiene un carácter formativo además de administrativo. Su resultado no busca únicamente calificar, sino identificar fortalezas y aspectos por mejorar, que deben traducirse en un plan de desarrollo profesional concertado entre el docente y su evaluador, generalmente el rector o coordinador.",
    qs: [
      {
        n: 13,
        stem: "Según el texto, ¿cuál es uno de los propósitos de la evaluación anual de desempeño?",
        options: [
          "Sancionar automáticamente a los docentes con bajo puntaje",
          "Identificar fortalezas y aspectos por mejorar mediante un plan de desarrollo concertado",
          "Reemplazar el concurso de méritos como forma de ingreso",
          "Evaluar exclusivamente los conocimientos disciplinares del docente",
        ],
        correct: "B",
        expl: "Tiene carácter formativo: identifica fortalezas y aspectos a mejorar con plan concertado.",
        tags: ["decreto1278"],
      },
      {
        n: 14,
        stem: "¿Quién suele actuar como evaluador en este proceso, según el texto?",
        options: [
          "Un docente elegido por sorteo entre sus pares",
          "El rector o coordinador",
          "Exclusivamente la Secretaría de Educación",
          "El Consejo Directivo en pleno",
        ],
        correct: "B",
        expl: "El texto indica que el evaluador suele ser el rector o coordinador.",
        tags: ["decreto1278"],
      },
    ],
  },
  {
    caso: "La alta rotación de docentes en instituciones rurales, frecuentemente asociada a nombramientos provisionales, dificulta la continuidad de los procesos pedagógicos y el fortalecimiento de una cultura institucional estable. Algunos rectores han buscado mitigar este efecto mediante estrategias de inducción rápida y acompañamiento entre pares, de modo que un docente nuevo pueda apropiarse en pocas semanas del Proyecto Educativo Institucional y de las dinámicas propias de la comunidad.",
    qs: [
      {
        n: 15,
        stem: "¿Cuál es el problema principal descrito en el texto?",
        options: [
          "El exceso de docentes de planta en zonas rurales",
          "La alta rotación docente y su efecto sobre la continuidad pedagógica",
          "La falta de interés de los estudiantes por aprender",
          "El exceso de presupuesto destinado a capacitación",
        ],
        correct: "B",
        expl: "La idea central es la alta rotación y su efecto sobre la continuidad pedagógica.",
        tags: ["ley115"],
      },
      {
        n: 16,
        stem: "¿Qué estrategia institucional se menciona para mitigar este problema?",
        options: [
          "Reducir el número de docentes contratados",
          "Inducción rápida y acompañamiento entre pares para nuevos docentes",
          "Eliminar los nombramientos provisionales",
          "Trasladar la responsabilidad exclusivamente a la Secretaría de Educación",
        ],
        correct: "B",
        expl: "Se menciona inducción rápida y acompañamiento entre pares.",
      },
    ],
  },
  {
    caso: "El Consejo de Padres, contemplado en el Decreto 1286 de 2005, es una instancia de participación de las familias en el proceso educativo, distinta de la Asociación de Padres de Familia, que es una persona jurídica de carácter voluntario. Mientras el Consejo de Padres tiene representantes por cada grado y participa en aspectos como la revisión del PEI, la Asociación se enfoca en actividades de apoyo y bienestar, y su conformación no es obligatoria para el funcionamiento de la institución.",
    qs: [
      {
        n: 17,
        stem: "Según el texto, ¿cuál es una diferencia entre el Consejo de Padres y la Asociación de Padres de Familia?",
        options: [
          "Ambos son exactamente la misma instancia con nombres distintos",
          "El Consejo de Padres es obligatorio y participa en aspectos como el PEI; la Asociación es voluntaria",
          "La Asociación de Padres tiene representantes por cada grado",
          "El Consejo de Padres es una persona jurídica voluntaria",
        ],
        correct: "B",
        expl: "El Consejo de Padres participa en el PEI; la Asociación es voluntaria.",
        tags: ["ley115", "decreto1860"],
      },
      {
        n: 18,
        stem: "¿En qué aspecto puede participar el Consejo de Padres, según el texto?",
        options: [
          "En la contratación de docentes",
          "En la revisión del Proyecto Educativo Institucional",
          "En la evaluación del desempeño docente",
          "En la administración del presupuesto de mantenimiento",
        ],
        correct: "B",
        expl: "El texto menciona participación en la revisión del PEI.",
        tags: ["ley115"],
      },
    ],
  },
  {
    caso: "El Plan Escolar de Gestión del Riesgo es un instrumento que permite a cada institución educativa identificar amenazas propias de su entorno —como deslizamientos, inundaciones o riesgos eléctricos— y definir protocolos de respuesta, rutas de evacuación y responsables por cada zona. Su elaboración no es una tarea exclusiva del rector, sino que debe involucrar a docentes, personal administrativo y, en lo posible, a organismos de socorro locales, para que los simulacros reflejen condiciones reales del contexto.",
    qs: [
      {
        n: 19,
        stem: "¿Cuál es el propósito del Plan Escolar de Gestión del Riesgo, según el texto?",
        options: [
          "Sancionar a los estudiantes que incumplan las rutas de evacuación",
          "Identificar amenazas del entorno y definir protocolos de respuesta ante emergencias",
          "Reemplazar el manual de convivencia institucional",
          "Evaluar el desempeño de los docentes en situaciones de riesgo",
        ],
        correct: "B",
        expl: "Sirve para identificar amenazas y definir protocolos de respuesta.",
      },
      {
        n: 20,
        stem: "Según el texto, ¿quiénes deberían participar en la elaboración del plan?",
        options: [
          "Únicamente el rector de la institución",
          "Docentes, personal administrativo y, de ser posible, organismos de socorro locales",
          "Exclusivamente los estudiantes de grado once",
          "Solo la Secretaría de Educación municipal",
        ],
        correct: "B",
        expl: "Debe involucrar docentes, administrativos y, de ser posible, organismos de socorro.",
      },
    ],
  },
];

for (const block of lectura) {
  for (const q of block.qs) {
    push({
      id: `dir-apt-lec-${String(q.n).padStart(2, "0")}`,
      pillar: "lecturaCritica",
      module: "Lectura crítica",
      topic: "Lectura crítica · Directivo",
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

module.exports = {raw, push, L};
