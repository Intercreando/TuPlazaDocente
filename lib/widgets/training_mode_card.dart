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
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final FeatureAccessLevel access;
  final String limitedLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locked = access == FeatureAccessLevel.locked;
    final dim = locked ? 0.72 : 1.0;

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
                color: locked
                    ? AppColors.gold.withValues(alpha: 0.55)
                    : theme.colorScheme.outline,
                width: locked ? 1.4 : 1,
              ),
              color: locked
                  ? AppColors.gold.withValues(alpha: 0.06)
                  : null,
            ),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
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
                        color: locked ? color.withValues(alpha: 0.55) : color,
                      ),
                    ),
                    if (locked)
                      Positioned(
                        right: -4,
                        bottom: -4,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.gold,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.cardTheme.color ?? AppColors.white,
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.lock_rounded,
                            size: 11,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                  ],
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
                  locked
                      ? Icons.lock_outline_rounded
                      : Icons.chevron_right,
                  color: locked
                      ? AppColors.goldDeep
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
