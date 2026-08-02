import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

/// Cliente de checkout Premium vía Cloud Function + Mercado Pago.
class PaymentService {
  PaymentService({FirebaseFunctions? functions})
      : _functions = functions ??
            FirebaseFunctions.instanceFor(region: 'southamerica-east1');

  final FirebaseFunctions _functions;

  /// Crea preferencia y devuelve URL de pago (init_point).
  Future<String> createCheckoutUrl() async {
    try {
      final callable = _functions.httpsCallable('createPremiumCheckout');
      final result = await callable.call();
      final data = Map<String, dynamic>.from(result.data as Map);
      final initPoint = data['initPoint'] as String?;
      if (initPoint == null || initPoint.isEmpty) {
        throw Exception('No recibimos la URL de Mercado Pago.');
      }
      return initPoint;
    } on FirebaseFunctionsException catch (e) {
      debugPrint(
        'PaymentService createCheckout: ${e.code} ${e.message}',
      );
      throw Exception(_friendlyFunctionsError(e));
    } catch (e) {
      debugPrint('PaymentService createCheckout error: $e');
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
            'Mercado Pago aún no está configurado en el servidor.';
      case 'invalid-argument':
        return e.message ?? 'Código inválido.';
      case 'unavailable':
      case 'not-found':
        return 'El servicio de pagos no está desplegado o disponible aún.';
      default:
        return e.message ?? 'Error del servicio (${e.code}).';
    }
  }
}
