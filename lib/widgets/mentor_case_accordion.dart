import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';

const _kLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

/// Caso y postura plegados: no roban el hilo hasta que el docente los abre.
class MentorCaseAccordion extends StatelessWidget {
  const MentorCaseAccordion({
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
    final caseText = question.caseContext?.trim() ?? '';
    final chosen = chosenIndex >= 0 && chosenIndex < question.options.length
        ? question.options[chosenIndex]
        : '';
    final letter = chosenIndex >= 0 && chosenIndex < _kLetters.length
        ? _kLetters[chosenIndex]
        : '${chosenIndex + 1}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dark ? AppColors.darkSurface : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dark ? AppColors.darkStroke : AppColors.stroke,
          ),
        ),
        child: Theme(
          data: theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: false,
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            title: Text(
              '📄 Ver texto del caso',
              style: theme.textTheme.labelLarge,
            ),
            dense: true,
            children: [
              if (caseText.isNotEmpty) ...[
                Text('El caso', style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(caseText, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 12),
              ],
              Text('La pregunta', style: theme.textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(question.stem, style: theme.textTheme.bodyMedium),
              if (chosen.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Tu postura', style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                Text('$letter. $chosen', style: theme.textTheme.bodyMedium),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
