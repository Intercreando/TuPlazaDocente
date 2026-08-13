import 'dart:async';

import 'package:web/web.dart' as web;

/// Quita el overlay HTML `#boot` con un fade corto.
void hideWebBoot() {
  try {
    final boot = web.document.getElementById('boot');
    if (boot == null) return;
    boot.classList.add('boot-out');
    Timer(const Duration(milliseconds: 320), () {
      web.document.getElementById('boot')?.remove();
    });
  } catch (_) {}
}
