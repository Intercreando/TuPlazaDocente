import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tu_plaza_docente/services/tutor_day_balance.dart';

void main() {
  final now = DateTime.utc(2026, 8, 28, 17); // 12:00 en Bogotá

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('con 2 tutorías no recuerda los otros modos', () async {
    final prefs = await SharedPreferences.getInstance();
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    expect(
      await TutorDayBalance.shouldShowNudge(now: now, prefs: prefs),
      isFalse,
    );
  });

  test(
    'a la tercera tutoría del día, si no practicó otra cosa, sí recuerda',
    () async {
      final prefs = await SharedPreferences.getInstance();
      await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
      await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
      await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
      expect(
        await TutorDayBalance.shouldShowNudge(now: now, prefs: prefs),
        isTrue,
      );
    },
  );

  test('si ya hizo simulacro o práctica, no insiste', () async {
    final prefs = await SharedPreferences.getInstance();
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    await TutorDayBalance.recordOtherTraining(now: now, prefs: prefs);
    expect(
      await TutorDayBalance.shouldShowNudge(now: now, prefs: prefs),
      isFalse,
    );
  });

  test('al día siguiente el conteo arranca de cero', () async {
    final prefs = await SharedPreferences.getInstance();
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    await TutorDayBalance.recordTutorVisit(now: now, prefs: prefs);
    final nextDay = now.add(const Duration(days: 1));
    expect(
      await TutorDayBalance.shouldShowNudge(now: nextDay, prefs: prefs),
      isFalse,
    );
  });
}
