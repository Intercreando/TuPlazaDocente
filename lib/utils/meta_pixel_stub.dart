/// Stub (móvil / tests): el píxel de Meta solo corre en web.
abstract final class MetaPixel {
  static void completeRegistration({String? method}) {}

  static void initiateCheckout({
    required double value,
    String currency = 'COP',
    String? contentName,
  }) {}

  static void purchase({
    required double value,
    String currency = 'COP',
    String? contentName,
  }) {}
}
