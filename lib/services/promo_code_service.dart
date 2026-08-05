import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Resultado de canjear un código (gratis o descuento).
class PromoRedeemResult {
  const PromoRedeemResult({
    required this.ok,
    required this.code,
    required this.type,
    required this.discountPercent,
  });

  final bool ok;
  final String code;

  /// `grant` | `discount`
  final String type;
  final int discountPercent;

  bool get isGrant => type == 'grant';
  bool get isDiscount => type == 'discount' && discountPercent > 0;
}

class PromoCodeAdminItem {
  const PromoCodeAdminItem({
    required this.code,
    required this.type,
    required this.discountPercent,
    required this.active,
    required this.maxRedemptions,
    required this.redeemedCount,
    this.note,
    this.expiresAtMs,
  });

  final String code;
  final String type;
  final int discountPercent;
  final bool active;
  final int maxRedemptions;
  final int redeemedCount;
  final String? note;
  final int? expiresAtMs;

  factory PromoCodeAdminItem.fromMap(Map<String, dynamic> raw) {
    return PromoCodeAdminItem(
      code: '${raw['code'] ?? ''}',
      type: '${raw['type'] ?? 'grant'}',
      discountPercent: (raw['discountPercent'] as num?)?.toInt() ?? 0,
      active: raw['active'] == true,
      maxRedemptions: (raw['maxRedemptions'] as num?)?.toInt() ?? 0,
      redeemedCount: (raw['redeemedCount'] as num?)?.toInt() ?? 0,
      note: raw['note'] as String?,
      expiresAtMs: (raw['expiresAtMs'] as num?)?.toInt(),
    );
  }
}

/// Cliente de códigos promo (canje + admin).
class PromoCodeService {
  PromoCodeService({FirebaseFunctions? functions})
      : _functionsOverride = functions;

  final FirebaseFunctions? _functionsOverride;

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) {
      throw Exception('Firebase no está disponible.');
    }
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  Future<PromoRedeemResult> redeem(String code) async {
    try {
      final callable = _functions.httpsCallable('activatePremiumCode');
      final result = await callable.call(<String, dynamic>{
        'code': code.trim(),
      });
      final raw = result.data;
      if (raw is! Map) {
        return const PromoRedeemResult(
          ok: true,
          code: '',
          type: 'grant',
          discountPercent: 0,
        );
      }
      final data = Map<String, dynamic>.from(raw);
      return PromoRedeemResult(
        ok: data['ok'] == true,
        code: '${data['code'] ?? code}'.toUpperCase(),
        type: '${data['type'] ?? 'grant'}',
        discountPercent: (data['discountPercent'] as num?)?.toInt() ?? 0,
      );
    } on FirebaseFunctionsException catch (e) {
      debugPrint('PromoCodeService redeem: ${e.code} ${e.message}');
      throw Exception(_friendly(e));
    }
  }

  Future<List<PromoCodeAdminItem>> adminList() async {
    final callable = _functions.httpsCallable('adminListPromoCodes');
    final result = await callable.call();
    final raw = result.data;
    if (raw is! Map) return const [];
    final data = Map<String, dynamic>.from(raw);
    final items = data['items'];
    if (items is! List) return const [];
    return items
        .whereType<Map>()
        .map((e) => PromoCodeAdminItem.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> adminUpsert({
    required String code,
    required String type,
    int discountPercent = 0,
    int maxRedemptions = 0,
    String? note,
    bool active = true,
    int? expiresAtMs,
  }) async {
    final callable = _functions.httpsCallable('adminUpsertPromoCode');
    await callable.call(<String, dynamic>{
      'code': code.trim().toUpperCase(),
      'type': type,
      'discountPercent': discountPercent,
      'maxRedemptions': maxRedemptions,
      'note': note,
      'active': active,
      'expiresAtMs': ?expiresAtMs,
    });
  }

  Future<void> adminSetActive({
    required String code,
    required bool active,
  }) async {
    try {
      final callable = _functions.httpsCallable('adminSetPromoCodeActive');
      await callable.call(<String, dynamic>{
        'code': code.trim().toUpperCase(),
        'active': active,
      });
    } on FirebaseFunctionsException catch (e) {
      debugPrint('PromoCodeService adminSetActive: ${e.code} ${e.message}');
      throw Exception(_friendly(e));
    }
  }

  /// Elimina un código desactivado. Falla si aún está activo.
  Future<void> adminDelete({required String code}) async {
    try {
      final callable = _functions.httpsCallable('adminDeletePromoCode');
      await callable.call(<String, dynamic>{
        'code': code.trim().toUpperCase(),
      });
    } on FirebaseFunctionsException catch (e) {
      debugPrint('PromoCodeService adminDelete: ${e.code} ${e.message}');
      throw Exception(_friendly(e));
    }
  }

  String _friendly(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'No tienes permiso de administrador.';
      case 'unauthenticated':
        return 'Inicia sesión con tu cuenta admin.';
      case 'already-exists':
        return e.message ?? 'Ya canjeaste este código.';
      case 'resource-exhausted':
        return e.message ?? 'Este código ya no tiene usos.';
      case 'not-found':
        return e.message ?? 'Código no encontrado.';
      case 'failed-precondition':
      case 'invalid-argument':
        return e.message ?? 'Código no válido.';
      default:
        return e.message ?? 'Error del servidor (${e.code}).';
    }
  }
}
