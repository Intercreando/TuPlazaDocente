import 'package:shared_preferences/shared_preferences.dart';

/// Cupo de tutorías del día (Bogotá) para recordar los otros entrenamientos.
abstract final class TutorDayBalance {
  static const nudgeAfterVisits = 3;

  static const _dayKey = 'tutor_balance_day';
  static const _tutorKey = 'tutor_balance_tutor_count';
  static const _otherKey = 'tutor_balance_other_count';

  /// Fecha civil en Colombia (UTC−5, sin DST).
  static String civilDayBogota([DateTime? now]) {
    final utc = (now ?? DateTime.now()).toUtc();
    final bogota = utc.subtract(const Duration(hours: 5));
    final y = bogota.year.toString().padLeft(4, '0');
    final m = bogota.month.toString().padLeft(2, '0');
    final d = bogota.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Una visita = cerró el caso principal del Tutor personalizado.
  static Future<int> recordTutorVisit({
    DateTime? now,
    SharedPreferences? prefs,
  }) async {
    final store = await _ready(prefs, now);
    final next = store.tutorCount + 1;
    await store.prefs.setInt(_tutorKey, next);
    return next;
  }

  /// Práctica, simulacro, preguntas cortas, área o casos.
  static Future<void> recordOtherTraining({
    DateTime? now,
    SharedPreferences? prefs,
  }) async {
    final store = await _ready(prefs, now);
    await store.prefs.setInt(_otherKey, store.otherCount + 1);
  }

  /// Casos cerrados seguidos en esta visita al tutor, sin mezclar otro modo.
  static bool nudgeForStreak({
    required int consecutiveClosed,
    required bool mixedOtherToday,
  }) {
    return consecutiveClosed >= nudgeAfterVisits && !mixedOtherToday;
  }

  /// Ya practicó simulacro, área, cortas u otro modo hoy.
  static Future<bool> hasOtherTrainingToday({
    DateTime? now,
    SharedPreferences? prefs,
  }) async {
    final store = await _ready(prefs, now);
    return store.otherCount > 0;
  }

  static Future<_BalanceStore> _ready(
    SharedPreferences? injected,
    DateTime? now,
  ) async {
    final prefs = injected ?? await SharedPreferences.getInstance();
    final day = civilDayBogota(now);
    if (prefs.getString(_dayKey) != day) {
      await prefs.setString(_dayKey, day);
      await prefs.setInt(_tutorKey, 0);
      await prefs.setInt(_otherKey, 0);
    }
    return _BalanceStore(
      prefs: prefs,
      tutorCount: prefs.getInt(_tutorKey) ?? 0,
      otherCount: prefs.getInt(_otherKey) ?? 0,
    );
  }
}

class _BalanceStore {
  const _BalanceStore({
    required this.prefs,
    required this.tutorCount,
    required this.otherCount,
  });

  final SharedPreferences prefs;
  final int tutorCount;
  final int otherCount;
}
