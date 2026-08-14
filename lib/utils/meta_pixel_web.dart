import 'dart:js_interop';

import 'package:uuid/uuid.dart';

/// Meta Pixel (fbq) en Flutter Web.
@JS('fbq')
external JSFunction? get _fbq;

abstract final class MetaPixel {
  static const _uuid = Uuid();

  static void completeRegistration({String? method}) {
    final params = <String, Object?>{
      'status': true,
      // Valor simbólico > 0: el registro es gratis; el ingreso real va en Purchase.
      'value': 1.0,
      'currency': 'COP',
    };
    if (method != null && method.isNotEmpty) {
      params['content_name'] = method;
    }
    _track('CompleteRegistration', params);
  }

  /// Intención alta: el usuario abre la pasarela de pago (Wompi).
  static void initiateCheckout({
    required double value,
    String currency = 'COP',
    String? contentName,
  }) {
    final params = <String, Object?>{
      'value': value,
      'currency': currency,
      'num_items': 1,
    };
    if (contentName != null && contentName.isNotEmpty) {
      params['content_name'] = contentName;
    }
    _track('InitiateCheckout', params);
  }

  static void purchase({
    required double value,
    String currency = 'COP',
    String? contentName,
  }) {
    final params = <String, Object?>{
      'value': value,
      'currency': currency,
    };
    if (contentName != null && contentName.isNotEmpty) {
      params['content_name'] = contentName;
    }
    _track('Purchase', params);
  }

  static void _track(String event, Map<String, Object?>? params) {
    try {
      final fbq = _fbq;
      if (fbq == null) return;
      final payload = params ?? <String, Object?>{};
      final options = <String, Object?>{'eventID': _uuid.v4()};
      fbq.callAsFunction(
        null,
        'track'.toJS,
        event.toJS,
        payload.jsify(),
        options.jsify(),
      );
    } catch (_) {
      // Píxel bloqueado o no disponible.
    }
  }
}
