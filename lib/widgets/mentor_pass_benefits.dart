import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../theme/app_colors.dart';

/// Beneficios del pase Mentor, en lenguaje de quien entrena (sin motor técnico).
class MentorPassBenefits extends StatelessWidget {
  const MentorPassBenefits({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadStyle = compact
        ? theme.textTheme.bodySmall
        : theme.textTheme.bodyMedium;
    final itemStyle = compact
        ? theme.textTheme.bodySmall
        : theme.textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConfig.mentorPassPaywallLead, style: leadStyle),
        const SizedBox(height: 12),
        for (final benefit in AppConfig.mentorPassBenefits) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_rounded, color: AppColors.canopy),
                const SizedBox(width: 8),
                Expanded(child: Text(benefit, style: itemStyle)),
              ],
            ),
          ),
        ],
        Text(
          '${AppConfig.mentorPassPriceLabel} · ${AppConfig.mentorPassBillingLabel}',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 4),
        Text(
          AppConfig.mentorPassBillingDetail,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
