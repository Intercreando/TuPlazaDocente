import '../data/question_bank.dart';
import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';
import '../models/recent_session_snapshot.dart';
import '../models/user_profile.dart';
import '../utils/progress_gaps.dart';
import 'tag_mastery_service.dart';

/// Plan de una sesión de Tutor Inteligente (sin IA).
class IntelligentTutorPlan {
  const IntelligentTutorPlan({
    required this.displayName,
    required this.headline,
    required this.body,
    required this.weakLabels,
    required this.question,
    required this.focusPillar,
    this.focusCode,
  });

  final String displayName;
  final String headline;
  final String body;
  final List<String> weakLabels;
  final Question question;
  final CompetencyPillar focusPillar;
  final KnowledgeCode? focusCode;
}

/// Arma saludo, diagnóstico y un caso del banco a partir del perfil.
abstract final class IntelligentTutorPlanner {
  /// Nombre corto para el saludo (primera palabra del perfil).
  static String greetingName(UserProfile profile) {
    final raw = profile.displayName.trim();
    if (raw.isEmpty) return 'Aspirante';
    return raw.split(RegExp(r'\s+')).first;
  }

  static IntelligentTutorPlan build(
    UserProfile profile, {
    List<Question>? bank,
    String? excludeQuestionId,
    DateTime? now,
  }) {
    final pool = bank ?? QuestionBank.all;
    final rec = TagMasteryService.recommendedToday(profile);
    final recentTag =
        RecentSessionSnapshot.dominantWeakTag(profile.recentSessions);
    final recentPillar =
        RecentSessionSnapshot.dominantWeakPillar(profile.recentSessions);
    final pillar = recentPillar ?? ProgressGaps.weakestPillar(profile);
    final focusCode = recentTag ?? rec?.code;
    final fromRecent = recentTag != null;
    final question = pickCase(
      pool: pool,
      focusCode: focusCode,
      focusPillar: pillar,
      excludeQuestionId: excludeQuestionId,
      now: now ?? DateTime.now(),
    );

    final labels = <String>[];
    if (recentTag != null) {
      labels.add(TagMasteryService.headlineFor(recentTag));
    } else if (rec != null) {
      labels.add(rec.headline);
    }
    final pillarLabel = ProgressGaps.shortLabel(pillar);
    if (!labels.contains(pillarLabel)) labels.add(pillarLabel);

    return IntelligentTutorPlan(
      displayName: greetingName(profile),
      headline: _headline(
        profile,
        rec,
        pillar,
        fromRecent: fromRecent,
        recentTag: recentTag,
      ),
      body: _body(
        profile,
        rec,
        pillar,
        fromRecent: fromRecent,
        recentTag: recentTag,
      ),
      weakLabels: labels.take(3).toList(),
      question: question,
      focusPillar: pillar,
      focusCode: focusCode,
    );
  }

  /// Elige un caso del banco: etiqueta débil → pilar → cualquier caso.
  static Question pickCase({
    required List<Question> pool,
    KnowledgeCode? focusCode,
    required CompetencyPillar focusPillar,
    String? excludeQuestionId,
    required DateTime now,
  }) {
    if (pool.isEmpty) {
      throw StateError('El banco de preguntas está vacío.');
    }
    final filtered = excludeQuestionId == null || pool.length == 1
        ? pool
        : pool.where((q) => q.id != excludeQuestionId).toList();
    final source = filtered.isEmpty ? pool : filtered;

    List<Question> withCode(KnowledgeCode code) => source
        .where((q) => q.knowledgeTags.any((tag) => tag.code == code))
        .toList();

    final ranked = <List<Question>>[
      if (focusCode != null)
        withCode(focusCode).where((q) => q.isCaseStudy).toList(),
      if (focusCode != null)
        withCode(focusCode)
            .where((q) => (q.caseContext ?? '').trim().isNotEmpty)
            .toList(),
      if (focusCode != null) withCode(focusCode),
      source
          .where((q) => q.isCaseStudy && q.pillar == focusPillar)
          .toList(),
      source.where((q) => q.pillar == focusPillar).toList(),
      source.where((q) => q.isCaseStudy).toList(),
      source
          .where((q) => (q.caseContext ?? '').trim().isNotEmpty)
          .toList(),
      source,
    ];

    for (final group in ranked) {
      if (group.isEmpty) continue;
      return _pickStable(group, now);
    }
    return _pickStable(source, now);
  }

  static Question _pickStable(List<Question> group, DateTime now) {
    final sorted = [...group]..sort((a, b) => a.id.compareTo(b.id));
    final seed = now.year * 1000 + now.month * 32 + now.day;
    return sorted[seed % sorted.length];
  }

  static String _headline(
    UserProfile profile,
    TagMasteryRow? rec,
    CompetencyPillar pillar, {
    required bool fromRecent,
    KnowledgeCode? recentTag,
  }) {
    if (profile.recentSessions.isEmpty && profile.totalAnswers == 0) {
      return 'Aún sin historial reciente. Un caso de '
          '${ProgressGaps.shortLabel(pillar)}.';
    }
    if (fromRecent && recentTag != null) {
      return 'En tus últimas prácticas el hueco es '
          '${TagMasteryService.headlineFor(recentTag)}.';
    }
    if (rec != null && rec.total > 0) {
      return 'Según tu mapa de práctica, el hueco es ${rec.headline}.';
    }
    if (rec != null && rec.level == MasteryLevel.sinDatos) {
      return 'Según tu mapa de práctica, conviene medir ${rec.headline}.';
    }
    return 'Según tu mapa de práctica, un caso de '
        '${ProgressGaps.shortLabel(pillar)}.';
  }

  static String _body(
    UserProfile profile,
    TagMasteryRow? rec,
    CompetencyPillar pillar, {
    required bool fromRecent,
    KnowledgeCode? recentTag,
  }) {
    if (profile.recentSessions.isEmpty && profile.totalAnswers == 0) {
      return 'Todavía no hay prácticas ni simulacros guardados. Partimos de '
          '${ProgressGaps.shortLabel(pillar)}, el peso más claro del concurso. '
          'El caso sale del banco, no lo inventa la IA.';
    }
    if (fromRecent && recentTag != null) {
      return 'No es un tema al azar: sale de lo que más fallaste en tus '
          'últimas sesiones. Elige cómo actuarías; el contraste ya está escrito.';
    }
    if (rec != null && rec.total > 0 && rec.level == MasteryLevel.critico) {
      return 'Según tu mapa de práctica (no el último simulacro), en '
          '${rec.headline} llevas ${rec.accuracyPercent}% de aciertos '
          '(${rec.total} evidencias). Este caso apunta ahí.';
    }
    if (rec != null && rec.level == MasteryLevel.sinDatos) {
      return 'Según tu mapa de práctica, ${rec.headline} aún no tiene evidencias. '
          'Un caso corto hoy deja de ser un punto ciego.';
    }
    if (rec != null && rec.total > 0 && rec.level == MasteryLevel.enDesarrollo) {
      return 'Según tu mapa de práctica, en ${rec.headline} vas en desarrollo '
          '(${rec.accuracyPercent}%). Un caso de este dominio te acerca a Profesional.';
    }
    return 'Según tu mapa de práctica, el hueco más útil ahora es '
        '${ProgressGaps.shortLabel(pillar)}. El caso de abajo sale del banco.';
  }
}
