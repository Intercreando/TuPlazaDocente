import 'dart:io';

import 'package:image/image.dart' as img;

/// Comprime la foto del hero a JPEG web (ancho máx. 1280, calidad 72).
void main() {
  const srcPath = 'assets/landing/landing-hero-triunfo-lagrimas.png';
  const outPath = 'assets/landing/landing-hero-triunfo-lagrimas.jpg';
  const maxWidth = 1280;
  const quality = 72;

  final src = File(srcPath);
  if (!src.existsSync()) {
    stderr.writeln('No está el original: $srcPath');
    exitCode = 1;
    return;
  }

  final decoded = img.decodeImage(src.readAsBytesSync());
  if (decoded == null) {
    stderr.writeln('No se pudo leer $srcPath');
    exitCode = 1;
    return;
  }

  var out = decoded;
  if (out.width > maxWidth) {
    out = img.copyResize(
      out,
      width: maxWidth,
      interpolation: img.Interpolation.average,
    );
  }

  final jpg = img.encodeJpg(out, quality: quality);
  File(outPath).writeAsBytesSync(jpg);

  final srcKb = (src.lengthSync() / 1024).round();
  final outKb = (jpg.length / 1024).round();
  stdout.writeln(
    'Hero: ${decoded.width}x${decoded.height} ${srcKb} KB PNG → '
    '${out.width}x${out.height} ${outKb} KB JPG',
  );
}
