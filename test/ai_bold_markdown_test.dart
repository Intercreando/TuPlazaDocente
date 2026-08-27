import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/utils/ai_bold_markdown.dart';

void main() {
  test('parsea dos o tres conceptos en negrita', () {
    const raw =
        'En otro contexto el **castigo** parece inmediato, pero aquí '
        'el **debido proceso** y el **PIAR** exigen otra ruta.';
    final spans = parseAiBoldMarkdown(raw);
    final bold = spans.where((s) => s.bold).map((s) => s.text).toList();
    expect(bold, ['castigo', 'debido proceso', 'PIAR']);
    expect(spans.first.bold, isFalse);
  });

  test('sin marcas devuelve un solo tramo', () {
    final spans = parseAiBoldMarkdown('Solo texto llano.');
    expect(spans, hasLength(1));
    expect(spans.single.bold, isFalse);
    expect(spans.single.text, 'Solo texto llano.');
  });
}
