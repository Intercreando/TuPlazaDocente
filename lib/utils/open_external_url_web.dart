import 'package:web/web.dart' as web;

/// Abre una URL en una pestaña nueva (web nativo, sin url_launcher).
Future<bool> openExternalUrl(String url) async {
  try {
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      return false;
    }
    web.window.open(url, '_blank');
    return true;
  } catch (_) {
    return false;
  }
}
