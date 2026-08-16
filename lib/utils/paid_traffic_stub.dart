/// En móvil/tests no hay clic de anuncio web: se trata como orgánico.
abstract final class PaidTraffic {
  static bool get isPaid => false;

  /// En tests/móvil no hay pauta web: siempre onboarding de invitado.
  static String get startPath => '/onboarding';

  static void captureFromUri(Uri uri) {}

  static void clearPendingClaim() {}

  static void markClaimSettled(String uid) {}

  static bool isClaimSettledFor(String uid) => false;

  static void clearClaimSettled() {}
}
