import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

/// Resultado de elegir una imagen en el navegador.
class PickedNewsImage {
  const PickedNewsImage({
    required this.bytes,
    required this.contentType,
  });

  final Uint8List bytes;
  final String contentType;
}

/// Abre el selector de archivos del navegador (solo web).
Future<PickedNewsImage?> pickNewsImage() async {
  final input = web.HTMLInputElement()
    ..type = 'file'
    ..accept = 'image/jpeg,image/png,image/webp';
  final done = Completer<web.File?>();

  void onChange(web.Event _) {
    final files = input.files;
    done.complete(files == null || files.length == 0 ? null : files.item(0));
  }

  input.addEventListener('change', onChange.toJS);
  input.click();
  final file = await done.future;
  if (file == null) return null;

  final buffer = await file.arrayBuffer().toDart;
  final bytes = buffer.toDart.asUint8List();
  final type = file.type.trim().isEmpty ? 'image/jpeg' : file.type;
  return PickedNewsImage(bytes: bytes, contentType: type);
}
