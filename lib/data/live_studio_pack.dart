import '../models/enums.dart';
import 'live_clip_mapper.dart';
import 'live_clips_enunciado.dart';
import 'question_bank.dart';
import 'reel_studio_pack.dart';

export 'reel_clip.dart';

/// Textos fijos del lienzo de YouTube. El catálogo es propio del directo
/// (enunciados 16:9 + alta exigencia del banco), no el pack de Reels.
abstract final class LiveStudioPack {
  static const seriesKicker = 'CONCURSO DOCENTE 2026';
  static const brand = 'TuPlazaDocente';
  static const site = 'tuplazadocente.com';
  static const closeAction = 'Simulacros completos, gratis';
  static const disclaimer =
      'Entrenamiento en vivo. No es un ítem oficial de la CNSC.';

  static const liveBadge = 'EN VIVO';
  static const soonBadge = 'EMPEZAMOS YA';
  static const standbyTitle = 'Casos reales. Tú votas. Yo revelo.';
  static const standbyHint =
      'Abre el chat y prepárate para escribir A, B, C o D.';

  static const chatCue = 'Escribe tu letra en el chat';
  static const voteTitle = '¿Cuál es tu letra?';
  static const holdForChat = 'Miro el chat y después revelo';
  static const nextPrefix = 'Siguiente';
  static const camLabel = 'Cámara';

  /// Tope de ítems de alta exigencia en el picker, los de enunciado más largo.
  static const maxAltaClips = 16;

  /// El chat de YouTube es más lento que un comentario de TikTok.
  static const voteMs = 20000;
  static const fadeMs = 120;

  static const titleHint = 'Estudio Directo YouTube (admin)';

  /// Casos escritos para el lienzo (enunciado largo).
  static const enunciadoClips = liveClipsEnunciado;

  /// Catálogo que usa el estudio: enunciados propios + alta exigencia.
  static List<ReelClip> catalog() => [
        ...enunciadoClips,
        ...altaExigenciaClips(),
      ];

  static List<ReelClip> get clips => catalog();

  /// Casos de nivel 3 del banco, con contexto o enunciado largo.
  static List<ReelClip> altaExigenciaClips() {
    final candidates = QuestionBank.all
        .where(
          (q) =>
              q.difficulty == QuestionDifficulty.avanzado &&
              q.options.length >= 4 &&
              (q.isCaseStudy ||
                  (q.caseContext ?? '').trim().isNotEmpty ||
                  q.stem.trim().length >= 160),
        )
        .toList()
      ..sort((a, b) {
        final la = ((a.caseContext ?? '') + a.stem).length;
        final lb = ((b.caseContext ?? '') + b.stem).length;
        return lb.compareTo(la);
      });

    final out = <ReelClip>[];
    for (final question in candidates) {
      if (out.length >= maxAltaClips) break;
      final clip = liveClipFromAltaQuestion(question);
      if (clip != null) out.add(clip);
    }
    return out;
  }

  static ReelClip byId(String? id) => ReelStudioPack.byIdIn(catalog(), id);

  static ReelClip byIdIn(List<ReelClip> catalog, String? id) =>
      ReelStudioPack.byIdIn(catalog, id);
}
