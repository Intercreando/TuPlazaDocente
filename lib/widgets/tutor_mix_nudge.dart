import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Recuerda mezclar simulacro, especialidad y práctica si el día fue solo tutor.
class TutorMixNudge extends StatelessWidget {
  const TutorMixNudge({super.key, required this.onSeeOtherTrainings});

  final VoidCallback onSeeOtherTrainings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.skyLine.withValues(alpha: dark ? 0.16 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.skyLine.withValues(alpha: 0.40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diversifica tu preparación hoy',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Has aprovechado al máximo el tutor por hoy. Maximiza tu tiempo '
              'alternando con otros métodos de estudio:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Simulacros: Entrénate contra el reloj.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Tu especialidad: Domina los temas de tu área.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Práctica libre: Resuelve preguntas para ganar agilidad.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: onSeeOtherTrainings,
              child: const Text('Ver otros entrenamientos'),
            ),
          ],
        ),
      ),
    );
  }
}
