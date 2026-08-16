/// Rutas públicas de aterrizaje SEO (una intención de búsqueda por URL).
abstract final class SeoLandingRoutes {
  static const casos = '/casos-de-aula-resueltos';
  static const psicotecnica = '/prueba-psicotecnica-docente-ejemplos';
  static const simulacro = '/simulacro-concurso-docente-gratis';

  static const casosId = 'casos';
  static const psicotecnicaId = 'psicotecnica';
  static const simulacroId = 'simulacro';

  static const all = {casos, psicotecnica, simulacro};

  /// Registro forzado: dispara CompleteRegistration, no invitado.
  static String authCta({required String source}) =>
      '/auth?register=1&src=$source';
}
