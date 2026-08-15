import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Resultado de marcar la cuenta como tráfico de pauta (servidor).
class PaidAcquisitionClaim {
  const PaidAcquisitionClaim({
    required this.acquiredViaPaid,
    this.welcomeOfferExpiresAt,
    this.already = false,
    this.rejected = false,
  });

  final bool acquiredViaPaid;
  final DateTime? welcomeOfferExpiresAt;
  final bool already;

  /// Cuenta vieja / anónima: no volver a llamar la función.
  final bool rejected;
}

/// Llama a claimPaidAcquisition (idempotente).
class PaidAcquisitionService {
  PaidAcquisitionService({FirebaseFunctions? functions})
      : _functionsOverride = functions;

  final FirebaseFunctions? _functionsOverride;

  FirebaseFunctions? get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  Future<PaidAcquisitionClaim?> claim() async {
    final functions = _functions;
    if (functions == null) return null;
    try {
      final callable = functions.httpsCallable(
        'claimPaidAcquisition',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 20)),
      );
      final result = await callable.call();
      final raw = result.data;
      if (raw is! Map) return null;
      final data = Map<String, dynamic>.from(raw);
      final expRaw = data['welcomeOfferExpiresAt']?.toString();
      return PaidAcquisitionClaim(
        acquiredViaPaid: data['acquiredViaPaid'] == true,
        welcomeOfferExpiresAt:
            expRaw == null || expRaw.isEmpty ? null : DateTime.tryParse(expRaw),
        already: data['already'] == true,
      );
    } on FirebaseFunctionsException catch (e) {
      debugPrint('claimPaidAcquisition: ${e.code} ${e.message}');
      if (e.code == 'failed-precondition') {
        return const PaidAcquisitionClaim(
          acquiredViaPaid: false,
          rejected: true,
        );
      }
      return null;
    } catch (e) {
      debugPrint('claimPaidAcquisition: $e');
      return null;
    }
  }
}
