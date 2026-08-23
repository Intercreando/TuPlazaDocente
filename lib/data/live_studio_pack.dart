/// Textos fijos del lienzo de YouTube. El catálogo de casos es el de Reels:
/// un directo reutiliza las mismas trampas, con otro ritmo y otro formato.
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

  /// El chat de YouTube es más lento que un comentario de TikTok.
  static const voteMs = 20000;
  static const fadeMs = 120;

  static const titleHint = 'Estudio Directo YouTube (admin)';
}
