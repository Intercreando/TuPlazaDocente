import 'package:flutter/material.dart';

import '../config/concurso_config.dart';
import '../theme/app_colors.dart';

/// Badge de convocatoria vigente (nombre + fase).
class ConcursoPhaseBadge extends StatelessWidget {
  const ConcursoPhaseBadge({
    super.key,
    this.showDetail = false,
    this.light = false,
  });

  final bool showDetail;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = light
        ? AppColors.gold.withValues(alpha: 0.55)
        : AppColors.canopy.withValues(alpha: 0.45);
    final titleColor = light ? AppColors.gold : AppColors.canopy;
    final bodyColor = light
        ? AppColors.white.withValues(alpha: 0.88)
        : AppColors.textSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
        color: light
            ? AppColors.white.withValues(alpha: 0.06)
            : AppColors.canopy.withValues(alpha: 0.06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ConcursoConfig.badgeLabel.toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: titleColor,
              letterSpacing: 0.6,
            ),
          ),
          if (showDetail) ...[
            const SizedBox(height: 6),
            Text(
              ConcursoConfig.phaseDetail,
              style: theme.textTheme.bodySmall?.copyWith(color: bodyColor),
            ),
          ],
        ],
      ),
    );
  }
}
