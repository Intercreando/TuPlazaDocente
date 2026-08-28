import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/config/app_config.dart';
import 'package:tu_plaza_docente/widgets/mentor_pass_benefits.dart';

void main() {
  testWidgets('el pase habla de lo que gana el docente, no del motor', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: MentorPassBenefits())),
    );

    expect(find.text(AppConfig.mentorPassPaywallLead), findsOneWidget);
    expect(find.text(AppConfig.mentorPassBenefits.first), findsOneWidget);
    expect(find.textContaining('Vertex'), findsNothing);
    expect(find.textContaining('Gemini'), findsNothing);
    expect(find.textContaining(AppConfig.mentorPassPriceLabel), findsOneWidget);
    expect(find.textContaining('débito automático'), findsOneWidget);
  });
}
