import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/models/enums.dart';
import 'package:tu_plaza_docente/models/knowledge_taxonomy.dart';
import 'package:tu_plaza_docente/models/question.dart';
import 'package:tu_plaza_docente/services/intelligent_tutor_guide.dart';
import 'package:tu_plaza_docente/services/tutor_scaffold_copy.dart';

Question _q({
  required String id,
  QuestionDifficulty difficulty = QuestionDifficulty.intermedio,
  Map<int, String> distractors = const {0: 'Salta el debido proceso.'},
  KnowledgeCode? code = KnowledgeCode.decreto1290,
  CompetencyPillar pillar = CompetencyPillar.pedagogico,
}) {
  return Question(
    id: id,
    pillar: pillar,
    topic: 'Tema $id',
    stem: 'Enunciado de prueba suficientemente largo para $id.',
    options: const [
      'Sancionar ya',
      'Indagar con evidencia',
      'Ignorar',
      'Delegar',
    ],
    correctIndex: 1,
    explanation: 'La B es la exigida.',
    difficulty: difficulty,
    knowledgeTags: [if (code != null) KnowledgeTag(code: code)],
    distractorAnalysis: distractors,
  );
}

void main() {
  test('el primer fallo da pista y no revela la correcta', () {
    final guide = IntelligentTutorGuide(primary: _q(id: 'a'));
    final outcome = guide.choose(0);
    expect(outcome, TutorChoiceOutcome.hint);
    expect(guide.primaryClosed, isFalse);
    expect(guide.eliminated, {0});
    expect(guide.hint, contains('debido proceso'));
    expect(guide.hint, contains('Sancionar ya'));
    expect(guide.primary.isCorrect(guide.primaryChoice!), isFalse);
  });

  test('la opción tachada no cuenta como segundo intento', () {
    final guide = IntelligentTutorGuide(primary: _q(id: 'a'));
    guide.choose(0);
    expect(guide.choose(0), TutorChoiceOutcome.ignored);
    expect(guide.primaryAttempts, 1);
    expect(guide.primaryClosed, isFalse);
  });

  test('el segundo fallo revela el caso', () {
    final guide = IntelligentTutorGuide(primary: _q(id: 'a'));
    guide.choose(0);
    final outcome = guide.choose(2);
    expect(outcome, TutorChoiceOutcome.primaryRevealed);
    expect(guide.primaryClosed, isTrue);
    expect(guide.firstTryCorrect, isFalse);
  });

  test('acierto al primer intento salta la pista', () {
    final guide = IntelligentTutorGuide(primary: _q(id: 'a'));
    expect(guide.choose(1), TutorChoiceOutcome.primaryFirstTry);
    expect(guide.firstTryCorrect, isTrue);
    expect(guide.hint, isEmpty);
  });

  test('acierto en el reintento es recuperación', () {
    final guide = IntelligentTutorGuide(primary: _q(id: 'a'));
    guide.choose(0);
    expect(guide.choose(1), TutorChoiceOutcome.primaryRecovered);
    expect(guide.primaryClosed, isTrue);
    expect(guide.firstTryCorrect, isFalse);
  });

  test('el follow-up es una sola postura', () {
    final guide = IntelligentTutorGuide(
      primary: _q(id: 'a'),
      followUp: _q(id: 'b'),
    );
    guide.choose(1);
    guide.startFollowUp();
    expect(guide.showingFollowUp, isTrue);
    expect(guide.choose(0), TutorChoiceOutcome.followUpRevealed);
    expect(guide.followUpClosed, isTrue);
    expect(guide.choose(1), TutorChoiceOutcome.ignored);
  });

  test('la pista numérica no usa la explicación con cuentas', () {
    final q = _q(
      id: 'n',
      pillar: CompetencyPillar.aptitudNumerica,
      code: null,
      distractors: const {},
    );
    final hint = TutorScaffoldCopy.hintFor(q, 0);
    expect(hint.toLowerCase(), isNot(contains('exigida')));
    expect(hint, contains('enunciado'));
    expect(hint, contains('Sancionar ya'));
  });

  test('el distractor genérico del banco no se muestra', () {
    final q = _q(
      id: 'g',
      distractors: const {
        0:
            'Opción cercana o habitual que no articula el referente, '
            'la evidencia o la instancia del caso.',
      },
    );
    final hint = TutorScaffoldCopy.whyMarkedWrong(q, 0);
    expect(hint.toLowerCase(), isNot(contains('opción cercana')));
    expect(hint, contains('Sancionar ya'));
    expect(hint.toLowerCase(), contains('debido proceso'));
  });

  test('la clave de 1290 habla de debido proceso', () {
    final clave = TutorScaffoldCopy.claveFor(_q(id: 'a'));
    expect(clave.toLowerCase(), contains('debido proceso'));
  });
}
