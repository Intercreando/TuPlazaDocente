import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';
import '../models/user_profile.dart';
import 'tag_mastery_service.dart';

/// Umbrales del cierre emocional (alineados al mapa de maestría).
abstract final class SessionFeedbackConfig {
  /// 90% o más: celebración alta.
  static const double celebrateHighMin = 0.90;

  /// 75% o más: celebración.
  static const double celebrateMin = 0.75;

  /// 50% o más (y menos de 75%): refuerzo “vas en camino”.
  static const double developMin = 0.50;
}

enum SessionFeedbackTone {
  celebrateHigh,
  celebrate,
  reinforcePath,
  reinforceStart,
}

/// A dónde llevar si el docente toca “practicar esto”.
class SessionPracticeFocus {
  const SessionPracticeFocus.tag(this.code) : pillar = null;
  const SessionPracticeFocus.pillar(this.pillar) : code = null;

  final KnowledgeCode? code;
  final CompetencyPillar? pillar;

  String get label {
    if (code != null) return TagMasteryService.headlineFor(code!);
    return pillar?.label ?? 'este tema';
  }
}

/// Cierre de sesión: tono + foco elegido por lo fallado hoy.
class SessionFeedback {
  const SessionFeedback({
    required this.tone,
    required this.headline,
    required this.body,
    required this.celebrate,
    this.focus,
  });

  final SessionFeedbackTone tone;
  final String headline;
  final String body;
  final bool celebrate;
  final SessionPracticeFocus? focus;
}

/// Arma el mensaje con datos de **esta sesión**; historial solo como desempate.
abstract final class SessionFeedbackService {
  static SessionFeedback build(SessionResult result, UserProfile profile) {
    final accuracy = result.accuracy;
    if (accuracy >= SessionFeedbackConfig.celebrateHighMin) {
      return const SessionFeedback(
        tone: SessionFeedbackTone.celebrateHigh,
        headline: 'Excelente sesión.',
        body:
            'Así se asegura una plaza. Tu experiencia marcó la diferencia hoy.',
        celebrate: true,
      );
    }
    if (accuracy >= SessionFeedbackConfig.celebrateMin) {
      return const SessionFeedback(
        tone: SessionFeedbackTone.celebrate,
        headline: 'Vas con paso firme.',
        body:
            'El esfuerzo está dando frutos. Tienes el nivel, sigamos puliéndolo.',
        celebrate: true,
      );
    }

    final focus = _focusFromMisses(result, profile);
    final tema = focus?.label ?? 'este tema';

    if (accuracy >= SessionFeedbackConfig.developMin) {
      return SessionFeedback(
        tone: SessionFeedbackTone.reinforcePath,
        headline: 'Vas en camino; hoy conviene reforzar $tema.',
        body:
            'Es normal dudar en estos puntos. Usemos este resultado a tu favor '
            'fortaleciendo $tema.',
        celebrate: false,
        focus: focus,
      );
    }

    return SessionFeedback(
      tone: SessionFeedbackTone.reinforceStart,
      headline: 'Esto se corrige, no es un juicio. El siguiente paso es $tema.',
      body:
          'Respira, este es el lugar seguro para equivocarse. '
          'Vamos a desenredar $tema.',
      celebrate: false,
      focus: focus,
    );
  }

  /// Fallos de esta sesión: más etiquetas erradas → menor acierto → recomendación.
  static SessionPracticeFocus? _focusFromMisses(
    SessionResult result,
    UserProfile profile,
  ) {
    final wrong = result.answers.where((a) => !a.correct).toList();
    if (wrong.isEmpty) return null;

    final fromTags = _bestTag(result.answers, profile);
    if (fromTags != null) return fromTags;

    final fromPillar = _bestPillar(wrong);
    if (fromPillar != null) return fromPillar;

    final rec = TagMasteryService.recommendedToday(profile);
    if (rec != null) return SessionPracticeFocus.tag(rec.code);
    return null;
  }

  static SessionPracticeFocus? _bestTag(
    List<AnswerRecord> answers,
    UserProfile profile,
  ) {
    final miss = <KnowledgeCode, int>{};
    final seen = <KnowledgeCode, int>{};
    final hits = <KnowledgeCode, int>{};

    for (final answer in answers) {
      final codes = answer.knowledgeCodes.toSet();
      for (final code in codes) {
        seen[code] = (seen[code] ?? 0) + 1;
        if (answer.correct) {
          hits[code] = (hits[code] ?? 0) + 1;
        } else {
          miss[code] = (miss[code] ?? 0) + 1;
        }
      }
    }
    if (miss.isEmpty) return null;

    int accPct(KnowledgeCode code) {
      final total = seen[code] ?? 0;
      if (total == 0) return 100;
      return (((hits[code] ?? 0) / total) * 100).round();
    }

    final ranked = miss.keys.toList()
      ..sort((a, b) {
        final byMiss = miss[b]!.compareTo(miss[a]!);
        if (byMiss != 0) return byMiss;
        return accPct(a).compareTo(accPct(b));
      });

    final topMiss = miss[ranked.first]!;
    final topAcc = accPct(ranked.first);
    final tied = ranked
        .where((c) => miss[c] == topMiss && accPct(c) == topAcc)
        .toList();

    final rec = TagMasteryService.recommendedToday(profile);
    if (rec != null && tied.contains(rec.code)) {
      return SessionPracticeFocus.tag(rec.code);
    }
    return SessionPracticeFocus.tag(tied.first);
  }

  static SessionPracticeFocus? _bestPillar(List<AnswerRecord> wrong) {
    final miss = <CompetencyPillar, int>{};
    for (final answer in wrong) {
      miss[answer.pillar] = (miss[answer.pillar] ?? 0) + 1;
    }
    if (miss.isEmpty) return null;
    final ranked = miss.keys.toList()
      ..sort((a, b) => miss[b]!.compareTo(miss[a]!));
    return SessionPracticeFocus.pillar(ranked.first);
  }
}
