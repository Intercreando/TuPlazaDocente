import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_colors.dart';

/// Recuadro con el caso o situación al que se refiere el enunciado.
///
/// Va en todas las pantallas de sesión: si la pregunta dice «en este caso»
/// y el recuadro falta, el ítem queda sin el texto que debe analizarse.
/// Devuelve `SizedBox.shrink()` cuando la pregunta no trae caso.
class QuestionCaseContext extends StatelessWidget {
  const QuestionCaseContext({
    super.key,
    required this.question,
    this.bottomSpacing = 14,
  });

  final Question question;

  /// Aire entre el recuadro y el enunciado.
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final caseText = question.caseContext?.trim() ?? '';
    if (caseText.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.skyLine.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.skyLine.withValues(alpha: 0.35),
          ),
        ),
        child: Text(caseText, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
