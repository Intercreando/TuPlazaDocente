/**
 * Ola 4 — expansión del cerebro pedagógico (volumen alto, distractores “casi correctos”).
 * Meta: que la herramienta no se perciba básica por escasez de casos.
 */
const {gold} = require("./gold_handcrafted_core");

const stems = [
  "A partir del caso, ¿qué decisión sostiene el derecho a aprender, la trazabilidad y la mediación pedagógica?",
  "Dadas las tensiones del escenario (comunidad, equidad formal y marco vigente), ¿cuál intervención es la más defendible?",
  "Si debieras argumentar tu elección ante un jurado del concurso, ¿qué opción cierra el problema de fondo?",
  "¿Qué decisión evita tanto tratar a todos igual por “equidad” como una flexibilidad que elimina la meta esencial?",
  "Evaluando criterios, evidencia e instancias, ¿cuál acción es la más coherente con el caso?",
];

/** @type {{module:string, cargo:string, tagsCargo:string[], tags:object[], norma:string, theory:string, cases:{caso:string, good:string, near:string[]}[]}[]} */
const domains = [
  {
    module: "Pedagogía y evaluación formativa",
    cargo: "primaria",
    tagsCargo: ["primaria"],
    tags: [
      {code: "decreto1290", focus: "evaluación formativa"},
      {code: "vygotsky", focus: "mediación"},
    ],
    norma: "El Decreto 1290 orienta una evaluación integral, flexible y formativa al servicio del aprendizaje y la promoción.",
    theory: "La mediación en la ZDP (Vygotsky) y la retroalimentación con criterios convierten la evidencia en mejora real.",
    cases: [
      {
        caso: "Tras una prueba, el docente publica solo el promedio del curso y no devoluciones individuales.",
        good: "Devolver a cada estudiante su logro frente a criterios y un siguiente paso de mejora",
        near: [
          "Publicar el ranking completo para 'motivar competencia sana'",
          "Repetir la misma prueba sin analizar errores frecuentes",
          "Subir todas las notas por 'clima' sin evidencia nueva",
        ],
      },
      {
        caso: "Un niño comprende con material concreto, pero la recuperación solo admite algoritmo escrito cronometrado.",
        good: "Diseñar recuperación con representaciones y tiempo suficiente, manteniendo la meta esencial",
        near: [
          "Mantener el cronómetro idéntico 'para que sea justo'",
          "Eximirlo de demostrar el aprendizaje esencial",
          "Sustituir matemáticas por copia de procedimientos ajenos",
        ],
      },
      {
        caso: "La autoevaluación se usa como trámite: el estudiante marca caritas sin criterios.",
        good: "Enseñar autoevaluación con rúbrica clara y contraste frente a evidencias del trabajo",
        near: [
          "Eliminar la autoevaluación porque 'no es objetiva'",
          "Dejar que la autoevaluación reemplace toda evidencia docente",
          "Usar autoevaluación solo al final del año",
        ],
      },
      {
        caso: "El consejo de evaluación promueve con un promedio 3.0 aunque no hay evidencias de aprendizajes esenciales.",
        good: "Aplicar criterios del SIEE y evidencias de proceso, no solo el promedio aritmético",
        near: [
          "Promover siempre por empatía aunque falte evidencia",
          "Reprobar sin revisar el carácter formativo del SIEE",
          "Cambiar la escala del SIEE en la misma reunión sin proceso",
        ],
      },
      {
        caso: "Un docente entrega la rúbrica el día de la sustentación 'para que no se preparen'.",
        good: "Socializar criterios antes de la producción para orientar el aprendizaje",
        near: [
          "Entregar criterios solo a quienes 'se portan bien'",
          "Usar rúbrica secreta incluso para el equipo docente",
          "Evaluar sin rúbrica y decidir por impresión general",
        ],
      },
      {
        caso: "En coevaluación, los pares solo dicen 'me gustó' sin referirse a criterios.",
        good: "Entrenar coevaluación con protocolo de evidencias y lenguaje de la rúbrica",
        near: [
          "Prohibir coevaluación porque genera conflicto",
          "Dejar comentarios libres sin formación ni criterios",
          "Usar coevaluación para castigar socialmente",
        ],
      },
      {
        caso: "Hay error sistemático en fracciones; el docente avanza al siguiente capítulo del libro.",
        good: "Reenseñar con diagnóstico del error, nuevas representaciones y evidencia de cierre",
        near: [
          "Seguir el libro para 'no retrasarse' aunque no haya comprensión",
          "Poner más tarea idéntica sin mediación distinta",
          "Culpar a las familias como única explicación",
        ],
      },
      {
        caso: "La evidencia del periodo son solo 2 quizzes de opción múltiple.",
        good: "Triangular procesos, productos y autoevaluación con función formativa",
        near: [
          "Añadir un tercer quiz idéntico y dar por cerrado el periodo",
          "Evaluar solo participación y asistencia",
          "Usar una prueba oral improvisada sin criterios",
        ],
      },
      {
        caso: "Un estudiante mejora con andamiaje y el docente lo interpreta como 'copia del compañero'.",
        good: "Diseñar mediación intencional y evaluar el progreso hacia la autonomía con criterios",
        near: [
          "Prohibir toda ayuda entre pares de forma permanente",
          "Ignorar la evidencia de avance con mediación",
          "Bajar la nota por haber trabajado en pareja aunque el SIEE lo permita",
        ],
      },
      {
        caso: "La devolución llega 6 semanas después, cuando el tema ya cerró.",
        good: "Acortar el ciclo feedback–acción con devoluciones oportunas y accionables",
        near: [
          "Concentrar toda la devolución en el boletín final",
          "Dar feedback solo a quienes reprobaron",
          "Sustituir feedback por más contenido nuevo",
        ],
      },
      {
        caso: "Se usa portfolio, pero sin criterios ni momentos de reflexión metacognitiva.",
        good: "Guiar el portfolio con criterios, selección de evidencias y reflexión de mejora",
        near: [
          "Acumular hojas sin propósito ni revisión",
          "Calificar el portfolio solo por cantidad de páginas",
          "Eliminar el portfolio porque 'toma tiempo'",
        ],
      },
      {
        caso: "En 2°, se evalúa lectura solo por velocidad en voz alta.",
        good: "Evaluar comprensión (literal/inferencial) con textos y tareas alineadas a DBA/EBC",
        near: [
          "Seguir midiendo solo velocidad como indicador único",
          "Abandonar la lectura oral por completo",
          "Evaluar comprensión solo con dictado de palabras",
        ],
      },
    ],
  },
  {
    module: "Inclusión y convivencia escolar",
    cargo: "primaria",
    tagsCargo: ["primaria", "directivos"],
    tags: [
      {code: "decreto1421", focus: "PIAR"},
      {code: "decreto1290", focus: "evaluación accesible"},
    ],
    norma: "El Decreto 1421 exige PIAR y ajustes razonables; el 1290 exige evaluación con criterios al servicio del aprendizaje.",
    theory: "Equidad es diversificar medios de acceso y demostración sin abandonar aprendizajes esenciales.",
    cases: [
      {
        caso: "Una estudiante con discapacidad auditiva recibe las mismas guías orales densas sin apoyo visual.",
        good: "Ajustar materiales (visuales, tiempo, formato) según PIAR y evaluar el aprendizaje esencial",
        near: [
          "Eximirla de todas las actividades del área",
          "Mantener el formato oral 'porque así es la clase'",
          "Trasladarla de grado sin plan de ajustes",
        ],
      },
      {
        caso: "El PIAR existe en archivo, pero ningún docente de área lo consulta al evaluar.",
        good: "Operar el PIAR en la evaluación cotidiana con roles claros y seguimiento",
        near: [
          "Dejar el PIAR solo para visitas de supervisión",
          "Inventar ajustes el día del examen sin acuerdo previo",
          "Anular el PIAR porque 'complica la logística'",
        ],
      },
      {
        caso: "Un estudiante con TDAH es sancionado reiteradamente por movimiento, sin ajustes de ambiente.",
        good: "Diseñar apoyos ambientales/organizativos y criterios claros, evitando sanción como única respuesta",
        near: [
          "Aumentar sanciones para 'corregir conducta'",
          "Excluirlo del aula cada vez que se mueve",
          "Ignorar el tema porque 'es problema de la casa'",
        ],
      },
      {
        caso: "La IE acepta el cupo inclusivo pero no asigna tiempo para trabajo colaborativo del PIAR.",
        good: "Organizar tiempos, roles y seguimiento institucional del PIAR como deber del establecimiento",
        near: [
          "Dejar toda la carga en un solo docente 'voluntario'",
          "Negar apoyos hasta 'tener más presupuesto'",
          "Evaluar inclusión solo con una jornada simbólica al año",
        ],
      },
      {
        caso: "Se propone 'nota mínima automática' a estudiantes con discapacidad 'por inclusión'.",
        good: "Evaluar aprendizajes esenciales con ajustes y evidencias accesibles, no notas simbólicas",
        near: [
          "Asignar la nota mínima sin evidencia de aprendizaje",
          "Eximir de toda evaluación del periodo",
          "Usar la misma prueba sin ningún ajuste",
        ],
      },
      {
        caso: "Un ajuste razonable (tiempo extra) se niega en el simulacro interno 'para que se acostumbren al ICFES'.",
        good: "Aplicar los ajustes acordados también en evaluaciones internas alineadas al PIAR",
        near: [
          "Negar ajustes en todo el año escolar",
          "Aplicar ajustes solo si la familia insiste por escrito cada vez",
          "Cambiar la meta esencial en cada prueba sin registro",
        ],
      },
      {
        caso: "Hay barrera arquitectónica y se 'resuelve' dejando al estudiante en portería durante el descanso.",
        good: "Eliminar/gestionar la barrera y garantizar participación en la vida escolar con plan institucional",
        near: [
          "Mantener la exclusión del descanso como medida permanente",
          "Culpar al estudiante por no 'adaptarse'",
          "Documentar la barrera sin ninguna acción de mejora",
        ],
      },
      {
        caso: "Un docente dice que inclusión es 'trabajo de orientación', no del aula.",
        good: "Asumir corresponsabilidad de aula + equipo de apoyo con PIAR y ajustes en la enseñanza",
        near: [
          "Delegar toda decisión pedagógica solo a orientación",
          "Rechazar estudiantes con discapacidad en el grupo",
          "Hacer inclusión solo en actos cívicos",
        ],
      },
      {
        caso: "La familia pide bajar expectativas esenciales; el docente acepta sin equipo ni PIAR.",
        good: "Acordar en equipo PIAR: mantener esenciales y ajustar acceso/demostración con la familia",
        near: [
          "Bajar la meta esencial de forma informal",
          "Ignorar a la familia por completo",
          "Eximir de evidencias sin criterios",
        ],
      },
      {
        caso: "En educación física se excluye a un estudiante con movilidad reducida 'por seguridad' sin alternativas.",
        good: "Rediseñar participación con ajustes y metas esenciales de la clase, no exclusión",
        near: [
          "Dejarlo sentado mirando toda la hora",
          "Eximirlo del área todo el año",
          "Evaluarlo solo por asistencia",
        ],
      },
    ],
  },
  {
    module: "Inclusión y convivencia escolar",
    cargo: "directivos",
    tagsCargo: ["directivos", "primaria"],
    tags: [
      {code: "ley1620", focus: "ruta integral"},
      {code: "guiaMen49", focus: "manual y tipificación"},
      {code: "guiaMen51", focus: "atención"},
    ],
    norma: "Ley 1620 y Guías MEN 49/51 orientan promoción, prevención, atención y seguimiento con tipificación y confidencialidad.",
    theory: "La convivencia se educa con rutas claras, proporcionalidad y enfoque restaurativo, no solo con sanción.",
    cases: [
      {
        caso: "Un meme humillante circula en el grupo del grado; la IE espera a que 'se olvide'.",
        good: "Tipificar, proteger, activar ruta y hacer seguimiento del clima digital/escolar",
        near: [
          "Pedir que lo borren y archivar sin registro",
          "Publicar el meme en la reunión de padres como ejemplo",
          "Sancionar a toda el aula sin indagación",
        ],
      },
      {
        caso: "El manual no distingue situaciones Tipo I, II y III.",
        good: "Actualizar el manual con tipologías, rutas y participación del comité",
        near: [
          "Seguir con un listado genérico de 'faltas leves/graves' sin ruta",
          "Copiar tipologías de otra IE sin lectura de contexto",
          "Eliminar tipologías 'para simplificar'",
        ],
      },
      {
        caso: "Una situación Tipo III se maneja solo con trabajo pedagógico interno.",
        good: "Activar remisión a autoridades competentes y acciones de protección, además del manejo escolar",
        near: [
          "Ocultar el caso para proteger la imagen institucional",
          "Expulsar sin registro ni ruta",
          "Dejar que las familias lo resuelvan solas en redes",
        ],
      },
      {
        caso: "Tras mediación, no hay seguimiento y el hostigamiento reaparece.",
        good: "Programar seguimiento de acuerdos, clima y posible reincidencia",
        near: [
          "Archivar el caso como cerrado el mismo día",
          "Cambiar de puesto a la víctima como única medida",
          "Amenazar con expulsión sin proceso restaurativo",
        ],
      },
      {
        caso: "Docentes comentan el caso con nombres en la sala de profesores.",
        good: "Restringir información a quienes deben actuar en la ruta y proteger identidad",
        near: [
          "Compartir detalles 'para que todos vigilen'",
          "Publicar circular con nombres",
          "Interrogar al curso completo en asamblea",
        ],
      },
      {
        caso: "Solo hay sanciones; el calendario no tiene acciones de promoción de convivencia.",
        good: "Diseñar promoción (ciudadanía, diálogo, cuidado) con el comité a lo largo del año",
        near: [
          "Añadir más suspensiones como política única",
          "Hacer una charla anual y dar por cumplida la promoción",
          "Delegar promoción solo a policía o externos",
        ],
      },
      {
        caso: "Un conflicto Tipo I se trata como delito y genera pánico institucional.",
        good: "Tipificar con proporcionalidad y aplicar respuesta formativa acorde al Tipo I",
        near: [
          "Remitir siempre a fiscalía cualquier conflicto",
          "Ignorar el Tipo I porque 'no es grave'",
          "Castigar en público para escarmentar",
        ],
      },
      {
        caso: "Familias desconocen cómo reportar una situación de riesgo.",
        good: "Socializar canales, roles y ruta de forma comprensible a la comunidad",
        near: [
          "Asumir que 'ya saben' porque está en el manual PDF",
          "Recibir reportes solo por WhatsApp del rector sin protocolo",
          "Desincentivar reportes 'para no inflar estadísticas'",
        ],
      },
      {
        caso: "El comité de convivencia no se reunió en el semestre.",
        good: "Reactivarlo con calendario, actas y liderazgo de promoción/prevención",
        near: [
          "Sustituirlo por decisiones unilaterales de rectoría",
          "Reunirlo solo cuando haya escándalo mediático",
          "Disolverlo informalmente",
        ],
      },
      {
        caso: "Se ridiculiza la orientación sexual de un estudiante y un adulto minimiza.",
        good: "Activar protección, educación en derechos y ruta ante discriminación",
        near: [
          "Pedir a la víctima que 'no provoque'",
          "Ignorar porque 'no es académico'",
          "Obligar a explicar su vida privada ante el curso",
        ],
      },
      {
        caso: "Hay reincidencia y la IE no analiza patrones por grado o espacio.",
        good: "Hacer lectura de contexto con datos y priorizar prevención focalizada",
        near: [
          "Seguir solo reaccionando caso a caso",
          "Sancionar de forma masiva sin diagnóstico",
          "Ocultar indicadores de convivencia",
        ],
      },
      {
        caso: "Un docente agrede verbalmente a un estudiante y el caso se 'suaviza' internamente.",
        good: "Activar protocolo frente a vulneración por adulto según competencia y protección al estudiante",
        near: [
          "Pedir disculpas privadas sin ruta ni registro",
          "Trasladar al estudiante de grupo como 'solución'",
          "Negar el hecho para evitar procesos",
        ],
      },
    ],
  },
  {
    module: "Gestión institucional y PEI",
    cargo: "directivos",
    tagsCargo: ["directivos"],
    tags: [
      {code: "ley115", focus: "PEI"},
      {code: "decreto1860", focus: "gobierno escolar"},
      {code: "decreto1278", focus: "profesionalización"},
    ],
    norma: "Ley 115 y Decreto 1860 organizan PEI y gobierno escolar; el 1278 articula profesionalización y calidad del servicio.",
    theory: "La gestión directiva mejora aprendizajes cuando acompaña la práctica, no solo la burocracia.",
    cases: [
      {
        caso: "El PEI se actualizó, pero los planes de área no cambian ni lo citan.",
        good: "Alinear planes de área, SIEE y proyectos al horizonte del PEI con el consejo académico",
        near: [
          "Dejar el PEI en el archivo como cumplimiento formal",
          "Reemplazar el PEI por tendencias de redes",
          "Exigir cambios sin participación docente",
        ],
      },
      {
        caso: "La observación de aula se usa solo para 'pillar faltas', sin devolución formativa.",
        good: "Observar con criterios, devolver feedback y acordar mejoramiento profesional",
        near: [
          "Eliminar toda observación de aula",
          "Publicar ranking de docentes observados",
          "Observar sin criterios ni diálogo posterior",
        ],
      },
      {
        caso: "Docentes nuevos no reciben inducción sobre SIEE, PIAR y rutas.",
        good: "Implementar inducción obligatoria con mentoría y documentos vivos",
        near: [
          "Dejar que 'aprendan solos' en el semestre",
          "Entregar un PDF sin acompañamiento",
          "Inducir solo en temas administrativos de nómina",
        ],
      },
      {
        caso: "El consejo directivo no sesiona; hay decisiones de impacto sin acta.",
        good: "Reactivar instancias con calendario, participación y actas trazables",
        near: [
          "Decidir solo por WhatsApp del rector",
          "Simular actas sin reunión real",
          "Eliminar el consejo 'por agilidad'",
        ],
      },
      {
        caso: "Resultados internos bajos se responden solo con memorandos.",
        good: "Acompañar práctica, co-planificar metas de aprendizaje y hacer seguimiento",
        near: [
          "Multiplicar memorandos sin observación",
          "Culpar públicamente a un grado en reunión general",
          "Ignorar los datos porque 'el ICFES es otra cosa'",
        ],
      },
      {
        caso: "La evaluación de desempeño no tiene plan de mejoramiento asociado.",
        good: "Conectar evaluación de desempeño con plan de desarrollo profesional y evidencias",
        near: [
          "Usarla solo para ranking interno",
          "Archivarla sin devolución al docente",
          "Sustituirla por votación estudiantil informal",
        ],
      },
      {
        caso: "El SIEE no se socializa a familias ni se aplica igual entre áreas.",
        good: "Socializar y monitorear aplicación coherente del SIEE en toda la IE",
        near: [
          "Permitir escalas secretas por docente",
          "Cambiar criterios cada periodo sin proceso",
          "Ocultar el SIEE 'para evitar reclamos'",
        ],
      },
      {
        caso: "Se priorizan eventos ornamentales sobre tiempo de aula en semanas clave.",
        good: "Proteger tiempo de enseñanza-aprendizaje y alinear eventos al PEI",
        near: [
          "Seguir desplazando clase por ensayos prolongados",
          "Cancelar toda vida institucional comunitaria",
          "Evaluar docentes por decoración de actos",
        ],
      },
      {
        caso: "No hay plan de mejoramiento con metas, responsables ni fechas.",
        good: "Definir PMI con metas medibles, responsables y seguimiento periódico",
        near: [
          "Escribir un PMI genérico sin indicadores",
          "Dejar el PMI solo para la visita de calidad",
          "Culpar al contexto externo como único factor",
        ],
      },
      {
        caso: "Un docente pide formación en didáctica y se responde que 'no hay presupuesto para eso'.",
        good: "Priorizar desarrollo profesional situado (comunidades de aprendizaje, mentoría, microformación)",
        near: [
          "Negar cualquier formación continua",
          "Enviar solo a cursos sin relación con el aula",
          "Castigar el bajo desempeño sin ofrecer apoyo",
        ],
      },
    ],
  },
  {
    module: "Currículo y referentes MEN",
    cargo: "primaria",
    tagsCargo: ["primaria", "matematicas", "lenguaje"],
    tags: [
      {code: "ebc", focus: "competencias"},
      {code: "dba", focus: "progresión"},
      {code: "lineamientos", focus: "área"},
    ],
    norma: "EBC, DBA y lineamientos son referentes complementarios para orientar currículo, enseñanza y evaluación.",
    theory: "La coherencia curricular evita activismo sin meta y permite evaluar procesos, no solo productos.",
    cases: [
      {
        caso: "El plan de área lista temas del libro y no declara competencias ni DBA del grado.",
        good: "Reorientar metas a EBC/DBA del grado y explicitar evidencias de aprendizaje",
        near: [
          "Seguir el índice del libro como único currículo",
          "Copiar DBA de otro grado 'para adelantar'",
          "Eliminar evaluación de procesos",
        ],
      },
      {
        caso: "Un proyecto de agua potable no tiene criterios por área.",
        good: "Definir evidencias y criterios por área articulados al proyecto",
        near: [
          "Hacer el proyecto solo como evento sin evaluación",
          "Calificar solo la cartelería",
          "Fusionar notas sin intencionalidad disciplinar",
        ],
      },
      {
        caso: "En matemáticas se invalida una estrategia correcta distinta a la del tablero.",
        good: "Validar estrategias equivalentes y comparar eficiencia/representaciones",
        near: [
          "Aceptar solo el algoritmo enseñado ese día",
          "Prohibir material concreto en todos los grados",
          "Evaluar solo la respuesta final numérica",
        ],
      },
      {
        caso: "Lenguaje se reduce a ortografía y no hay producción de textos con audiencia.",
        good: "Diseñar secuencias de lectura/escritura/oralidad con propósito y audiencia real",
        near: [
          "Aumentar dictados diarios como única mejora",
          "Eliminar escritura porque 'toma tiempo'",
          "Evaluar solo cantidad de páginas",
        ],
      },
      {
        caso: "Ciencias se enseña con definiciones para memorizar, sin indagación.",
        good: "Promover ciclo pregunta–exploración–evidencia–explicación",
        near: [
          "Copiar glosarios largos al cuaderno",
          "Omitir registro de observaciones",
          "Sustituir ciencias por videos sin mediación",
        ],
      },
      {
        caso: "Sociales evita problemas del entorno y solo memoriza fechas.",
        good: "Analizar problemas locales con evidencia, respeto y pensamiento crítico",
        near: [
          "Evitar todo conflicto social en clase",
          "Tomar postura partidista desde el tablero",
          "Evaluar solo listas de fechas",
        ],
      },
      {
        caso: "Se planea sin diagnóstico de saberes previos.",
        good: "Explorar ideas previas y conectar el nuevo contenido (aprendizaje significativo)",
        near: [
          "Empezar siempre por la definición abstracta",
          "Asumir que 'ya deberían saber'",
          "Diagnosticar solo con una nota sancionatoria",
        ],
      },
      {
        caso: "El tránsito enactivo–icónico–simbólico se salta en un día.",
        good: "Diseñar progresión representacional con conexiones explícitas",
        near: [
          "Exigir símbolo desde el primer minuto",
          "Quedarse en concreto sin avanzar nunca",
          "Memorizar fórmulas sin modelo",
        ],
      },
      {
        caso: "Los DBA se pegan en el plan pero no aparecen en las tareas ni en la evaluación.",
        good: "Alinear tareas y criterios de evaluación a los DBA declarados",
        near: [
          "Dejar los DBA solo como adorno documental",
          "Evaluar contenidos ajenos al grado",
          "Cambiar DBA cada semana sin coherencia",
        ],
      },
      {
        caso: "Se usa un recurso viral sin meta de aprendizaje ni referente de área.",
        good: "Seleccionar recursos solo si sirven a una meta EBC/DBA/lineamiento explícita",
        near: [
          "Priorizar 'engagement' sobre aprendizaje",
          "Prohibir todo recurso digital",
          "Evaluar el like/reacción como evidencia",
        ],
      },
      {
        caso: "En 3° se enseñan contenidos de 6° 'para que el ICFES no los coja desprevenidos'.",
        good: "Asegurar aprendizajes esenciales del grado y progresión sólida",
        near: [
          "Adelantar grados sin bases",
          "Omitir comprensión por cobertura de temas difíciles",
          "Entrenar solo tipologías de prueba sin aprendizaje",
        ],
      },
      {
        caso: "La malla no articula evaluación formativa con los desempeños del área.",
        good: "Diseñar criterios y evidencias coherentes con lo enseñado y los referentes",
        near: [
          "Evaluar lo que no se enseñó",
          "Usar solo promedio de quizzes ajenos al plan",
          "Improvisar criterios el día de la entrega",
        ],
      },
    ],
  },
  {
    module: "Pedagogía y evaluación formativa",
    cargo: "preescolar",
    tagsCargo: ["preescolar"],
    tags: [
      {code: "guiaMen50", focus: "educación inicial"},
      {code: "piaget", focus: "desarrollo"},
      {code: "vygotsky", focus: "mediación"},
    ],
    norma: "La Guía MEN 50 y orientaciones de inicial privilegian juego, cuidado, observación y desarrollo integral.",
    theory: "El aprendizaje temprano se construye en la acción y la interacción; forzar primaria temprana fragiliza el desarrollo.",
    cases: [
      {
        caso: "En transición se imponen planas diarias y se reduce el juego a 10 minutos.",
        good: "Reequilibrar la jornada con juego intencional, lenguaje y exploración como eje",
        near: [
          "Aumentar planas 'para llegar bien a primero'",
          "Eliminar toda intencionalidad pedagógica",
          "Evaluar solo con exámenes escritos",
        ],
      },
      {
        caso: "Un niño de 5 años aún no escribe su nombre y se le niega el recreo.",
        good: "Acompañar literacidad emergente con sentido; no castigar el ritmo madurativo",
        near: [
          "Privar de recreo hasta lograr letra convencional",
          "Etiquetarlo como 'atrasado' ante el grupo",
          "Exigir planas como única mediación",
        ],
      },
      {
        caso: "La documentación son solo caritas semanales sin observaciones.",
        good: "Registrar observaciones del desarrollo con ejemplos y devolución a familias",
        near: [
          "Usar promedios numéricos como en 5°",
          "No registrar para 'no etiquetar'",
          "Entregar un informe genérico anual sin evidencia",
        ],
      },
      {
        caso: "El aula está en filas fijas sin rincones de juego.",
        good: "Organizar ambientes de juego, exploración e interacción con materiales significativos",
        near: [
          "Mantener filas rígidas todo el día",
          "Vaciar materiales 'por orden'",
          "Convertir el aula en sala de dictados",
        ],
      },
      {
        caso: "Familias piden 'más tareas de primero' y la docente cede con paquetes diarios.",
        good: "Dialogar con evidencias del enfoque de desarrollo y acordar apoyos coherentes en casa",
        near: [
          "Ceder a la presión escolarizante sin criterio",
          "Descalificar a las familias",
          "Cortar toda comunicación con el hogar",
        ],
      },
      {
        caso: "Se enseña suma formal en hoja a los 4 años sin conteo ni clasificación en juego.",
        good: "Trabajar nociones matemáticas en juego y rutinas (conteo, serieción, comparación)",
        near: [
          "Insistir en algoritmos formales prematuros",
          "Eliminar toda experiencia numérica",
          "Memorizar tablas de multiplicar",
        ],
      },
      {
        caso: "Un niño bilingüe es corregido para que 'deje su lengua'.",
        good: "Valorar la lengua propia y fortalecer el castellano sin estigma",
        near: [
          "Prohibir la lengua materna en el aula",
          "Ignorar el desarrollo del lenguaje oral",
          "Evaluar solo silencio como 'buen comportamiento'",
        ],
      },
      {
        caso: "La asamblea es un monólogo adulto de 40 minutos.",
        good: "Diseñar asamblea breve con participación infantil real",
        near: [
          "Mantener el monólogo porque 'hay que informar'",
          "Eliminar la asamblea",
          "Usar la asamblea solo para regaños",
        ],
      },
      {
        caso: "Hay hipersensibilidad auditiva y se sanciona la desregulación como indisciplina.",
        good: "Ajustar ambiente/tiempos/señales y documentar apoyos (PIAR si aplica)",
        near: [
          "Insistir en sanción para 'acostumbrarlo'",
          "Excluirlo de todas las asambleas sin plan",
          "Ignorar la hipersensibilidad",
        ],
      },
      {
        caso: "Se prioriza 'adelantar lectoescritura' y se descuida alimentación y descanso.",
        good: "Integrar cuidado y aprendizaje como dimensiones inseparables",
        near: [
          "Sacrificar cuidado por rendimiento anticipado",
          "Eliminar rutinas de cuidado",
          "Evaluar solo velocidad de lectura",
        ],
      },
    ],
  },
  {
    module: "Currículo y referentes MEN",
    cargo: "matematicas",
    tagsCargo: ["matematicas", "primaria"],
    tags: [
      {code: "ebc", focus: "pensamiento matemático"},
      {code: "bruner", focus: "representaciones"},
      {code: "decreto1290", focus: "criterios"},
    ],
    norma: "EBC/lineamientos de matemáticas centran el área en resolución de problemas y procesos; el 1290 exige criterios claros.",
    theory: "Bruner y la didáctica actual recomiendan múltiples representaciones y discusión del razonamiento.",
    cases: [
      {
        caso: "20 ejercicios idénticos de división sin problema ni discusión.",
        good: "Plantear problemas con sentido, varias estrategias y socialización de representaciones",
        near: [
          "Duplicar la cantidad de ejercicios idénticos",
          "Evaluar solo velocidad de cálculo",
          "Eliminar la argumentación matemática",
        ],
      },
      {
        caso: "El error 6×7=36 se marca con X sin analizar la estrategia.",
        good: "Usar el error para indagar el pensamiento y reenseñar con representación",
        near: [
          "Solo bajar la nota",
          "Pasar al siguiente tema sin cierre",
          "Prohibir material concreto",
        ],
      },
      {
        caso: "Se prohíbe explicar el procedimiento; solo importa la respuesta.",
        good: "Valorar y enseñar estrategias, justificación y verificación",
        near: [
          "Seguir penalizando la explicación",
          "Aceptar cualquier procedimiento sin verificación",
          "Evaluar solo limpieza del cuaderno",
        ],
      },
      {
        caso: "Geometría = memorizar nombres de figuras.",
        good: "Explorar propiedades, composición/descomposición y argumentación espacial",
        near: [
          "Aumentar listas de definiciones",
          "Omitir material manipulativo siempre",
          "Evaluar solo dibujo estético",
        ],
      },
      {
        caso: "Estadística aparece solo la última semana del año.",
        good: "Distribuir recolección y lectura de datos a lo largo del año",
        near: [
          "Seguir dejándola como 'relleno final'",
          "Enseñar fórmulas sin datos reales",
          "Omitir interpretación de gráficos",
        ],
      },
      {
        caso: "Problemas con contextos ajenos (nieve/metro) en IE rural tropical.",
        good: "Contextualizar situaciones al entorno manteniendo la estructura matemática del DBA",
        near: [
          "Insistir en el libro sin adaptación",
          "Abandonar los problemas",
          "Enseñar solo cálculos sin situación",
        ],
      },
      {
        caso: "La rúbrica del problema es solo bien/mal.",
        good: "Explicitar criterios de proceso, representación, resultado y comunicación",
        near: [
          "Mantener bien/mal",
          "Entregar la rúbrica después de calificar",
          "Evaluar solo presentación estética",
        ],
      },
      {
        caso: "Un estudiante con PIAR comprende con base 10; la prueba niega el material.",
        good: "Ajustar forma/tiempo de evidencia manteniendo el aprendizaje esencial del PIAR",
        near: [
          "Negar el ajuste 'por equidad'",
          "Eximir de toda evidencia",
          "Bajar la meta esencial sin actualizar el PIAR",
        ],
      },
      {
        caso: "La recuperacion es otra lista de algoritmos sin diagnóstico.",
        good: "Diagnosticar errores conceptuales y reenseñar con nueva mediación",
        near: [
          "Repetir la misma lista más larga",
          "Poner recuperación solo sumativa sin enseñanza",
          "Promover sin evidencia de cierre",
        ],
      },
      {
        caso: "Se invalida el uso de calculadora incluso al explorar patrones.",
        good: "Usar herramientas con intencionalidad según la meta de aprendizaje",
        near: [
          "Prohibir toda herramienta siempre",
          "Permitir calculadora sin meta ni criterios",
          "Evaluar solo tecleo rápido",
        ],
      },
    ],
  },
  {
    module: "Currículo y referentes MEN",
    cargo: "lenguaje",
    tagsCargo: ["lenguaje", "primaria"],
    tags: [
      {code: "lineamientos", focus: "lenguaje"},
      {code: "ebc", focus: "comunicación"},
      {code: "ausubel", focus: "saberes previos"},
    ],
    norma: "Lineamientos y EBC de lenguaje orientan prácticas sociales: lectura, escritura, oralidad y escucha con propósito.",
    theory: "Se aprende a comunicar comunicando; la revisión con criterios desarrolla metacognición.",
    cases: [
      {
        caso: "Periodo = dictados diarios sin textos completos.",
        good: "Organizar secuencias con textos auténticos y producción con audiencia",
        near: [
          "Aumentar dictados",
          "Eliminar escritura",
          "Enseñar solo morfología aislada",
        ],
      },
      {
        caso: "Textos 'finales' a la primera, sin borradores ni rúbrica.",
        good: "Ciclo planificar–textualizar–revisar con criterios conocidos",
        near: [
          "Solo nota final",
          "Prohibir revisión",
          "Evaluar solo extensión",
        ],
      },
      {
        caso: "Después de un argumentativo, solo copian el primer párrafo.",
        good: "Preguntas de interpretación, evaluación de argumentos y respuesta propia",
        near: [
          "Seguir solo con copia",
          "Medir solo velocidad lectora",
          "Evitar textos argumentativos",
        ],
      },
      {
        caso: "Se introduce un género sin propósito ni modelos.",
        good: "Activar previos, propósito comunicativo y modelos antes de producir",
        near: [
          "Empezar por examen de definiciones",
          "Omitir modelos",
          "Enseñar solo ortografía del género",
        ],
      },
      {
        caso: "Se burla el acento regional y el docente 'corrige' ridiculizando.",
        good: "Valorar diversidad lingüística y enseñar registros según contexto, deteniendo discriminación",
        near: [
          "Reforzar la burla como corrección",
          "Prohibir que el estudiante hable",
          "Ignorar el hostigamiento",
        ],
      },
      {
        caso: "Oralidad no se evalúa porque 'es difícil'.",
        good: "Diseñar situaciones orales con rúbricas de claridad, escucha y argumentación",
        near: [
          "Omitir oralidad",
          "Evaluar solo volumen de voz",
          "Sustituir por más ortografía",
        ],
      },
      {
        caso: "Podcast escolar se evalúa solo por 'leer bien el guion'.",
        good: "Valorar propósito, audiencia, organización discursiva y uso ético de fuentes",
        near: [
          "Solo fluidez de lectura del guion",
          "Solo efectos de sonido",
          "Solo minutos de duración",
        ],
      },
      {
        caso: "Texto desafiante: 'léanlo en silencio' y luego examen.",
        good: "Andamiar con vocabulario, lectura compartida y preguntas guía",
        near: [
          "Mantener silencio sin apoyo",
          "Bajar siempre a textos triviales",
          "Castigar a quien no comprende",
        ],
      },
      {
        caso: "Biblioteca de aula cerrada 'para que no se dañen los libros'.",
        good: "Circular libros con acuerdos de cuidado y tiempo de lectura libre",
        near: [
          "Mantenerlos bajo llave",
          "Usar solo fotocopias sueltas",
          "Evaluar lectura solo con opción múltiple literal",
        ],
      },
      {
        caso: "Se copia de internet sin crédito y no se enseña citación ética.",
        good: "Enseñar uso ético de fuentes y parafraseo según grado",
        near: [
          "Ignorar el plagio",
          "Prohibir toda búsqueda de información",
          "Calificar el copy-paste por extensión",
        ],
      },
    ],
  },
  {
    module: "Competencias comportamentales",
    cargo: "primaria",
    tagsCargo: ["primaria", "directivos"],
    tags: [{code: "decreto1278", focus: "ética profesional"}],
    norma: "El ejercicio docente implica deberes éticos, confidencialidad, trabajo en equipo y orientación al aprendizaje.",
    theory: "Las competencias comportamentales del concurso evalúan criterio profesional en dilemas reales de escuela.",
    cases: [
      {
        caso: "Un compañero pide que firmes una asistencia que no cumplió.",
        good: "Negarte con respeto y proponer corregir el registro con la verdad institucional",
        near: [
          "Firmar para 'no quedar mal'",
          "Exponerlo en redes públicas",
          "Ignorar y esperar que 'otro lo denuncie'",
        ],
      },
      {
        caso: "Una familia pide adelantar información confidencial de otro estudiante.",
        good: "Proteger la intimidad y redirigir a canales institucionales pertinentes",
        near: [
          "Compartir 'en confianza'",
          "Publicar datos en el grupo de WhatsApp",
          "Mentir inventando información",
        ],
      },
      {
        caso: "Hay desacuerdo fuerte en el área sobre criterios; la reunión se polariza.",
        good: "Facilitar diálogo con evidencia, SIEE y acuerdos documentados",
        near: [
          "Imponer tu criterio sin escuchar",
          "Abandonar la reunión",
          "Atacar personalmente al colega",
        ],
      },
      {
        caso: "Un colega ridiculiza a un estudiante en sala de profesores.",
        good: "Interrumpir con respeto, proteger dignidad y activar ruta institucional si aplica",
        near: [
          "Reírte para pertenecer al grupo",
          "Grabar y publicar en redes",
          "Guardar silencio permanente",
        ],
      },
      {
        caso: "Te piden 'maquillar' evidencias para una visita de supervisión.",
        good: "Documentar prácticas reales y honestas; rechazar la simulación",
        near: [
          "Fabricar evidencias",
          "Sabotear la visita",
          "Culpar a estudiantes públicamente",
        ],
      },
      {
        caso: "Un estudiante te confía un riesgo grave y pide secreto total.",
        good: "Escuchar, proteger y activar ruta de atención según protocolo, sin exponerlo en redes",
        near: [
          "Prometer secreto absoluto aunque haya riesgo",
          "Contarlo en el recreo a otros docentes con nombres",
          "Minimizarlo sin registro",
        ],
      },
      {
        caso: "Te asignan un grado nuevo sin materiales; sientes rabia.",
        good: "Priorizar el aprendizaje con lo disponible, pedir apoyo institucional con propuestas concretas",
        near: [
          "Suspender clase hasta que 'den todo'",
          "Descargar la rabia en los estudiantes",
          "Abandonar planeación por completo",
        ],
      },
      {
        caso: "Un padre grita en recepción; hay estudiantes cerca.",
        good: "Proteger el espacio, bajar la tensión y reconducir a reunión privada con protocolo",
        near: [
          "Gritar de vuelta",
          "Discutir el caso frente a todos",
          "Publicar el altercado en redes del colegio",
        ],
      },
      {
        caso: "Te ofrecen un 'favor' a cambio de subir una nota.",
        good: "Rechazar, mantener criterios del SIEE y reportar por canal institucional si corresponde",
        near: [
          "Aceptar el favor",
          "Subir la nota 'un poquito'",
          "Amenazar a la familia sin debido proceso",
        ],
      },
      {
        caso: "El equipo quiere ocultar un accidente menor para 'no quedar mal'.",
        good: "Registrar, comunicar a quienes corresponde y activar cuidado/seguimiento",
        near: [
          "Ocultar el hecho",
          "Culpar al estudiante menor sin indagación",
          "Minimizar sin atención",
        ],
      },
    ],
  },
];

/** @type {ReturnType<typeof gold>[]} */
const wave4 = [];

let n = 0;
for (const domain of domains) {
  domain.cases.forEach((c, idx) => {
    n += 1;
    const stem = stems[n % stems.length];
    // Variar cargo en algunos ítems del dominio.
    let cargo = domain.cargo;
    let tagsCargo = domain.tagsCargo;
    if (domain.module.includes("Gestión") && n % 3 === 0) {
      cargo = "directivos";
      tagsCargo = ["directivos"];
    }
    wave4.push(
        gold({
          id: `oro-c4-${n}`,
          module: domain.module,
          subtema: `${domain.tags[0].code} · cerebro ${n}`,
          cargo,
          tagsCargo,
          caso: c.caso,
          stem,
          options: [c.near[0], c.good, c.near[1], c.near[2]],
          correct: "B",
          norma: domain.norma,
          theory: domain.theory,
          wrong: {
            A: "Parece práctica habitual, pero es parcial o inequitativa.",
            C: "Prioriza cobertura, imagen o costumbre sobre aprendizaje/protección.",
            D: "Omite criterios, trazabilidad o la meta esencial del caso.",
          },
          tags: domain.tags,
          dif: n % 5 === 0 || idx % 3 === 2 ? 3 : 2,
          secs: n % 5 === 0 ? 120 : 100,
        }),
    );
  });
}

// Segunda capa: cruces norma×teoría con casos únicos (más densidad de cerebro).
const crosses = [
  {
    key: "1290-aus",
    module: "Pedagogía y evaluación formativa",
    tags: [
      {code: "decreto1290", focus: "formativa"},
      {code: "ausubel", focus: "previos"},
    ],
    norma: "El 1290 exige evaluación al servicio del aprendizaje.",
    theory: "Ausubel: sin anclaje en saberes previos, la enseñanza se vuelve mecánica.",
    cases: [
      ["Se inicia un tema nuevo con definición y examen el mismo día, sin explorar ideas previas.", "Diagnosticar previos y conectar el contenido nuevo antes de evaluar", "Evaluar de inmediato para 'ver quién entiende'", "Omitir el tema porque 'no hay tiempo'", "Castigar a quienes no traen la definición memorizada"],
      ["El error frecuente revela un modelo mental previo incorrecto y se ignora.", "Usar el error como evidencia formativa para reorganizar la enseñanza", "Seguir adelante porque 'ya se explicó'", "Bajar notas sin reenseñar", "Culpar solo a la falta de estudio en casa"],
      ["La recuperación repite la misma explicación sin partir de lo que el estudiante sí sabe.", "Partir de anclajes existentes y diseñar mediación diferenciada", "Repetir más fuerte la misma clase", "Dar la respuesta final para cerrar", "Eximir de recuperación"],
    ],
  },
  {
    key: "1421-vyg",
    module: "Inclusión y convivencia escolar",
    tags: [
      {code: "decreto1421", focus: "ajustes"},
      {code: "vygotsky", focus: "andamiaje"},
    ],
    norma: "1421 exige ajustes razonables y PIAR.",
    theory: "El andamiaje permite participar en la ZDP con apoyos temporales.",
    cases: [
      ["Un ajuste (guion visual) se retira bruscamente sin evaluar autonomía.", "Retirar andamiajes de forma gradual según evidencia de autonomía", "Retirar todo apoyo de un día para otro 'para que se esfuerce'", "Mantener el apoyo eterno sin meta de autonomía", "Excluirlo de la actividad grupal"],
      ["El estudiante participa con apoyo de par; se interpreta como trampa.", "Diseñar roles de mediación intencional y evaluar el progreso individual con criterios", "Prohibir pares de forma permanente", "Bajar la meta esencial", "Evaluar solo trabajo aislado cronometrado"],
      ["Hay barrera de acceso al material y se culpa al estudiante.", "Ajustar el acceso al material y mediar la participación", "Insistir en sanción", "Ignorar la barrera", "Trasladarlo de grupo sin plan"],
    ],
  },
  {
    key: "1620-rest",
    module: "Inclusión y convivencia escolar",
    tags: [
      {code: "ley1620", focus: "restaurativo"},
      {code: "guiaMen49", focus: "proporcionalidad"},
    ],
    norma: "La ruta integral exige proporcionalidad y seguimiento.",
    theory: "Lo restaurativo repara daño y vínculos; no se reduce al castigo.",
    cases: [
      ["Tipo I: solo suspensión, sin diálogo ni reparación.", "Mediar acuerdos restaurativos con seguimiento según el manual", "Suspender siempre como primera opción", "Ignorar el hecho", "Humillar en público"],
      ["La víctima es cambiada de curso; el agresor no tiene proceso.", "Proteger a la víctima y activar ruta también con quien agrede, con debido proceso", "Solo mover a la víctima", "Exponer a ambos en redes", "Archivar sin indagación"],
      ["Hay acuerdo, pero nadie verifica cumplimiento.", "Hacer seguimiento de acuerdos y clima", "Dar por cerrado el día de la mediación", "Amenazar sin mediación", "Delegar seguimiento solo a estudiantes"],
    ],
  },
  {
    key: "ebc-1290",
    module: "Currículo y referentes MEN",
    tags: [
      {code: "ebc", focus: "desempeños"},
      {code: "decreto1290", focus: "criterios"},
    ],
    norma: "EBC orientan desempeños; 1290 exige criterios conocidos.",
    theory: "Evaluar lo que se enseña con criterios visibles fortalece la autorregulación.",
    cases: [
      ["Se enseñan competencias y se evalúa solo memoria de datos aislados.", "Alinear evidencias a los desempeños enseñados (saber/saber hacer)", "Mantener desalineación enseñanza-evaluación", "Eliminar la evaluación de procesos", "Improvisar criterios al calificar"],
      ["Los estudiantes no conocen qué se espera en la producción.", "Socializar rúbrica/criterios antes y usarlos en la devolución", "Ocultar criterios 'para que sea auténtico'", "Evaluar por impresión general", "Calificar solo presentación"],
      ["El plan declara EBC, pero las tareas son activismo sin meta.", "Rediseñar tareas con meta de competencia y evidencia observable", "Seguir con actividades 'bonitas' sin criterio", "Eliminar proyectos", "Evaluar solo asistencia"],
    ],
  },
  {
    key: "1278-etica",
    module: "Gestión institucional y PEI",
    tags: [{code: "decreto1278", focus: "ética y desempeño"}],
    norma: "El 1278 articula deberes, derechos y evaluación orientada al mejoramiento profesional.",
    theory: "La profesionalidad se prueba en dilemas éticos y en el uso formativo de la evaluación.",
    cases: [
      ["Se filtran calificaciones sensibles en un grupo de padres.", "Cesar la filtración, proteger datos y usar canales institucionales", "Seguir publicando 'para transparencia'", "Culpar al estudiante", "Ignorar el hecho"],
      ["La evaluación docente no se socializa con criterios previos.", "Socializar criterios y devolver feedback con plan de mejora", "Evaluar sin criterios", "Usar ranking público", "Omitir devolución"],
      ["Un directivo pide falsear evidencias de clase.", "Negarte y documentar prácticas reales; escalar por canal institucional", "Falsear evidencias", "Renunciar sin reportar", "Confrontar en redes"],
    ],
  },
  {
    key: "lin-bruner",
    module: "Currículo y referentes MEN",
    tags: [
      {code: "lineamientos", focus: "didáctica"},
      {code: "bruner", focus: "E-I-S"},
    ],
    norma: "Los lineamientos de área recomiendan progresiones didácticas con sentido.",
    theory: "Bruner: enactivo → icónico → simbólico con conexiones explícitas.",
    cases: [
      ["Se introduce el símbolo algebraico sin etapas previas.", "Transitar por representaciones concretas e icónicas antes del símbolo", "Exigir símbolo inmediato", "Evitar el símbolo para siempre", "Memorizar reglas sin modelo"],
      ["En ciencias se salta de la definición al examen sin modelo/evidencia.", "Indagar con evidencia y luego formalizar el lenguaje científico", "Memorizar definiciones", "Omitir registro", "Copiar del tablero"],
      ["En lenguaje se exige ensayo sin modelos ni andamiaje de estructura.", "Mostrar modelos, criterios y andamiaje de planificación textual", "Pedir ensayo sin apoyo", "Evaluar solo ortografía", "Prohibir borradores"],
    ],
  },
];

for (const cross of crosses) {
  cross.cases.forEach((row, i) => {
    n += 1;
    const [caso, good, a, c, d] = row;
    wave4.push(
        gold({
          id: `oro-c4x-${cross.key}-${i + 1}`,
          module: cross.module,
          subtema: `${cross.key} · cruce ${i + 1}`,
          cargo: cross.key.includes("1278") || cross.key.includes("1620") ? "directivos" : "primaria",
          tagsCargo:
            cross.key.includes("1278") || cross.key.includes("1620")
              ? ["directivos", "primaria"]
              : ["primaria"],
          caso,
          stem: stems[n % stems.length],
          options: [a, good, c, d],
          correct: "B",
          norma: cross.norma,
          theory: cross.theory,
          wrong: {
            A: "Respuesta parcial o ritualmente 'correcta' pero insuficiente.",
            C: "Omite mediación, evidencia o proporcionalidad.",
            D: "Debilita derechos, criterios o aprendizaje esencial.",
          },
          tags: cross.tags,
          dif: 3,
          secs: 120,
        }),
    );
  });
}

module.exports = {wave4};
