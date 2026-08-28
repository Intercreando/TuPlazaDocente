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
      find.text('¿Quieres dominar el porqué de esta respuesta?'),
      findsOneWidget,
    );
    expect(
      find.textContaining('desglosar el criterio de la CNSC'),
      findsOneWidget,
    );
    expect(find.text('Hablar con el Mentor'), findsOneWidget);
    expect(
      find.text('¿Quieres analizar por qué esta opción es incorrecta?'),
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
      find.text('¿Quieres analizar por qué esta opción es incorrecta?'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Disfruta de 1 sesión de prueba gratuita'),
      findsOneWidget,
    );
    expect(find.text('Hablar con el Mentor'), findsOneWidget);
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
      expect(
        find.text('¿Quieres entender por qué esta opción es incorrecta?'),
        findsOneWidget,
      );
      expect(
        find.textContaining('debatir a fondo el criterio pedagógico'),
        findsOneWidget,
      );
      expect(
        find.textContaining('4 tutorías diarias por 30 días (sin cobros automáticos)'),
        findsOneWidget,
      );
      expect(find.text('Activar pase por \$19.900 COP'), findsOneWidget);
    },
  );
}
