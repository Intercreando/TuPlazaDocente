import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/data/question_bank.dart';
import 'package:tu_plaza_docente/models/enums.dart';
import 'package:tu_plaza_docente/widgets/especialidad_picker.dart';

void main() {
  test('el perfil de aula no ofrece gestión directiva', () {
    final aula = Especialidad.values.where((e) => e.aula).toList();
    expect(aula, isNot(contains(Especialidad.directivos)));
    expect(aula, contains(Especialidad.educacionFisica));
    expect(aula, contains(Especialidad.artistica));
  });

  test('la portada del onboarding son las 7 iniciales', () {
    expect(Especialidad.portada, [
      Especialidad.preescolar,
      Especialidad.primaria,
      Especialidad.matematicas,
      Especialidad.ciencias,
      Especialidad.lenguaje,
      Especialidad.sociales,
      Especialidad.directivos,
    ]);
  });

  test('el cargo directivo solo calibra gestión', () {
    expect(Especialidad.paraCargo(CargoAspiracion.directivo), [
      Especialidad.directivos,
    ]);
  });

  test('el buscador de aula incluye el catálogo amplio', () {
    expect(
      Especialidad.buscar('artistica', cargo: CargoAspiracion.docenteAula),
      contains(Especialidad.artistica),
    );
    expect(
      Especialidad.buscar('gestion', cargo: CargoAspiracion.docenteAula),
      contains(Especialidad.directivos),
    );
  });

  test('la búsqueda ignora tildes, puntos y usa alias', () {
    expect(
      Especialidad.buscar('ed fisica', cargo: CargoAspiracion.docenteAula),
      contains(Especialidad.educacionFisica),
    );
    expect(
      Especialidad.buscar('ed. fisica', cargo: CargoAspiracion.docenteAula),
      contains(Especialidad.educacionFisica),
    );
    expect(
      Especialidad.buscar('ingles', cargo: CargoAspiracion.docenteAula),
      contains(Especialidad.ingles),
    );
  });

  test('perfiles nuevos reutilizan un banco existente', () {
    expect(Especialidad.ingles.especialidadDeBanco, Especialidad.lenguaje);
    expect(QuestionBank.bySpecialty(Especialidad.ingles), isNotEmpty);
    expect(QuestionBank.bySpecialty(Especialidad.artistica), isNotEmpty);
  });

  test('los perfiles guardados con el nombre viejo siguen leyéndose', () {
    expect(Especialidad.values.any((e) => e.name == 'matematicas'), isTrue);
    expect(Especialidad.values.any((e) => e.name == 'directivos'), isTrue);
  });

  testWidgets('el picker de aula muestra las 7 de portada y busca el resto', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EspecialidadPicker(
            cargo: CargoAspiracion.docenteAula,
            especialidad: null,
            onSelect: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Preescolar'), findsOneWidget);
    expect(find.text('Primaria'), findsOneWidget);
    expect(find.text('Matemáticas'), findsOneWidget);
    expect(find.text('Ciencias Naturales'), findsOneWidget);
    expect(find.text('Lenguaje'), findsOneWidget);
    expect(find.text('Ciencias Sociales'), findsOneWidget);
    expect(find.text('Gestión directiva'), findsOneWidget);
    expect(find.text('Educación artística'), findsNothing);
    expect(find.text('Educación física'), findsNothing);
    expect(find.text('¿No ves tu área?'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'artistica');
    await tester.pump();

    expect(find.text('Educación artística'), findsOneWidget);
    expect(find.text('Preescolar'), findsNothing);
  });
}
