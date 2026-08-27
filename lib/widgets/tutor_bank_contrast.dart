import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';
import 'normative_link_chips.dart';

/// Contraste del banco (sin IA): justificación + por qué la postura no es la mejor.
class TutorBankContrast extends StatelessWidget {
  const TutorBankContrast({
    super.key,
    required this.question,
    required this.chosenIndex,
  });

  final Question question;
  final int chosenIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final acierto = question.isCorrect(chosenIndex);
    final distractor = question.distractorAnalysis[chosenIndex];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.mist.withValues(alpha: dark ? 0.12 : 1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.canopy.withValues(alpha: 0.35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              acierto
                  ? 'Esa es la postura exigida'
                  : 'Por qué tu postura no es la mejor',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            if (!acierto && distractor != null && distractor.trim().isNotEmpty)
              Text(distractor, style: theme.textTheme.bodyMedium),
            if (!acierto && (distractor == null || distractor.trim().isEmpty))
              Text(
                'La opción exigida es: ${question.options[question.correctIndex]}',
                style: theme.textTheme.bodyMedium,
              ),
            if (question.normativeJustification != null &&
                question.normativeJustification!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Justificación normativa', style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(
                question.normativeJustification!,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            if (question.theoreticalJustification != null &&
                question.theoreticalJustification!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Justificación teórica', style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(
                question.theoreticalJustification!,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            if ((question.normativeJustification == null ||
                    question.normativeJustification!.isEmpty) &&
                (question.theoreticalJustification == null ||
                    question.theoreticalJustification!.isEmpty) &&
                question.explanation.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(question.explanation, style: theme.textTheme.bodyMedium),
            ],
            if (question.referenceLabels.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Referentes: ${question.referenceLabels.join(' · ')}',
                style: theme.textTheme.labelMedium,
              ),
            ],
            const SizedBox(height: 12),
            NormativeLinkChips(question: question),
          ],
        ),
      ),
    );
  }
}
