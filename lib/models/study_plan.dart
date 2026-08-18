import 'enums.dart';

/// Tarea concreta del plan diario.
class StudyTask {
  const StudyTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.pillar,
    required this.questionCount,
    required this.mode,
    required this.minutes,
    this.isCaseStudy = false,
    this.completed = false,
    this.minDifficultyLevel,
    this.mixPillars = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final CompetencyPillar pillar;
  final int questionCount;
  final SessionMode mode;
  final int minutes;
  final bool isCaseStudy;
  final bool completed;

  /// 3 = alta exigencia: solo ítems difíciles (o lo más duro disponible).
  final int? minDifficultyLevel;

  /// Mezcla pilares (simulacro duro), no un solo foco.
  final bool mixPillars;

  StudyTask copyWith({bool? completed}) {
    return StudyTask(
      id: id,
      title: title,
      subtitle: subtitle,
      pillar: pillar,
      questionCount: questionCount,
      mode: mode,
      minutes: minutes,
      isCaseStudy: isCaseStudy,
      completed: completed ?? this.completed,
      minDifficultyLevel: minDifficultyLevel,
      mixPillars: mixPillars,
    );
  }
}

/// Plan del día generado hasta la fecha de examen.
class DailyStudyPlan {
  const DailyStudyPlan({
    required this.date,
    required this.daysRemaining,
    required this.intensityLabel,
    required this.focusPillar,
    required this.tasks,
    required this.summary,
  });

  final DateTime date;
  final int daysRemaining;
  final String intensityLabel;
  final CompetencyPillar focusPillar;
  final List<StudyTask> tasks;
  final String summary;

  int get totalMinutes => tasks.fold(0, (sum, t) => sum + t.minutes);
  int get completedCount => tasks.where((t) => t.completed).length;
  double get progress => tasks.isEmpty ? 0 : completedCount / tasks.length;
}
