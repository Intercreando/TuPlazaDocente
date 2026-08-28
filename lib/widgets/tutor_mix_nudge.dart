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
              'Hoy ya llevas varias tutorías',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'El tutor te lleva a la clave de un tema. Para el concurso '
              'también importa practicar de otras formas el mismo día:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Simulacro con tiempo — como el día de la prueba.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Mi área — las preguntas de tu especialidad.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Preguntas cortas o las 8 sin reloj — para coger volumen.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: onSeeOtherTrainings,
              child: const Text('Ver los otros entrenamientos'),
            ),
          ],
        ),
      ),
    );
  }
}
