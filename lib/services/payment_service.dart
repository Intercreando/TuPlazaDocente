import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'promo_code_service.dart';

/// Sesión de checkout Premium (URL Wompi + monto real cobrado).
class PremiumCheckoutSession {
  const PremiumCheckoutSession({
    required this.initPoint,
    required this.amountCop,
    this.reference,
    this.listPriceCop,
    this.discountPercent = 0,
  });

  final String initPoint;
  final double amountCop;
  final String? reference;
  final double? listPriceCop;
  final int discountPercent;
}

/// Cliente de checkout Premium vía Cloud Function + Wompi (Colombia).
class PaymentService {
  PaymentService({FirebaseFunctions? functions}) : _functionsOverride = functions;

  final FirebaseFunctions? _functionsOverride;

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) {
      throw Exception(
        'Firebase no está disponible. Recarga la página e intenta de nuevo.',
      );
    }
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  /// Crea checkout Wompi y devuelve URL + monto real (con descuento si aplica).
  Future<PremiumCheckoutSession> createCheckout() async {
    try {
      final callable = _functions.httpsCallable(
        'createPremiumCheckout',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 45)),
      );
      final result = await callable.call();
      final raw = result.data;
      if (raw is! Map) {
        throw Exception('Respuesta inválida del servidor de pagos.');
      }
      final data = Map<String, dynamic>.from(raw);
      final initPoint = data['initPoint'] as String?;
      if (initPoint == null || initPoint.isEmpty) {
        throw Exception('No recibimos la URL de Wompi.');
      }

      final amountCop = _asDouble(data['amountCop']) ??
          (_asDouble(data['amountInCents']) != null
              ? _asDouble(data['amountInCents'])! / 100
              : null);
      if (amountCop == null || amountCop <= 0) {
        throw Exception('No recibimos el monto del checkout.');
      }

      return PremiumCheckoutSession(
        initPoint: initPoint,
        amountCop: amountCop,
        reference: data['reference']?.toString(),
        listPriceCop: _asDouble(data['listPriceCop']),
        discountPercent: (data['discountPercent'] as num?)?.toInt() ?? 0,
      );
    } on FirebaseFunctionsException catch (e) {
      debugPrint(
        'PaymentService createCheckout: ${e.code} ${e.message} ${e.details}',
      );
      throw Exception(_friendlyFunctionsError(e));
    } catch (e) {
      debugPrint('PaymentService createCheckout error: $e');
      if (e is Exception) rethrow;
      throw Exception(
        'No pudimos iniciar el pago. Verifica tu conexión e intenta de nuevo.',
      );
    }
  }

  /// Alias: solo la URL (compatibilidad).
  Future<String> createCheckoutUrl() async {
    final session = await createCheckout();
    return session.initPoint;
  }

  /// Activa Premium o aplica descuento con código validado en servidor.
  Future<PromoRedeemResult> activateWithCode(String code) async {
    final promo = PromoCodeService();
    return promo.redeem(code);
  }

  double? _asDouble(Object? raw) {
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw);
    return null;
  }

  String _friendlyFunctionsError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return 'Inicia sesión (Google o correo) antes de continuar.';
      case 'failed-precondition':
        return e.message ??
            'No se pudo completar la operación (revisa cuenta o código).';
      case 'invalid-argument':
        return e.message ?? 'Código inválido.';
      case 'already-exists':
        return e.message ?? 'Ya canjeaste este código.';
      case 'resource-exhausted':
        return e.message ?? 'Este código ya no tiene usos disponibles.';
      case 'unavailable':
      case 'not-found':
        return 'El servicio de pagos no está desplegado o disponible aún.';
      default:
        return e.message ?? 'Error del servicio (${e.code}).';
    }
  }
}
