import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/models/enums.dart';
import 'package:tu_plaza_docente/models/user_profile.dart';
import 'package:tu_plaza_docente/utils/progress_gaps.dart';

void main() {
  test('si solo hay pedagógico, el hueco es Numérica (como el radar)', () {
    const profile = UserProfile(
      pillarTotal: {'pedagogico': 12},
      pillarCorrect: {'pedagogico': 8},
    );
    expect(
      ProgressGaps.unmeasuredCognitive(profile),
      [
        CompetencyPillar.aptitudNumerica,
        CompetencyPillar.lecturaCritica,
        CompetencyPillar.comportamental,
      ],
    );
    expect(ProgressGaps.weakestPillar(profile), CompetencyPillar.aptitudNumerica);
  });

  test('sin ninguna evidencia, el primer foco es pedagógico (50% CNSC)', () {
    const profile = UserProfile();
    expect(ProgressGaps.weakestPillar(profile), CompetencyPillar.pedagogico);
  });

  test('con los 4 pilares medidos, gana el de menor acierto', () {
    const profile = UserProfile(
      pillarTotal: {
        'aptitudNumerica': 10,
        'lecturaCritica': 10,
        'pedagogico': 10,
        'comportamental': 10,
      },
      pillarCorrect: {
        'aptitudNumerica': 8,
        'lecturaCritica': 3,
        'pedagogico': 7,
        'comportamental': 6,
      },
    );
    expect(ProgressGaps.unmeasuredCognitive(profile), isEmpty);
    expect(ProgressGaps.weakestPillar(profile), CompetencyPillar.lecturaCritica);
  });
}
