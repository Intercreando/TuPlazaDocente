import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/seo_landing_page.dart';

/// Carga el catálogo público de landings SEO (misma fuente que el HTML).
abstract final class SeoLandingCatalog {
  static const assetPath = 'assets/seo/landings.json';
  static List<SeoLandingPage>? _cache;

  static Future<List<SeoLandingPage>> load() async {
    if (_cache != null) return _cache!;
    try {
      final raw = await rootBundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      final pages = decoded is Map ? decoded['pages'] : null;
      if (pages is! List) {
        _cache = const [];
        return _cache!;
      }
      _cache = pages
          .whereType<Map>()
          .map((e) => SeoLandingPage.fromJson(Map<String, dynamic>.from(e)))
          .where((p) => p.id.isNotEmpty && p.path.isNotEmpty)
          .toList();
      return _cache!;
    } catch (_) {
      _cache = const [];
      return _cache!;
    }
  }

  static Future<SeoLandingPage?> byId(String id) async {
    final all = await load();
    for (final page in all) {
      if (page.id == id) return page;
    }
    return null;
  }
}
