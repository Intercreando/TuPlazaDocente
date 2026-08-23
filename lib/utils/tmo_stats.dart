/// TMO: tiempo medio por pregunta, solo con muestras que sí se cronometraron.
abstract final class TmoStats {
  static const int minSeconds = 1;
  static const int maxSeconds = 600;

  /// Convierte el cronómetro a segundos enteros (redondeo, no recorte a 0).
  static int elapsedSeconds(DateTime started, {DateTime? now}) {
    final ms = (now ?? DateTime.now()).difference(started).inMilliseconds;
    if (ms <= 0) return minSeconds;
    return (ms / 1000).round().clamp(minSeconds, maxSeconds);
  }

  /// `null` si no hay muestras con cronómetro. Nunca divide por el total
  /// histórico: ese total incluye respuestas de antes de medir el tiempo.
  static double? averageSeconds({
    required int timeSpent,
    required int timedCount,
  }) {
    if (timedCount < 1 || timeSpent < 1) return null;
    return timeSpent / timedCount;
  }

  /// Perfiles viejos: había segundos pero se dividían por todas las evidencias.
  /// Sin contador de muestras ese promedio no es confiable: se descarta.
  static Map<String, int> timeIfSampled({
    required Map<String, int> timeSpent,
    required Map<String, int> timedCount,
  }) {
    if (timedCount.isNotEmpty) return timeSpent;
    return const {};
  }
}
