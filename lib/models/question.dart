import 'enums.dart';

/// Pregunta del banco con explicación pedagógica.
class Question {
  const Question({
    required this.id,
    required this.pillar,
    required this.topic,
    required this.stem,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.difficulty,
    this.isCaseStudy = false,
    this.caseContext,
    this.normativeRefs = const [],
    this.specialtyTags = const [],
  });

  final String id;
  final CompetencyPillar pillar;
  final String topic;
  final String stem;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final QuestionDifficulty difficulty;
  final bool isCaseStudy;
  final String? caseContext;
  final List<String> normativeRefs;
  final List<Especialidad> specialtyTags;

  bool isCorrect(int selectedIndex) => selectedIndex == correctIndex;
}

/// Registro de respuesta para métricas y mapa de calor.
class AnswerRecord {
  const AnswerRecord({
    required this.questionId,
    required this.selectedIndex,
    required this.correct,
    required this.secondsSpent,
    required this.pillar,
    required this.topic,
  });

  final String questionId;
  final int selectedIndex;
  final bool correct;
  final int secondsSpent;
  final CompetencyPillar pillar;
  final String topic;
}

/// Resultado agregado de una sesión.
class SessionResult {
  const SessionResult({
    required this.mode,
    required this.answers,
    required this.startedAt,
    required this.finishedAt,
  });

  final SessionMode mode;
  final List<AnswerRecord> answers;
  final DateTime startedAt;
  final DateTime finishedAt;

  int get total => answers.length;
  int get correctCount => answers.where((a) => a.correct).length;
  double get accuracy => total == 0 ? 0 : correctCount / total;
  int get totalSeconds => answers.fold(0, (sum, a) => sum + a.secondsSpent);
}
