/// Configuración de producto sin secretos embebidos.
abstract final class AppConfig {
  /// Precio mostrado (informativo). El cobro real lo define Wompi.
  static const String premiumPriceLabel = r'$89.900 COP';

  /// Valor numérico Premium en COP (Meta Pixel / analítica).
  static const double premiumPriceCop = 89900;

  /// Aclara que no es suscripción mensual.
  static const String premiumBillingLabel = 'Pago único por convocatoria';

  static const String premiumBillingDetail =
      'Un solo pago: sin cuotas mensuales. El acceso Premium cubre la convocatoria '
      'docente vigente (CNSC) hasta que esa etapa termine. No es una suscripción.';

  /// Dispositivos concurrentes permitidos por cuenta Premium.
  static const int maxPremiumDevices = 3;

  static const String supportEmail = 'soporte@tuplazadocente.com';
}
