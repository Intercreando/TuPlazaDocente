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

  /// Ciclo: el vídeo pide la letra; la respuesta oficial va en el comentario.
  static const holdCue = 'Mantén presionado para leer';
  static const commentNow =
      'Deja tu letra en los comentarios antes del reloj';

  /// Cierre sin revelar: debate en comentarios, no en el lienzo.
  static const closeAsk = '¿A, B, C o D?';
  static const closePrompt =
      'Pausa el video, escribe tu opción y corre al primer comentario. '
      'Ya te dejé la respuesta oficial explicada para que no caigas '
      'en la trampa. 👇';

  static const site = 'tuplazadocente.com';
  static const closeAction = 'Simulacros completos, gratis';
  static const closeRegister = '$site — $closeAction';
  static const brand = 'TuPlazaDocente';
  static const disclaimer = 'Entrenamiento. No es un ítem oficial de la CNSC.';
  static const hashtags =
      '#ConcursoDocente #ConcursoDocente2026 #CNSC #DocentesColombia '
      '#MagisterioColombia #TuPlazaDocente #CasosDeAula #Pedagogia';

  static const pinnedCommentCta =
      '💡 Si quieres practicar con simulacros completos y asegurar tu '
      'resultado, ve al enlace de mi perfil y entrena en TuPlazaDocente.';

  static const pinnedCommentHashtags =
      '#ConcursoDocente2026 #ConcursoDocenteColombia #DocentesColombia '
      '#CNSC #MagisterioColombiano #PruebasSaber #TuPlazaDocente';

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

  /// Caption de TikTok/Reels. La letra no va aquí ni en el vídeo: si se
  /// delata, nadie comenta. La explicación va en el primer comentario.
  ///
  /// Primera línea: gancho + palabra clave del tema (SEO). Luego CTA con
  /// flecha al comentario y el enlace marcado como recurso gratis.
  static String captionFor(ReelClip clip) {
    return [
      '${clip.hook} ${clip.group.captionKeyword}',
      '',
      '👇 $closeAsk $closePrompt',
      '',
      '🎁 $closeRegister',
      '',
      hashtagsFor(clip),
    ].join('\n');
  }

  /// Primer comentario: letra, criterio y CTA al perfil. El vídeo no revela.
  static String pinnedCommentFor(ReelClip clip) {
    const letters = ['A', 'B', 'C', 'D'];
    final i = clip.correctIndex.clamp(0, letters.length - 1);
    var why = clip.revealWhy.trim();
    if (why.isNotEmpty) {
      why = '${why[0].toLowerCase()}${why.substring(1)}';
    }
    if (why.isNotEmpty && !why.endsWith('.')) why = '$why.';
    return [
      'La respuesta correcta es la ${letters[i]}.',
      '',
      '¿Por qué? Según los lineamientos, $why Las otras opciones son la '
          'típica trampa en la que muchos caen.',
      '',
      pinnedCommentCta,
      '',
      pinnedCommentHashtags,
    ].join('\n');
  }
}
