/**
 * Ajustes de ítems con score alto: enunciado ≥70, opciones comparables
 * y distractores sin palabras-señuelo del auditor.
 */

const HAND_ALTOS = {
  "dir-apt-ges-62": {
    stem:
      "En este desacuerdo sobre quién adopta el manual, ¿qué instancia corresponde en el gobierno escolar (Ley 115 y Decreto 1860)?",
  },
  "dir-apt-ges-63": {
    stem:
      "Tras reclamos de participación, ¿quién debe aprobar el SIEE para que el acto de adopción sea válido?",
  },
  "dir-apt-ges-67": {
    stem:
      "De esos documentos vigentes, ¿cuál orienta la organización pedagógica, administrativa y de gestión de la IE?",
  },
  "dir-apt-ges-69": {
    caseContext:
      "El personero estudiantil es presionado para “defender al rector en Secretaría” y para “aprobar el presupuesto”. Estudiantes le piden que los represente en derechos y deberes.",
    stem:
      "Ante esas presiones, ¿cuál es la función principal del personero estudiantil?",
  },
  "dir-apt-ges-73": {
    stem:
      "En la revisión del plan de estudios, ¿qué instancia es órgano consultivo del currículo (Decreto 1860)?",
  },
  "dir-apt-ges-75": {
    stem:
      "Para homologar valoraciones entre áreas, ¿qué escala nacional debe incluir el SIEE?",
  },
  "dir-apt-ped-87": {
    stem:
      "En este intento de “cumplir” copiando artículos o reemplazando un área, ¿cuál es el propósito principal de la Cátedra de la Paz?",
  },
  "dir-apt-ges-162": {
    stem:
      "En este anuncio del alcalde de un municipio no certificado, ¿quién administra el servicio educativo en esa jurisdicción?",
  },
  "oro-cie-01": {
    caseContext:
      "En grado 6°, el docente pide copiar del tablero la definición de “hipótesis” y recitarla en el quiz, sin formular preguntas ni observar fenómenos. Un colega defiende que “así se cubre el tema más rápido”.",
    stem:
      "En este episodio, ¿cuál decisión está menos alineada con el enfoque de indagación en ciencias?",
    options: [
      "Partir de una pregunta investigable, observar y contrastar explicaciones con evidencia registrada.",
      "Reducir el aprendizaje a recitar definiciones del tablero, sin explorar fenómenos ni registrar observaciones.",
      "Registrar observaciones del fenómeno y discutir con el grupo posibles explicaciones antes de formalizar.",
      "Revisar con el grupo el diseño experimental (variables, controles) antes de sacar conclusiones.",
    ],
    correctIndex: 1,
  },
  "oro-rect-08": {
    caseContext:
      "Un aspirante afirma que el nombramiento se obtiene por amistad con el rector, sin concurso. El rector duda entre “ayudar” y remitir a las reglas del sistema de carrera. El consejo de padres pide “opinar los nombramientos”.",
    stem:
      "En este pedido de nombramiento informal, ¿cuál lectura del Estatuto de Profesionalización (Decreto 1278) es la más precisa?",
    options: [
      "Que el ingreso dependa de la antigüedad en el municipio, sin concurso de méritos.",
      "Que el ingreso a la carrera docente se rige por concurso y reglas del sistema, no por un favor informal.",
      "Que el rector nombre libremente, porque la planta de la sede “es de su resorte”.",
      "Que el consejo de padres decida los nombramientos, como si fuera gobierno escolar de personal.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-72": {
    caseContext:
      "Quieren “autoevaluar” copiando el formato del año anterior y publicando un ranking de sedes. Un coordinador pide identificar fortalezas y brechas en las cuatro áreas de gestión como insumo del PMI. El Consejo Directivo pide evidencia, no imagen.",
    stem:
      "¿Cuál es el propósito principal de la autoevaluación institucional anual en ese ciclo de mejoramiento?",
    options: [
      "Usar el ejercicio como ranking punitivo de sedes o docentes, como si el fin fuera la imagen pública.",
      "Identificar fortalezas y oportunidades de mejora en las cuatro áreas de gestión, como insumo del plan de mejoramiento.",
      "Sustituir el PEI por un informe de prensa para la secretaría, sin un PMI que traduzca la autoevaluación.",
      "Reemplazar el PMI y el SIEE por un único promedio de satisfacción familiar, sin evidencias de gestión.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-84": {
    caseContext:
      "El plan de área copia el índice del libro. Un docente propone usar los DBA como saberes y habilidades básicos por grado para planear. Otro dice que los DBA “reemplazan EBC y PEI” o que “solo sirven para evaluar docentes”.",
    stem:
      "En esta discusión de planeación, ¿cuál es el propósito principal de los DBA como referente del MEN?",
    options: [
      "Reemplazar los Estándares Básicos de Competencias y anular la autonomía curricular de la IE.",
      "Establecer saberes y habilidades básicos esperados por grado, como referente de planeación curricular.",
      "Definir de forma exclusiva los criterios de evaluación docente y de la visita de supervisión.",
      "Sustituir el Proyecto Educativo Institucional por un listado de desempeños desconectado del PEI.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-174": {
    caseContext:
      "El calendario marca Día E. Un sector pide “día recreativo sin clases ni análisis”. El equipo de calidad quiere reflexionar el ISCE y ajustar el PMI. No es evaluación de directivos ni reemplazo de las semanas de desarrollo institucional.",
    stem:
      "En esa jornada del calendario, ¿cuál es el propósito principal del Día E promovido por el MEN?",
    options: [
      "Suspender clases para actividades exclusivamente recreativas, sin análisis de resultados.",
      "Dedicar una jornada a la reflexión pedagógica sobre el ISCE y la construcción de planes de mejoramiento.",
      "Evaluar únicamente el desempeño de los directivos docentes, como si fuera un acto de personal.",
      "Reemplazar la semana de desarrollo institucional y la autoevaluación anual de la Guía 34.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-177": {
    caseContext:
      "Una familia pide traslado “con una carta al rector de origen”. El rector de destino dice que “si hay cupo, él decide solo”. La secretaría indica que el traslado entre oficiales del mismo municipio certificado se gestiona por el sistema de matrícula, con las IE involucradas.",
    stem:
      "En este pedido de cambio de IE oficial, ¿a quién corresponde principalmente autorizar el traslado?",
    options: [
      "A la Secretaría de Educación municipal, mediante su sistema de matrícula, con la gestión de las instituciones involucradas.",
      "Exclusivamente al rector de origen, sin registro en el sistema de matrícula de la entidad territorial.",
      "Al personero estudiantil, como si el traslado fuera un derecho que él autoriza por representación.",
      "Al Consejo Académico, por ser órgano consultivo del plan de estudios y no de matrícula.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-179": {
    caseContext:
      "En una vereda sin oferta oficial suficiente, proponen “un acuerdo verbal con un colegio privado” o “cerrar lo oficial”. La secretaría recuerda que la contratación del servicio con particulares tiene marco de calidad, cobertura y supervisión, no un trato de palabra del rector.",
    stem:
      "Cuando la oferta oficial no alcanza, ¿qué rige principalmente esa contratación del servicio educativo?",
    options: [
      "La libre decisión de cada familia, sin marco de calidad, cobertura ni supervisión estatal.",
      "La eliminación total de la educación oficial en esa zona, como si el contrato sustituyera al Estado.",
      "La normatividad que regula la prestación por particulares mediante contrato con el Estado, sujeta a calidad y cobertura.",
      "Un acuerdo exclusivamente verbal entre el rector y el particular, sin acto de la entidad territorial.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ped-189": {
    caseContext:
      "Proponen “aula invertida” como “nada de explicación nunca” o “solo virtual”. Un docente pide revisar contenidos introductorios fuera y usar la clase para aplicar y profundizar, con mediación.",
    stem:
      "En esta propuesta de reorganizar el tiempo, ¿qué caracteriza principalmente al aula invertida?",
    options: [
      "Que los estudiantes revisan contenidos introductorios fuera del aula y dedican la clase a aplicar y profundizar.",
      "Eliminar por completo cualquier exposición o mediación del docente, dentro o fuera del aula.",
      "Invertir el orden de las evaluaciones respecto a las actividades, sin cambiar el uso del tiempo de clase.",
      "Aplicarse únicamente en educación virtual, como si no pudiera usarse en una IE presencial.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-292": {
    caseContext:
      "La unidad es solo exposición o solo examen. Un docente sigue a Kolb: experiencia concreta, observación reflexiva, conceptualización y experimentación activa. Un colega pide “más teoría para el quiz”.",
    stem:
      "Según el ciclo de Kolb, ¿a través de qué se produce principalmente el aprendizaje experiencial en este diseño de unidad?",
    options: [
      "La recitación repetida de teoría, sin experiencia concreta ni experimentación posterior.",
      "La exposición pasiva del estudiante a la información, sin observación reflexiva del grupo.",
      "La evaluación exclusivamente mediante un examen final, sin ciclo de experiencia y conceptualización.",
      "Un ciclo de experiencia concreta, observación reflexiva, conceptualización abstracta y experimentación activa.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-296": {
    caseContext:
      "La comprensión lectora es lectura silenciosa y preguntas de copia. Un docente propone enseñanza recíproca: roles rotativos de predecir, cuestionar, aclarar y resumir, de forma colaborativa.",
    stem:
      "En esta clase de comprensión, ¿qué caracteriza principalmente a la enseñanza recíproca (reciprocal teaching)?",
    options: [
      "Leer de forma completamente individual, sin interacción ni roles compartidos de comprensión.",
      "Recitar el texto palabra por palabra, como si la comprensión fuera reproducción literal.",
      "Recibir únicamente preguntas cerradas del docente, sin que el estudiante guíe la discusión.",
      "Asumir roles rotativos (predecir, cuestionar, aclarar y resumir) para guiar en colaboración la comprensión.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ped-299": {
    caseContext:
      "Los grupos son fijos por lista o se evita el trabajo en equipo. Un docente propone agrupamiento flexible: variar la composición según el propósito de la actividad y las necesidades, no por capricho.",
    stem:
      "En esta organización del trabajo, ¿en qué consiste principalmente el agrupamiento flexible como estrategia pedagógica?",
    options: [
      "Mantener los mismos grupos todo el año, sin variación según la actividad o las necesidades.",
      "Formar grupos exclusivamente por orden alfabético, sin propósito pedagógico de la tarea.",
      "Variar la composición de los grupos según el propósito de cada actividad y las necesidades.",
      "Evitar cualquier trabajo grupal en el aula, para que toda evidencia sea estrictamente individual.",
    ],
    correctIndex: 2,
  },
  "dir-apt-dis-370": {
    caseContext:
      "En geografía de Colombia, un equipo nombra el Cauca como “el más largo”; otro el Magdalena, articulando transporte e historia económica; otro el Atrato “porque es el más caudaloso en su relato”. Se pide el río más largo y su papel histórico, no fama local.",
    stem:
      "¿Qué identificación del río más largo de Colombia es la más precisa y qué error conceptual hay que reenseñar?",
    options: [
      "El Cauca como el más largo, por ser afluente conocido y visible en el mapa escolar de la región andina.",
      "El Magdalena (el más largo y eje histórico de transporte) y reenseñar no sustituirlo por afluentes o ríos regionales.",
      "El Atrato como el más largo, por relatos de caudal, sin distinguir longitud de otras magnitudes.",
      "El Meta como el más largo, por la Orinoquía en el mapa escolar, sin comparar trayectos.",
    ],
    correctIndex: 1,
  },
  "dir-apt-dis-375": {
    caseContext:
      "Sobre la Guerra Fría (aprox. 1947-1991), un ensayo afirma que EE. UU. y la URSS se combatieron de forma directa y continua en Europa. Otro describe tensión bipolar, carrera armamentista y conflictos indirectos, sin guerra directa entre ambas potencias.",
    stem:
      "¿Qué caracterización de la Guerra Fría es la más precisa y qué error conceptual hay que reenseñar?",
    options: [
      "Guerra directa y continua entre EE. UU. y la URSS en territorio europeo, como si fuera una guerra clásica.",
      "Unificación política mundial bajo un solo sistema, omitiendo la bipolaridad de bloques.",
      "Tensión bipolar sin enfrentamiento militar directo entre las dos potencias, y reenseñar no igualarla a una guerra europea continua entre ambas.",
      "El fin de todo conflicto internacional tras 1945, como si la posguerra hubiera cancelado la tensión.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ped-293": {
    stem:
      "Una pregunta como “¿por qué crees que el personaje tomó esa decisión?”, frente a una literal, es principalmente de:",
    options: [
      "Orden superior: exige análisis e interpretación, no solo recuperación literal.",
      "Orden inferior: solo recupera un dato puntual del texto, sin interpretación.",
      "Orden reproductivo: copia una frase del texto sin interpretarla.",
      "Orden administrativo: sirve para tomar asistencia, no para comprender.",
    ],
    correctIndex: 0,
  },
  "oro-rect-14": {
    stem:
      "Con el gobierno escolar inactivo, ¿qué decisión es la más defendible para recuperar instancia, quórum y trazabilidad?",
    options: [
      "Esperar a que supervisión nombre los órganos, aunque eso aplace el año lectivo.",
      "Sustituir instancias por encuestas anónimas en redes, aunque parezca participación.",
      "Reactivar calendarios, convocatorias, quórums y actas de las instancias del gobierno escolar.",
      "Centralizar todo en rectoría “para no perder tiempo”, aunque se presente como eficiencia.",
    ],
    correctIndex: 2,
    difficulty: "avanzado",
    dificultad: 3,
  },
  "dir-apt-ped-381": {
    caseContext:
      "La historia se evalúa como lista de fechas. Un docente pide causalidad, cambio y continuidad entre momentos. Un colega defiende “más datos para el quiz de efemérides”.",
    stem:
      "En esta evaluación de historia, ¿qué implica principalmente desarrollar pensamiento histórico en el estudiante?",
    options: [
      "Comprender relaciones de causalidad, cambio y continuidad, más allá de acumular fechas aisladas.",
      "Acumular la mayor cantidad posible de fechas exactas, sin establecer relaciones entre períodos.",
      "Repetir de memoria los nombres de los personajes más importantes, sin analizar procesos.",
      "Evitar relacionar distintos períodos históricos, para “no mezclar temas” en la prueba.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ped-386": {
    caseContext:
      "Ciudadanas se reduce a copiar la Constitución o a imponer una militancia. El MEN busca habilidades cognitivas, emocionales y comunicativas para participar en una sociedad democrática.",
    stem:
      "En este reduccionismo de la clase, ¿qué buscan principalmente desarrollar las competencias ciudadanas del MEN?",
    options: [
      "Solo conocimientos teóricos sobre instituciones, sin práctica de participación ni dilemas del entorno.",
      "Habilidades cognitivas, emocionales y comunicativas para participar de forma constructiva en una sociedad democrática.",
      "Una postura política específica obligatoria para todo el grupo, como si el área formara militancia.",
      "Únicamente la recitación de artículos de la Constitución Política, sin habilidades de participación.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ped-388": {
    caseContext:
      "En sociales, un “caso” es recitar definiciones. El estudio de caso analiza en profundidad una situación real o realista para decidir con evidencia, no un quiz secreto ni un promedio vacío.",
    stem:
      "En esta clase, ¿en qué consiste principalmente el método de estudio de caso aplicado a las ciencias sociales?",
    options: [
      "Recitar conceptos de la unidad sin un ejemplo concreto ni decisión fundada en evidencia.",
      "Aplicar exclusivamente pruebas estandarizadas de selección múltiple, sin análisis de una situación.",
      "Evitar el análisis de situaciones reales del entorno, para no “salirse del temario”.",
      "Analizar en profundidad una situación real o realista para desarrollar análisis y toma de decisiones.",
    ],
    correctIndex: 3,
  },
};

module.exports = {HAND_ALTOS};
