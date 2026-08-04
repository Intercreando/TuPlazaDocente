import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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

  /// Crea checkout Wompi y devuelve la URL de pago (Web Checkout).
  Future<String> createCheckoutUrl() async {
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
      return initPoint;
    } on FirebaseFunctionsException catch (e) {
      debugPrint(
        'PaymentService createCheckout: ${e.code} ${e.message} ${e.details}',
      );
      throw Exception(_friendlyFunctionsError(e));
    } catch (e) {
      debugPrint('PaymentService createCheckout error: $e');
      final msg = e.toString().replaceFirst('Exception: ', '');
      if (msg.isNotEmpty && !msg.contains('No pudimos iniciar')) {
        throw Exception(msg);
      }
      throw Exception(
        'No pudimos iniciar el pago. Verifica tu conexión e intenta de nuevo.',
      );
    }
  }

  /// Activa Premium con código validado en servidor.
  Future<void> activateWithCode(String code) async {
    try {
      final callable = _functions.httpsCallable('activatePremiumCode');
      await callable.call(<String, dynamic>{'code': code.trim()});
    } on FirebaseFunctionsException catch (e) {
      debugPrint('PaymentService activateWithCode: ${e.code} ${e.message}');
      throw Exception(_friendlyFunctionsError(e));
    } catch (e) {
      debugPrint('PaymentService activateWithCode error: $e');
      throw Exception('No pudimos validar el código. Intenta de nuevo.');
    }
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
