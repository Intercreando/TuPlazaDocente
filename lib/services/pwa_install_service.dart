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

/// Gestiona "Instalar en el inicio" en la PWA web.
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

  void _bind() {
    try {
      isStandalone = _detectStandalone();
      iosHintVisible = _isIos() && !isStandalone;

      web.window.addEventListener(
        'beforeinstallprompt',
        (web.Event event) {
          event.preventDefault();
          _deferredPrompt = event as BeforeInstallPromptEvent;
          canInstall = !isStandalone;
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
          notifyListeners();
        }.toJS,
      );
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
    } catch (_) {}
    return false;
  }

  Future<bool> promptInstall() async {
    final promptEvent = _deferredPrompt;
    if (!kIsWeb || promptEvent == null) {
      return false;
    }

    try {
      promptEvent.prompt();
      await promptEvent.userChoice.toDart;
      _deferredPrompt = null;
      canInstall = false;
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }
}
