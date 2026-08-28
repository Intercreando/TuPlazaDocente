import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Pista tras el primer fallo: valida el error y no suelta la respuesta.
class TutorHintCard extends StatelessWidget {
  const TutorHintCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: dark ? 0.12 : 0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldDeep.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('💡 Pista del tutor', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),
            Text(
              'Por qué lo que marcaste no encaja',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(text, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 10),
            Text(
              'Con este análisis en mente, inténtalo de nuevo.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
