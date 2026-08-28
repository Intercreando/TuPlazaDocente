import 'package:flutter_test/flutter_test.dart';

import 'package:tu_plaza_docente/models/enums.dart';
import 'package:tu_plaza_docente/models/knowledge_taxonomy.dart';
import 'package:tu_plaza_docente/models/question.dart';
import 'package:tu_plaza_docente/models/recent_session_snapshot.dart';
import 'package:tu_plaza_docente/models/user_profile.dart';
import 'package:tu_plaza_docente/services/intelligent_tutor_planner.dart';

Question _q({
  required String id,
  CompetencyPillar pillar = CompetencyPillar.pedagogico,
  KnowledgeCode? code,
  bool isCase = false,
  String? caseContext,
}) {
  return Question(
    id: id,
    pillar: pillar,
    topic: 'Tema $id',
    stem: 'Enunciado de prueba para el caso $id y su contexto.',
    options: const ['A', 'B', 'C', 'D'],
    correctIndex: 1,
    explanation: 'La B es la exigida por el debido proceso.',
    difficulty: QuestionDifficulty.intermedio,
    isCaseStudy: isCase,
    caseContext: caseContext,
    knowledgeTags: [if (code != null) KnowledgeTag(code: code)],
    distractorAnalysis: const {0: 'Esa vía salta el conducto regular.'},
  );
}

void main() {
  final bank = [
    _q(id: 'num', pillar: CompetencyPillar.aptitudNumerica),
    _q(
      id: '1290-caso',
      code: KnowledgeCode.decreto1290,
      isCase: true,
      caseContext: 'Un grado 5 con promoción anticipada.',
    ),
    _q(id: 'piaget', code: KnowledgeCode.piaget, isCase: true),
  ];

  test('sin evidencias, saluda Aspirante y elige un caso del banco', () {
    final plan = IntelligentTutorPlanner.build(
      const UserProfile(),
      bank: bank,
      now: DateTime(2026, 8, 27),
    );
    expect(plan.displayName, 'Aspirante');
    expect(plan.question.id, isNotEmpty);
    expect(plan.headline.toLowerCase(), contains('historial reciente'));
  });

  test('con 1290 en crítico, el caso es el de esa etiqueta', () {
    const profile = UserProfile(
      displayName: 'Ana María',
      tagTotal: {'decreto1290': 10, 'piaget': 4},
      tagCorrect: {'decreto1290': 2, 'piaget': 3},
      pillarTotal: {'pedagogico': 14},
      pillarCorrect: {'pedagogico': 5},
    );
    final plan = IntelligentTutorPlanner.build(
      profile,
      bank: bank,
      now: DateTime(2026, 8, 27),
    );
    expect(plan.displayName, 'Ana');
    expect(plan.question.id, '1290-caso');
    expect(plan.headline, contains('mapa de práctica'));
    expect(plan.headline, contains('1290'));
    expect(plan.body, contains('20%'));
  });

  test('las últimas sesiones mandan sobre el mapa de por vida', () {
    final profile = UserProfile(
      displayName: 'Ana',
      tagTotal: const {'decreto1290': 10, 'piaget': 4},
      tagCorrect: const {'decreto1290': 2, 'piaget': 3},
      pillarTotal: const {'pedagogico': 14},
      pillarCorrect: const {'pedagogico': 5},
      recentSessions: [
        RecentSessionSnapshot(
          finishedAt: DateTime(2026, 8, 26),
          mode: SessionMode.exam,
          total: 8,
          correct: 5,
          weakTag: KnowledgeCode.piaget,
          weakPillar: CompetencyPillar.pedagogico,
        ),
      ],
    );
    final plan = IntelligentTutorPlanner.build(
      profile,
      bank: bank,
      now: DateTime(2026, 8, 27),
    );
    expect(plan.question.id, 'piaget');
    expect(plan.headline, contains('últimas prácticas'));
    expect(plan.headline.toLowerCase(), contains('piaget'));
  });

  test('prepend deja solo 5 sesiones', () {
    final seed = RecentSessionSnapshot(
      finishedAt: DateTime(2026, 8, 1),
      mode: SessionMode.practice,
      total: 8,
      correct: 4,
    );
    var list = <RecentSessionSnapshot>[];
    for (var i = 0; i < 7; i++) {
      list = RecentSessionSnapshot.prepend(list, seed);
    }
    expect(list.length, 5);
  });

  test('excludeQuestionId evita repetir el mismo caso si hay otro', () {
    final picked = IntelligentTutorPlanner.pickCase(
      pool: bank,
      focusCode: KnowledgeCode.decreto1290,
      focusPillar: CompetencyPillar.pedagogico,
      excludeQuestionId: '1290-caso',
      now: DateTime(2026, 8, 27),
    );
    expect(picked.id, isNot('1290-caso'));
  });

  test('pickFollowUp no repite el caso y sube de exigencia si hay', () {
    final followBank = [
      _q(
        id: '1290-caso',
        code: KnowledgeCode.decreto1290,
        isCase: true,
        caseContext: 'Un grado 5 con promoción anticipada.',
      ),
      Question(
        id: '1290-duro',
        pillar: CompetencyPillar.pedagogico,
        topic: 'Evaluación',
        stem: 'Segundo caso de evaluación para comprobar la clave del tema.',
        options: const ['A', 'B', 'C', 'D'],
        correctIndex: 0,
        explanation: 'Exigida por evidencia.',
        difficulty: QuestionDifficulty.avanzado,
        knowledgeTags: const [KnowledgeTag(code: KnowledgeCode.decreto1290)],
      ),
    ];
    final next = IntelligentTutorPlanner.pickFollowUp(
      pool: followBank,
      primary: followBank.first,
      preferHarder: true,
      now: DateTime(2026, 8, 28),
    );
    expect(next, isNotNull);
    expect(next!.id, '1290-duro');
  });
}
