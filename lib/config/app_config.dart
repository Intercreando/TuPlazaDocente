/// Configuración de producto sin secretos embebidos.
abstract final class AppConfig {
  /// Precio mostrado (informativo). El cobro real lo define Mercado Pago.
  static const String premiumPriceLabel = r'$89.900 COP';

  /// Aclara que no es suscripción mensual.
  static const String premiumBillingLabel = 'Pago único por convocatoria';

  static const String premiumBillingDetail =
      'Un solo pago: sin cuotas mensuales. El acceso Premium cubre la convocatoria '
      'docente vigente (CNSC) hasta que esa etapa termine. No es una suscripción.';

  /// Códigos válidos también en Cloud Function `activatePremiumCode`.
  static const Set<String> premiumAccessCodes = {
    'PLAZA2026',
    'DOCENTE-REY',
    'TUPLAZA-PREMIUM',
    'DEMO-LOCAL',
  };
}
