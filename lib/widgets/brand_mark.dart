import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';
import 'brand_logo.dart';

/// Marca hero-level de TuPlazaDocente (logo SVG + wordmark tipográfico).
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
    final markSize = compact ? 40.0 : 52.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(compact ? 12 : 16),
          child: BrandLogo(size: markSize),
        ),
        SizedBox(width: compact ? 10 : 14),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TuPlazaDocente',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: (compact
                        ? theme.textTheme.titleMedium
                        : theme.textTheme.headlineSmall)
                    ?.copyWith(color: titleColor),
              ),
              if (!compact)
                Text(
                  'Entrenador del concurso magisterio',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: subtitleColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.08, end: 0);
  }
}
