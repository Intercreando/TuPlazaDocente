import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

/// Regenera los iconos `maskable` de la PWA desde el emblema de marca.
///
/// Android 12+ recorta el icono en un círculo para el splash del acceso
/// directo. Si el arte llega con su propio marco (esquinas redondeadas o un
/// recuadro interior), ese borde queda dentro del círculo y se ve como un
/// contorno que no es el logo.
///
/// Solución: fondo liso de borde a borde y el arte centrado ocupando el 66 %
/// del lienzo, que es el área visible que define Android (160 dp de 240 dp).
///
/// Uso: dart run tools/generate_pwa_icons.dart
void main() {
  const srcPath = 'assets/brand/logo-mark.png';
  const outDir = 'web/icons';
  const sizes = <int>[512, 192];
  const artRatio = 0.66;

  final src = File(srcPath);
  if (!src.existsSync()) {
    stderr.writeln('No está el emblema: $srcPath');
    exitCode = 1;
    return;
  }

  final source = img.decodeImage(src.readAsBytesSync());
  if (source == null) {
    stderr.writeln('No se pudo leer $srcPath');
    exitCode = 1;
    return;
  }

  final background = _backgroundColor(source);
  final art = _cropArt(source, background);
  stdout.writeln(
    'Emblema: ${source.width}x${source.height} → arte ${art.width}x${art.height} '
    'sobre #${_hex(background)}',
  );

  for (final size in sizes) {
    final canvas = img.Image(width: size, height: size, numChannels: 4);
    img.fill(canvas, color: background);

    final target = (size * artRatio).round();
    final scale = target / math.max(art.width, art.height);
    final resized = img.copyResize(
      art,
      width: math.max(1, (art.width * scale).round()),
      height: math.max(1, (art.height * scale).round()),
      interpolation: img.Interpolation.cubic,
    );

    img.compositeImage(
      canvas,
      resized,
      dstX: ((size - resized.width) / 2).round(),
      dstY: ((size - resized.height) / 2).round(),
    );

    final outPath = '$outDir/Icon-maskable-$size.png';
    File(outPath).writeAsBytesSync(img.encodePng(canvas));
    stdout.writeln('Escrito $outPath (${size}x$size, arte $target px)');
  }
}

/// Color de fondo del emblema: se toma del borde superior, ya centrado en x
/// para no caer en las esquinas redondeadas transparentes.
img.Color _backgroundColor(img.Image source) {
  final pixel = source.getPixel(source.width ~/ 2, math.max(1, source.height ~/ 40));
  return img.ColorRgba8(
    pixel.r.toInt(),
    pixel.g.toInt(),
    pixel.b.toInt(),
    255,
  );
}

/// Recorta el arte (círculo, libro y llama) descartando el fondo liso.
///
/// Se exige opacidad total y una diferencia de color amplia: así se ignora
/// el borde suavizado del marco original, que si no arrastraría el recuadro
/// entero al recorte.
img.Image _cropArt(img.Image source, img.Color background) {
  const tolerance = 90;
  var minX = source.width;
  var minY = source.height;
  var maxX = -1;
  var maxY = -1;

  for (var y = 0; y < source.height; y++) {
    for (var x = 0; x < source.width; x++) {
      final pixel = source.getPixel(x, y);
      if (pixel.a < 250) continue;
      final diff = (pixel.r - background.r).abs() +
          (pixel.g - background.g).abs() +
          (pixel.b - background.b).abs();
      if (diff <= tolerance) continue;
      if (x < minX) minX = x;
      if (y < minY) minY = y;
      if (x > maxX) maxX = x;
      if (y > maxY) maxY = y;
    }
  }

  if (maxX < 0 || maxY < 0) {
    // Sin arte detectable: se devuelve el original para no romper el icono.
    return source;
  }

  return img.copyCrop(
    source,
    x: minX,
    y: minY,
    width: maxX - minX + 1,
    height: maxY - minY + 1,
  );
}

String _hex(img.Color color) {
  String part(num value) =>
      value.toInt().toRadixString(16).padLeft(2, '0').toUpperCase();
  return '${part(color.r)}${part(color.g)}${part(color.b)}';
}
