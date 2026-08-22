import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/utils/paid_traffic_signals.dart';

void main() {
  test('marca pauta con fbclid en query antes del hash', () {
    final uri = Uri.parse(
      'https://www.tuplazadocente.com/?fbclid=abc123#/',
    );
    expect(PaidTrafficSignals.looksPaid(uri), isTrue);
  });

  test('marca pauta con gclid detrás del hash', () {
    final uri = Uri.parse(
      'https://www.tuplazadocente.com/#/auth?gclid=xyz',
    );
    expect(PaidTrafficSignals.looksPaid(uri), isTrue);
  });

  test('marca pauta con utm_source=facebook', () {
    final uri = Uri.parse(
      'https://www.tuplazadocente.com/?utm_source=facebook&utm_medium=cpc',
    );
    expect(PaidTrafficSignals.looksPaid(uri), isTrue);
  });

  test('no marca una visita orgánica', () {
    final uri = Uri.parse('https://www.tuplazadocente.com/#/app');
    expect(PaidTrafficSignals.looksPaid(uri), isFalse);
  });
}
