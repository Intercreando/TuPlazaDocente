import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Banco "estándar oro": norma + teoría + análisis de distractores.
abstract final class GoldBrainBank {
  static const List<Question> items = [
    Question(
      id: 'gold-ped-001',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Evaluación formativa',
      module: ContentModule.pedagogiaEvaluacion,
      subtopic: 'Decreto 1290 / Vygotsky',
      targetCargo: Especialidad.primaria,
      specialtyTags: [Especialidad.primaria],
      caseContext:
          'Un docente de 3° nota que un estudiante no logra resolver problemas '
          'de suma con llevadas de manera independiente, pero al trabajar en '
          'parejas con un compañero más avanzado, comprende el procedimiento rápidamente.',
      stem:
          'Teniendo en cuenta las teorías del aprendizaje y la normativa de evaluación, '
          'la estrategia pedagógica más adecuada para acompañar a este estudiante es:',
      options: [
        'Asignarle guías individuales de repaso para la casa para nivelar sus falencias.',
        'Diseñar actividades de trabajo colaborativo que aprovechen la Zona de Desarrollo Próximo para andamiar su proceso.',
        'Repetir la explicación magistral frente a todo el grupo hasta que el estudiante memorice el algoritmo.',
        'Sancionar el trabajo en parejas para garantizar que la evaluación sea estrictamente individual.',
      ],
      correctIndex: 1,
      explanation:
          'La mejor opción articula Decreto 1290 (evaluación formativa centrada en el estudiante) '
          'con Vygotsky (ZDP y andamiaje entre pares).',
      normativeJustification:
          'El Decreto 1290 establece que la evaluación debe identificar características, '
          'intereses y ritmos del estudiante para consolidar aprendizajes (enfoque formativo), '
          'no solo certificar resultados individuales aislados.',
      theoreticalJustification:
          'Según Vygotsky, en la Zona de Desarrollo Próximo el estudiante alcanza un nivel '
          'potencial con mediación/andamiaje de un par más capaz. El trabajo colaborativo '
          'diseñado con intención pedagógica materializa esa mediación.',
      distractorAnalysis: {
        0: 'El repaso individual en casa ignora la evidencia de que el avance ocurre con mediación social.',
        2: 'La explicación magistral reiterada privilegia memorización y no el andamiaje situado.',
        3: 'Prohibir el trabajo en parejas contradice el aprovechamiento pedagógico de la ZDP.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1290, articleOrFocus: 'evaluación formativa'),
        KnowledgeTag(code: KnowledgeCode.vygotsky, articleOrFocus: 'ZDP y andamiaje'),
      ],
      normativeRefs: ['Decreto 1290 de 2009', 'Vygotsky — ZDP'],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
      recommendedSeconds: 100,
    ),
    Question(
      id: 'gold-ped-002',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Inclusión',
      module: ContentModule.inclusionConvivencia,
      subtopic: 'Decreto 1421 / PIAR',
      targetCargo: Especialidad.primaria,
      specialtyTags: [Especialidad.primaria, Especialidad.preescolar],
      caseContext:
          'Una estudiante con discapacidad visual ingresa a 4°. El grupo usa guías impresas densas '
          'y evaluaciones cronometradas idénticas para todos.',
      stem:
          'De acuerdo con el marco de educación inclusiva, la decisión más adecuada es:',
      options: [
        'Eximirla de todas las evaluaciones del periodo.',
        'Diseñar PIAR y ajustes razonables en materiales, tiempo y forma de demostrar el aprendizaje esencial.',
        'Trasladarla a otra institución “mejor preparada” sin plan.',
        'Evaluarla solo de forma oral improvisada, sin criterios previos.',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1421 orienta PIAR y ajustes razonables manteniendo expectativas esenciales.',
      normativeJustification:
          'El Decreto 1421 de 2017 exige atención educativa a estudiantes con discapacidad '
          'mediante PIAR y ajustes razonables que garanticen participación y aprendizaje, '
          'sin eliminar el derecho a ser evaluado con criterios claros.',
      theoreticalJustification:
          'Desde un enfoque de diseño universal y mediación, se adaptan condiciones de acceso '
          'y demostración del aprendizaje, no se rebaja arbitrariamente la meta esencial.',
      distractorAnalysis: {
        0: 'Eximir de toda evaluación vulnera el derecho a aprender y ser valorado con equidad.',
        2: 'El traslado sin plan no resuelve la obligación de inclusión en la institución.',
        3: 'Evaluar sin criterios previos impide retroalimentación formativa y transparencia.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.decreto1421, articleOrFocus: 'PIAR y ajustes razonables'),
        KnowledgeTag(code: KnowledgeCode.decreto1290, articleOrFocus: 'evaluación con criterios'),
      ],
      normativeRefs: ['Decreto 1421 de 2017', 'Decreto 1290 de 2009'],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'gold-ped-003',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Aprendizaje significativo',
      module: ContentModule.pedagogiaEvaluacion,
      subtopic: 'Ausubel / DBA',
      targetCargo: Especialidad.matematicas,
      specialtyTags: [Especialidad.matematicas, Especialidad.primaria],
      caseContext:
          'Antes de introducir fracciones equivalentes, el docente indaga qué saben los estudiantes '
          'sobre repartir y comparar partes de un todo con material concreto.',
      stem:
          'Esta práctica se alinea principalmente con:',
      options: [
        'Castigo del error y memorización del algoritmo.',
        'Aprendizaje significativo (Ausubel) articulando saberes previos con el nuevo contenido y referentes DBA.',
        'Solo exposición magistral sin activar conocimientos previos.',
        'Evaluación sumativa exclusiva al final del año.',
      ],
      correctIndex: 1,
      explanation:
          'Ausubel: anclar en saberes previos. Los DBA orientan la progresión esperada del aprendizaje.',
      normativeJustification:
          'Los DBA y EBC del MEN definen progresiones de lo que el estudiante debe saber y saber hacer; '
          'partir de saberes previos hace viable esa progresión.',
      theoreticalJustification:
          'Ausubel plantea que el aprendizaje es significativo cuando el nuevo contenido se relaciona '
          'de forma no arbitraria con la estructura cognitiva previa del estudiante.',
      distractorAnalysis: {
        0: 'Memorizar el algoritmo sin sentido produce aprendizaje mecánico, no significativo.',
        2: 'Omitir saberes previos dificulta la anclaje del nuevo concepto.',
        3: 'La evaluación solo sumativa no guía la enseñanza en el proceso.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ausubel, articleOrFocus: 'saberes previos'),
        KnowledgeTag(code: KnowledgeCode.dba, articleOrFocus: 'progresión de aprendizajes'),
        KnowledgeTag(code: KnowledgeCode.ebc, articleOrFocus: 'saber y saber hacer'),
      ],
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
    ),
    Question(
      id: 'gold-ped-004',
      pillar: CompetencyPillar.pedagogico,
      topic: 'PEI y gobierno escolar',
      module: ContentModule.gestionInstitucional,
      subtopic: 'Decreto 1860 / Ley 115',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],
      caseContext:
          'La rectoría actualiza el PEI en una semana, sin participación de docentes, familias ni estudiantes, '
          'para “cumplir un requerimiento de supervisión”.',
      stem:
          'La lectura más coherente con la norma es:',
      options: [
        'Es válido porque el PEI es un trámite exclusivo de rectoría.',
        'Debilita la legitimidad del PEI, que debe construirse con la comunidad educativa (Ley 115 / D.1860).',
        'Solo importa el PMI, el PEI es opcional.',
        'La supervisión puede reemplazar al gobierno escolar.',
      ],
      correctIndex: 1,
      explanation:
          'El PEI expresa identidad institucional y se construye con participación de la comunidad educativa.',
      normativeJustification:
          'La Ley 115 y el Decreto 1860 conciben el PEI y el gobierno escolar como construcción '
          'participativa de la comunidad educativa, no como documento unilateral.',
      theoreticalJustification:
          'La apropiación institucional requiere sentido compartido; sin participación, el documento '
          'no orienta prácticas reales de aula ni de gestión.',
      distractorAnalysis: {
        0: 'El PEI no es trámite exclusivo de un cargo; articula el proyecto colectivo.',
        2: 'PMI y PEI se relacionan, pero el PEI no es opcional ni prescindible.',
        3: 'La supervisión no sustituye la participación del gobierno escolar.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley115, articleOrFocus: 'PEI'),
        KnowledgeTag(code: KnowledgeCode.decreto1860, articleOrFocus: 'gobierno escolar'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'gold-ped-005',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Convivencia escolar',
      module: ContentModule.inclusionConvivencia,
      subtopic: 'Ley 1620 / Guía MEN 51',
      specialtyTags: [Especialidad.primaria, Especialidad.directivos],
      caseContext:
          'Un estudiante de 8° reporta acoso reiterado en el descanso y en un grupo de WhatsApp. '
          'Hay testigos; el agresor niega los hechos.',
      stem:
          'El primer curso de acción institucional correcto es:',
      options: [
        'Publicar el caso en redes del colegio para generar “escarmiento”.',
        'Activar la ruta del Manual de Convivencia y el Comité de Convivencia Escolar con debido proceso.',
        'Suspender sin investigación ni registro.',
        'Ignorar el reporte si no hay prueba física inmediata.',
      ],
      correctIndex: 1,
      explanation:
          'Ley 1620 y su desarrollo exigen rutas de atención, debido proceso y seguimiento.',
      normativeJustification:
          'La Ley 1620 y las orientaciones de convivencia escolar establecen rutas de atención, '
          'registro, seguimiento y rol del Comité de Convivencia, con protección a las partes.',
      theoreticalJustification:
          'Una respuesta formativa e institucional restaura clima escolar y evita la revictimización '
          'o el castigo espectáculo sin debido proceso.',
      distractorAnalysis: {
        0: 'La exposición pública vulnera derechos y no constituye ruta institucional.',
        2: 'Sancionar sin investigación viola debido proceso.',
        3: 'La ausencia de “prueba física” no habilita la omisión ante un reporte.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.ley1620, articleOrFocus: 'rutas de atención'),
        KnowledgeTag(code: KnowledgeCode.guiaMen51, articleOrFocus: 'convivencia escolar'),
      ],
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
    ),
    Question(
      id: 'gold-ped-006',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Desarrollo cognitivo',
      module: ContentModule.pedagogiaEvaluacion,
      subtopic: 'Piaget / educación inicial',
      targetCargo: Especialidad.preescolar,
      specialtyTags: [Especialidad.preescolar],
      caseContext:
          'En el grado jardín, los niños exploran cantidades con bloques y juego simbólico. '
          'Una familia exige hojas de algoritmos “para adelantar primero”.',
      stem:
          'La respuesta pedagógica más coherente es:',
      options: [
        'Sustituir el juego por planas numéricas diarias.',
        'Sostener experiencias concretas y juego como base del pensamiento, alineadas al desarrollo y a la educación inicial.',
        'Evaluar solo con exámenes escritos estandarizados.',
        'Ignorar el desarrollo cognitivo y homogeneizar actividades de primaria.',
      ],
      correctIndex: 1,
      explanation:
          'Piaget y la educación inicial priorizan acción y representación antes de la formalización abstracta.',
      normativeJustification:
          'Las orientaciones de educación inicial del MEN privilegian el juego, la exploración y el '
          'desarrollo integral, no la escolarización temprana con lógica de primaria.',
      theoreticalJustification:
          'Piaget muestra que el pensamiento se construye por estadios mediante acción sobre el medio; '
          'forzar algoritmos abstractos prematuros suele producir aprendizaje mecánico.',
      distractorAnalysis: {
        0: 'Reemplazar juego por planas desconoce el medio privilegiado de aprendizaje en inicial.',
        2: 'Exámenes escritos estandarizados no son el foco de evaluación en primera infancia.',
        3: 'Homogeneizar con primaria ignora el desarrollo y los referentes de inicial.',
      },
      knowledgeTags: [
        KnowledgeTag(code: KnowledgeCode.piaget, articleOrFocus: 'estadios y acción'),
        KnowledgeTag(code: KnowledgeCode.guiaMen50, articleOrFocus: 'educación inicial'),
      ],
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
    ),
  ];
}
