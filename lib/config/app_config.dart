/// Configuración de producto sin secretos embebidos.
abstract final class AppConfig {
  /// Precio mostrado (informativo). El cobro real lo define Wompi.
  static const String premiumPriceLabel = r'$89.900 COP';

  /// Add-on Mentor IA: pase de 30 días, renovación manual (no débito).
  static const double mentorPassPriceCop = 19900;

  static const String mentorPassPriceLabel = r'$19.900 COP';

  static const String mentorPassBillingLabel =
      'Pase de 30 días · renovación manual';

  static const String mentorPassBillingDetail =
      'No es un débito automático. Cuando venza, puedes renovar a mano por '
      'otros 30 días. El Premium de la convocatoria no cambia.';

  static const String mentorPassPaywallTitle = 'Tu mentor, todos los días';

  static const String mentorPassPaywallLead =
      'La prueba te mostró el valor de analizar un caso paso a paso. '
      'Activa el pase para que esta experiencia no se quede en una sola vez '
      'y llegues al simulacro sabiendo exactamente cómo deducir '
      'la respuesta correcta.';

  /// Beneficios para quien paga el pase (copy de producto, no de tecnología).
  static const List<String> mentorPassBenefits = [
    'Domina el criterio del concurso: Entiende por qué una actuación es la '
        'correcta según la norma, y no solo de memoria.',
    'Práctica constante: 4 tutorías al día durante 30 días (hasta 8 turnos '
        'por sesión), enfocadas en los casos que más te cuestan.',
    'Análisis enfocado: Un mentor que te cuestiona y te guía hasta que '
        'domines el tema. Un debate estructurado y sin distracciones.',
  ];

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
