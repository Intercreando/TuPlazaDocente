import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/models/news_item.dart';
import 'package:tu_plaza_docente/utils/news_slug.dart';

/// El slug es la URL pública de la noticia: si cambia de forma, Google pierde
/// la página que ya tenía indexada. Estas reglas deben coincidir con las del
/// backend (functions/news_admin.js) y del generador de páginas.
void main() {
  test('quita tildes, mayúsculas y signos', () {
    expect(
      newsSlugify('¡Atención! Inscripción del Concurso Docente'),
      'atencion-inscripcion-del-concurso-docente',
    );
  });

  test('descarta emojis y espacios sobrantes', () {
    expect(
      newsSlugify('  🚨  La CNSC publica   el acuerdo '),
      'la-cnsc-publica-el-acuerdo',
    );
  });

  test('se queda con las primeras nueve palabras', () {
    final slug = newsSlugify(
      'uno dos tres cuatro cinco seis siete ocho nueve diez once',
    );
    expect(slug, 'uno-dos-tres-cuatro-cinco-seis-siete-ocho-nueve');
  });

  test('nunca devuelve una cadena vacía', () {
    expect(newsSlugify('¿¡!?'), 'aviso');
    expect(newsSlugify(''), 'aviso');
  });

  test('no supera los setenta caracteres', () {
    final slug = newsSlugify(
      'convocatoria extraordinaria para docentes orientadores directivos '
      'rurales urbanos',
    );
    expect(slug.length, lessThanOrEqualTo(70));
  });

  test('la URL pública es la que indexa Google, con barra final', () {
    const item = NewsItem(
      id: 'abc',
      slug: 'opec-preliminar-concurso-docente-2026',
      title: 'OPEC preliminar',
      summary: 'Resumen',
      body: 'Cuerpo',
      tag: 'convocatoria',
      published: true,
      pinned: false,
    );
    expect(
      item.publicUrl,
      'https://www.tuplazadocente.com/noticias/opec-preliminar-concurso-docente-2026/',
    );
  });
}
