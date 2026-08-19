/// Enlace a una fuente oficial (CNSC, decreto, etc.).
class NewsLink {
  const NewsLink({required this.label, required this.url});

  final String label;
  final String url;

  Map<String, String> toMap() => {'label': label, 'url': url};

  static List<NewsLink> listFrom(Object? raw) {
    if (raw is! List) return const [];
    final out = <NewsLink>[];
    for (final item in raw) {
      if (item is! Map) continue;
      final data = Map<String, dynamic>.from(item);
      final label = '${data['label'] ?? ''}'.trim();
      final url = '${data['url'] ?? ''}'.trim();
      if (label.isEmpty || url.isEmpty) continue;
      out.add(NewsLink(label: label, url: url));
    }
    return out;
  }
}

/// Aviso de convocatoria / noticia editorial.
class NewsItem {
  const NewsItem({
    required this.id,
    required this.slug,
    required this.title,
    required this.summary,
    required this.body,
    required this.tag,
    required this.published,
    required this.pinned,
    this.imageUrl,
    this.links = const [],
    this.publishedAtMs,
    this.updatedAtMs,
  });

  final String id;

  /// Parte legible de la URL pública (/noticias/&lt;slug&gt;/).
  final String slug;
  final String title;
  final String summary;
  final String body;
  final String tag;
  final bool published;
  final bool pinned;
  final String? imageUrl;
  final List<NewsLink> links;
  final int? publishedAtMs;
  final int? updatedAtMs;

  /// Lo que se usa al navegar: el slug si existe, el id para los avisos viejos.
  String get routeKey => slug.isEmpty ? id : slug;

  /// URL pública de la noticia, la misma que indexa Google.
  String get publicUrl => 'https://www.tuplazadocente.com/noticias/$routeKey/';

  String get tagLabel {
    switch (tag) {
      case 'convocatoria':
        return 'Convocatoria';
      case 'fecha':
        return 'Fechas';
      case 'cambio':
        return 'Cambio';
      default:
        return 'Aviso';
    }
  }

  factory NewsItem.fromMap(String id, Map<String, dynamic> raw) {
    return NewsItem(
      id: id,
      slug: '${raw['slug'] ?? ''}'.trim(),
      title: '${raw['title'] ?? ''}',
      summary: '${raw['summary'] ?? ''}',
      body: '${raw['body'] ?? ''}',
      tag: '${raw['tag'] ?? 'aviso'}',
      published: raw['published'] == true,
      pinned: raw['pinned'] == true,
      imageUrl: raw['imageUrl'] as String?,
      links: NewsLink.listFrom(raw['links']),
      publishedAtMs:
          (raw['publishedAtMs'] as num?)?.toInt() ??
          _timestampMs(raw['publishedAt']),
      updatedAtMs:
          (raw['updatedAtMs'] as num?)?.toInt() ??
          _timestampMs(raw['updatedAt']),
    );
  }

  static int? _timestampMs(Object? raw) {
    if (raw is int) return raw;
    if (raw is num) return raw.toInt();
    try {
      final ms = (raw as dynamic).millisecondsSinceEpoch;
      if (ms is int) return ms;
    } catch (_) {}
    return null;
  }
}
