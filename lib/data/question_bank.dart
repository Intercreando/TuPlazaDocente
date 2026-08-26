import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';
import 'calibrated_bank.dart';
import 'ciencias_brain_bank.dart';
import 'directivo_aptitudes_bank.dart';
import 'extra_questions.dart';
import 'gold_brain_bank.dart';
import 'rector_brain_bank.dart';
import 'sociales_brain_bank.dart';
import 'specialty_questions.dart';

/// Banco calibrado al estilo CNSC/ICFES (local + remoto/asset).
abstract final class QuestionBank {
  static List<Question> _remote = const [];

  static List<Question> get _localBundle => [
    ...GoldBrainBank.items,
    ...RectorBrainBank.items,
    ...DirectivoAptitudesBank.items,
    ...CienciasBrainBank.items,
    ...SocialesBrainBank.items,
    ..._items,
    ...ExtraQuestions.items,
    ...SpecialtyQuestions.items,
    ...CalibratedBank.items,
  ];

  /// Preferencia: remoto/asset si existe; si no, bundle local.
  static List<Question> get all {
    if (_remote.isNotEmpty) {
      final localIds = _remote.map((q) => q.id).toSet();
      final extras = _localBundle
          .where((q) => !localIds.contains(q.id))
          .toList();
      return List.unmodifiable([..._remote, ...extras]);
    }
    return List.unmodifiable(_localBundle);
  }

  static void replaceRemote(List<Question> items) {
    _remote = List.unmodifiable(items);
  }

  static void clearRemote() {
    _remote = const [];
  }

  static int get remoteCount => _remote.length;

  static List<Question> byPillar(CompetencyPillar pillar) =>
      all.where((q) => q.pillar == pillar).toList();

  static List<Question> caseStudies() =>
      all.where((q) => q.isCaseStudy).toList();

  static List<Question> dailySet({int count = 5}) {
    final shuffled = [...all]..shuffle();
    return shuffled.take(count).toList();
  }

  static List<Question> diagnosticSet({
    int count = 20,
    Especialidad? specialty,
  }) {
    if (specialty != null) {
      final focused = [...bySpecialty(specialty)]..shuffle();
      final mixed = [...all]..shuffle();
      final selected = <Question>[];
      final seen = <String>{};
      void takeFrom(List<Question> source, int n) {
        for (final q in source) {
          if (selected.length >= n) break;
          if (seen.add(q.id)) selected.add(q);
        }
      }

      final focusQuota = (count * 0.6).round().clamp(8, count);
      takeFrom(focused, focusQuota);
      takeFrom(mixed, count);
      return selected.take(count).toList();
    }

    final perPillar = (count / CompetencyPillar.values.length).ceil();
    final selected = <Question>[];
    for (final pillar in CompetencyPillar.values) {
      selected.addAll(byPillar(pillar).take(perPillar));
    }
    return selected.take(count).toList();
  }

  static List<Question> bySpecialty(Especialidad specialty) {
    final exactas = all
        .where((q) => q.specialtyTags.contains(specialty))
        .toList();
    if (exactas.isNotEmpty) return exactas;
    final familia = specialty.especialidadDeBanco;
    if (familia != null && familia != specialty) {
      final relacionadas = all
          .where((q) => q.specialtyTags.contains(familia))
          .toList();
      if (relacionadas.isNotEmpty) return relacionadas;
    }
    return byPillar(CompetencyPillar.pedagogico);
  }

  static List<Question> byDifficultyLevel(int level) =>
      all.where((q) => q.dificultad == level).toList();

  static List<Question> forSession({
    required SessionMode mode,
    CompetencyPillar? pillar,
    Especialidad? specialty,
    int count = 10,
    bool casesOnly = false,
    int? difficultyLevel,
    int? minDifficultyLevel,
    KnowledgeCode? knowledgeCode,
  }) {
    if (mode == SessionMode.dailyStreak) return dailySet();
    if (mode == SessionMode.diagnostic) {
      return diagnosticSet(count: count, specialty: specialty);
    }

    // Reto rápido: solo nivel 1 (~45s por ítem).
    if (mode == SessionMode.speedBattle) {
      var fast = byDifficultyLevel(1);
      if (fast.isEmpty) fast = [...all];
      final shuffled = [...fast]..shuffle();
      return shuffled.take(30.clamp(1, shuffled.length)).toList();
    }

    var source = casesOnly
        ? caseStudies()
        : specialty != null
        ? bySpecialty(specialty)
        : pillar == null
        ? all
        : byPillar(pillar);

    // Casos de aula con perfil de gestión: prioriza escenarios directivos/rectoría.
    if (casesOnly && specialty != null) {
      final focused = source
          .where((q) => q.specialtyTags.contains(specialty))
          .toList();
      if (focused.isNotEmpty) {
        source = focused;
      } else {
        final familia = specialty.especialidadDeBanco;
        if (familia != null) {
          final relacionadas = source
              .where((q) => q.specialtyTags.contains(familia))
              .toList();
          if (relacionadas.isNotEmpty) source = relacionadas;
        }
      }
    }

    if (knowledgeCode != null) {
      final tagged = source
          .where((q) => q.knowledgeTags.any((tag) => tag.code == knowledgeCode))
          .toList();
      if (tagged.isNotEmpty) {
        source = tagged;
      } else {
        final fromAll = all
            .where(
              (q) => q.knowledgeTags.any((tag) => tag.code == knowledgeCode),
            )
            .toList();
        if (fromAll.isNotEmpty) source = fromAll;
      }
    }

    if (difficultyLevel != null) {
      final exact = source
          .where((q) => q.dificultad == difficultyLevel)
          .toList();
      if (exact.isNotEmpty) {
        source = exact;
      } else {
        source = _preferHardest(source, minLevel: difficultyLevel);
      }
    } else if (minDifficultyLevel != null) {
      source = _preferHardest(source, minLevel: minDifficultyLevel);
    }

    if (source.isEmpty) {
      source = minDifficultyLevel != null || difficultyLevel != null
          ? _preferHardest(
              all,
              minLevel: minDifficultyLevel ?? difficultyLevel ?? 3,
            )
          : all;
    }
    final shuffled = [...source]..shuffle();
    return shuffled.take(count.clamp(1, shuffled.length)).toList();
  }

  /// Prioriza nivel 3; si no alcanza, llena con nivel 2. Nunca con rápidas (1).
  static List<Question> _preferHardest(
    List<Question> pool, {
    required int minLevel,
  }) {
    if (pool.isEmpty) return pool;
    final hard = pool.where((q) => q.dificultad >= minLevel).toList();
    if (hard.isNotEmpty) return hard;

    final floor = minLevel > 2 ? 2 : minLevel;
    final mid = pool.where((q) => q.dificultad >= floor).toList();
    if (mid.isNotEmpty) return mid;

    var maxLevel = 0;
    for (final q in pool) {
      if (q.dificultad > maxLevel) maxLevel = q.dificultad;
    }
    return pool.where((q) => q.dificultad == maxLevel).toList();
  }

  static final List<Question> _items = [
    // —— Aptitud Numérica ——
    Question(
      id: 'num-01',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Porcentajes',
      stem:
          'Un colegio reduce en 20% el tiempo de una jornada de 6 horas para un simulacro. '
          '¿Cuántos minutos dura la jornada resultante?',
      options: ['240 minutos', '288 minutos', '300 minutos', '320 minutos'],
      correctIndex: 1,
      explanation:
          'El 20% de 6 horas (360 min) es 72 min. 360 − 72 = 288 minutos. '
          'En prueba sin calculadora, convierte primero a minutos y aplica la resta del porcentaje.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'num-02',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Regla de tres',
      stem:
          'Si 8 docentes elaboran 40 rúbricas en 5 días, ¿cuántas rúbricas elaborarán '
          '12 docentes en 5 días, a igual ritmo?',
      options: ['48', '50', '60', '72'],
      correctIndex: 2,
      explanation:
          'La proporción es directa con el número de docentes: '
          '(40/8) × 12 = 5 × 12 = 60. El tiempo se mantiene constante.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'num-03',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Lógica matemática',
      stem:
          'La secuencia de puntajes de un grupo es 12, 15, 21, 33, 57… ¿Cuál sigue?',
      options: ['87', '93', '99', '105'],
      correctIndex: 3,
      explanation:
          'Las diferencias entre términos son +3, +6, +12, +24: cada incremento '
          'duplica al anterior. El siguiente incremento es 24×2 = 48; '
          'por tanto 57 + 48 = 105.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'num-04',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Promedios',
      stem:
          'Cinco estudiantes obtienen 3.2, 3.8, 4.0, 2.9 y 4.1. '
          'Si se elimina el menor puntaje, ¿cuál es el nuevo promedio aproximado?',
      options: ['3.50', '3.68', '3.78', '3.90'],
      correctIndex: 2,
      explanation:
          'Se elimina 2.9. Suma restante: 3.2+3.8+4.0+4.1 = 15.1; 15.1/4 = 3.775 ≈ 3.78.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'num-05',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Proporciones',
      stem:
          'En una institución, la razón estudiantes:docentes es 28:1. '
          'Si hay 36 docentes, ¿cuántos estudiantes hay?',
      options: ['864', '980', '1008', '1120'],
      correctIndex: 2,
      explanation:
          '28 × 36 = 1008. Multiplica el término de la razón por la cantidad dada.',
      difficulty: QuestionDifficulty.basico,
    ),

    // —— Lectura Crítica ——
    Question(
      id: 'lec-01',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Premisas',
      stem:
          '“Solo si se garantiza la participación de las familias, el PEI será legítimo. '
          'El PEI de la institución X no involucró a las familias. Por tanto, no es legítimo.” '
          '¿Qué tipo de razonamiento predomina?',
      options: [
        'Inducción por analogía',
        'Deducción modus tollens',
        'Falacia de autoridad',
        'Generalización apresurada',
      ],
      correctIndex: 1,
      explanation:
          'La estructura es: si P entonces Q; no Q; luego no P (modus tollens). '
          'Identificar conectores condicionales es clave en lectura argumentativa.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'lec-02',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Conectores',
      stem:
          'En el fragmento: “La evaluación formativa retroalimenta el proceso; no obstante, '
          'muchas instituciones la reducen a notas parciales.” ¿Qué función cumple “no obstante”?',
      options: [
        'Adición de ejemplos',
        'Causa-efecto',
        'Contraste u oposición',
        'Temporalidad secuencial',
      ],
      correctIndex: 2,
      explanation:
          '“No obstante” introduce una idea que matiza o se opone a la anterior: contraste.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'lec-03',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Idea principal',
      stem:
          'Un texto sostiene que la inclusión no se agota en el acceso físico al aula, '
          'sino que exige ajustes razonables en evaluación y convivencia. '
          '¿Cuál es la idea principal?',
      options: [
        'La inclusión es solo infraestructura',
        'La inclusión exige transformar prácticas pedagógicas',
        'La evaluación debe ser homogénea para todos',
        'La convivencia es independiente del currículo',
      ],
      correctIndex: 1,
      explanation:
          'La tesis central amplía la inclusión más allá del acceso: implica cambios en evaluación y convivencia.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'lec-04',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Inferencia',
      stem:
          '“Los docentes que planifican con evidencia de aprendizaje reducen la improvisación '
          'y elevan la coherencia curricular.” Se puede inferir que:',
      options: [
        'La improvisación siempre es indeseable',
        'Planificar con evidencia favorece coherencia',
        'El currículo no requiere evidencia',
        'Solo los directivos deben planificar',
      ],
      correctIndex: 1,
      explanation:
          'La inferencia válida se limita a lo sustentado: evidencia en la planificación → mayor coherencia.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'lec-05',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Supuestos',
      stem:
          'Un autor afirma: “Sin liderazgo pedagógico, no hay mejora escolar sostenible.” '
          '¿Qué supuesto está implícito?',
      options: [
        'La mejora depende solo de recursos',
        'El liderazgo pedagógico influye en la sostenibilidad del cambio',
        'Los docentes no necesitan acompañamiento',
        'Las pruebas externas miden liderazgo',
      ],
      correctIndex: 1,
      explanation:
          'El enunciado asume una relación causal entre liderazgo pedagógico y sostenibilidad de la mejora.',
      difficulty: QuestionDifficulty.avanzado,
    ),

    // —— Pedagógico ——
    Question(
      id: 'ped-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Evaluación formativa',
      stem:
          'Una docente usa rúbricas compartidas con estudiantes antes de una producción escrita '
          'y ajusta la secuencia según los avances. ¿Qué enfoque predomina?',
      options: [
        'Evaluación sumativa exclusiva',
        'Evaluación formativa orientada al aprendizaje',
        'Promoción automática sin criterios',
        'Homologación externa de resultados',
      ],
      correctIndex: 1,
      explanation:
          'Compartir criterios y ajustar la enseñanza con evidencia en proceso es evaluación formativa '
          '(Decreto 1290: la evaluación como parte del proceso formativo).',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: const ['Decreto 1290 de 2009'],
      specialtyTags: const [Especialidad.primaria, Especialidad.lenguaje],
    ),
    Question(
      id: 'ped-02',
      pillar: CompetencyPillar.pedagogico,
      topic: 'PEI',
      stem: 'Según la Ley 115, el Proyecto Educativo Institucional debe:',
      options: [
        'Ser un documento exclusivo de la secretaría de educación',
        'Orientar la identidad, objetivos y organización de la institución con participación de la comunidad',
        'Reemplazar el currículo nacional en todas las áreas',
        'Definir únicamente el calendario de evaluaciones externas',
      ],
      correctIndex: 1,
      explanation:
          'El PEI expresa la identidad institucional y se construye con participación de la comunidad educativa (Ley 115).',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: const ['Ley 115 de 1994'],
    ),
    Question(
      id: 'ped-03',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Inclusión',
      stem:
          'Un estudiante con discapacidad visual requiere material en braille y mayor tiempo en evaluaciones. '
          'La respuesta pedagógica más coherente es:',
      options: [
        'Eximirlo de todas las evaluaciones',
        'Aplicar ajustes razonables sin bajar la expectativa de aprendizaje esencial',
        'Separarlo permanentemente del grupo',
        'Evaluarlo solo de forma oral sin criterios previos',
      ],
      correctIndex: 1,
      explanation:
          'La inclusión implica ajustes razonables (acceso y participación) manteniendo metas esenciales de aprendizaje.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: const [Especialidad.primaria, Especialidad.preescolar],
    ),
    Question(
      id: 'ped-04',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem:
          '¿Cuál debe ser el primer paso institucional ante un reporte de acoso escolar reiterado?',
      options: [
        'Publicar el caso en redes del colegio',
        'Activar el protocolo del Manual de Convivencia y el Comité de Convivencia Escolar',
        'Suspender de inmediato sin debido proceso',
        'Ignorar el reporte si no hay pruebas físicas',
      ],
      correctIndex: 1,
      explanation:
          'La Ley 1620 y su decreto reglamentario exigen rutas de atención, debido proceso y rol del Comité de Convivencia.',
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
      caseContext:
          'Un estudiante de grado 8° reporta burlas reiteradas en redes y en el descanso. '
          'Hay testigos, pero el agresor niega los hechos.',
      normativeRefs: const ['Ley 1620 de 2013', 'Manual de Convivencia'],
    ),
    Question(
      id: 'ped-05',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Currículo',
      stem: 'La coherencia vertical del currículo se evidencia cuando:',
      options: [
        'Cada grado ignora los aprendizajes previos',
        'Los aprendizajes se articulan progresivamente entre grados y ciclos',
        'Solo se enseñan contenidos de la prueba externa',
        'El plan de área cambia cada semana sin criterios',
      ],
      correctIndex: 1,
      explanation:
          'La coherencia vertical organiza la progresión de aprendizajes a lo largo de la trayectoria escolar.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'ped-06',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem:
          'En una clase de matemáticas, varios estudiantes no logran el objetivo. '
          'La decisión más alineada con evaluación formativa es:',
      options: [
        'Pasar al siguiente tema para cumplir el plan',
        'Reenseñar con otra estrategia y evidencias de progreso',
        'Bajar la nota de todo el grupo por igual',
        'Eliminar el objetivo del periodo',
      ],
      correctIndex: 1,
      explanation:
          'La evaluación formativa usa evidencia para ajustar la enseñanza: reenseñar con estrategias alternativas.',
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
      caseContext:
          'Tras una guía de fracciones, el 60% del grupo confunde equivalencias. Quedan dos semanas del periodo.',
      specialtyTags: const [Especialidad.matematicas, Especialidad.primaria],
    ),

    // —— Comportamental ——
    Question(
      id: 'com-01',
      pillar: CompetencyPillar.comportamental,
      topic: 'Trabajo en equipo',
      stem:
          'En una reunión de área hay desacuerdo fuerte sobre criterios de evaluación. '
          'La conducta más alineada al perfil del servicio público es:',
      options: [
        'Imponer la postura propia sin escuchar',
        'Facilitar acuerdos basados en evidencias y normas institucionales',
        'Aplazar indefinidamente la decisión',
        'Delegar el conflicto a los estudiantes',
      ],
      correctIndex: 1,
      explanation:
          'Se valora orientación al logro colectivo, escucha activa y decisiones basadas en criterios institucionales.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'com-02',
      pillar: CompetencyPillar.comportamental,
      topic: 'Resolución de conflictos',
      stem:
          'Dos colegas discuten frente a estudiantes. Como compañero, ¿qué acción es más adecuada?',
      options: [
        'Escalárlo en el chat del grupo de padres',
        'Intervenir con calma, sugerir continuar en espacio privado y preservar el clima escolar',
        'Tomar partido públicamente',
        'Grabar la discusión como evidencia',
      ],
      correctIndex: 1,
      explanation:
          'El perfil comportamental prioriza autocontrol, cuidado del clima escolar y canales institucionales.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'com-03',
      pillar: CompetencyPillar.comportamental,
      topic: 'Liderazgo',
      stem:
          'Un coordinador nota baja apropiación del PEI en el equipo. La mejor acción inicial es:',
      options: [
        'Sancionar a quienes no lo citan',
        'Diagnosticar brechas, socializar sentido del PEI y acordar rutinas de apropiación',
        'Reescribir el PEI sin la comunidad',
        'Ignorar el tema hasta la visita de supervisión',
      ],
      correctIndex: 1,
      explanation:
          'El liderazgo pedagógico combina diagnóstico, sentido compartido y rutinas de implementación.',
      difficulty: QuestionDifficulty.avanzado,
      specialtyTags: const [Especialidad.directivos],
    ),
    Question(
      id: 'com-04',
      pillar: CompetencyPillar.comportamental,
      topic: 'Orientación al ciudadano',
      stem:
          'Un acudiente llega molesto por una nota. La respuesta más profesional es:',
      options: [
        'Responder con el mismo tono',
        'Escuchar, explicar criterios con evidencia y ofrecer ruta de aclaración institucional',
        'Prometer cambiar la nota de inmediato',
        'Evitar la conversación',
      ],
      correctIndex: 1,
      explanation:
          'Competencias de servicio: empatía, claridad, apego a procedimientos y respeto.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'com-05',
      pillar: CompetencyPillar.comportamental,
      topic: 'Integridad',
      stem:
          'Te piden adelantar información confidencial de un proceso de selección interna. Debes:',
      options: [
        'Compartirla con un amigo de confianza',
        'Negarte con respeto y seguir el conducto regular de información',
        'Venderla a cambio de un favor',
        'Publicarla anónimamente',
      ],
      correctIndex: 1,
      explanation:
          'La integridad y confidencialidad son centrales en el perfil comportamental del servidor público.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'com-06',
      pillar: CompetencyPillar.comportamental,
      topic: 'Casos de aula',
      stem:
          'Un docente observa que un colega suele ridiculizar errores en clase. ¿Qué acción priorizar?',
      options: [
        'Confrontarlo frente a todo el equipo sin contexto',
        'Documentar hechos, acompañar con evidencia y activar rutas institucionales de convivencia laboral',
        'Imitar la práctica para “ganar respeto”',
        'Comentar el caso con estudiantes',
      ],
      correctIndex: 1,
      explanation:
          'Se espera protección del clima escolar, debido proceso y canales formales, no espectáculo ni omisión.',
      difficulty: QuestionDifficulty.avanzado,
      isCaseStudy: true,
      caseContext:
          'Varios estudiantes evitaron participar tras comentarios sarcásticos reiterados de un docente.',
    ),
  ];
}
