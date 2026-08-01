/// Configuración de producto sin secretos embebidos.
/// Usa --dart-define=MP_CHECKOUT_URL=https://... en build/deploy.
abstract final class AppConfig {
  static const String mercadoPagoCheckoutUrl = String.fromEnvironment(
    'MP_CHECKOUT_URL',
    defaultValue: '',
  );

  /// Precio mostrado (informativo). El cobro real lo define Mercado Pago.
  static const String premiumPriceLabel = r'$89.900 COP / convocatoria';

  /// Códigos de acceso para activación manual / alianzas.
  static const Set<String> premiumAccessCodes = {
    'PLAZA2026',
    'DOCENTE-REY',
    'TUPLAZA-PREMIUM',
  };

  static bool get hasMercadoPagoCheckout => mercadoPagoCheckoutUrl.isNotEmpty;
}
