/// Convierte un título en la parte legible de la URL (/noticias/&lt;slug&gt;/).
///
/// Debe dar el mismo resultado que la función del backend y que el generador
/// de páginas, porque el panel muestra esta previsualización antes de guardar.
library;

const _acentos = <String, String>{
  'á': 'a',
  'à': 'a',
  'ä': 'a',
  'â': 'a',
  'é': 'e',
  'è': 'e',
  'ë': 'e',
  'ê': 'e',
  'í': 'i',
  'ì': 'i',
  'ï': 'i',
  'î': 'i',
  'ó': 'o',
  'ò': 'o',
  'ö': 'o',
  'ô': 'o',
  'ú': 'u',
  'ù': 'u',
  'ü': 'u',
  'û': 'u',
  'ñ': 'n',
  'ç': 'c',
};

/// Máximo de palabras: las URLs cortas se comparten y se leen mejor.
const _maxPalabras = 9;
const _maxLargo = 70;

String newsSlugify(String raw) {
  var text = raw.toLowerCase();
  _acentos.forEach((from, to) {
    text = text.replaceAll(from, to);
  });

  final palabras = text
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .trim()
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .take(_maxPalabras);

  final slug = palabras.join('-');
  if (slug.isEmpty) return 'aviso';
  return slug.length <= _maxLargo ? slug : slug.substring(0, _maxLargo);
}
