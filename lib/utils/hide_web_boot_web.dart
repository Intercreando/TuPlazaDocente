import 'dart:async';

import 'package:web/web.dart' as web;

/// Quita el HTML de SEO y el overlay `#boot` cuando Flutter ya pintó.
void hideWebBoot() {
  try {
    web.document.getElementById('seo')?.remove();
    final boot = web.document.getElementById('boot');
    if (boot == null) return;
    boot.classList.add('boot-out');
    Timer(const Duration(milliseconds: 320), () {
      web.document.getElementById('boot')?.remove();
    });
  } catch (_) {}
}
