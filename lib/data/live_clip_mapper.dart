import '../models/enums.dart';
import '../models/question.dart';
import 'reel_clip.dart';

/// Prefijo de los clips que salen del banco (nivel 3 · alta exigencia).
const liveAltaIdPrefix = 'live-alta-';

/// Convierte un ítem del banco en clip de directo (enunciado completo, 16:9).
ReelClip? liveClipFromAltaQuestion(Question question) {
  if (question.options.length < 4) return null;
  if (question.correctIndex < 0 || question.correctIndex > 3) return null;

  final context = (question.caseContext ?? '').trim();
  final stem = question.stem.trim();
  if (stem.isEmpty) return null;

  final situation = context.isNotEmpty
      ? context
      : _compact('${question.topic}. ${question.subtopicLabel}');
  final why = (question.richFeedback.trim().isNotEmpty
          ? question.richFeedback
          : question.explanation)
      .trim();

  return ReelClip(
    id: '$liveAltaIdPrefix${question.id}',
    group: liveGroupFromQuestion(question),
    label: _compact('Alta · ${question.subtopicLabel}', 52),
    hook: 'Alta exigencia: ¿cuál es la actuación correcta?',
    situation: situation,
    stem: stem,
    options: question.options.take(4).map((o) => o.trim()).toList(),
    correctIndex: question.correctIndex,
    revealWhy: _compact(why, 280),
  );
}

/// Agrupa el caso de directo según el tema del ítem (no según el pack de Reels).
ReelGroup liveGroupFromQuestion(Question question) {
  final haystack = [
    question.topic,
    question.subtopic ?? '',
    question.moduleLabel,
    question.pillar.label,
  ].join(' ').toLowerCase();

  final parsed = ReelGroup.tryParse(haystack);
  if (parsed != null) return parsed;

  final esDirectivo =
      question.targetCargo == Especialidad.directivos ||
      question.specialtyTags.contains(Especialidad.directivos);
  return esDirectivo ? ReelGroup.directivo : ReelGroup.aula;
}

String _compact(String raw, [int max = 90]) {
  final text = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (text.length <= max) return text;
  return '${text.substring(0, max - 1).trimRight()}…';
}
