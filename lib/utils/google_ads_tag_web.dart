import 'dart:js_interop';

/// Conversiones Google Ads (gtag) en Flutter Web.
@JS('gtag')
external JSFunction? get _gtag;

abstract final class GoogleAdsTag {
  static const _purchaseSendTo = 'AW-17037005824/UJV8CJ7W1uAcEICo8Ls_';
  static const _registrationSendTo = 'AW-17037005824/zvnBCKHW1uAcEICo8Ls_';

  /// Registro de cuenta (Google o correo). Valor simbólico: el ingreso va en Purchase.
  static void completeRegistration() {
    _conversion(
      sendTo: _registrationSendTo,
      value: 1.0,
      currency: 'COP',
    );
  }

  /// Compra Premium confirmada (Wompi).
  static void purchase({
    required double value,
    String currency = 'COP',
    String? transactionId,
  }) {
    _conversion(
      sendTo: _purchaseSendTo,
      value: value > 0 ? value : 1.0,
      currency: currency,
      transactionId: transactionId,
    );
  }

  static void _conversion({
    required String sendTo,
    required double value,
    required String currency,
    String? transactionId,
  }) {
    try {
      final gtag = _gtag;
      if (gtag == null) return;
      final params = <String, Object?>{
        'send_to': sendTo,
        'value': value,
        'currency': currency,
      };
      if (transactionId != null && transactionId.isNotEmpty) {
        params['transaction_id'] = transactionId;
      }
      gtag.callAsFunction(
        null,
        'event'.toJS,
        'conversion'.toJS,
        params.jsify(),
      );
    } catch (_) {
      // gtag bloqueado o no disponible.
    }
  }
}
