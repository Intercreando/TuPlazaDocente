import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tu_plaza_docente/services/tutor_day_balance.dart';

void main() {
  final now = DateTime.utc(2026, 8, 28, 17); // 12:00 en Bogotá

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('con 2 casos seguidos no recuerda los otros modos', () {
    expect(
      TutorDayBalance.nudgeForStreak(
        consecutiveClosed: 2,
        mixedOtherToday: false,
      ),
      isFalse,
    );
  });

  test('a la tercera tutoría seguida, si no practicó otra cosa, sí recuerda', () {
    expect(
      TutorDayBalance.nudgeForStreak(
        consecutiveClosed: 3,
        mixedOtherToday: false,
      ),
      isTrue,
    );
  });

  test('si ya hizo simulacro o práctica, no insiste', () {
    expect(
      TutorDayBalance.nudgeForStreak(
        consecutiveClosed: 3,
        mixedOtherToday: true,
      ),
      isFalse,
    );
  });

  test('al día siguiente el conteo de otros modos arranca de cero', () async {
    final prefs = await SharedPreferences.getInstance();
    await TutorDayBalance.recordOtherTraining(now: now, prefs: prefs);
    expect(
      await TutorDayBalance.hasOtherTrainingToday(now: now, prefs: prefs),
      isTrue,
    );
    final nextDay = now.add(const Duration(days: 1));
    expect(
      await TutorDayBalance.hasOtherTrainingToday(now: nextDay, prefs: prefs),
      isFalse,
    );
  });
}
