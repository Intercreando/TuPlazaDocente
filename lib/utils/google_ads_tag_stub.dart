/// Stub (móvil / tests): gtag de Google Ads solo corre en web.
abstract final class GoogleAdsTag {
  static void completeRegistration({String? email}) {}

  static void purchase({
    required double value,
    String currency = 'COP',
    String? transactionId,
    String? email,
  }) {}
}
