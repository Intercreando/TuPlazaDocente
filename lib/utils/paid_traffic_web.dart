import 'package:web/web.dart' as web;

/// Detecta tráfico de pauta (Meta/Google) y lo recuerda en la pestaña.
/// Así, al ir de `/` a `/auth` no se pierde el `fbclid`.
abstract final class PaidTraffic {
  static const _storageKey = 'tpd_paid_traffic';

  static const _paidSources = {
    'facebook',
    'instagram',
    'fb',
    'ig',
    'meta',
    'anuncios',
  };

  static const _paidMedia = {
    'cpc',
    'ppc',
    'paid',
    'paid_social',
    'paidsocial',
  };

  /// True si esta pestaña llegó desde un anuncio (o se marcó al cargar).
  static bool get isPaid {
    try {
      if (web.window.sessionStorage.getItem(_storageKey) == '1') {
        return true;
      }
    } catch (_) {}
    try {
      return looksPaid(Uri.parse(web.window.location.href));
    } catch (_) {
      return false;
    }
  }

  /// Persiste la marca si el URI actual trae parámetros de pauta.
  static void captureFromUri(Uri uri) {
    if (!looksPaid(uri)) return;
    try {
      web.window.sessionStorage.setItem(_storageKey, '1');
    } catch (_) {}
  }

  static bool looksPaid(Uri uri) {
    final q = uri.queryParameters;
    if (q.containsKey('fbclid') ||
        q.containsKey('gclid') ||
        q.containsKey('ttclid')) {
      return true;
    }
    final source = (q['utm_source'] ?? '').trim().toLowerCase();
    if (_paidSources.contains(source)) return true;
    final medium = (q['utm_medium'] ?? '').trim().toLowerCase();
    return _paidMedia.contains(medium);
  }
}
