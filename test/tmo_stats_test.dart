import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/utils/tmo_stats.dart';

void main() {
  test('el promedio usa solo las preguntas cronometradas', () {
    expect(
      TmoStats.averageSeconds(timeSpent: 90, timedCount: 1),
      closeTo(90, 0.01),
    );
    expect(
      TmoStats.averageSeconds(timeSpent: 180, timedCount: 2),
      closeTo(90, 0.01),
    );
    expect(TmoStats.averageSeconds(timeSpent: 90, timedCount: 0), isNull);
  });

  test('redondea milisegundos en vez de truncar a 0s', () {
    final started = DateTime(2026, 8, 23, 12, 0, 0);
    expect(
      TmoStats.elapsedSeconds(
        started,
        now: started.add(const Duration(milliseconds: 1600)),
      ),
      2,
    );
    expect(
      TmoStats.elapsedSeconds(
        started,
        now: started.add(const Duration(seconds: 75)),
      ),
      75,
    );
  });

  test('descarta tiempos viejos si nunca se contaron las muestras', () {
    expect(
      TmoStats.timeIfSampled(
        timeSpent: const {'pedagogico': 90},
        timedCount: const {},
      ),
      isEmpty,
    );
    expect(
      TmoStats.timeIfSampled(
        timeSpent: const {'pedagogico': 90},
        timedCount: const {'pedagogico': 1},
      ),
      const {'pedagogico': 90},
    );
  });
}
