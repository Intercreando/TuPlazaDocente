import 'package:web/web.dart' as web;

/// Detecta tráfico de pauta (Meta/Google) y lo recuerda 48 h.
/// Así el claim de bienvenida no se pierde si se cierra la pestaña.
abstract final class PaidTraffic {
  static const _storageKey = 'tpd_paid_traffic';
  static const _pendingKey = 'tpd_paid_claim_at';
  static const _settledUidKey = 'tpd_paid_claim_settled_uid';
  static const _pendingTtlMs = 48 * 60 * 60 * 1000;

  static const _paidSources = {
    'facebook',
    'instagram',
    'fb',
    'ig',
    'meta',
    'anuncios',
    'google',
    'googleads',
    'adwords',
    'adsense',
  };

  static const _paidMedia = {
    'cpc',
    'ppc',
    'paid',
    'paid_social',
    'paidsocial',
    'paid-social',
    'display',
    'cpm',
    'banner',
    'paid_search',
    'paidsearch',
  };

  /// True si esta visita (o las últimas 48 h) vino de anuncio.
  static bool get isPaid {
    try {
      if (web.window.sessionStorage.getItem(_storageKey) == '1') {
        return true;
      }
    } catch (_) {}
    if (_pendingFresh) return true;
    try {
      return looksPaid(Uri.parse(web.window.location.href));
    } catch (_) {
      return false;
    }
  }

  /// Pauta: registro. Orgánico: onboarding de invitado.
  static String get startPath => isPaid ? '/auth' : '/onboarding';

  static bool get _pendingFresh {
    try {
      final raw = web.window.localStorage.getItem(_pendingKey);
      if (raw == null || raw.isEmpty) return false;
      final at = int.tryParse(raw);
      if (at == null) return false;
      return DateTime.now().millisecondsSinceEpoch - at < _pendingTtlMs;
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
    try {
      web.window.localStorage.setItem(
        _pendingKey,
        DateTime.now().millisecondsSinceEpoch.toString(),
      );
    } catch (_) {}
  }

  /// Tras sellar o rechazar en servidor: no repetir la Cloud Function.
  static void markClaimSettled(String uid) {
    if (uid.isEmpty) return;
    try {
      web.window.localStorage.setItem(_settledUidKey, uid);
    } catch (_) {}
    clearPendingClaim();
  }

  static bool isClaimSettledFor(String uid) {
    if (uid.isEmpty) return false;
    try {
      return web.window.localStorage.getItem(_settledUidKey) == uid;
    } catch (_) {
      return false;
    }
  }

  static void clearClaimSettled() {
    try {
      web.window.localStorage.removeItem(_settledUidKey);
    } catch (_) {}
  }

  /// Tras sellar la cuenta en servidor, ya no hace falta el pendiente local.
  static void clearPendingClaim() {
    try {
      web.window.localStorage.removeItem(_pendingKey);
    } catch (_) {}
  }

  static bool looksPaid(Uri uri) {
    final q = uri.queryParameters;
    if (q.containsKey('fbclid') ||
        q.containsKey('gclid') ||
        q.containsKey('gbraid') ||
        q.containsKey('wbraid') ||
        q.containsKey('ttclid')) {
      return true;
    }
    final source = (q['utm_source'] ?? '').trim().toLowerCase();
    if (_paidSources.contains(source)) return true;
    final medium = (q['utm_medium'] ?? '').trim().toLowerCase();
    return _paidMedia.contains(medium);
  }
}
