import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

/// Recordatorios de racha con Notification API del navegador (PWA web).
class StreakNotificationService {
  bool get isSupported => kIsWeb;

  Future<String> permissionStatus() async {
    if (!kIsWeb) return 'denied';
    try {
      return web.Notification.permission;
    } catch (_) {
      return 'denied';
    }
  }

  Future<bool> requestPermission() async {
    if (!kIsWeb) return false;
    try {
      final result = await web.Notification.requestPermission().toDart;
      return result.toDart == 'granted';
    } catch (e) {
      debugPrint('StreakNotificationService.requestPermission: $e');
      return false;
    }
  }

  /// Muestra un recordatorio local si hay permiso.
  Future<void> showStreakReminder({required int streakDays}) async {
    if (!kIsWeb) return;
    try {
      if (web.Notification.permission != 'granted') return;
      final body = streakDays > 0
          ? 'Llevas $streakDays días. Completa 5 preguntas hoy y no rompas la racha.'
          : 'Empieza tu racha hoy: 5 preguntas · ~10 minutos.';
      web.Notification(
        'TuPlazaDocente — Reto diario',
        web.NotificationOptions(body: body, tag: 'streak-reminder'),
      );
    } catch (e) {
      debugPrint('StreakNotificationService.showStreakReminder: $e');
    }
  }
}
