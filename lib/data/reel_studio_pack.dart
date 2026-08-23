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
  /// Reserva si un caso no trae gancho. En el pack cada clip tiene el suyo.
  static const hook = ReelClip.fallbackHook;
  static const seriesKicker = 'CONCURSO DOCENTE 2026';

  /// Ciclo cerrado: el vídeo pide la letra y revela en los mismos 15 s.
  static const holdCue = 'Mantén presionado para leer';
  static const commentNow =
      'Deja tu letra en los comentarios antes del reloj';

  static const site = 'tuplazadocente.com';
  static const closeAction = 'Simulacros completos, gratis';
  static const closeRegister = '$site — $closeAction';
  static const brand = 'TuPlazaDocente';
  static const disclaimer = 'Entrenamiento. No es un ítem oficial de la CNSC.';
  static const hashtags =
      '#ConcursoDocente #ConcursoDocente2026 #CNSC #DocentesColombia '
      '#MagisterioColombia #TuPlazaDocente #CasosDeAula #Pedagogia';
  static const pinnedComment =
      'Simulacros completos y gratis en tuplazadocente.com — crea tu cuenta.';

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

  /// Hashtags del pack más el del tema, para la barra de búsqueda de TikTok.
  static String hashtagsFor(ReelClip clip) =>
      '$hashtags ${clip.group.extraHashtag}';

  /// Caption de TikTok/Reels. La letra no va aquí: si se delata en el pie,
  /// nadie comenta. El vídeo sí revela al cierre.
  ///
  /// Primera línea: gancho + palabra clave del tema (SEO). Luego CTA con
  /// flecha al comentario y el enlace marcado como recurso gratis.
  static String captionFor(ReelClip clip) {
    return [
      '${clip.hook} ${clip.group.captionKeyword}',
      '',
      '👇 $commentNow',
      '',
      '🎁 $closeRegister',
      '',
      hashtagsFor(clip),
    ].join('\n');
  }
}
