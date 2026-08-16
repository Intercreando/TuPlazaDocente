/// En tests/móvil no hay document.head web.
abstract final class SeoDocument {
  static void apply({
    required String title,
    required String description,
    required String canonical,
  }) {}
}
