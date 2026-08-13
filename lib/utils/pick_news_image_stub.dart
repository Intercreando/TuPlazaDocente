import 'dart:typed_data';

class PickedNewsImage {
  const PickedNewsImage({
    required this.bytes,
    required this.contentType,
  });

  final Uint8List bytes;
  final String contentType;
}

Future<PickedNewsImage?> pickNewsImage() async => null;
