import 'package:url_launcher/url_launcher.dart';

/// Abre una URL con el navegador / app externa (móvil y escritorio).
Future<bool> openExternalUrl(String url) async {
  try {
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      return false;
    }
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}
