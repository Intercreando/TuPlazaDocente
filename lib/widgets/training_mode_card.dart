import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'feature_access_badge.dart';

/// Tarjeta de modo de entrenamiento con señal visual de acceso.
class TrainingModeCard extends StatelessWidget {
  const TrainingModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.access = FeatureAccessLevel.open,
    this.limitedLabel = 'Cupo gratis',
    this.featured = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final FeatureAccessLevel access;
  final String limitedLabel;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locked = access == FeatureAccessLevel.locked;
    final dim = locked && !featured ? 0.72 : 1.0;
    final isDark = theme.brightness == Brightness.dark;
    final goldTint = AppColors.gold.withValues(alpha: isDark ? 0.14 : 0.10);

    return Opacity(
      opacity: dim,
      child: Material(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: featured || locked
                    ? AppColors.gold
                    : theme.colorScheme.outline,
                width: featured ? 1.8 : (locked ? 1.4 : 1),
              ),
              color: featured
                  ? goldTint
                  : locked
                      ? AppColors.gold.withValues(alpha: 0.06)
                      : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: locked ? 0.08 : 0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: locked && !featured
                        ? color.withValues(alpha: 0.55)
                        : color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(title, style: theme.textTheme.titleSmall),
                          ),
                          FeatureAccessBadge(
                            level: access,
                            limitedLabel: limitedLabel,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
