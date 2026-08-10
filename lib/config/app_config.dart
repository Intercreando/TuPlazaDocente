/// Configuración de producto sin secretos embebidos.
abstract final class AppConfig {
  /// Precio mostrado (informativo). El cobro real lo define Wompi.
  static const String premiumPriceLabel = r'$89.900 COP';

  /// Valor numérico Premium en COP (Meta Pixel / analítica).
  static const double premiumPriceCop = 89900;

  /// Formatea un monto COP con separador de miles colombiano.
  static String formatCop(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      final remaining = digits.length - i;
      if (i > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }
    return '\$$buffer COP';
  }

  /// Precio de checkout (aplica descuento pendiente si existe).
  static String checkoutPriceLabel({int? discountPercent}) {
    final pct = discountPercent ?? 0;
    if (pct <= 0) return premiumPriceLabel;
    var price = (premiumPriceCop * (100 - pct) / 100).round();
    if (price < 1000) price = 1000;
    return formatCop(price);
  }

  /// Aclara que no es suscripción mensual.
  static const String premiumBillingLabel = 'Pago único por convocatoria';

  static const String premiumBillingDetail =
      'Un solo pago: sin cuotas mensuales. El acceso Premium cubre la convocatoria '
      'docente vigente (CNSC) hasta que esa etapa termine. No es una suscripción.';

  /// Dispositivos concurrentes permitidos por cuenta Premium.
  static const int maxPremiumDevices = 3;

  static const String supportEmail = 'soporte@tuplazadocente.com';
}
