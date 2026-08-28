import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/models/user_profile.dart';

void main() {
  test('hasMentorPass es true solo con vencimiento futuro', () {
    expect(const UserProfile().hasMentorPass, isFalse);
    expect(
      UserProfile(
        mentorPassExpiresAt: DateTime.now().subtract(const Duration(hours: 1)),
      ).hasMentorPass,
      isFalse,
    );
    expect(
      UserProfile(
        mentorPassExpiresAt: DateTime.now().add(const Duration(days: 10)),
      ).hasMentorPass,
      isTrue,
    );
  });

  test('fromJson lee prueba y pase del servidor', () {
    final profile = UserProfile.fromJson({
      'mentorTrialUsed': true,
      'mentorPassExpiresAt': '2026-09-28T15:00:00.000Z',
    });
    expect(profile.mentorTrialUsed, isTrue);
    expect(profile.mentorPassExpiresAt, isNotNull);
  });
}
