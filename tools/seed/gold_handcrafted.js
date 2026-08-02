/**
 * Casos oro hechos a mano: norma + teoría + distractores.
 * Exporta objetos listos para el seed Firestore.
 */
const {gold} = require("./gold_handcrafted_core");
const {wave2} = require("./gold_wave2_1278_guias");
const {wave3} = require("./gold_wave3_especialidades");
const {wave4} = require("./gold_wave4_cerebro");
const {wave4b} = require("./gold_wave4b_volumen");
const {wave5} = require("./gold_wave5_rector");

/** @type {ReturnType<typeof gold>[]} */
const handcrafted = [
  // —— Decreto 1290 ——
  gold({
    id: "oro-1290-01",
    subtema: "Decreto 1290 / evaluación formativa",
    cargo: "primaria",
    caso: "Una docente usa solo promedios de quizzes para decidir promoción, sin retroalimentación durante el periodo.",
    stem: "Según el Decreto 1290, la práctica más débil es:",
    options: [
      "Usar evidencias diversas y retroalimentar en el proceso",
      "Reducir la evaluación a promedios finales sin carácter formativo",
      "Compartir criterios con estudiantes antes de la producción",
      "Ajustar la enseñanza con base en errores frecuentes",
    ],
    correct: "B",
    norma: "El Decreto 1290 concibe la evaluación como integral, flexible y formativa, al servicio del aprendizaje y la promoción.",
    theory: "Sin retroalimentación en proceso, la evaluación pierde su función pedagógica y se vuelve solo certificadora.",
    wrong: {
      A: "Esta sí es coherente con evaluación formativa.",
      C: "Compartir criterios fortalece la autorregulación.",
      D: "Ajustar con evidencia es el corazón formativo.",
    },
    tags: [{code: "decreto1290", focus: "evaluación formativa"}],
    dif: 2,
  }),
  gold({
    id: "oro-1290-02",
    subtema: "Decreto 1290 / escala de valoración",
    cargo: "primaria",
    caso: "Un colegio impone una escala nacional única y prohíbe describir niveles de desempeño en el boletín.",
    stem: "La lectura más alineada al Decreto 1290 es:",
    options: [
      "La institución tiene autonomía para definir su escala de valoración en el SIEE",
      "Solo el ICFES define la escala interna del colegio",
      "No se puede valorar cualitativamente",
      "La promoción no requiere criterios previos",
    ],
    correct: "A",
    norma: "El Decreto 1290 otorga autonomía escolar para definir el sistema institucional de evaluación (SIEE), incluida la escala.",
    theory: "La claridad de criterios y niveles de desempeño permite comunicar avances de forma comprensible a familias y estudiantes.",
    wrong: {
      B: "El ICFES no sustituye el SIEE institucional.",
      C: "La valoración puede ser cuantitativa y/o cualitativa según el SIEE.",
      D: "La promoción exige criterios explícitos.",
    },
    tags: [{code: "decreto1290", focus: "SIEE y autonomía"}],
    dif: 2,
  }),
  gold({
    id: "oro-1290-03",
    subtema: "Decreto 1290 / promoción",
    cargo: "primaria",
    caso: "Un estudiante con dificultades reiteradas no recibe plan de apoyo; al final se le niega el grado sin acompañamiento previo.",
    stem: "Lo más coherente con la norma es:",
    options: [
      "Negar promoción sin estrategias de apoyo durante el año",
      "Activar estrategias de apoyo y seguimiento antes de decidir la promoción",
      "Promover automáticamente sin criterios",
      "Evaluar solo con una prueba final externa",
    ],
    correct: "B",
    norma: "El Decreto 1290 vincula evaluación, seguimiento y estrategias de apoyo al proceso de promoción.",
    theory: "La decisión de promoción debe sustentarse en acompañamiento pedagógico, no solo en un corte final punitivo.",
    wrong: {
      A: "Omite el deber de apoyo y seguimiento.",
      C: "La promoción automática sin criterios no es el estándar del 1290.",
      D: "Una sola prueba externa no agota la evaluación integral.",
    },
    tags: [{code: "decreto1290", focus: "promoción y apoyo"}],
    dif: 3,
    secs: 110,
  }),
  gold({
    id: "oro-1290-04",
    subtema: "Decreto 1290 / Vygotsky",
    cargo: "matematicas",
    tagsCargo: ["matematicas", "primaria"],
    caso: "En 5°, varios estudiantes fallan problemas de proporciones. El docente diseña estaciones con mediación entre pares y rúbrica compartida.",
    stem: "Esta decisión articula principalmente:",
    options: [
      "Evaluación punitiva y memorización",
      "Evaluación formativa (1290) y andamiaje en la ZDP (Vygotsky)",
      "Homogeneización sin criterios",
      "Eliminación del trabajo colaborativo",
    ],
    correct: "B",
    norma: "El 1290 exige usar la evaluación para mejorar aprendizajes mediante criterios y seguimiento.",
    theory: "Vygotsky: la mediación social en la ZDP permite alcanzar desempeños potenciales con andamiaje.",
    wrong: {
      A: "No hay intención punitiva en la descripción.",
      C: "Hay criterios (rúbrica) y diferenciación por estaciones.",
      D: "El colaborativo es intencional y pedagógico.",
    },
    tags: [
      {code: "decreto1290", focus: "formativa"},
      {code: "vygotsky", focus: "ZDP"},
    ],
    dif: 2,
  }),
  gold({
    id: "oro-1290-05",
    subtema: "Decreto 1290 / Ausubel",
    cargo: "ciencias",
    tagsCargo: ["ciencias"],
    caso: "Antes de enseñar ecosistemas, el docente explora ideas previas con un mapa conceptual colectivo y ajusta la secuencia.",
    stem: "La práctica es sólida porque:",
    options: [
      "Ignora los saberes previos",
      "Activa aprendizajes previos (Ausubel) y usa evidencia para orientar la enseñanza (1290)",
      "Solo memoriza definiciones del libro",
      "Evalúa únicamente al final del año",
    ],
    correct: "B",
    norma: "La evaluación formativa del 1290 se nutre de evidencias tempranas para tomar decisiones didácticas.",
    theory: "Ausubel: el aprendizaje significativo parte de relacionar lo nuevo con la estructura cognitiva previa.",
    wrong: {
      A: "Justamente se exploran previos.",
      C: "No se limita a memorización.",
      D: "Hay evaluación/diagnóstico en el proceso.",
    },
    tags: [
      {code: "decreto1290", focus: "evidencias"},
      {code: "ausubel", focus: "saberes previos"},
    ],
    dif: 1,
    secs: 70,
  }),

  // —— Decreto 1421 ——
  gold({
    id: "oro-1421-01",
    module: "Inclusión y convivencia escolar",
    subtema: "Decreto 1421 / PIAR",
    cargo: "primaria",
    caso: "Un estudiante con discapacidad intelectual leve llega a 2°. No existe PIAR y se le exige el mismo formato de evaluación escrita cronometrada.",
    stem: "La acción prioritaria es:",
    options: [
      "Negar el cupo por falta de formación docente",
      "Elaborar PIAR con ajustes razonables en acceso, participación y evaluación",
      "Eximirlo de todo aprendizaje esencial",
      "Separarlo permanentemente del aula",
    ],
    correct: "B",
    norma: "El Decreto 1421 ordena la atención educativa a través del PIAR y ajustes razonables.",
    theory: "La equidad implica remover barreras de acceso y demostración del aprendizaje, no excluir.",
    wrong: {
      A: "La falta de formación no justifica negar el derecho.",
      C: "Eximir de todo vulnera el derecho a aprender.",
      D: "La separación permanente contradice inclusión.",
    },
    tags: [{code: "decreto1421", focus: "PIAR"}],
    dif: 2,
  }),
  gold({
    id: "oro-1421-02",
    module: "Inclusión y convivencia escolar",
    subtema: "Decreto 1421 / ajustes razonables",
    cargo: "lenguaje",
    tagsCargo: ["lenguaje", "primaria"],
    caso: "Una estudiante con discapacidad auditiva requiere interpretación y más tiempo en evaluaciones orales/escritas.",
    stem: "El ajuste razonable más coherente es:",
    options: [
      "Quitar completamente los objetivos de lenguaje del grado",
      "Proveer apoyos de acceso y tiempo adicional manteniendo aprendizajes esenciales",
      "Evaluarla sin criterios conocidos",
      "Obligarla a lip-reading sin apoyos",
    ],
    correct: "B",
    norma: "Los ajustes razonables del 1421 garantizan participación sin eliminar el derecho a una educación de calidad.",
    theory: "Se adaptan medios y condiciones; la meta esencial se preserva con accesibilidad.",
    wrong: {
      A: "Eliminar objetivos esenciales no es ajuste razonable.",
      C: "Sin criterios no hay evaluación justa.",
      D: "Negar apoyos mantiene la barrera.",
    },
    tags: [{code: "decreto1421", focus: "ajustes razonables"}],
    dif: 2,
  }),
  gold({
    id: "oro-1421-03",
    module: "Inclusión y convivencia escolar",
    subtema: "Decreto 1421 / Decreto 1290",
    cargo: "primaria",
    caso: "El consejo académico debate si un estudiante con discapacidad puede ser evaluado con rúbrica flexible y productos alternativos.",
    stem: "La decisión alineada a ambos decretos es:",
    options: [
      "Prohibir cualquier flexibilidad evaluativa",
      "Permitir formas diversas de evidenciar aprendizajes esenciales con criterios claros",
      "No evaluar al estudiante",
      "Usar solo pruebas estandarizadas externas",
    ],
    correct: "B",
    norma: "1421 exige ajustes; 1290 exige evaluación formativa con criterios institucionales.",
    theory: "Diversificar evidencias es coherente con evaluación auténtica e inclusión.",
    wrong: {
      A: "La inflexibilidad crea barreras.",
      C: "No evaluar vulnera derechos.",
      D: "Lo externo no reemplaza el SIEE inclusivo.",
    },
    tags: [
      {code: "decreto1421", focus: "evaluación inclusiva"},
      {code: "decreto1290", focus: "criterios"},
    ],
    dif: 3,
    secs: 120,
  }),

  // —— Ley 1620 / convivencia ——
  gold({
    id: "oro-1620-01",
    module: "Inclusión y convivencia escolar",
    subtema: "Ley 1620 / rutas de atención",
    cargo: "primaria",
    caso: "Hay un reporte de ciberacoso entre estudiantes de 7°. El docente titular decide 'arreglarlo en privado' sin registro ni ruta.",
    stem: "La omisión principal es:",
    options: [
      "Activar la ruta institucional y registrar el caso conforme a la Ley 1620",
      "Publicar nombres en redes del colegio",
      "Ignorar porque ocurrió fuera del aula física",
      "Sancionar sin escuchar a las partes",
    ],
    correct: "A",
    norma: "La Ley 1620 exige rutas de atención, prevención, registro y seguimiento del Comité de Convivencia.",
    theory: "La gestión restaurativa e institucional protege derechos y evita la revictimización.",
    wrong: {
      B: "La exposición pública vulnera derechos.",
      C: "El ciberacoso también activa rutas escolares.",
      D: "Sin debido proceso no hay justicia escolar.",
    },
    tags: [
      {code: "ley1620", focus: "rutas"},
      {code: "guiaMen51", focus: "convivencia"},
    ],
    dif: 2,
  }),
  gold({
    id: "oro-1620-02",
    module: "Inclusión y convivencia escolar",
    subtema: "Ley 1620 / debido proceso",
    cargo: "directivos",
    tagsCargo: ["directivos"],
    caso: "Coordinación suspende a un estudiante el mismo día del reporte, sin versión de las partes ni activación del comité.",
    stem: "El problema central es:",
    options: [
      "Actuó con debida diligencia plena",
      "Omitió debido proceso y la ruta del Manual/Comité de Convivencia",
      "Debió publicar el caso primero",
      "No necesita registrar nada",
    ],
    correct: "B",
    norma: "La Ley 1620 y el manual exigen procedimiento, escucha y proporcionalidad.",
    theory: "El debido proceso escolar forma ciudadanía y legitima las decisiones institucionales.",
    wrong: {
      A: "No hubo diligencia procedimental.",
      C: "Publicar agrava la vulneración.",
      D: "El registro es necesario.",
    },
    tags: [{code: "ley1620", focus: "debido proceso"}],
    dif: 3,
    secs: 110,
  }),

  // —— PEI / 1860 / 115 ——
  gold({
    id: "oro-pei-01",
    module: "Gestión institucional y PEI",
    subtema: "Ley 115 / Decreto 1860",
    cargo: "directivos",
    tagsCargo: ["directivos"],
    caso: "Se modifica el componente pedagógico del PEI sin consultar docentes ni gobierno escolar, 'para ganar tiempo'.",
    stem: "La implicación normativa es:",
    options: [
      "Es válido por eficiencia administrativa",
      "Se debilita la legitimidad participativa del PEI y del gobierno escolar",
      "El PEI no requiere comunidad educativa",
      "Solo la secretaría puede escribir el PEI",
    ],
    correct: "B",
    norma: "Ley 115 y Decreto 1860 definen el PEI como construcción de la comunidad educativa.",
    theory: "Sin apropiación colectiva, el PEI no orienta prácticas reales.",
    wrong: {
      A: "La eficiencia no sustituye participación.",
      C: "Sí requiere comunidad.",
      D: "No es documento exclusivo de la secretaría.",
    },
    tags: [
      {code: "ley115", focus: "PEI"},
      {code: "decreto1860", focus: "gobierno escolar"},
    ],
    dif: 2,
  }),
  gold({
    id: "oro-pei-02",
    module: "Gestión institucional y PEI",
    subtema: "Decreto 1860 / gobierno escolar",
    cargo: "directivos",
    tagsCargo: ["directivos"],
    caso: "El consejo de estudiantes pide participar en la revisión del manual de convivencia y se les niega el espacio.",
    stem: "Según el marco de gobierno escolar, lo correcto es:",
    options: [
      "Excluir siempre a estudiantes de esos temas",
      "Garantizar participación estudiantil en instancias del gobierno escolar",
      "Solo escuchar a proveedores externos",
      "Decidir únicamente por redes sociales",
    ],
    correct: "B",
    norma: "El Decreto 1860 organiza el gobierno escolar con participación de estamentos, incluidos estudiantes.",
    theory: "La participación forma ciudadanía y mejora la legitimidad de normas de convivencia.",
    wrong: {
      A: "La exclusión contradice el gobierno escolar.",
      C: "Lo externo no reemplaza la comunidad.",
      D: "Las redes no son la instancia formal.",
    },
    tags: [{code: "decreto1860", focus: "participación"}],
    dif: 2,
  }),

  // —— Decreto 1278 ——
  gold({
    id: "oro-1278-01",
    module: "Gestión institucional y PEI",
    subtema: "Decreto 1278 / profesionalización docente",
    cargo: "directivos",
    tagsCargo: ["directivos"],
    caso: "Un docente nuevo pregunta por evaluación de desempeño y oportunidades de mejoramiento en el marco del estatuto.",
    stem: "Una respuesta institucional coherente con el Decreto 1278 enfatiza:",
    options: [
      "Que no existe evaluación de desempeño docente",
      "Que hay deberes, derechos y evaluación de desempeño orientada al mejoramiento profesional",
      "Que el escalafón es irrelevante",
      "Que solo importa la antigüedad sin criterios",
    ],
    correct: "B",
    norma: "El Decreto 1278 regula el estatuto de profesionalización docente: deberes, derechos, evaluación y escalafón.",
    theory: "La evaluación de desempeño, bien usada, debe alimentar desarrollo profesional, no solo sanción.",
    wrong: {
      A: "Sí existe marco de evaluación de desempeño.",
      C: "El escalafón es parte del estatuto.",
      D: "Hay criterios profesionales, no solo antigüedad.",
    },
    tags: [{code: "decreto1278", focus: "desempeño y escalafón"}],
    dif: 2,
  }),

  // —— Teorías ——
  gold({
    id: "oro-vyg-01",
    subtema: "Vygotsky / andamiaje",
    cargo: "primaria",
    caso: "Un niño no escribe un párrafo solo, pero con preguntas guía del docente organiza ideas y luego escribe con mayor autonomía.",
    stem: "El fenómeno se explica mejor como:",
    options: [
      "Castigo efectivo",
      "Andamiaje dentro de la Zona de Desarrollo Próximo",
      "Aprendizaje por mera repetición sin mediación",
      "Ausencia total de interacción social",
    ],
    correct: "B",
    norma: "Las prácticas de mediación docente son coherentes con una enseñanza que acompaña trayectorias diversas (enfoque inclusivo/formativo).",
    theory: "Vygotsky: el andamiaje permite pasar de lo potencial a lo real mediante mediación.",
    wrong: {
      A: "No hay castigo en el caso.",
      C: "Hay mediación explícita.",
      D: "La interacción es central.",
    },
    tags: [{code: "vygotsky", focus: "andamiaje"}],
    dif: 1,
    secs: 60,
  }),
  gold({
    id: "oro-pia-01",
    subtema: "Piaget / educación inicial",
    cargo: "preescolar",
    tagsCargo: ["preescolar"],
    module: "Pedagogía y evaluación formativa",
    caso: "Familias piden 'planas de números' diarias en jardín. El equipo sostiene juego, exploración y representación concreta.",
    stem: "La postura del equipo se sustenta especialmente en:",
    options: [
      "Adelantar algoritmos abstractos a toda costa",
      "Respeto al desarrollo cognitivo y al aprendizaje por acción/juego (Piaget + educación inicial)",
      "Evaluación solo con exámenes escritos",
      "Rankings públicos de niños",
    ],
    correct: "B",
    norma: "Las orientaciones de educación inicial del MEN privilegian juego y desarrollo integral.",
    theory: "Piaget: el pensamiento se construye por estadios mediante acción sobre el medio.",
    wrong: {
      A: "Lo abstracto prematuro suele ser mecánico.",
      C: "No es el foco de inicial.",
      D: "Los rankings vulneran el enfoque.",
    },
    tags: [
      {code: "piaget", focus: "estadios"},
      {code: "guiaMen50", focus: "educación inicial"},
    ],
    dif: 2,
  }),
  gold({
    id: "oro-bru-01",
    subtema: "Bruner / representaciones",
    cargo: "matematicas",
    tagsCargo: ["matematicas", "primaria"],
    caso: "Para enseñar valor posicional: primero bloques, luego dibujos, después símbolos numéricos.",
    stem: "La secuencia corresponde a:",
    options: [
      "Solo evaluación sumativa",
      "Modos enactivo → icónico → simbólico (Bruner)",
      "Eliminación de material concreto",
      "Castigo del error simbólico",
    ],
    correct: "B",
    norma: "Los lineamientos y didácticas de matemáticas recomiendan progresión de representaciones.",
    theory: "Bruner describe la representación enactiva, icónica y simbólica como mediaciones del aprendizaje.",
    wrong: {
      A: "No describe evaluación.",
      C: "Justamente usa concreto.",
      D: "No hay castigo.",
    },
    tags: [{code: "bruner", focus: "representaciones"}],
    dif: 1,
    secs: 55,
  }),
  gold({
    id: "oro-aus-01",
    subtema: "Ausubel / organizadores previos",
    cargo: "sociales",
    tagsCargo: ["sociales"],
    caso: "Antes de un tema histórico complejo, el docente presenta un esquema comparativo que conecta con lo ya estudiado.",
    stem: "Ese recurso funciona como:",
    options: [
      "Castigo anticipado",
      "Organizador previo para aprendizaje significativo (Ausubel)",
      "Evaluación punitiva",
      "Sustituto del currículo",
    ],
    correct: "B",
    norma: "Planear con sentido y progresión se alinea a referentes de calidad y a una enseñanza intencional.",
    theory: "Ausubel: los organizadores previos facilitan anclar lo nuevo en la estructura cognitiva.",
    wrong: {
      A: "No es castigo.",
      C: "No es evaluación punitiva.",
      D: "No reemplaza el currículo; lo media.",
    },
    tags: [{code: "ausubel", focus: "organizadores previos"}],
    dif: 2,
  }),

  // —— EBC / DBA ——
  gold({
    id: "oro-ebc-01",
    module: "Currículo y referentes MEN",
    subtema: "EBC",
    cargo: "lenguaje",
    tagsCargo: ["lenguaje"],
    caso: "El área discute si planear por listados de temas del libro o por competencias de lenguaje por ciclos.",
    stem: "Los EBC orientan a:",
    options: [
      "Solo copiar el índice editorial",
      "Definir lo que el estudiante debe saber y saber hacer por grupos de grados",
      "Ignorar la progresión por ciclos",
      "Eliminar la lectura crítica",
    ],
    correct: "B",
    norma: "Los Estándares Básicos de Competencias del MEN son referentes de calidad por grupos de grados.",
    theory: "Planear por competencias evita el enciclopedismo y prioriza desempeños.",
    wrong: {
      A: "El libro es recurso, no el estándar.",
      C: "Los EBC sí organizan progresión.",
      D: "La lectura crítica es central en lenguaje.",
    },
    tags: [{code: "ebc", focus: "saber y saber hacer"}],
    dif: 1,
    secs: 60,
  }),
  gold({
    id: "oro-dba-01",
    module: "Currículo y referentes MEN",
    subtema: "DBA",
    cargo: "matematicas",
    tagsCargo: ["matematicas", "primaria"],
    caso: "En 3° se priorizan DBA de pensamiento numérico y se diseñan evidencias observables de esos aprendizajes.",
    stem: "El uso correcto de los DBA implica:",
    options: [
      "Tomarlos como lista rígida sin contextualizar",
      "Usarlos como referente año a año para enfocar aprendizajes esenciales y evidencias",
      "Reemplazar completamente el PEI",
      "Ignorarlos si hay un libro texto",
    ],
    correct: "B",
    norma: "Los DBA orientan aprendizajes por grado y ayudan a enfocar la enseñanza y la evaluación.",
    theory: "Explicitar evidencias de aprendizaje alinea planeación, mediación y evaluación.",
    wrong: {
      A: "Requieren contextualización didáctica.",
      C: "No sustituyen el PEI.",
      D: "El libro no prevalece sobre el referente.",
    },
    tags: [{code: "dba", focus: "aprendizajes por grado"}],
    dif: 2,
  }),
  gold({
    id: "oro-lin-01",
    module: "Currículo y referentes MEN",
    subtema: "Lineamientos curriculares",
    cargo: "ciencias",
    tagsCargo: ["ciencias"],
    caso: "El equipo de ciencias debate si el laboratorio es 'actividad extra' o parte del enfoque de indagación del área.",
    stem: "Desde lineamientos de ciencias, lo más coherente es:",
    options: [
      "Reducir ciencias a memorización de definiciones",
      "Integrar indagación, evidencia y explicación como núcleo del área",
      "Eliminar el registro experimental",
      "Evaluar solo limpieza del laboratorio",
    ],
    correct: "B",
    norma: "Los lineamientos curriculares orientan epistemológica y didácticamente cada área.",
    theory: "La alfabetización científica se construye indagando y argumentando con evidencia.",
    wrong: {
      A: "Memorizar no basta.",
      C: "El registro es parte del proceso científico escolar.",
      D: "La limpieza no es el aprendizaje central.",
    },
    tags: [{code: "lineamientos", focus: "ciencias"}],
    dif: 2,
  }),
];

// Amplía variantes sistemáticas de alta calidad (norma×teoría) sin plantillas vacías.
const combos = [
  {
    key: "1290-vyg",
    module: "Pedagogía y evaluación formativa",
    subtema: "Decreto 1290 / Vygotsky",
    tags: [
      {code: "decreto1290", focus: "formativa"},
      {code: "vygotsky", focus: "ZDP"},
    ],
    norma: "El Decreto 1290 exige evaluación formativa con criterios y uso pedagógico de evidencias.",
    theory: "Vygotsky plantea que el aprendizaje avanza con mediación social en la ZDP.",
  },
  {
    key: "1290-aus",
    module: "Pedagogía y evaluación formativa",
    subtema: "Decreto 1290 / Ausubel",
    tags: [
      {code: "decreto1290", focus: "evidencias"},
      {code: "ausubel", focus: "significativo"},
    ],
    norma: "El 1290 orienta a identificar características e intereses para consolidar aprendizajes.",
    theory: "Ausubel: lo nuevo debe anclarse en saberes previos de forma no arbitraria.",
  },
  {
    key: "1421-1290",
    module: "Inclusión y convivencia escolar",
    subtema: "Decreto 1421 / Decreto 1290",
    tags: [
      {code: "decreto1421", focus: "PIAR"},
      {code: "decreto1290", focus: "evaluación"},
    ],
    norma: "1421 exige PIAR/ajustes; 1290 exige evaluación con criterios al servicio del aprendizaje.",
    theory: "La inclusión pedagógica diversifica medios de evidencia sin abandonar metas esenciales.",
  },
  {
    key: "1620-rest",
    module: "Inclusión y convivencia escolar",
    subtema: "Ley 1620 / convivencia restaurativa",
    tags: [
      {code: "ley1620", focus: "rutas"},
      {code: "guiaMen51", focus: "atención"},
    ],
    norma: "La Ley 1620 establece prevención, promoción, atención y seguimiento de la convivencia.",
    theory: "Un enfoque restaurativo busca reparar daño y restaurar vínculos, no solo castigar.",
  },
  {
    key: "pei-1860",
    module: "Gestión institucional y PEI",
    subtema: "PEI / Decreto 1860",
    tags: [
      {code: "ley115", focus: "PEI"},
      {code: "decreto1860", focus: "participación"},
    ],
    norma: "El PEI y el gobierno escolar se construyen con participación de la comunidad educativa.",
    theory: "La apropiación institucional requiere sentido compartido y rutinas de implementación.",
  },
  {
    key: "ebc-dba",
    module: "Currículo y referentes MEN",
    subtema: "EBC / DBA",
    tags: [
      {code: "ebc", focus: "competencias"},
      {code: "dba", focus: "grado"},
    ],
    norma: "EBC y DBA son referentes MEN para orientar currículo, enseñanza y evaluación.",
    theory: "Alinear planeación a desempeños evita el activismo sin meta de aprendizaje.",
  },
  {
    key: "piaget-ini",
    module: "Pedagogía y evaluación formativa",
    subtema: "Piaget / educación inicial",
    tags: [
      {code: "piaget", focus: "desarrollo"},
      {code: "guiaMen50", focus: "inicial"},
    ],
    norma: "La educación inicial se rige por orientaciones de juego, cuidado y desarrollo integral.",
    theory: "Piaget enfatiza construcción del conocimiento según nivel de desarrollo.",
  },
  {
    key: "bruner-mat",
    module: "Currículo y referentes MEN",
    subtema: "Bruner / didáctica",
    tags: [{code: "bruner", focus: "representaciones"}],
    norma: "Los referentes de área recomiendan progresiones didácticas con múltiples representaciones.",
    theory: "Bruner: enactivo, icónico y simbólico como trayectoria de comprensión.",
  },
];

const scenarios = [
  {
    caso: "El equipo observa bajo desempeño y responde solo con más tareas mecánicas para la casa.",
    stem: "La mejora más alineada a norma y teoría sería:",
    good: "Diagnosticar con evidencia, mediar aprendizajes y ajustar la enseñanza con criterios claros",
    bad: [
      "Aumentar tareas mecánicas y sanciones leves, sin cambiar la mediación ni diagnosticar errores",
      "Avanzar el temario con el mismo método y revisar solo promedios finales",
      "Homogeneizar ritmos 'para no retrasar al grupo', omitiendo trayectorias y criterios formativos",
    ],
  },
  {
    caso: "Un estudiante avanza con apoyo de un par y se estanca cuando trabaja siempre aislado.",
    stem: "La decisión didáctica más potente es:",
    good: "Diseñar andamiaje colaborativo intencional y evaluar el progreso con criterios formativos",
    bad: [
      "Permitir parejas solo al final 'si alcanza el tiempo', sin diseño de roles ni criterios",
      "Sustituir la mediación por más explicación magistral y ejercicios idénticos",
      "Evaluar solo el producto individual final, ignorando el proceso de construcción",
    ],
  },
  {
    caso: "Hay tensión entre cumplir temario y atender ritmos diversos del grupo.",
    stem: "La postura más coherente con el concurso docente es:",
    good: "Priorizar aprendizajes esenciales con mediación diferenciada y evaluación formativa",
    bad: [
      "Cumplir cobertura completa aunque las evidencias muestren no aprendizaje esencial",
      "Abandonar criterios del SIEE 'para ser flexibles' sin alternativa evaluativa",
      "Usar recuperación punitiva como único mecanismo de 'nivelación'",
    ],
  },
  {
    caso: "La institución documenta poco las decisiones pedagógicas y de convivencia.",
    stem: "Para fortalecer legalidad y mejora, conviene:",
    good: "Registrar rutas, evidencias y acuerdos en claves institucionales (SIEE, convivencia, PIAR cuando aplique)",
    bad: [
      "Resolver de viva voz y archivar solo si hay queja externa",
      "Publicar resúmenes del caso en redes 'para transparencia'",
      "Delegar registro y decisión exclusivamente a las familias",
    ],
  },
  {
    caso: "Se planea el periodo solo con el índice del libro texto.",
    stem: "Una planeación de mayor calidad partiría de:",
    good: "Referentes MEN (EBC/DBA/lineamientos) + diagnóstico de aula + criterios de evaluación",
    bad: [
      "Seleccionar actividades atractivas del libro sin meta de aprendizaje explícita",
      "Copiar la malla de otra IE sin diagnóstico ni PEI local",
      "Planear solo evaluaciones sumativas y luego 'ver qué se alcanza'",
    ],
  },
  {
    caso: "Un estudiante con apoyo de PIAR es evaluado igual que el grupo, sin ajustes acordados.",
    stem: "La corrección normativa y pedagógica es:",
    good: "Aplicar los ajustes del PIAR y evaluar aprendizajes esenciales con criterios accesibles",
    bad: [
      "Mantener la misma evidencia cronometrada 'por equidad', sin ajustes de acceso",
      "Eximir de toda evidencia de aprendizaje esencial 'para no complicarse'",
      "Bajar la meta esencial de forma informal, sin actualizar el PIAR",
    ],
  },
  {
    caso: "La retroalimentación solo dice 'mal' o 'bien' sin criterios ni siguiente paso.",
    stem: "Para que sea formativa de verdad, debe:",
    good: "Describir el logro frente a criterios y ofrecer una acción concreta de mejora",
    bad: [
      "Subir la nota por esfuerzo sin evidenciar el aprendizaje",
      "Sustituir la devolución por una sanción disciplinaria",
      "Dejar toda la devolución detallada solo para el boletín final",
    ],
  },
];

let n = 0;
for (const combo of combos) {
  for (const sc of scenarios) {
    n += 1;
    handcrafted.push(
        gold({
          id: `oro-x-${combo.key}-${n}`,
          module: combo.module,
          subtema: combo.subtema,
          cargo: n % 5 === 0 ? "directivos" : n % 3 === 0 ? "matematicas" : "primaria",
          tagsCargo:
            n % 5 === 0 ? ["directivos"] : n % 3 === 0 ? ["matematicas", "primaria"] : ["primaria"],
          caso: sc.caso,
          stem: sc.stem,
          options: [sc.bad[0], sc.good, sc.bad[1], sc.bad[2]],
          correct: "B",
          norma: combo.norma,
          theory: combo.theory,
          wrong: {
            A: "No articula mediación ni uso formativo de evidencias.",
            C: "Debilita criterios o trazabilidad institucional.",
            D: "Prioriza una respuesta no pedagógica o no normativa.",
          },
          tags: combo.tags,
          dif: n % 4 === 0 ? 3 : 2,
          secs: n % 4 === 0 ? 120 : 95,
        }),
    );
  }
}

// Segunda ola: microcasos por norma específica (calidad alta, enunciados distintos).
const micro = [
  ["1290", "Una rúbrica se entrega después de calificar, no antes.", "Entregar y socializar criterios antes de la producción", "El 1290 exige claridad de criterios al servicio del aprendizaje.", "La autorregulación mejora cuando el estudiante conoce la meta y los criterios (enfoque formativo)."],
  ["1290", "Solo se usa una prueba escrita final por periodo.", "Triangular evidencias (procesos, productos, autoevaluación) con función formativa", "La evaluación debe ser integral y flexible.", "Múltiples evidencias reducen el error de medir con un solo instrumento."],
  ["1421", "Un docente dice que 'no sabe de inclusión' y no ajusta nada.", "Buscar apoyo institucional y avanzar PIAR/ajustes con el equipo", "El 1421 obliga a la atención educativa con PIAR y ajustes razonables.", "La inclusión es responsabilidad institucional compartida, no optativa."],
  ["1421", "Se propone bajar la expectativa esencial 'para no complicarse'.", "Mantener aprendizajes esenciales con ajustes de acceso y demostración", "Ajuste razonable ≠ eliminación de la meta esencial.", "Equidad es accesibilidad con rigor pedagógico."],
  ["1620", "Un conflicto se 'resuelve' en el grupo de WhatsApp de padres.", "Conducirlo por la ruta institucional y proteger intimidad", "La 1620 exige rutas formales y debido proceso.", "Los canales informales pueden revictimizar y polarizar."],
  ["1620", "No existe comité activo de convivencia.", "Conformarlo/activarlo y operar rutas del manual", "La ley prevé instancias y rutas institucionales.", "Sin instancia, no hay respuesta sostenible."],
  ["1860", "El gobierno escolar no se reúne en el año.", "Reactivar instancias y calendarios de participación", "El 1860 organiza el gobierno escolar.", "La participación real requiere rutinas, no solo organigrama."],
  ["115", "El PEI está desactualizado y nadie lo usa en planeación.", "Actualizarlo con comunidad y usarlo como norte de la gestión", "La 115 define el PEI como proyecto orientador.", "Un PEI vivo conecta identidad, currículo y evaluación."],
  ["1278", "Se confunde evaluación de estudiantes con evaluación docente.", "Distinguir SIEE estudiantil (1290) de evaluación de desempeño docente (1278)", "Son marcos distintos con propósitos distintos.", "La claridad institucional evita decisiones injustas."],
  ["VYG", "El docente explica 40 minutos sin participación.", "Diseñar tareas con mediación y participación guiada", "La enseñanza mediada es coherente con trayectorias diversas.", "Vygotsky: aprendizaje social y andamiaje."],
  ["AUS", "Se introduce un concepto sin explorar ideas previas.", "Diagnosticar previos y conectar el nuevo contenido", "La planeación sensible a evidencia es formativa.", "Ausubel: anclaje en estructura cognitiva previa."],
  ["PIA", "En preescolar se imita el ritmo de primaria.", "Respetar juego, exploración y evaluación por observación", "Educación inicial tiene orientaciones propias MEN.", "Piaget: no forzar operaciones formales prematuras."],
  ["BRU", "Se salta del concreto al símbolo sin representaciones intermedias.", "Incluir etapa icónica/pictórica de transición", "Didácticas de área recomiendan progresión representacional.", "Bruner: enactivo-icónico-simbólico."],
  ["EBC", "El plan de área no menciona competencias.", "Releer EBC y reorientar metas a saber/saber hacer", "EBC son referente nacional de competencias.", "Competencias integran conocimiento, habilidades y actitudes."],
  ["DBA", "Se enseñan temas de grados superiores 'para adelantar'.", "Focalizar DBA del grado y asegurar aprendizajes esenciales", "DBA orientan por grado.", "La progresión curricular evita saltos sin bases."],
];

const microStems = [
  "Ante este caso, ¿qué decisión articula mejor norma vigente y mediación pedagógica?",
  "Cuál respuesta evita tanto la omisión normativa como una medida “casi correcta” insuficiente?",
];

let m = 0;
for (const row of micro) {
  // Máximo 2 variantes por caso base (se retiró el spam k=1..12).
  for (let k = 1; k <= 2; k++) {
    m += 1;
    const [code, caso, good, norma, theory] = row;
    handcrafted.push(
        gold({
          id: `oro-m-${code.toLowerCase()}-${m}`,
          module:
            code === "1620" || code === "1421"
              ? "Inclusión y convivencia escolar"
              : code === "1860" || code === "115" || code === "1278"
                ? "Gestión institucional y PEI"
                : code === "EBC" || code === "DBA" || code === "BRU"
                  ? "Currículo y referentes MEN"
                  : "Pedagogía y evaluación formativa",
          subtema: `${code} · caso ${k}`,
          cargo: k % 2 === 0 ? "directivos" : "primaria",
          caso: k === 1 ? caso : `${caso} El equipo debate si basta con “hacer algo rápido”.`,
          stem: microStems[k - 1],
          options: [
            "Aplicar una medida parcial (charla o nota) sin criterios, seguimiento ni mediación real",
            good,
            "Priorizar cobertura/imagen institucional aunque las evidencias muestren no aprendizaje o riesgo",
            "Homogeneizar la respuesta “para todos igual”, omitiendo tipificación, ajustes o referentes del caso",
          ],
          correct: "B",
          norma,
          theory,
          wrong: {
            A: "Parece actuar, pero es parcial y no formativa.",
            C: "Privilegia cobertura/imagen sobre derecho a aprender o proteger.",
            D: "La igualdad formal niega la respuesta situada que exige el caso.",
          },
          tags: [{code: code === "VYG" ? "vygotsky" : code === "AUS" ? "ausubel" : code === "PIA" ? "piaget" : code === "BRU" ? "bruner" : code === "EBC" ? "ebc" : code === "DBA" ? "dba" : code === "1290" ? "decreto1290" : code === "1421" ? "decreto1421" : code === "1620" ? "ley1620" : code === "1860" ? "decreto1860" : code === "115" ? "ley115" : code === "1278" ? "decreto1278" : "lineamientos", focus: "aplicación"}],
          dif: 3,
          secs: 115,
        }),
    );
  }
}

// Segunda ola: 1278 + Guías 49/50/51 + lineamientos
for (const q of wave2) {
  handcrafted.push(q);
}

// Tercera ola: especialidades (preescolar, mates, lenguaje, directivos)
for (const q of wave3) {
  handcrafted.push(q);
}

// Cuarta ola: expansión del cerebro (volumen + exigencia)
for (const q of wave4) {
  handcrafted.push(q);
}
for (const q of wave4b) {
  handcrafted.push(q);
}

// Quinta ola: casos específicos de rectoría (Gestión directiva)
for (const q of wave5) {
  handcrafted.push(q);
}

module.exports = {handcrafted, gold};
