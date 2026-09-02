import 'dart:js_interop';

/// Conversiones Google Ads (gtag) en Flutter Web.
@JS('tpdGtagConversion')
external JSFunction? get _tpdGtagConversion;

@JS('gtag')
external JSFunction? get _gtag;

abstract final class GoogleAdsTag {
  static const _purchaseSendTo = 'AW-17037005824/UJV8CJ7W1uAcEICo8Ls_';
  static const _registrationSendTo = 'AW-17037005824/zvnBCKHW1uAcEICo8Ls_';

  /// Registro de cuenta (Google o correo). Valor simbólico: el ingreso va en Purchase.
  static void completeRegistration({String? email}) {
    _conversion(
      sendTo: _registrationSendTo,
      value: 1.0,
      currency: 'COP',
      email: email,
    );
  }

  /// Compra Premium o pase Mentor confirmada (Wompi o cupón que otorga acceso).
  static void purchase({
    required double value,
    String currency = 'COP',
    String? transactionId,
    String? email,
  }) {
    _conversion(
      sendTo: _purchaseSendTo,
      value: value > 0 ? value : 1.0,
      currency: currency,
      transactionId: transactionId,
      email: email,
    );
  }

  static void _conversion({
    required String sendTo,
    required double value,
    required String currency,
    String? transactionId,
    String? email,
  }) {
    final tx = transactionId?.trim() ?? '';
    final em = email?.trim() ?? '';
    try {
      final bridge = _tpdGtagConversion;
      if (bridge != null) {
        bridge.callAsFunction(
          null,
          {
            'sendTo': sendTo,
            'value': value,
            'currency': currency,
            'transactionId': tx,
            'email': em,
          }.jsify(),
        );
        return;
      }
    } catch (_) {
      // Sin puente: se intenta gtag directo.
    }
    try {
      final gtag = _gtag;
      if (gtag == null) return;
      if (em.contains('@')) {
        gtag.callAsFunction(
          null,
          'set'.toJS,
          'user_data'.toJS,
          {'email': em}.jsify(),
        );
      }
      final params = <String, Object?>{
        'send_to': sendTo,
        'value': value,
        'currency': currency,
      };
      if (tx.isNotEmpty) params['transaction_id'] = tx;
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
