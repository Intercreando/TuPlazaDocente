import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

/// Evento beforeinstallprompt tipado para Chrome/Edge.
@JS()
@staticInterop
class BeforeInstallPromptEvent {}

extension BeforeInstallPromptEventExt on BeforeInstallPromptEvent {
  external void prompt();
  external JSPromise<JSAny?> get userChoice;
}

@JS('__tpdDeferredPrompt')
external BeforeInstallPromptEvent? get _globalDeferredPrompt;

@JS('__tpdDeferredPrompt')
external set _globalDeferredPrompt(BeforeInstallPromptEvent? value);

/// Gestiona "Instalar en el inicio" en la PWA web.
///
/// - En Android Chrome/Edge: diálogo nativo vía [beforeinstallprompt].
/// - En iPhone/iPad: Apple no permite instalar por botón; hay que usar Compartir.
class PwaInstallService extends ChangeNotifier {
  PwaInstallService() {
    if (kIsWeb) {
      _bind();
    }
  }

  BeforeInstallPromptEvent? _deferredPrompt;
  bool canInstall = false;
  bool isStandalone = false;
  bool iosHintVisible = false;

  /// Mensaje amigable según plataforma cuando no hay diálogo nativo.
  String get fallbackInstallMessage {
    if (isStandalone) {
      return 'Ya estás en modo app instalada.';
    }
    if (iosHintVisible) {
      return 'En iPhone/iPad: toca Compartir (□↑) y luego “Añadir a pantalla de inicio”. '
          'Apple no permite instalar con un solo botón.';
    }
    return 'En Chrome: menú ⋮ → “Instalar app” o “Añadir a la pantalla de inicio”. '
        'Si no aparece, abre la página en Chrome (no en Instagram/WhatsApp).';
  }

  void _bind() {
    try {
      isStandalone = _detectStandalone();
      iosHintVisible = _isIos() && !isStandalone;
      _syncDeferredPrompt();

      web.window.addEventListener(
        'beforeinstallprompt',
        (web.Event event) {
          event.preventDefault();
          _deferredPrompt = event as BeforeInstallPromptEvent;
          _globalDeferredPrompt = _deferredPrompt;
          canInstall = !isStandalone;
          notifyListeners();
        }.toJS,
      );

      // Evento propio de index.html cuando el prompt se capturó antes de Flutter.
      web.window.addEventListener(
        'tpd-install-ready',
        (web.Event _) {
          _syncDeferredPrompt();
          notifyListeners();
        }.toJS,
      );

      web.window.addEventListener(
        'appinstalled',
        (web.Event _) {
          canInstall = false;
          isStandalone = true;
          iosHintVisible = false;
          _deferredPrompt = null;
          _globalDeferredPrompt = null;
          notifyListeners();
        }.toJS,
      );
    } catch (_) {
      canInstall = false;
    }
  }

  void _syncDeferredPrompt() {
    try {
      final global = _globalDeferredPrompt;
      if (global != null) {
        _deferredPrompt = global;
      }
      canInstall = !isStandalone && _deferredPrompt != null;
    } catch (_) {
      canInstall = false;
    }
  }

  bool _isIos() {
    final ua = web.window.navigator.userAgent.toLowerCase();
    return ua.contains('iphone') || ua.contains('ipad') || ua.contains('ipod');
  }

  bool _detectStandalone() {
    try {
      if (web.window.matchMedia('(display-mode: standalone)').matches) {
        return true;
      }
      // iOS Safari: modo app añadida a inicio.
      if (web.window.matchMedia('(display-mode: fullscreen)').matches) {
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> promptInstall() async {
    _syncDeferredPrompt();
    final promptEvent = _deferredPrompt;
    if (!kIsWeb || promptEvent == null) {
      return false;
    }

    try {
      promptEvent.prompt();
      await promptEvent.userChoice.toDart;
      _deferredPrompt = null;
      _globalDeferredPrompt = null;
      canInstall = false;
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }
}
