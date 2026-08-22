/// Señales de pauta en la URL (query normal o parámetros detrás del hash).
abstract final class PaidTrafficSignals {
  static const paidSources = {
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

  static const paidMedia = {
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

  static const clickIds = {
    'fbclid',
    'gclid',
    'gbraid',
    'wbraid',
    'ttclid',
  };

  /// True si la URI trae clic de Ads (antes o después de #).
  static bool looksPaid(Uri uri) {
    if (paramsLookPaid(uri.queryParameters)) return true;
    return paramsLookPaid(queryParametersInFragment(uri.fragment));
  }

  /// Fragmento tipo `/auth?fbclid=…` o `?gclid=…`.
  static Map<String, String> queryParametersInFragment(String fragment) {
    if (fragment.isEmpty) return const {};
    final q = fragment.indexOf('?');
    if (q < 0 || q >= fragment.length - 1) return const {};
    return Uri.splitQueryString(fragment.substring(q + 1));
  }

  static bool paramsLookPaid(Map<String, String> q) {
    for (final key in clickIds) {
      if (q.containsKey(key) && (q[key] ?? '').isNotEmpty) return true;
    }
    final source = (q['utm_source'] ?? '').trim().toLowerCase();
    if (paidSources.contains(source)) return true;
    final medium = (q['utm_medium'] ?? '').trim().toLowerCase();
    return paidMedia.contains(medium);
  }
}
