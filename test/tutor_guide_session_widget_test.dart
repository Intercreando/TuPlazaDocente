import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/models/enums.dart';
import 'package:tu_plaza_docente/models/knowledge_taxonomy.dart';
import 'package:tu_plaza_docente/models/question.dart';
import 'package:tu_plaza_docente/services/intelligent_tutor_guide.dart';
import 'package:tu_plaza_docente/services/intelligent_tutor_planner.dart';
import 'package:tu_plaza_docente/widgets/tutor_guide_session.dart';

Question _q() {
  return const Question(
    id: 't1',
    pillar: CompetencyPillar.pedagogico,
    topic: 'Evaluación',
    stem: 'Un estudiante llega tarde. ¿Qué haces primero?',
    options: ['Sancionar ya', 'Indagar con evidencia', 'Ignorar', 'Delegar'],
    correctIndex: 1,
    explanation: 'La B es la exigida.',
    difficulty: QuestionDifficulty.intermedio,
    knowledgeTags: [KnowledgeTag(code: KnowledgeCode.decreto1290)],
    distractorAnalysis: {0: 'Salta el debido proceso.'},
  );
}

IntelligentTutorPlan _plan(Question q) {
  return IntelligentTutorPlan(
    displayName: 'Ana',
    headline: 'El hueco es Decreto 1290.',
    body: 'Elige cómo actuarías.',
    weakLabels: const ['Evaluación'],
    question: q,
    focusPillar: CompetencyPillar.pedagogico,
    focusCode: KnowledgeCode.decreto1290,
  );
}

class _Host extends StatefulWidget {
  const _Host();

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  late final IntelligentTutorGuide guide = IntelligentTutorGuide(primary: _q());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TutorGuideSession(
          plan: _plan(guide.primary),
          guide: guide,
          onChoose: (index) {
            setState(() => guide.choose(index));
          },
          onStartFollowUp: () {},
          onPracticeMore: () {},
          onBackHome: () {},
        ),
      ),
    );
  }
}

void main() {
  testWidgets('el primer fallo muestra pista y no suelta la clave', (
    tester,
  ) async {
    await tester.pumpWidget(const _Host());

    await tester.tap(find.text('Sancionar ya'));
    await tester.pump();

    final host = tester.state<_HostState>(find.byType(_Host));
    expect(host.guide.awaitingRetry, isTrue);
    expect(host.guide.hint, contains('debido proceso'));
    expect(
      find.textContaining(
        'Con esa explicación, elige otra.',
        skipOffstage: false,
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'La clave para superar este tema',
        skipOffstage: false,
      ),
      findsNothing,
    );
    expect(
      find.text('Practicar más de este tema', skipOffstage: false),
      findsNothing,
    );
  });
}
