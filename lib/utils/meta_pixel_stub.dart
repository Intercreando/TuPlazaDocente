/// Stub (móvil / tests): el píxel de Meta solo corre en web.
abstract final class MetaPixel {
  static void identify({String? email, String? externalId}) {}

  static void completeRegistration({
    String? method,
    String? email,
    String? externalId,
  }) {}

  static void initiateCheckout({
    required double value,
    String currency = 'COP',
    String? contentName,
    String? email,
    String? externalId,
  }) {}

  static void purchase({
    required double value,
    String currency = 'COP',
    String? contentName,
    String? email,
    String? externalId,
  }) {}
}
