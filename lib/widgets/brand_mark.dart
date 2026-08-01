import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';

/// Marca hero-level de TuPlazaDocente.
class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.compact = false,
    this.light = false,
  });

  final bool compact;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = light ? AppColors.white : theme.colorScheme.onSurface;
    final subtitleColor = light
        ? AppColors.white.withValues(alpha: 0.82)
        : theme.colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 40 : 52,
          height: compact ? 40 : 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(compact ? 12 : 16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.ink, AppColors.canopy],
            ),
          ),
          child: Center(
            child: Text(
              'TP',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.gold,
              ),
            ),
          ),
        ),
        SizedBox(width: compact ? 10 : 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'TuPlazaDocente',
              style: (compact ? theme.textTheme.titleMedium : theme.textTheme.headlineSmall)
                  ?.copyWith(color: titleColor),
            ),
            if (!compact)
              Text(
                'Entrenador del concurso magisterio',
                style: theme.textTheme.bodySmall?.copyWith(color: subtitleColor),
              ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.08, end: 0);
  }
}
