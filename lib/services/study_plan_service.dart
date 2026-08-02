import '../models/enums.dart';
import '../models/study_plan.dart';
import '../models/user_profile.dart';

/// Genera el plan diario táctico según perfil, debilidades y fecha de examen.
abstract final class StudyPlanService {
  static DailyStudyPlan buildFor(UserProfile profile, {DateTime? now}) {
    final today = now ?? DateTime.now();
    final day = DateTime(today.year, today.month, today.day);
    final exam = profile.examDate;
    final daysRemaining = exam == null
        ? 60
        : DateTime(exam.year, exam.month, exam.day).difference(day).inDays.clamp(0, 800);

    final focus = _weakestPillar(profile);
    final intensity = _intensity(daysRemaining);
    final tasks = _tasksFor(
      profile: profile,
      focus: focus,
      intensity: intensity,
      daysRemaining: daysRemaining,
    );

    final specialty = profile.especialidad?.label ?? 'tu especialidad';
    final summary = daysRemaining == 0
        ? 'Hoy es el día. Mantén calma: 1 bloque corto de repaso y descanso mental.'
        : 'Quedan $daysRemaining días. Intensidad $intensity · foco en ${focus.label} '
            'para $specialty.';

    return DailyStudyPlan(
      date: day,
      daysRemaining: daysRemaining,
      intensityLabel: intensity,
      focusPillar: focus,
      tasks: tasks,
      summary: summary,
    );
  }

  static CompetencyPillar _weakestPillar(UserProfile profile) {
    CompetencyPillar weakest = CompetencyPillar.pedagogico;
    var lowest = 2.0;
    var found = false;
    for (final pillar in CompetencyPillar.values) {
      final total = profile.pillarTotal[pillar.name] ?? 0;
      if (total == 0) continue;
      found = true;
      final acc = profile.pillarAccuracy(pillar);
      if (acc < lowest) {
        lowest = acc;
        weakest = pillar;
      }
    }
    if (!found) return CompetencyPillar.pedagogico;
    return weakest;
  }

  static String _intensity(int daysRemaining) {
    if (daysRemaining <= 7) return 'Sprint final';
    if (daysRemaining <= 21) return 'Alta';
    if (daysRemaining <= 60) return 'Constante';
    return 'Base';
  }

  static List<StudyTask> _tasksFor({
    required UserProfile profile,
    required CompetencyPillar focus,
    required String intensity,
    required int daysRemaining,
  }) {
    final focusCount = intensity == 'Sprint final'
        ? 8
        : intensity == 'Alta'
            ? 6
            : 5;

    final tasks = <StudyTask>[
      StudyTask(
        id: 'focus-block',
        title: 'Bloque foco: ${focus.label}',
        subtitle: 'Ataque directo a tu talón de Aquiles de hoy',
        pillar: focus,
        questionCount: focusCount,
        mode: SessionMode.practice,
        minutes: (focusCount * 1.6).round().clamp(8, 18),
      ),
      StudyTask(
        id: 'case-block',
        title: 'Caso de aula',
        subtitle: 'Decide con criterio normativo y comportamental',
        pillar: CompetencyPillar.pedagogico,
        questionCount: intensity == 'Base' ? 2 : 3,
        mode: SessionMode.practice,
        minutes: 8,
        isCaseStudy: true,
      ),
    ];

    if (!profile.dailyCompletedToday) {
      tasks.insert(
        0,
        const StudyTask(
          id: 'streak',
          title: 'Racha diaria',
          subtitle: '5 preguntas para mantener la disciplina',
          pillar: CompetencyPillar.lecturaCritica,
          questionCount: 5,
          mode: SessionMode.dailyStreak,
          minutes: 10,
        ),
      );
    }

    if (daysRemaining > 0 && daysRemaining <= 30 && profile.isPremium) {
      tasks.add(
        const StudyTask(
          id: 'timed-drill',
          title: 'Drill cronometrado',
          subtitle: '2 minutos por ítem · mapa de calor al final',
          pillar: CompetencyPillar.aptitudNumerica,
          questionCount: 6,
          mode: SessionMode.exam,
          minutes: 14,
        ),
      );
    } else if (daysRemaining > 30) {
      final support = CompetencyPillar.values.firstWhere(
        (p) => p != focus,
        orElse: () => CompetencyPillar.lecturaCritica,
      );
      tasks.add(
        StudyTask(
          id: 'support-block',
          title: 'Bloque de soporte: ${support.label}',
          subtitle: 'Equilibra tu radar sin abandonar el foco',
          pillar: support,
          questionCount: 4,
          mode: SessionMode.practice,
          minutes: 8,
        ),
      );
    }

    if (profile.cargo?.esGestionInstitucional == true ||
        profile.especialidad == Especialidad.directivos) {
      tasks.add(
        StudyTask(
          id: 'rector-block',
          title: 'Gestión directiva',
          subtitle: 'PEI, gobierno escolar, SIEE y convivencia institucional',
          pillar: CompetencyPillar.pedagogico,
          questionCount: intensity == 'Base' ? 4 : 6,
          mode: SessionMode.practice,
          minutes: 12,
          isCaseStudy: true,
        ),
      );
    }

    return tasks;
  }
}
