import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('el wav del gancho está en assets y es un RIFF válido', () async {
    final data = await rootBundle.load('assets/reels/sfx/hook.wav');
    expect(data.lengthInBytes, greaterThan(1000));
    final head = data.buffer.asUint8List(data.offsetInBytes, 4);
    expect(String.fromCharCodes(head), 'RIFF');
  });
}
