/// Configuración de producto sin secretos embebidos.
abstract final class AppConfig {
  /// Precio mostrado (informativo). El cobro real lo define Mercado Pago.
  static const String premiumPriceLabel = r'$89.900 COP / convocatoria';

  /// Códigos válidos también en Cloud Function `activatePremiumCode`.
  static const Set<String> premiumAccessCodes = {
    'PLAZA2026',
    'DOCENTE-REY',
    'TUPLAZA-PREMIUM',
    'DEMO-LOCAL',
  };
}
