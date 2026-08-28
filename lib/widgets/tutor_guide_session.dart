import 'package:flutter/material.dart';

import '../models/question.dart';
import '../services/intelligent_tutor_guide.dart';
import '../services/intelligent_tutor_planner.dart';
import '../services/tutor_scaffold_copy.dart';
import 'option_tile.dart';
import 'question_case_context.dart';
import 'tutor_bank_contrast.dart';
import 'tutor_clave_card.dart';
import 'tutor_hint_card.dart';
import 'tutor_mix_nudge.dart';

const _kLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

/// Cuerpo de la tutoría guiada (diagnóstico + andamiaje + segundo ítem).
class TutorGuideSession extends StatelessWidget {
  const TutorGuideSession({
    super.key,
    required this.plan,
    required this.guide,
    required this.onChoose,
    required this.onStartFollowUp,
    required this.onPracticeMore,
    required this.onBackHome,
    this.onNextCase,
    this.showMixNudge = false,
    this.mentorCta,
  });

  final IntelligentTutorPlan plan;
  final IntelligentTutorGuide guide;
  final ValueChanged<int> onChoose;
  final VoidCallback onStartFollowUp;
  final VoidCallback onPracticeMore;
  final VoidCallback onBackHome;
  final VoidCallback? onNextCase;
  final bool showMixNudge;
  final Widget? mentorCta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Hola, ${plan.displayName}.',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(plan.headline, style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(plan.body, style: theme.textTheme.bodyMedium),
          if (plan.weakLabels.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final label in plan.weakLabels) Chip(label: Text(label)),
              ],
            ),
          ],
          const SizedBox(height: 18),
          Text('Tu caso de hoy', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          _CaseBlock(
            question: guide.primary,
            selectedIndex: guide.primaryChoice,
            revealed: guide.primaryClosed,
            eliminated: guide.showingFollowUp ? const {} : guide.eliminated,
            onChoose: guide.primaryClosed ? null : onChoose,
            banner: guide.awaitingRetry
                ? TutorHintCard(text: guide.hint)
                : null,
          ),
          if (guide.primaryClosed) ...[
            const SizedBox(height: 14),
            if (_failedToArrive) ...[
              TutorBankContrast(
                question: guide.primary,
                chosenIndex: guide.primaryChoice ?? 0,
              ),
              const SizedBox(height: 12),
            ],
            TutorClaveCard(
              title: _claveTitle(),
              clave: TutorScaffoldCopy.claveFor(guide.primary),
            ),
            if (mentorCta != null) ...[const SizedBox(height: 16), mentorCta!],
          ],
          if (guide.canOfferFollowUp) ...[
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onStartFollowUp,
              child: Text(
                guide.firstTryCorrect
                    ? 'Un peldaño más del mismo tema'
                    : 'Apliquemos la clave en otro caso',
              ),
            ),
          ],
          if (guide.showingFollowUp && guide.followUp != null) ...[
            const SizedBox(height: 22),
            Text(
              guide.firstTryCorrect
                  ? 'Mismo hueco, un poco más exigente'
                  : 'Comprobemos la clave',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Una sola postura. Ya viste la regla; aplícala aquí.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            _CaseBlock(
              question: guide.followUp!,
              selectedIndex: guide.followUpChoice,
              revealed: guide.followUpClosed,
              eliminated: const {},
              onChoose: guide.followUpClosed ? null : onChoose,
            ),
            if (guide.followUpClosed && guide.followUpChoice != null) ...[
              const SizedBox(height: 14),
              TutorBankContrast(
                question: guide.followUp!,
                chosenIndex: guide.followUpChoice!,
              ),
            ],
          ],
          if (guide.primaryClosed) ...[
            const SizedBox(height: 20),
            if (showMixNudge) ...[
              TutorMixNudge(onSeeOtherTrainings: onBackHome),
              const SizedBox(height: 16),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (onNextCase != null) ...[
                  FilledButton(
                    onPressed: onNextCase,
                    child: const Text('Otro caso del tutor'),
                  ),
                  const SizedBox(height: 8),
                ],
                OutlinedButton(
                  onPressed: onPracticeMore,
                  child: const Text('Practicar más de este tema'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: onBackHome,
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  bool get _failedToArrive {
    final choice = guide.primaryChoice;
    if (!guide.primaryClosed || choice == null) return false;
    return !guide.primary.isCorrect(choice);
  }

  String _claveTitle() {
    if (guide.firstTryCorrect) {
      return 'Llegaste a la postura exigida. La clave de este tema';
    }
    if (guide.primaryAttempts < IntelligentTutorGuide.maxPrimaryAttempts ||
        (guide.primaryChoice != null &&
            guide.primary.isCorrect(guide.primaryChoice!))) {
      return 'Ahora sí. La clave para el siguiente simulacro';
    }
    return 'La clave para superar este tema';
  }
}

class _CaseBlock extends StatelessWidget {
  const _CaseBlock({
    required this.question,
    required this.selectedIndex,
    required this.revealed,
    required this.eliminated,
    required this.onChoose,
    this.banner,
  });

  final Question question;
  final int? selectedIndex;
  final bool revealed;
  final Set<int> eliminated;
  final ValueChanged<int>? onChoose;
  final Widget? banner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: Text(question.pillar.label)),
            Chip(label: Text(question.topic)),
            if (question.isCaseStudy) const Chip(label: Text('Caso de aula')),
          ],
        ),
        const SizedBox(height: 12),
        QuestionCaseContext(question: question),
        Text(question.stem, style: theme.textTheme.titleLarge),
        if (banner != null) ...[const SizedBox(height: 14), banner!],
        const SizedBox(height: 16),
        Text(
          revealed ? 'Tu postura' : '¿Cómo actuarías?',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ...List.generate(question.options.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OptionTile(
              letter: i < _kLetters.length ? _kLetters[i] : '${i + 1}',
              label: question.options[i],
              selected: selectedIndex == i,
              showResult: revealed,
              isCorrect: i == question.correctIndex,
              eliminated: eliminated.contains(i),
              onTap: onChoose == null ? null : () => onChoose!(i),
            ),
          );
        }),
      ],
    );
  }
}
