import 'enums.dart';
import 'knowledge_taxonomy.dart';

/// Pregunta del banco con cerebro pedagógico (norma + teoría + distractores).
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
    this.module,
    this.subtopic,
    this.targetCargo,
    this.knowledgeTags = const [],
    this.normativeJustification,
    this.theoreticalJustification,
    this.distractorAnalysis = const {},
    this.recommendedSeconds,
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

  /// Campos del cerebro enriquecido (estándar oro).
  final ContentModule? module;
  final String? subtopic;
  final Especialidad? targetCargo;
  final List<KnowledgeTag> knowledgeTags;
  final String? normativeJustification;
  final String? theoreticalJustification;

  /// Clave = índice de opción (0..n). Explica por qué es distractor.
  final Map<int, String> distractorAnalysis;

  /// Override opcional de `tiempo_recomendado_seg` en JSON.
  /// Si es null, se usa el default del nivel de dificultad.
  final int? recommendedSeconds;

  bool isCorrect(int selectedIndex) => selectedIndex == correctIndex;

  /// Alias JSON: `dificultad` (1 = rápida, 2 = estándar, 3 = alta exigencia).
  int get dificultad => difficulty.level;

  /// Alias JSON: `tiempo_recomendado_seg`.
  int get tiempoRecomendadoSeg =>
      recommendedSeconds ?? difficulty.defaultSeconds;

  /// Compatibilidad con el nombre anterior del campo.
  int get expectedSeconds => tiempoRecomendadoSeg;

  String get moduleLabel => module?.label ?? pillar.label;

  String get subtopicLabel => subtopic ?? topic;

  /// Retroalimentación unificada para ítems antiguos y nuevos.
  String get richFeedback {
    final parts = <String>[];
    if (normativeJustification != null && normativeJustification!.isNotEmpty) {
      parts.add(normativeJustification!);
    }
    if (theoreticalJustification != null &&
        theoreticalJustification!.isNotEmpty) {
      parts.add(theoreticalJustification!);
    }
    if (parts.isEmpty) return explanation;
    return parts.join('\n\n');
  }

  List<String> get referenceLabels {
    if (knowledgeTags.isNotEmpty) {
      return knowledgeTags.map((t) => t.display).toList();
    }
    return normativeRefs;
  }
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
    this.knowledgeCodes = const [],
  });

  final String questionId;

  /// Índice marcado; `null` si se acabó el tiempo sin responder.
  final int? selectedIndex;
  final bool correct;
  final int secondsSpent;
  final CompetencyPillar pillar;
  final String topic;

  /// Etiquetas de la pregunta (Decreto 1290, Vygotsky, etc.).
  final List<KnowledgeCode> knowledgeCodes;
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
  int get unansweredCount =>
      answers.where((a) => a.selectedIndex == null).length;
  double get accuracy => total == 0 ? 0 : correctCount / total;
  int get totalSeconds => answers.fold(0, (sum, a) => sum + a.secondsSpent);
}
