import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Cierre del caso: la regla que sirve en el siguiente simulacro.
class TutorClaveCard extends StatelessWidget {
  const TutorClaveCard({super.key, required this.title, required this.clave});

  final String title;
  final String clave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.canopy.withValues(alpha: dark ? 0.16 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.canopy.withValues(alpha: 0.40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Text(clave, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
