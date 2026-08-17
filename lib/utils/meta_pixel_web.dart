import 'dart:js_interop';

import 'package:uuid/uuid.dart';

/// Meta Pixel (fbq) + CAPI: el mismo event_id y el mismo matching en ambas rutas.
@JS('fbq')
external JSFunction? get _fbq;

@JS('tpdFbqTrack')
external JSFunction? get _fbqTrack;

@JS('tpdTrackMetaCapi')
external JSFunction? get _capi;

@JS('tpdRememberMetaUser')
external JSFunction? get _remember;

abstract final class MetaPixel {
  static const _uuid = Uuid();

  /// Advanced Matching: correo y UID para CAPI y visitas siguientes.
  static void identify({String? email, String? externalId}) {
    final em = email?.trim() ?? '';
    final eid = externalId?.trim() ?? '';
    if (em.isEmpty && eid.isEmpty) return;
    try {
      _remember?.callAsFunction(null, em.toJS, eid.toJS);
    } catch (_) {
      // Píxel bloqueado o no disponible.
    }
  }

  static void completeRegistration({
    String? method,
    String? email,
    String? externalId,
  }) {
    final params = <String, Object?>{
      'status': true,
      // Valor simbólico > 0: el registro es gratis; el ingreso real va en Purchase.
      'value': 1.0,
      'currency': 'COP',
    };
    if (method != null && method.isNotEmpty) {
      params['content_name'] = method;
    }
    _track(
      'CompleteRegistration',
      params,
      email: email,
      externalId: externalId,
    );
  }

  /// Intención alta: el usuario abre la pasarela de pago (Wompi).
  static void initiateCheckout({
    required double value,
    String currency = 'COP',
    String? contentName,
    String? email,
    String? externalId,
  }) {
    final params = <String, Object?>{
      'value': value,
      'currency': currency,
      'num_items': 1,
    };
    if (contentName != null && contentName.isNotEmpty) {
      params['content_name'] = contentName;
    }
    _track('InitiateCheckout', params, email: email, externalId: externalId);
  }

  static void purchase({
    required double value,
    String currency = 'COP',
    String? contentName,
    String? email,
    String? externalId,
  }) {
    final params = <String, Object?>{'value': value, 'currency': currency};
    if (contentName != null && contentName.isNotEmpty) {
      params['content_name'] = contentName;
    }
    _track('Purchase', params, email: email, externalId: externalId);
  }

  static Map<String, Object?> _userHints(String? email, String? externalId) {
    return {'email': email ?? '', 'external_id': externalId ?? ''};
  }

  static void _track(
    String event,
    Map<String, Object?>? params, {
    String? email,
    String? externalId,
  }) {
    identify(email: email, externalId: externalId);
    final eventId = _uuid.v4();
    final payload = params ?? <String, Object?>{};
    final hints = _userHints(email, externalId);

    // Un solo puente JS: init (em/uid/país) + track Pixel + CAPI.
    try {
      final bridge = _fbqTrack;
      if (bridge != null) {
        bridge.callAsFunction(
          null,
          event.toJS,
          eventId.toJS,
          payload.jsify(),
          hints.jsify(),
        );
        return;
      }
    } catch (_) {
      // Sin puente: se intenta Pixel y CAPI por separado.
    }

    final options = <String, Object?>{'eventID': eventId};
    try {
      final fbq = _fbq;
      if (fbq != null) {
        fbq.callAsFunction(
          null,
          'track'.toJS,
          event.toJS,
          payload.jsify(),
          options.jsify(),
        );
      }
    } catch (_) {
      // Píxel bloqueado o no disponible.
    }
    try {
      _capi?.callAsFunction(
        null,
        event.toJS,
        eventId.toJS,
        payload.jsify(),
        hints.jsify(),
      );
    } catch (_) {
      // CAPI no disponible (local / bloqueo).
    }
  }
}
