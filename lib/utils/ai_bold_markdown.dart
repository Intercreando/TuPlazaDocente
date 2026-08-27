/// Fragmentos de un texto con **negritas** tipo markdown.
class AiBoldSpan {
  const AiBoldSpan({required this.text, required this.bold});

  final String text;
  final bool bold;
}

/// Parser mínimo de `**concepto**` (solo pares, sin anidación).
List<AiBoldSpan> parseAiBoldMarkdown(String raw) {
  final source = raw.trim();
  if (source.isEmpty) return const [];
  final spans = <AiBoldSpan>[];
  final pattern = RegExp(r'\*\*(.+?)\*\*');
  var cursor = 0;
  for (final match in pattern.allMatches(source)) {
    if (match.start > cursor) {
      spans.add(
        AiBoldSpan(text: source.substring(cursor, match.start), bold: false),
      );
    }
    final inner = match.group(1) ?? '';
    if (inner.isNotEmpty) {
      spans.add(AiBoldSpan(text: inner, bold: true));
    }
    cursor = match.end;
  }
  if (cursor < source.length) {
    spans.add(AiBoldSpan(text: source.substring(cursor), bold: false));
  }
  if (spans.isEmpty) {
    return [AiBoldSpan(text: source, bold: false)];
  }
  return spans;
}
