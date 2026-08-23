import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../theme/app_colors.dart';
import '../utils/progress_practice_launch.dart';

/// Fila tocable: pilar del examen que el radar marca vacío y el mapa de
/// normas no cubre (Numérica, Lectura, Comportamental).
class ProgressGapTile extends StatelessWidget {
  const ProgressGapTile({
    super.key,
    required this.pillar,
    this.compact = false,
  });

  final CompetencyPillar pillar;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = AppColors.coral;

    return Padding(
      padding: EdgeInsets.only(bottom: compact ? 8 : 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => launchProgressPillar(context, pillar),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: EdgeInsets.all(compact ? 12 : 14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.14 : 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.45)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        pillar.label,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      'Sin evidencias',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Aún no la practicas. Toca para un bloque de este pilar.',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
