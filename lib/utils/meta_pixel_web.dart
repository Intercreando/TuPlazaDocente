import 'dart:js_interop';

/// Meta Pixel (fbq) en Flutter Web.
@JS('fbq')
external JSFunction? get _fbq;

abstract final class MetaPixel {
  static void completeRegistration({String? method}) {
    _track(
      'CompleteRegistration',
      method == null ? null : <String, Object?>{'content_name': method},
    );
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
      if (params == null) {
        fbq.callAsFunction(null, 'track'.toJS, event.toJS);
      } else {
        fbq.callAsFunction(null, 'track'.toJS, event.toJS, params.jsify());
      }
    } catch (_) {
      // Píxel bloqueado o no disponible.
    }
  }
}
