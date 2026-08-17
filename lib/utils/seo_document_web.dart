import 'package:web/web.dart' as web;

/// Title, description y canonical para navegación interna (SPA).
abstract final class SeoDocument {
  static void apply({
    required String title,
    required String description,
    required String canonical,
    bool noIndex = false,
  }) {
    try {
      web.document.title = title;
      _setMeta('description', description);
      _setMeta('og:description', description, property: true);
      _setMeta('og:title', title, property: true);
      _setMeta(
        'robots',
        noIndex ? 'noindex, nofollow' : 'index, follow, max-image-preview:large',
      );
      _setCanonical(canonical);
    } catch (_) {}
  }

  static void _setMeta(String name, String content, {bool property = false}) {
    final attr = property ? 'property' : 'name';
    final doc = web.document;
    var el = doc.querySelector('meta[$attr="$name"]');
    if (el == null) {
      el = doc.createElement('meta');
      el.setAttribute(attr, name);
      doc.head?.append(el);
    }
    el.setAttribute('content', content);
  }

  static void _setCanonical(String href) {
    final doc = web.document;
    var el = doc.querySelector('link[rel="canonical"]');
    if (el == null) {
      el = doc.createElement('link');
      el.setAttribute('rel', 'canonical');
      doc.head?.append(el);
    }
    el.setAttribute('href', href);
  }
}
