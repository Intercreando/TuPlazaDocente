import 'enums.dart';
import 'knowledge_taxonomy.dart';
import 'question.dart';

/// Recorte de una sesión (máximo 5 en el perfil). Sin enunciados.
class RecentSessionSnapshot {
  const RecentSessionSnapshot({
    required this.finishedAt,
    required this.mode,
    required this.total,
    required this.correct,
    this.weakTag,
    this.weakPillar,
    this.failedQuestionIds = const [],
  });

  static const maxStored = 5;

  final DateTime finishedAt;
  final SessionMode mode;
  final int total;
  final int correct;
  final KnowledgeCode? weakTag;
  final CompetencyPillar? weakPillar;
  final List<String> failedQuestionIds;

  bool get isEmpty => total <= 0;

  /// El reto rápido no entra: ensucia el diagnóstico con azar de 45 s.
  static bool shouldStore(SessionMode mode) =>
      mode != SessionMode.speedBattle;

  static RecentSessionSnapshot? fromResult(SessionResult result) {
    if (!shouldStore(result.mode) || result.answers.isEmpty) return null;
    final wrong = result.answers.where((a) => !a.correct).toList();
    return RecentSessionSnapshot(
      finishedAt: result.finishedAt,
      mode: result.mode,
      total: result.total,
      correct: result.correctCount,
      weakTag: _topWrongTag(wrong),
      weakPillar: _topWrongPillar(wrong),
      failedQuestionIds: [
        for (final a in wrong.take(5)) a.questionId,
      ],
    );
  }

  static RecentSessionSnapshot fromTutorStance({
    required Question question,
    required int selectedIndex,
    required DateTime at,
  }) {
    final ok = question.isCorrect(selectedIndex);
    final codes = [
      for (final tag in question.knowledgeTags) tag.code,
    ];
    return RecentSessionSnapshot(
      finishedAt: at,
      mode: SessionMode.practice,
      total: 1,
      correct: ok ? 1 : 0,
      weakTag: ok || codes.isEmpty ? null : codes.first,
      weakPillar: ok ? null : question.pillar,
      failedQuestionIds: ok ? const [] : [question.id],
    );
  }

  /// Más reciente primero. Tope [maxStored].
  static List<RecentSessionSnapshot> prepend(
    List<RecentSessionSnapshot> current,
    RecentSessionSnapshot next,
  ) {
    return [next, ...current].take(maxStored).toList(growable: false);
  }

  static KnowledgeCode? dominantWeakTag(List<RecentSessionSnapshot> sessions) {
    final counts = <KnowledgeCode, int>{};
    for (final session in sessions) {
      final tag = session.weakTag;
      if (tag == null) continue;
      counts[tag] = (counts[tag] ?? 0) + 1;
    }
    return _maxKey(counts);
  }

  static CompetencyPillar? dominantWeakPillar(
    List<RecentSessionSnapshot> sessions,
  ) {
    final counts = <CompetencyPillar, int>{};
    for (final session in sessions) {
      final pillar = session.weakPillar;
      if (pillar == null) continue;
      counts[pillar] = (counts[pillar] ?? 0) + 1;
    }
    return _maxKey(counts);
  }

  Map<String, dynamic> toJson() => {
        'finishedAt': finishedAt.toIso8601String(),
        'mode': mode.name,
        'total': total,
        'correct': correct,
        'weakTag': weakTag?.name,
        'weakPillar': weakPillar?.name,
        'failedQuestionIds': failedQuestionIds,
      };

  factory RecentSessionSnapshot.fromJson(Map<String, dynamic> json) {
    DateTime finished = DateTime.now();
    final rawAt = json['finishedAt'];
    if (rawAt is String) {
      finished = DateTime.tryParse(rawAt) ?? finished;
    }
    final ids = json['failedQuestionIds'];
    return RecentSessionSnapshot(
      finishedAt: finished,
      mode: _enumByName(SessionMode.values, json['mode'] as String?) ??
          SessionMode.practice,
      total: (json['total'] as num?)?.toInt() ?? 0,
      correct: (json['correct'] as num?)?.toInt() ?? 0,
      weakTag: _enumByName(KnowledgeCode.values, json['weakTag'] as String?),
      weakPillar:
          _enumByName(CompetencyPillar.values, json['weakPillar'] as String?),
      failedQuestionIds: ids is List
          ? ids.map((e) => e.toString()).take(5).toList()
          : const [],
    );
  }

  static KnowledgeCode? _topWrongTag(List<AnswerRecord> wrong) {
    final counts = <KnowledgeCode, int>{};
    for (final answer in wrong) {
      for (final code in answer.knowledgeCodes) {
        counts[code] = (counts[code] ?? 0) + 1;
      }
    }
    return _maxKey(counts);
  }

  static CompetencyPillar? _topWrongPillar(List<AnswerRecord> wrong) {
    final counts = <CompetencyPillar, int>{};
    for (final answer in wrong) {
      counts[answer.pillar] = (counts[answer.pillar] ?? 0) + 1;
    }
    return _maxKey(counts);
  }

  static K? _maxKey<K>(Map<K, int> counts) {
    K? best;
    var max = 0;
    counts.forEach((key, value) {
      if (value > max) {
        max = value;
        best = key;
      }
    });
    return best;
  }
}

T? _enumByName<T extends Enum>(List<T> values, String? name) {
  if (name == null) return null;
  for (final value in values) {
    if (value.name == name) return value;
  }
  return null;
}
