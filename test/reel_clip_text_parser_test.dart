import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/data/reel_clip_text_parser.dart';
import 'package:tu_plaza_docente/data/reel_studio_pack.dart';

/// El compositor del estudio depende de este parser: si deja de entender el
/// texto pegado, no se pueden crear casos sin tocar el código.
void main() {
  test('la plantilla de ejemplo se interpreta completa', () {
    final draft = ReelClipTextParser.parse(ReelClipTextParser.plantilla);

    expect(draft.errors, isEmpty);
    expect(draft.isValid, isTrue);
    final clip = draft.clip!;
    expect(clip.group, ReelGroup.convivencia);
    expect(clip.label, 'WhatsApp · el grupo del curso');
    expect(clip.options.length, 4);
    expect(clip.correctIndex, 0);
    expect(clip.isCustom, isTrue);
    expect(clip.id, startsWith('whatsapp-el-grupo-del-curso'));
    expect(clip.revealWhy, isNotEmpty);
    expect(clip.hook, '¿Respetas el silencio y no avisas a la casa?');
  });

  test('acepta etiquetas sin tildes y otros separadores de opción', () {
    const texto = '''
tema: piar
titulo: Ajustes sin diagnostico
situacion: Un estudiante no termina nada y la cita medica esta lejos.
enunciado: ¿Que haces?
A. Ajustar ya y documentarlo
B- Esperar el diagnostico
C: Bajarle la exigencia
D) Suspender su valoracion
respuesta: A
razon: El ajuste no depende del diagnostico.
''';

    final draft = ReelClipTextParser.parse(texto);

    expect(draft.errors, isEmpty);
    expect(draft.clip!.group, ReelGroup.inclusion);
    expect(draft.clip!.hook, ReelClip.fallbackHook);
    expect(draft.clip!.options.first, 'Ajustar ya y documentarlo');
    expect(draft.clip!.correctIndex, 0);
  });

  test('reconoce la correcta marcada con asterisco', () {
    const texto = '''
Tema: evaluación
Título: El cero del viernes
Caso: No presentó por incapacidad médica y el promedio la deja perdiendo.
Pregunta: ¿Qué corresponde?
A) Dejar el cero
B) Promediar lo que tenga
C) Subirle la nota mínima
D) Reprogramar según el SIEE *
Porque: La ausencia justificada da derecho a presentar.
''';

    final draft = ReelClipTextParser.parse(texto);

    expect(draft.errors, isEmpty);
    expect(draft.clip!.correctIndex, 3);
    expect(draft.clip!.options.last, 'Reprogramar según el SIEE');
  });

  test('une los párrafos sueltos al último campo', () {
    const texto = '''
Tema: aula
Título: Nadie participa
Caso: Preguntas si entendieron y todos asienten.
En la prueba la mitad falla lo básico.
Pregunta: ¿Qué cambias?
A) Preguntas que exijan explicar *
B) Avanzar y repasar después
C) Preguntar por lista
D) Repetir la explicación
Porque: Sin evidencia de quién falla no hay ajuste.
''';

    final draft = ReelClipTextParser.parse(texto);

    expect(draft.errors, isEmpty);
    expect(draft.clip!.situation, contains('la mitad falla lo básico'));
  });

  test('avisa qué falta cuando el texto está incompleto', () {
    const texto = '''
Título: Caso sin tema
Caso: Algo pasa en el colegio.
Pregunta: ¿Qué haces?
A) Una cosa
B) Otra cosa
''';

    final draft = ReelClipTextParser.parse(texto);

    expect(draft.isValid, isFalse);
    expect(draft.clip, isNull);
    expect(draft.errors.any((e) => e.contains('tema')), isTrue);
    expect(draft.errors.any((e) => e.contains('4 opciones')), isTrue);
    expect(draft.errors.any((e) => e.contains('correcta')), isTrue);
  });

  test('avisa de textos largos sin bloquear el guardado', () {
    final largo = 'palabra ' * 60;
    final texto =
        '''
Tema: directivo
Título: Caso con un caso larguísimo para el lienzo del estudio de reels
Caso: $largo
Pregunta: ¿Qué haces?
A) Una opción *
B) Otra opción
C) Tercera opción
D) Cuarta opción
Porque: Una razón.
''';

    final draft = ReelClipTextParser.parse(texto);

    expect(draft.isValid, isTrue);
    expect(draft.warnings, isNotEmpty);
    expect(draft.warnings.any((w) => w.contains('El caso')), isTrue);
  });

  test('el caso viaja completo a Firestore y vuelve igual', () {
    final original = ReelClipTextParser.parse(
      ReelClipTextParser.plantilla,
    ).clip!;

    final vuelta = ReelClip.fromMap(original.id, original.toMap());

    expect(vuelta, isNotNull);
    expect(vuelta!.id, original.id);
    expect(vuelta.group, original.group);
    expect(vuelta.label, original.label);
    expect(vuelta.situation, original.situation);
    expect(vuelta.stem, original.stem);
    expect(vuelta.options, original.options);
    expect(vuelta.correctIndex, original.correctIndex);
    expect(vuelta.revealWhy, original.revealWhy);
    expect(vuelta.hook, original.hook);
    expect(vuelta.isCustom, isTrue);
  });

  test('un documento incompleto no rompe el estudio', () {
    expect(ReelClip.fromMap('x', {'label': 'Solo título'}), isNull);
    expect(
      ReelClip.fromMap('x', {
        'group': 'convivencia',
        'label': 'Título',
        'situation': 'Caso',
        'stem': 'Pregunta',
        'options': ['A', 'B', 'C'],
        'correctIndex': 0,
      }),
      isNull,
    );
  });
}
