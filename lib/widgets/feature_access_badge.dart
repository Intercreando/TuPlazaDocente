import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Nivel visual de acceso a un modo o tarea.
enum FeatureAccessLevel {
  /// Disponible sin restricción aparente.
  open,

  /// Disponible con cupo freemium (1/día, 1/mes, etc.).
  limited,

  /// Solo Premium: se ve bloqueado.
  locked,
}

/// Chip compacto: candado Premium o cupo gratis.
class FeatureAccessBadge extends StatelessWidget {
  const FeatureAccessBadge({
    super.key,
    required this.level,
    this.limitedLabel = 'Cupo gratis',
  });

  final FeatureAccessLevel level;
  final String limitedLabel;

  @override
  Widget build(BuildContext context) {
    if (level == FeatureAccessLevel.open) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final locked = level == FeatureAccessLevel.locked;
    final bg = locked
        ? AppColors.gold.withValues(alpha: 0.18)
        : AppColors.seafoam.withValues(alpha: 0.16);
    final fg = locked ? AppColors.goldDeep : AppColors.canopy;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            locked ? Icons.lock_outline_rounded : Icons.timelapse_rounded,
            size: 14,
            color: fg,
          ),
          const SizedBox(width: 4),
          Text(
            locked ? 'Premium' : limitedLabel,
            style: theme.textTheme.labelMedium?.copyWith(color: fg),
          ),
        ],
      ),
    );
  }
}
