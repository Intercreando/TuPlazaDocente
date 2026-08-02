import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Casos oro enfocados en el rol de Rectoría (specialty: Gestión directiva).
abstract final class RectorBrainBank {
  static const List<Question> items = [
    Question(
      id: 'oro-rect-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / PEI participativo',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Ley 115 / Decreto 1860',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'La rectoría reescribe el PEI en un fin de semana para una visita de supervisión, '
          'sin docentes, familias ni estudiantes.',
      stem: 'La decisión más alineada a Ley 115 / Decreto 1860 es:',
      options: [
        'Validar el documento unilateral porque el rector es el máximo responsable',
        'Reabrir un proceso participativo con gobierno escolar y socializar ajustes antes de formalizar',
        'Archivar el PEI y operar solo con el PMI',
        'Delegar el PEI a un abogado externo sin comunidad',
      ],
      correctIndex: 1,
      explanation:
          'Ley 115 y Decreto 1860 conciben el PEI como proyecto de la comunidad educativa, '
          'no como trámite unilateral de rectoría.',
      normativeJustification:
          'Ley 115 y Decreto 1860 conciben el PEI como proyecto de la comunidad educativa, '
          'no como trámite unilateral de rectoría.',
      theoreticalJustification:
          'Sin participación, el PEI pierde apropiación y no orienta prácticas reales de aula ni de gestión.',
      distractorAnalysis: {
        0: 'La responsabilidad del rector no elimina el deber de participación.',
        2: 'El PMI no sustituye al PEI; se articula con él.',
        3: 'La tercerización sin comunidad vacía el sentido institucional.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley115, articleOrFocus: 'PEI'),
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'gobierno escolar'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-02',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / Consejo Directivo',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Decreto 1860',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Hay que aprobar el presupuesto de inversión y el rector lo decide solo por chat '
          'con el pagador, sin sesión del Consejo Directivo.',
      stem: 'Según el gobierno escolar (D.1860), conviene:',
      options: [
        'Mantener la decisión informal por agilidad',
        'Convocar al Consejo Directivo, deliberar con actas y formalizar la decisión',
        'Consultar solo al consejo de padres por WhatsApp',
        'Esperar a que supervisión dicte el presupuesto',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1860 asigna al Consejo Directivo competencias de gobierno institucional; '
          'las decisiones de impacto deben ser trazables.',
      normativeJustification:
          'El Decreto 1860 asigna al Consejo Directivo competencias de gobierno institucional; '
          'las decisiones de impacto deben ser trazables.',
      theoreticalJustification:
          'La gobernanza escolar legitima recursos y reduce riesgos de arbitrariedad o captura informal.',
      distractorAnalysis: {
        0: 'La agilidad no justifica omitir el órgano competente.',
        2: 'El consejo de padres no reemplaza al Consejo Directivo.',
        3: 'La supervisión no sustituye la autonomía con control interno.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'Consejo Directivo'),
        KnowledgeTag(code: KnowledgeCode.ley115, articleOrFocus: 'gobierno escolar'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-03',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / Manual de convivencia',
      module: ContentModule.inclusionConvivencia,
      subtopic: 'Ley 1620 / Guías MEN',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'El manual de convivencia tiene 8 años, copia normas de otra IE y no tipifica '
          'rutas digitales ni debida proceso.',
      stem: 'La acción rectoral prioritaria es:',
      options: [
        "Seguir usándolo porque 'siempre ha servido'",
        'Actualizarlo con participación, tipificación clara y rutas alineadas a Ley 1620 y Guías MEN 49/51',
        'Reemplazarlo por un reglamento verbal del rector',
        'Publicar sanciones ejemplarizantes en redes sin revisar el manual',
      ],
      correctIndex: 1,
      explanation:
          'Ley 1620 y Guías MEN 49/51 exigen manual vivo, contextualizado y coherente con rutas de atención.',
      normativeJustification:
          'Ley 1620 y Guías MEN 49/51 exigen manual vivo, contextualizado y coherente con rutas de atención.',
      theoreticalJustification:
          'Un manual desactualizado genera inequidad, improvisación y vulnerabilidad jurídica.',
      distractorAnalysis: {
        0: 'La antigüedad no garantiza validez ni pertinencia.',
        2: 'El reglamento verbal carece de trazabilidad y participación.',
        3: 'La exposición pública no es ruta institucional.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley1620, articleOrFocus: 'manual de convivencia'),
        KnowledgeTag(code: KnowledgeCode.guiaMen49, articleOrFocus: 'actualización'),
        KnowledgeTag(code: KnowledgeCode.guiaMen51, articleOrFocus: 'rutas'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-04',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / SIEE',
      module: ContentModule.pedagogiaEvaluacion,
      subtopic: 'Decreto 1290',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Familias desconocen la escala; docentes del mismo grado valoran con criterios distintos; '
          'hay quejas por promoción.',
      stem: 'Como rector, la intervención más coherente con el Decreto 1290 es:',
      options: [
        'Prohibir que familias pregunten por criterios',
        'Liderar revisión, socialización y monitoreo del SIEE para aplicación coherente',
        'Imponer promedios nacionales sin SIEE institucional',
        'Dejar que cada docente invente su propia escala cada periodo',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1290 exige un sistema institucional de evaluación conocido, aplicado y orientado al aprendizaje.',
      normativeJustification:
          'El Decreto 1290 exige un sistema institucional de evaluación conocido, aplicado y orientado al aprendizaje.',
      theoreticalJustification:
          'La coherencia de criterios genera confianza y mejora la autorregulación del aprendizaje.',
      distractorAnalysis: {
        0: 'La opacidad aumenta conflicto y desconfianza.',
        2: 'La autonomía institucional se ejerce vía SIEE, no vía imposición externa genérica.',
        3: 'La inconsistencia vulnera el debido proceso evaluativo.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1290, articleOrFocus: 'SIEE institucional'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-05',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / Comité de convivencia',
      module: ContentModule.inclusionConvivencia,
      subtopic: 'Ley 1620',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Un caso Tipo II llega a rectoría. El rector propone arreglarlo en privado '
          'sin activar el comité ni registrar.',
      stem: 'La respuesta correcta es:',
      options: [
        'Cerrar el caso en privado para proteger la imagen institucional',
        'Activar la ruta, proteger a las partes, registrar y hacer seguimiento con el Comité de Convivencia',
        'Expulsar de inmediato sin procedimiento',
        'Publicar los nombres en la cartelera',
      ],
      correctIndex: 1,
      explanation:
          'Ley 1620 y Guías 49/51 exigen ruta de atención integral con trazabilidad y roles definidos.',
      normativeJustification:
          'Ley 1620 y Guías 49/51 exigen ruta de atención integral con trazabilidad y roles definidos.',
      theoreticalJustification:
          'La informalidad protege la imagen, no los derechos ni el debido proceso.',
      distractorAnalysis: {
        0: 'El secreto informal puede constituir omisión.',
        2: 'Sin procedimiento no hay garantía de derechos.',
        3: 'La exposición pública vulnera intimidad.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley1620, articleOrFocus: 'Comité de Convivencia'),
        KnowledgeTag(code: KnowledgeCode.guiaMen51, articleOrFocus: 'Tipo II'),
      ],
      difficulty: QuestionDifficulty.avanzado,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-06',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / inclusión y PIAR',
      module: ContentModule.inclusionConvivencia,
      subtopic: 'Decreto 1421',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          "Ingresa un estudiante con discapacidad. Varios docentes dicen 'no estamos formados' "
          'y piden negarle el cupo.',
      stem: 'La postura rectoral alineada al Decreto 1421 es:',
      options: [
        'Negar el cupo por falta de formación del equipo',
        'Garantizar el ingreso, activar PIAR/ajustes razonables y acompañar al equipo docente',
        "Aceptarlo sin ningún ajuste 'para que se adapte solo'",
        'Trasladarlo de inmediato a otra IE sin plan',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1421 orienta educación inclusiva con PIAR y ajustes razonables; '
          'la falta de formación no habilita exclusión.',
      normativeJustification:
          'El Decreto 1421 orienta educación inclusiva con PIAR y ajustes razonables; '
          'la falta de formación no habilita exclusión.',
      theoreticalJustification:
          'El liderazgo inclusivo convierte la barrera del entorno en objeto de gestión, '
          'no en culpa del estudiante.',
      distractorAnalysis: {
        0: 'La formación se gestiona; no justifica discriminación.',
        2: 'Sin ajustes se niega el derecho a aprender en igualdad de condiciones.',
        3: 'El traslado sin plan puede ser exclusión encubierta.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1421, articleOrFocus: 'PIAR y ajustes'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-07',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / PMI y PEI',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Mejoramiento institucional',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'El PMI lista compras de equipos, pero no se articula con las metas del PEI '
          'ni con evidencias de aprendizaje.',
      stem: 'La mejora de gestión más sólida es:',
      options: [
        'Mantener el PMI como lista de compras independiente',
        'Alinear el PMI a prioridades del PEI con indicadores de aprendizaje y seguimiento',
        'Eliminar el PEI porque el PMI basta para supervisión',
        'Cambiar el PEI cada mes según la moda pedagógica',
      ],
      correctIndex: 1,
      explanation:
          'La gestión institucional debe articular PEI, mejoramiento y calidad del servicio educativo.',
      normativeJustification:
          'La gestión institucional debe articular PEI, mejoramiento y calidad del servicio educativo.',
      theoreticalJustification:
          'Un plan de mejoramiento sin norte pedagógico gasta recursos sin transformar resultados de aprendizaje.',
      distractorAnalysis: {
        0: 'Compras sin foco pedagógico son gestión incompleta.',
        2: 'El PMI no sustituye la identidad y horizonte del PEI.',
        3: 'La inestabilidad documental impide seguimiento serio.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley115, articleOrFocus: 'PEI'),
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'mejoramiento'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-08',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / Estatuto 1278',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Decreto 1278',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Un aspirante a docente afirma que el nombramiento se obtiene por amistad '
          'con el rector, sin concurso.',
      stem: 'La lectura correcta del marco de profesionalización (D.1278) es:',
      options: [
        'Sí: el rector nombra libremente sin reglas',
        'El ingreso a la carrera docente se rige por concurso y reglas del sistema, no por favor informal',
        'Solo importa la antigüedad en el municipio',
        'El consejo de padres decide los nombramientos',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1278 estructura la carrera docente con ingreso por mérito/concurso '
          'y reglas del sistema educativo.',
      normativeJustification:
          'El Decreto 1278 estructura la carrera docente con ingreso por mérito/concurso '
          'y reglas del sistema educativo.',
      theoreticalJustification:
          'La profesionalización protege la calidad y la igualdad de oportunidades frente al clientelismo.',
      distractorAnalysis: {
        0: 'El nombramiento no es potestad informal del rector.',
        2: 'La antigüedad local no sustituye el concurso.',
        3: 'El consejo de padres no nombra docentes de carrera.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1278, articleOrFocus: 'ingreso y carrera'),
      ],
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-09',
      pillar: CompetencyPillar.comportamental,
      topic: 'Rectoría / liderazgo pedagógico',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Calidad del servicio',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'La rectoría dedica casi todo el tiempo a disciplina de pasillo y trámites; '
          'casi no hay acompañamiento a planeación ni a evidencias de aula.',
      stem: 'Un liderazgo rectoral más pedagógico priorizaría:',
      options: [
        'Solo vigilancia de pasillos y sanciones',
        'Acompañar aulas, analizar evidencias de aprendizaje y apoyar planes de mejoramiento docente',
        'Eliminar el SIEE para reducir carga',
        'Delegar toda la pedagogía a las familias',
      ],
      correctIndex: 1,
      explanation:
          'La gestión directiva debe velar por la calidad del servicio educativo '
          '(Ley 115, D.1860, D.1278).',
      normativeJustification:
          'La gestión directiva debe velar por la calidad del servicio educativo '
          '(Ley 115, D.1860, D.1278).',
      theoreticalJustification:
          'El liderazgo pedagógico mejora resultados cuando se centra en la enseñanza y el aprendizaje.',
      distractorAnalysis: {
        0: 'La convivencia importa, pero no sustituye el foco de aprendizaje.',
        2: 'El SIEE es obligatorio y orientador.',
        3: 'Las familias no reemplazan la gestión pedagógica institucional.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1278, articleOrFocus: 'calidad del servicio'),
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'gestión'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-10',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / Consejo Académico',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Decreto 1860',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Se cambia el plan de estudios de un área por decisión unilateral del rector, '
          'sin Consejo Académico ni socialización docente.',
      stem: 'Lo más coherente con el gobierno escolar es:',
      options: [
        'Validar el cambio unilateral por agilidad',
        'Someter el ajuste al Consejo Académico y socializar criterios pedagógicos con el equipo',
        'Consultar solo a un influencer educativo',
        "Ignorar el plan de estudios porque 'cada docente hace lo suyo'",
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1860 organiza instancias (entre ellas el Consejo Académico) '
          'para decisiones curriculares institucionales.',
      normativeJustification:
          'El Decreto 1860 organiza instancias (entre ellas el Consejo Académico) '
          'para decisiones curriculares institucionales.',
      theoreticalJustification:
          'Los cambios curriculares requieren deliberación pedagógica para coherencia y apropiación.',
      distractorAnalysis: {
        0: 'La agilidad no justifica saltarse la instancia académica.',
        2: 'Las modas externas no sustituyen el órgano institucional.',
        3: 'La atomización rompe el proyecto curricular común.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'Consejo Académico'),
        KnowledgeTag(code: KnowledgeCode.lineamientos, articleOrFocus: 'plan de estudios'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-11',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / promoción y apoyo',
      module: ContentModule.pedagogiaEvaluacion,
      subtopic: 'Decreto 1290',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Al final del año, varios estudiantes con bajo desempeño no tuvieron planes de apoyo; '
          "la rectoría quiere negar promoción masivamente 'para subir estándares'.",
      stem: 'Según el Decreto 1290, la postura más sólida es:',
      options: [
        'Negar promoción sin evidencias de acompañamiento previo',
        'Exigir que haya habido estrategias de apoyo y seguimiento antes de decidir promoción',
        'Promover a todos automáticamente sin criterios',
        'Evaluar solo con una prueba externa de un día',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1290 vincula evaluación, seguimiento y estrategias de apoyo al proceso de promoción.',
      normativeJustification:
          'El Decreto 1290 vincula evaluación, seguimiento y estrategias de apoyo al proceso de promoción.',
      theoreticalJustification:
          'La exigencia académica es legítima cuando va acompañada de acompañamiento pedagógico, '
          'no solo de corte punitivo final.',
      distractorAnalysis: {
        0: 'Omite el deber de apoyo durante el proceso.',
        2: 'La promoción sin criterios no es el estándar del 1290.',
        3: 'Una sola prueba no agota la evaluación integral.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1290, articleOrFocus: 'promoción y apoyo'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-12',
      pillar: CompetencyPillar.comportamental,
      topic: 'Rectoría / clima laboral',
      module: ContentModule.comportamental,
      subtopic: 'Liderazgo situacional',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Dos docentes discuten fuerte en un corredor lleno de estudiantes. '
          'El tono escala y hay público.',
      stem: 'La intervención rectoral más profesional es:',
      options: [
        "Confrontarlos en público para 'dar ejemplo'",
        'Contener, separar del escenario público, restablecer clima y abrir un espacio privado de mediación con acuerdos',
        "Ignorar el conflicto porque 'son adultos'",
        'Sancionar a ambos sin escuchar versiones',
      ],
      correctIndex: 1,
      explanation:
          'El liderazgo directivo debe proteger el clima institucional y el debido proceso '
          'en conflictos laborales/pedagógicos.',
      normativeJustification:
          'El liderazgo directivo debe proteger el clima institucional y el debido proceso '
          'en conflictos laborales/pedagógicos.',
      theoreticalJustification:
          'La contención pública y la mediación privada reducen daño al clima y permiten acuerdos sostenibles.',
      distractorAnalysis: {
        0: 'La confrontación pública refuerza el espectáculo del conflicto.',
        2: 'Omitir puede normalizar violencia simbólica ante estudiantes.',
        3: 'Sancionar sin escuchar vulnera debido proceso.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1278, articleOrFocus: 'clima y liderazgo'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-13',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / rutas de riesgo',
      module: ContentModule.inclusionConvivencia,
      subtopic: 'Ley 1620',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'Familias desconocen cómo reportar una situación de riesgo; '
          'solo existe un chat informal del rector.',
      stem: 'La mejora institucional correcta es:',
      options: [
        'Mantener solo el WhatsApp del rector como canal único',
        'Socializar canales formales, protocolos y roles del Comité de Convivencia con trazabilidad',
        'Prohibir reportes de familias',
        "Publicar rumores en redes para 'investigar en comunidad'",
      ],
      correctIndex: 1,
      explanation:
          'Ley 1620 y Guías MEN orientan rutas claras, accesibles y con registro institucional.',
      normativeJustification:
          'Ley 1620 y Guías MEN orientan rutas claras, accesibles y con registro institucional.',
      theoreticalJustification:
          'Canales formales reducen re-victimización y dependencia de una sola persona.',
      distractorAnalysis: {
        0: 'Un chat personal no garantiza trazabilidad ni continuidad.',
        2: 'Las familias son parte de la ruta de protección.',
        3: 'Investigar por redes vulnera derechos y sesga el proceso.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley1620, articleOrFocus: 'canales de reporte'),
        KnowledgeTag(code: KnowledgeCode.guiaMen49, articleOrFocus: 'protocolo'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-14',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / gobierno escolar activo',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Decreto 1860',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'El gobierno escolar no se reunió en el año; las decisiones de impacto se improvisan.',
      stem: 'La acción rectoral prioritaria es:',
      options: [
        "Centralizar todo en rectoría 'para no perder tiempo'",
        'Reactivar calendarios, convocatorias, quórums y actas de las instancias del gobierno escolar',
        'Sustituir instancias por encuestas anónimas en redes',
        'Esperar a que supervisión nombre los órganos',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1860 organiza el gobierno escolar; su funcionamiento periódico '
          'es parte de la gestión institucional.',
      normativeJustification:
          'El Decreto 1860 organiza el gobierno escolar; su funcionamiento periódico '
          'es parte de la gestión institucional.',
      theoreticalJustification:
          'Sin instancias activas no hay participación real ni memoria institucional de decisiones.',
      distractorAnalysis: {
        0: 'La centralización excesiva debilita legitimidad y control.',
        2: 'Las redes no reemplazan órganos estatutarios.',
        3: 'La reactivación es deber institucional, no solo de supervisión.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'gobierno escolar'),
        KnowledgeTag(code: KnowledgeCode.ley115, articleOrFocus: 'participación'),
      ],
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-15',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Rectoría / calidad curricular',
      module: ContentModule.curriculumReferentes,
      subtopic: 'DBA / EBC / lineamientos',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          "Docentes enseñan 'lo que alcanza el libro' sin articulación a DBA/EBC "
          'ni seguimiento institucional.',
      stem: 'El liderazgo rectoral más pertinente es:',
      options: [
        'Prohibir cualquier libro de texto',
        'Orientar planeación y seguimiento con referentes MEN (DBA/EBC/lineamientos) y evidencias de aprendizaje',
        'Imponer un único cuadernillo nacional sin contexto',
        'Dejar el currículo solo a la preferencia individual de cada docente',
      ],
      correctIndex: 1,
      explanation:
          'Los referentes de calidad MEN orientan el currículo; la gestión institucional '
          'debe monitorear su apropiación.',
      normativeJustification:
          'Los referentes de calidad MEN orientan el currículo; la gestión institucional '
          'debe monitorear su apropiación.',
      theoreticalJustification:
          'El libro es un medio; el norte son aprendizajes esenciales con seguimiento colegiado.',
      distractorAnalysis: {
        0: 'El problema no es el libro, sino la falta de norte curricular.',
        2: 'La imposición descontextualizada ignora el PEI y el contexto.',
        3: 'La atomización rompe coherencia institucional.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.dba, articleOrFocus: 'planeación'),
        KnowledgeTag(code: KnowledgeCode.ebc, articleOrFocus: 'competencias'),
        KnowledgeTag(code: KnowledgeCode.lineamientos, articleOrFocus: 'currículo'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'oro-rect-16',
      pillar: CompetencyPillar.comportamental,
      topic: 'Rectoría / comunicación con familias',
      module: ContentModule.comportamental,
      subtopic: 'Clima institucional',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'En reunión de padres, una familia acusa públicamente a un docente con tono agresivo. '
          'Hay estudiantes presentes.',
      stem: 'La respuesta rectoral más adecuada es:',
      options: [
        "Dejar que el debate escale en público 'para transparencia'",
        'Contener el espacio, proteger la dignidad de las partes y abrir un canal privado con debido proceso',
        'Expulsar a la familia del colegio en el acto sin procedimiento',
        'Ridiculizar a la familia para defender al docente',
      ],
      correctIndex: 1,
      explanation:
          'El liderazgo institucional debe garantizar respeto, debido proceso y canales formales de reclamación.',
      normativeJustification:
          'El liderazgo institucional debe garantizar respeto, debido proceso y canales formales de reclamación.',
      theoreticalJustification:
          'La contención pública y el proceso privado protegen clima, derechos y posibilidad de solución.',
      distractorAnalysis: {
        0: 'El espectáculo público daña clima y puede revictimizar.',
        2: 'Sanciones inmediatas sin proceso son arbitrarias.',
        3: 'La ridiculización escala el conflicto y modela violencia.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley1620, articleOrFocus: 'clima y respeto'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
  ];
}
