import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Lado máximo de la portada tras redimensionar.
const int kNewsCoverMaxSide = 1600;

/// Calidad JPEG inicial (0–100).
const int kNewsCoverJpegQuality = 72;

const int _kMaxBytes = 2 * 1024 * 1024;

/// Redimensiona y recodifica a JPEG para no saturar Storage ni el ancho de banda.
Uint8List compressNewsCoverBytes(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw Exception('No se pudo leer la imagen. Usa JPG, PNG o WebP.');
  }

  var out = decoded;
  if (out.width > kNewsCoverMaxSide || out.height > kNewsCoverMaxSide) {
    out = out.width >= out.height
        ? img.copyResize(
            out,
            width: kNewsCoverMaxSide,
            interpolation: img.Interpolation.linear,
          )
        : img.copyResize(
            out,
            height: kNewsCoverMaxSide,
            interpolation: img.Interpolation.linear,
          );
  }

  var quality = kNewsCoverJpegQuality;
  var encoded = Uint8List.fromList(img.encodeJpg(out, quality: quality));
  while (encoded.length > _kMaxBytes && quality > 40) {
    quality -= 12;
    encoded = Uint8List.fromList(img.encodeJpg(out, quality: quality));
  }

  if (encoded.length > _kMaxBytes) {
    out = img.copyResize(
      out,
      width: (out.width * 0.7).clamp(1, kNewsCoverMaxSide).round(),
      interpolation: img.Interpolation.linear,
    );
    encoded = Uint8List.fromList(img.encodeJpg(out, quality: 50));
  }

  if (encoded.length > _kMaxBytes) {
    throw Exception('La imagen sigue siendo demasiado grande tras comprimir.');
  }

  return encoded;
}
