import 'reel_clip.dart';
import 'reel_clips/reel_clips_aula.dart';
import 'reel_clips/reel_clips_convivencia.dart';
import 'reel_clips/reel_clips_directivo.dart';
import 'reel_clips/reel_clips_evaluacion.dart';
import 'reel_clips/reel_clips_inclusion.dart';

export 'reel_clip.dart';

/// Pack viral: trampas reales, opciones cortas, debate en comentarios.
/// Los casos viven en `reel_clips/` agrupados por tema; aquí solo se componen
/// el catálogo y los textos fijos del lienzo.
abstract final class ReelStudioPack {
  static const hook = '¿Pasarías esta pregunta del Concurso Docente?';

  /// Cierre sin revelar: se pide la letra para provocar comentarios.
  static const closeAsk = '¿A, B, C o D?';
  static const closeComenta = 'Comenta tu letra y por qué la elegiste';
  static const closeDebate = 'El que la sustenta, la aprende.';
  static const closeFollow = 'Mañana subo la respuesta. Sígueme para verla.';

  static const site = 'tuplazadocente.com';
  static const closeAction = 'Crea tu cuenta gratis';
  static const closeRegister = '$site — $closeAction';
  static const brand = 'TuPlazaDocente';
  static const disclaimer = 'Entrenamiento. No es un ítem oficial de la CNSC.';
  static const hashtags =
      '#ConcursoDocente #ConcursoDocente2026 #CNSC #DocentesColombia '
      '#MagisterioColombia #TuPlazaDocente';
  static const pinnedComment =
      'La explicación y el simulador están en tuplazadocente.com — crea tu cuenta gratis.';

  /// Catálogo completo. Las letras correctas están repartidas por igual entre
  /// A, B, C y D para que la audiencia no aprenda a adivinar.
  static const clips = <ReelClip>[
    ...reelClipsConvivencia,
    ...reelClipsInclusion,
    ...reelClipsEvaluacion,
    ...reelClipsAula,
    ...reelClipsDirectivo,
  ];

  static List<ReelClip> byGroup(ReelGroup group) {
    return clips.where((clip) => clip.group == group).toList();
  }

  /// Grupos que sí tienen casos, en el orden del catálogo.
  static List<ReelGroup> get groups => groupsIn(clips);

  static ReelClip byId(String? id) => byIdIn(clips, id);

  /// Búsqueda simple por tema, título o texto del caso.
  static List<ReelClip> search(String query) => searchIn(clips, query);

  /// Las variantes `*In` operan sobre el catálogo del estudio, que suma los
  /// casos del código y los creados a mano en Firestore.
  static List<ReelGroup> groupsIn(List<ReelClip> catalog) {
    return ReelGroup.values
        .where((g) => catalog.any((clip) => clip.group == g))
        .toList();
  }

  static ReelClip byIdIn(List<ReelClip> catalog, String? id) {
    final fallback = catalog.isEmpty ? clips.first : catalog.first;
    if (id == null || id.isEmpty) return fallback;
    for (final clip in catalog) {
      if (clip.id == id) return clip;
    }
    return fallback;
  }

  static List<ReelClip> searchIn(List<ReelClip> catalog, String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return catalog;
    return catalog.where((clip) => clip.searchText.contains(needle)).toList();
  }

  /// Caption de TikTok/Reels (sin revelar la letra en el capítulo 1).
  static String captionFor(ReelClip clip, {required bool reveal}) {
    final lines = <String>[hook, '', clip.label];
    if (!reveal) {
      lines.addAll([
        clip.situation,
        clip.stem,
        '',
        '$closeAsk $closeComenta.',
        closeFollow,
        '',
        closeRegister,
      ]);
    } else {
      lines.addAll([
        'Respuesta: ${clip.correctLetter}. ${clip.revealWhy}',
        '',
        closeRegister,
      ]);
    }
    lines.addAll(['', hashtags]);
    return lines.join('\n');
  }
}
