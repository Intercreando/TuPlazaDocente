/// Página de aterrizaje SEO (una intención de búsqueda).
class SeoLandingPage {
  const SeoLandingPage({
    required this.id,
    required this.path,
    required this.kind,
    required this.source,
    required this.title,
    required this.description,
    required this.h1,
    required this.kicker,
    required this.lead,
    required this.ctaTitle,
    required this.ctaBody,
    required this.ctaLabel,
    required this.items,
    this.related = const [],
    this.faq = const [],
  });

  final String id;
  final String path;
  final String kind;
  final String source;
  final String title;
  final String description;
  final String h1;
  final String kicker;
  final String lead;
  final String ctaTitle;
  final String ctaBody;
  final String ctaLabel;
  final List<SeoLandingItem> items;
  final List<SeoLandingLink> related;
  final List<SeoFaq> faq;

  bool get isQuiz => kind == 'quiz';

  factory SeoLandingPage.fromJson(Map<String, dynamic> json) {
    List<T> mapList<T>(String key, T Function(Map<String, dynamic>) parse) {
      final raw = json[key];
      if (raw is! List) return [];
      return raw
          .whereType<Map>()
          .map((e) => parse(Map<String, dynamic>.from(e)))
          .toList();
    }

    return SeoLandingPage(
      id: json['id'] as String? ?? '',
      path: json['path'] as String? ?? '',
      kind: json['kind'] as String? ?? 'worked',
      source: json['source'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      h1: json['h1'] as String? ?? '',
      kicker: json['kicker'] as String? ?? '',
      lead: json['lead'] as String? ?? '',
      ctaTitle: json['ctaTitle'] as String? ?? '',
      ctaBody: json['ctaBody'] as String? ?? '',
      ctaLabel: json['ctaLabel'] as String? ?? 'Registrarme gratis',
      items: mapList('items', SeoLandingItem.fromJson),
      related: mapList('related', SeoLandingLink.fromJson),
      faq: mapList('faq', SeoFaq.fromJson),
    );
  }
}

class SeoLandingItem {
  const SeoLandingItem({
    required this.id,
    required this.eyebrow,
    required this.context,
    required this.stem,
    required this.options,
    required this.correctIndex,
    required this.normative,
    required this.theory,
    required this.distractors,
  });

  final String id;
  final String eyebrow;
  final String context;
  final String stem;
  final List<String> options;
  final int correctIndex;
  final String normative;
  final String theory;
  final List<String?> distractors;

  factory SeoLandingItem.fromJson(Map<String, dynamic> json) {
    final rawOpts = json['options'];
    final rawDist = json['distractors'];
    return SeoLandingItem(
      id: json['id'] as String? ?? '',
      eyebrow: json['eyebrow'] as String? ?? '',
      context: json['context'] as String? ?? '',
      stem: json['stem'] as String? ?? '',
      options: rawOpts is List
          ? rawOpts.map((e) => e.toString()).toList()
          : const [],
      correctIndex: json['correctIndex'] as int? ?? 0,
      normative: json['normative'] as String? ?? '',
      theory: json['theory'] as String? ?? '',
      distractors: rawDist is List
          ? rawDist.map((e) => e?.toString()).toList()
          : const [],
    );
  }
}

class SeoLandingLink {
  const SeoLandingLink({required this.href, required this.label});

  final String href;
  final String label;

  factory SeoLandingLink.fromJson(Map<String, dynamic> json) {
    return SeoLandingLink(
      href: json['href'] as String? ?? '/',
      label: json['label'] as String? ?? '',
    );
  }
}

class SeoFaq {
  const SeoFaq({required this.question, required this.answer});

  final String question;
  final String answer;

  factory SeoFaq.fromJson(Map<String, dynamic> json) {
    return SeoFaq(
      question: json['q'] as String? ?? '',
      answer: json['a'] as String? ?? '',
    );
  }
}
