import 'package:web/web.dart' as web;

import 'open_external_url.dart';

const _hub = 'https://www.tuplazadocente.com/noticias/';

/// Índice público de noticias (HTML que indexa Google).
const newsHubUrl = _hub;

/// Abre una página HTML del sitio, saliendo de la PWA.
///
/// Si usamos el router de Flutter, el visitante se queda en `/#/noticias/...`
/// y no ve la página que rankea. `_self` fuerza una navegación real a Hosting.
Future<void> openSitePage(String url, {bool newTab = false}) async {
  try {
    final target = _absolute(url);
    if (target == null) return;
    if (newTab) {
      await openExternalUrl(target);
      return;
    }
    web.window.open(target, '_self');
  } catch (_) {}
}

Future<void> openNewsHub({bool newTab = false}) =>
    openSitePage('/noticias/', newTab: newTab);

/// Convierte `/noticias/slug/` en URL del origen actual (www, apex o local).
String? _absolute(String raw) {
  final trimmed = raw.trim();
  if (trimmed.startsWith('/')) {
    return '${web.window.location.origin}$trimmed';
  }
  final uri = Uri.tryParse(trimmed);
  if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
    return null;
  }
  return trimmed;
}
