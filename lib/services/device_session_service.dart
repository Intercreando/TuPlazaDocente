import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../config/app_config.dart';

/// Resultado del registro / verificación de dispositivo Premium.
class DeviceSessionResult {
  const DeviceSessionResult({
    required this.allowed,
    this.skipped = false,
    this.kickedOthers = const [],
    this.message,
  });

  final bool allowed;
  final bool skipped;
  final List<String> kickedOthers;
  final String? message;
}

/// Identidad local del dispositivo + callables de cupo Premium.
class DeviceSessionService {
  DeviceSessionService({FirebaseFunctions? functions})
      : _functionsOverride = functions;

  static const _prefsKey = 'tpd_device_id_v1';
  static const _maxIdLen = 64;

  final FirebaseFunctions? _functionsOverride;
  String? _cachedDeviceId;

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) {
      throw Exception('Firebase no está disponible.');
    }
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  /// UUID estable por navegador/instalación PWA.
  Future<String> getOrCreateDeviceId() async {
    if (_cachedDeviceId != null) return _cachedDeviceId!;
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_prefsKey);
    if (id == null || id.length < 8 || id.length > _maxIdLen) {
      id = const Uuid().v4().replaceAll('-', '');
      if (id.length > _maxIdLen) {
        id = id.substring(0, _maxIdLen);
      }
      await prefs.setString(_prefsKey, id);
    }
    _cachedDeviceId = id;
    return id;
  }

  String get deviceLabel {
    if (kIsWeb) return 'Navegador web';
    return 'Dispositivo';
  }

  /// Registra este dispositivo y expulsa los más antiguos si hay más de N.
  Future<DeviceSessionResult> registerPremiumDevice() async {
    try {
      final deviceId = await getOrCreateDeviceId();
      final callable = _functions.httpsCallable(
        'registerPremiumDevice',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 20)),
      );
      final result = await callable.call(<String, dynamic>{
        'deviceId': deviceId,
        'label': deviceLabel,
        'maxDevices': AppConfig.maxPremiumDevices,
      });
      return _parseResult(result.data, expectAllowed: true);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('registerPremiumDevice: ${e.code} ${e.message}');
      // No bloquear Premium por fallo temporal de red/función.
      return DeviceSessionResult(
        allowed: true,
        skipped: true,
        message: e.message,
      );
    } catch (e) {
      debugPrint('registerPremiumDevice error: $e');
      return const DeviceSessionResult(allowed: true, skipped: true);
    }
  }

  /// Comprueba si este dispositivo sigue en el cupo (sin reinsertarse).
  Future<DeviceSessionResult> checkPremiumDevice() async {
    try {
      final deviceId = await getOrCreateDeviceId();
      final callable = _functions.httpsCallable(
        'checkPremiumDevice',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 15)),
      );
      final result = await callable.call(<String, dynamic>{
        'deviceId': deviceId,
      });
      return _parseResult(result.data, expectAllowed: false);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('checkPremiumDevice: ${e.code} ${e.message}');
      return DeviceSessionResult(
        allowed: true,
        skipped: true,
        message: e.message,
      );
    } catch (e) {
      debugPrint('checkPremiumDevice error: $e');
      return const DeviceSessionResult(allowed: true, skipped: true);
    }
  }

  DeviceSessionResult _parseResult(dynamic raw, {required bool expectAllowed}) {
    if (raw is! Map) {
      return DeviceSessionResult(allowed: expectAllowed, skipped: true);
    }
    final data = Map<String, dynamic>.from(raw);
    final skipped = data['skipped'] == true;
    if (skipped) {
      return const DeviceSessionResult(allowed: true, skipped: true);
    }
    final allowed = data['allowed'] != false;
    final kicked = <String>[];
    final rawKicked = data['kicked'];
    if (rawKicked is List) {
      for (final item in rawKicked) {
        if (item != null) kicked.add(item.toString());
      }
    }
    return DeviceSessionResult(
      allowed: allowed,
      kickedOthers: kicked,
      message: data['message'] as String?,
    );
  }
}
