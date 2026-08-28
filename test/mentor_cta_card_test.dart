import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/widgets/mentor_cta_card.dart';

void main() {
  testWidgets('CTA de acierto no pide defender un error', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MentorCtaCard(enabled: true, choseCorrect: true, onOpen: () {}),
        ),
      ),
    );
    expect(
      find.text('¿Quieres anclar por qué esa es la exigida?'),
      findsOneWidget,
    );
    expect(
      find.text('¿Quieres entender por qué esa no era la exigida?'),
      findsNothing,
    );
  });

  testWidgets('CTA de fallo invita a entender el hueco', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MentorCtaCard(
            enabled: true,
            choseCorrect: false,
            onOpen: () {},
          ),
        ),
      ),
    );
    expect(
      find.text('¿Quieres entender por qué esa no era la exigida?'),
      findsOneWidget,
    );
  });

  testWidgets(
    'con la prueba usada el CTA habla del criterio, no del cupo solo',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MentorCtaCard(enabled: true, trialUsed: true, onOpen: () {}),
          ),
        ),
      );
      expect(find.textContaining('anclar el criterio'), findsOneWidget);
      expect(find.textContaining(r'$19.900'), findsOneWidget);
    },
  );
}
