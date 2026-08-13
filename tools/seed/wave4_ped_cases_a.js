/**
 * Casos pedagógicos (directivo, olas 1-2): DUA, DBA, evaluación, ABP, inclusión.
 * Distractores de la misma familia conceptual; no bancos cruzados.
 */

const HAND_PED_A = {
  "dir-apt-ped-81": {
    caseContext:
      "En 4° planean “un solo canal: fotocopia y quiz”. Un docente de apoyo pide DUA: múltiples formas de representación, acción/expresión y compromiso desde el diseño, no un ajuste improvisado el día de la prueba.",
    stem:
      "Según el DUA, ¿qué debe ofrecer la planeación desde el inicio?",
    options: [
      "Un único instrumento sumativo cronometrado, igual para todos, como garantía de equidad.",
      "Múltiples formas de representación, de acción/expresión y de motivación/compromiso.",
      "Solo calificación numérica más frecuente, sin cambiar materiales ni formas de evidenciar.",
      "Distribuir el tiempo de clase en ranking público, sin opciones de acceso ni expresión.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-83": {
    caseContext:
      "En ciencias se plantea un problema abierto; los estudiantes exploran, se equivocan y reformulan. Un colega pide “dictar la ley y repetirla” para no perder tiempo. Coordinación pregunta qué enfoque está en juego.",
    stem:
      "¿Qué enfoque aplica principalmente quien organiza la situación problema para construir conocimiento con exploración y error?",
    options: [
      "Conductista: reforzar la respuesta correcta sin mediación del error.",
      "Constructivista: el aprendizaje se construye activamente a partir de la exploración.",
      "Memorístico: copiar la definición y evaluarla al día siguiente.",
      "Transmisionista: exponer la conclusión y pedir reproducción literal.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-84": {
    caseContext:
      "El plan de área copia el índice del libro. Un docente propone usar los DBA como saberes y habilidades básicos por grado para planear. Otro dice que los DBA “reemplazan EBC y PEI” o que “solo sirven para evaluar docentes”.",
    stem:
      "¿Cuál es el propósito principal de los DBA del MEN?",
    options: [
      "Reemplazar los Estándares Básicos de Competencias.",
      "Establecer saberes y habilidades básicos esperados por grado, como referente de planeación curricular.",
      "Definir exclusivamente los criterios de evaluación docente.",
      "Sustituir el Proyecto Educativo Institucional.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-86": {
    caseContext:
      "Se califica “de ojo” y se entrega la rúbrica el día de los resultados. Estudiantes piden niveles de desempeño conocidos de antemano. Un colega dice que la rúbrica “reemplaza toda devolución oral” o “solo sirve en matemáticas”.",
    stem:
      "¿Qué permite principalmente una rúbrica de evaluación?",
    options: [
      "Ocultar los criterios hasta el final del período, para que “no se adelanten”.",
      "Describir niveles de desempeño con criterios explícitos y comunicables al estudiante.",
      "Reemplazar por completo la retroalimentación oral del docente.",
      "Usarse únicamente en evaluaciones de matemáticas.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-87": {
    caseContext:
      "Quieren “cumplir la Cátedra de la Paz” copiando artículos o reemplazando sociales. Un docente propone desarrollar competencias ciudadanas y cultura de paz en la comunidad, sin sustituir el manual ni el área.",
    stem:
      "Según la Ley 1732 de 2014, ¿cuál es el propósito principal de la Cátedra de la Paz?",
    options: [
      "Reemplazar el área de ciencias sociales.",
      "Fomentar competencias ciudadanas y una cultura de paz en la comunidad educativa.",
      "Sustituir el manual de convivencia por una cartilla conmemorativa.",
      "Evaluar solo con un quiz de fechas del conflicto, sin prácticas de convivencia.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-89": {
    caseContext:
      "Un plan de área es lista de temas. Otro articula saber, saber hacer y saber ser para resolver situaciones. Un colega cree que “competencias” significa prescindir de contenidos o evaluar solo actitudes.",
    stem:
      "¿En qué se diferencia la planeación por competencias de un enfoque solo por contenidos?",
    options: [
      "Prescinde por completo de los contenidos disciplinares.",
      "Articula saberes, habilidades y actitudes que el estudiante moviliza para resolver situaciones.",
      "Se centra únicamente en la actitud y omite el saber disciplinar.",
      "Sustituye la evaluación por un concepto de “participación” sin evidencias.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-90": {
    caseContext:
      "En la planeación, los verbos son “identificar, recordar, listar”. Un docente propone tareas de evaluar (juzgar con criterios). Coordinación pide no confundir nivel superior con más ítems de memoria.",
    stem:
      "Según la taxonomía de Bloom revisada, ¿qué verbo se asocia a un nivel superior de pensamiento?",
    options: [
      "Identificar.",
      "Recordar.",
      "Evaluar.",
      "Listar.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ped-91": {
    caseContext:
      "Proponen “un proyecto” que es más quizzes y un examen sorpresa. Otro equipo parte de una pregunta auténtica y un producto con sentido. Se pide distinguir ABP de activismo o de más notas.",
    stem:
      "¿Qué caracteriza principalmente al aprendizaje basado en proyectos?",
    options: [
      "Aumentar quizzes para tener más notas, sin producto ni pregunta auténtica.",
      "Resolver un problema o pregunta auténtica mediante un producto final significativo.",
      "Dejar la autoevaluación como trámite de caritas, sin contrastar el producto.",
      "Unificar la evidencia en un único examen acumulativo sorpresa.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-92": {
    caseContext:
      "La visita de calidad pregunta por EBC. El área muestra el índice del libro. Un docente explica que los EBC fijan criterios comunes de saber y saber hacer por grupos de grados, sin anular la autonomía curricular ni reemplazar el PEI.",
    stem:
      "¿Cuál es la función principal de los Estándares Básicos de Competencias del MEN?",
    options: [
      "Reemplazar la autonomía curricular de las instituciones.",
      "Establecer criterios comunes sobre lo que los estudiantes deben saber y saber hacer en cada área y grupo de grados.",
      "Definir el horario y la planta de cargos de la IE.",
      "Sustituir los DBA y el SIEE por un único listado de temas.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-93": {
    caseContext:
      "Hay un estudiante con discapacidad. Un colega propone “bajar la meta para todos” o “no evaluar”. Otro pide ajustar tiempos, metodologías o formas de evidencia sin renunciar al aprendizaje esencial.",
    stem:
      "En inclusión, ¿qué implica principalmente la flexibilización curricular?",
    options: [
      "Reducir las expectativas de aprendizaje para todo el grupo.",
      "Ajustar tiempos, metodologías o formas de evaluación sin renunciar a los propósitos esenciales.",
      "Eliminar la evaluación para estudiantes con discapacidad.",
      "Aplicarse únicamente en instituciones de educación especial.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-96": {
    caseContext:
      "Arman “grupos” donde uno copia y los demás esperan. Un docente diseña roles, meta común e interdependencia positiva, con responsabilidad individual. No es ausencia de roles ni retiro del docente.",
    stem:
      "A diferencia del trabajo meramente grupal, ¿qué caracteriza al trabajo colaborativo?",
    options: [
      "La ausencia total de roles definidos.",
      "Interdependencia positiva, con responsabilidad individual y colectiva sobre el resultado.",
      "Evaluación exclusivamente individual, sin ningún componente de equipo.",
      "Eliminar el rol del docente durante toda la actividad.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-98": {
    caseContext:
      "En media, orientación vocacional se reduce a “elegir carrera ya” o a un test. Un docente acompaña la reflexión de intereses, metas y decisiones. No reemplaza el área de ética ni impone un oficio.",
    stem:
      "¿Qué busca principalmente el Proyecto de Vida como estrategia en educación media?",
    options: [
      "Definir de manera obligatoria la carrera profesional del estudiante.",
      "Acompañar la reflexión sobre intereses, metas y decisiones futuras.",
      "Reemplazar la orientación vocacional por pruebas estandarizadas únicas.",
      "Evaluarse únicamente en el área de ética, sin acompañamiento.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-181": {
    caseContext:
      "Un “trabajo en grupo” es competencia por nota. Un docente de Johnson y Johnson diseña interdependencia positiva: el éxito de cada uno depende del trabajo conjunto, con responsabilidad individual.",
    stem:
      "Según Johnson y Johnson, ¿cuál es un elemento esencial del aprendizaje cooperativo?",
    options: [
      "La interdependencia positiva, donde el éxito de cada integrante depende del trabajo conjunto.",
      "La competencia individual entre integrantes como motor único.",
      "La evaluación solo grupal, sin ninguna responsabilidad individual.",
      "La ausencia de roles y de meta común.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-183": {
    caseContext:
      "Quieren “separar el curso por inteligencia dominante” de por vida. Un docente usa Gardner para diversificar formas de presentar y evaluar, sin etiquetar ni evaluar solo lo lógico-matemático.",
    stem:
      "¿Qué sugiere una aplicación pertinente de las inteligencias múltiples en el aula?",
    options: [
      "Que cada estudiante tiene un único tipo de inteligencia fijo de por vida.",
      "Que solo la inteligencia lógico-matemática debe evaluarse.",
      "Diversificar formas de presentar y evaluar, reconociendo distintas fortalezas cognitivas.",
      "Separar grupos permanentes según la inteligencia “dominante”.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ped-184": {
    caseContext:
      "Al iniciar la unidad, aplican un instrumento y lo usan como nota definitiva. Un docente lo usa para identificar saberes previos y reorientar la planeación, no para sancionar ni para reemplazar la formativa del período.",
    stem:
      "¿Cuál es el propósito principal de la evaluación diagnóstica al inicio de un período o unidad?",
    options: [
      "Asignar la calificación definitiva del período.",
      "Sancionar a quienes muestran menor desempeño previo.",
      "Reemplazar la evaluación formativa durante el período.",
      "Identificar saberes previos y necesidades para orientar la planeación pedagógica.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-185": {
    caseContext:
      "Confunden formativa y sumativa: quieren “solo quizzes de proceso” o “solo el examen final”. Se pide el cierre valorativo de un período frente al acompañamiento continuo.",
    stem:
      "A diferencia de la formativa, ¿qué caracteriza principalmente a la evaluación sumativa?",
    options: [
      "Emitir un juicio valorativo final sobre el aprendizaje logrado al cierre de un proceso o período.",
      "Brindar retroalimentación continua durante todo el proceso.",
      "Aplicarse exclusivamente al inicio de cada unidad.",
      "Excluir cualquier forma de calificación o certificación.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-188": {
    caseContext:
      "Un docente “dicta y examina”. Otro facilita que el estudiante construya, con preguntas y andamiaje. No se trata de reemplazar a la familia ni de ser solo juez disciplinario.",
    stem:
      "¿A qué se refiere principalmente el docente como mediador pedagógico?",
    options: [
      "A resolver exclusivamente conflictos disciplinarios.",
      "A reemplazar por completo el rol de la familia en el aprendizaje.",
      "A evaluar únicamente con pruebas estandarizadas.",
      "A facilitar y acompañar la construcción de conocimiento, más que transmitir en un solo sentido.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-189": {
    caseContext:
      "Proponen “aula invertida” como “nada de explicación nunca” o “solo virtual”. Un docente pide revisar contenidos introductorios fuera y usar la clase para aplicar y profundizar.",
    stem:
      "¿Qué caracteriza principalmente al aula invertida?",
    options: [
      "Que los estudiantes revisan contenidos introductorios fuera del aula y dedican la clase a aplicar y profundizar.",
      "Eliminar por completo cualquier exposición o mediación del docente.",
      "Invertir el orden de las evaluaciones respecto a las actividades, sin cambio de uso del tiempo.",
      "Aplicarse únicamente en educación virtual.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-191": {
    caseContext:
      "El “programa socioemocional” es memorizar definiciones o prohibir expresar emociones. Un docente busca que reconozcan y gestionen emociones y se relacionen de forma asertiva.",
    stem:
      "¿Qué busca principalmente el desarrollo de competencias socioemocionales en el aula?",
    options: [
      "Memorizar definiciones teóricas sobre las emociones.",
      "Evaluarlas exclusivamente con pruebas escritas estandarizadas.",
      "Reconocer y gestionar emociones, y relacionarse de manera asertiva.",
      "Evitar expresar cualquier emoción dentro del aula.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ped-192": {
    caseContext:
      "Confunden autonomía con “trabajar siempre solo y sin devolución”. Un estudiante planifica, ejecuta y revisa su proceso, con mediación y criterios. No es independencia extrema ni dependencia total del docente.",
    stem:
      "¿Qué caracteriza principalmente al aprendizaje autónomo?",
    options: [
      "Trabajar siempre de manera individual, sin interacción.",
      "Depender exclusivamente de la instrucción directa del docente.",
      "No requerir ningún tipo de retroalimentación.",
      "Asumir un rol activo en la planificación, ejecución y evaluación del propio aprendizaje.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-193": {
    caseContext:
      "Una clase es solo exposición o solo examen. Un docente estructura inicio (saberes previos), desarrollo (construcción y aplicación) y cierre (síntesis y evaluación).",
    stem:
      "¿Qué momentos debe contemplar, como mínimo, una secuencia didáctica bien estructurada?",
    options: [
      "Inicio (activación de saberes previos), desarrollo (construcción y aplicación) y cierre (síntesis y evaluación).",
      "Únicamente actividades de evaluación sumativa.",
      "Solo la exposición del docente, sin actividad de los estudiantes.",
      "Un único momento continuo, sin estructura interna.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-194": {
    caseContext:
      "Quieren “que los estudiantes se pongan la nota y el docente no evalúe”. Otro usa autoevaluación y coevaluación con criterios, complementando la heteroevaluación, no reemplazándola.",
    stem:
      "¿Qué permiten principalmente la coevaluación y la autoevaluación junto a la heteroevaluación?",
    options: [
      "Reemplazar por completo la evaluación que realiza el docente.",
      "Que los estudiantes desarrollen criterio sobre su desempeño y el de pares, fortaleciendo la reflexión.",
      "Reducir la responsabilidad del docente en el proceso evaluativo.",
      "Aplicarse únicamente en educación superior.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-195": {
    caseContext:
      "“Uso de TIC” es pasar diapositivas o calificar el dispositivo. Un docente las integra para pensar (simular, contrastar fuentes, producir), no como fin ni para prescindir de lo analógico cuando aporta.",
    stem:
      "Más allá del uso instrumental, ¿qué implica el uso pedagógico de las TIC?",
    options: [
      "Utilizar solo presentaciones digitales en reemplazo del tablero.",
      "Evaluar el uso de dispositivos como fin en sí mismo.",
      "Integrar herramientas digitales de forma intencionada para fortalecer pensamiento y aprendizaje, no solo transmitir.",
      "Prescindir por completo de materiales físicos o análogos.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ped-196": {
    caseContext:
      "Confunden ABPr y ABP: uno es un problema acotado a resolver; el otro, un producto más amplio y largo. No son “iguales” ni excluyen investigación o trabajo en equipo.",
    stem:
      "¿En qué se diferencia principalmente el aprendizaje basado en problemas del basado en proyectos?",
    options: [
      "El ABPr no requiere investigación por parte del estudiante.",
      "El aprendizaje basado en proyectos no admite trabajo en equipo.",
      "Ambos enfoques son exactamente iguales en estructura y duración.",
      "El ABPr se centra en un problema específico y acotado; el proyecto suele derivar en un producto más amplio y de mayor duración.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-197": {
    caseContext:
      "Diagnosticaron “estilos” visual/auditivo/kinestésico y quieren enseñar a cada uno solo en su canal. La evidencia recomienda variedad de estrategias para todos, no un estilo fijo dominante.",
    stem:
      "Respecto a los llamados estilos de aprendizaje, ¿qué recomienda principalmente la evidencia pedagógica actual?",
    options: [
      "Usar variedad de estrategias y recursos para todos, sin limitar la enseñanza a un único estilo supuesto.",
      "Diagnosticar un único estilo y enseñar solo en ese canal todo el año.",
      "Evaluar únicamente en el formato “preferido”, aunque no evidencie el aprendizaje esencial.",
      "Separar el grupo de forma permanente por estilo declarado.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-199": {
    caseContext:
      "La “devolución” es un “bien” genérico a fin de año o solo señalar errores. Un docente da retroalimentación oportuna, específica y con un siguiente paso de mejora.",
    stem:
      "Para que la retroalimentación docente sea efectiva, ¿cómo debe caracterizarse principalmente?",
    options: [
      "Genérica e idéntica para todos, sin distinción de evidencia.",
      "Entregada únicamente al finalizar el año escolar.",
      "Oportuna, específica y orientada a acciones concretas de mejora, más que una valoración general.",
      "Centrada exclusivamente en señalar errores, sin orientación de mejora.",
    ],
    correctIndex: 2,
  },
};

module.exports = {HAND_PED_A};
