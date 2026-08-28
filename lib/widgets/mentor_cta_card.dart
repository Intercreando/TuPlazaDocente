import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Entrada al Mentor IA desde el Tutor personalizado (tras elegir postura).
class MentorCtaCard extends StatelessWidget {
  const MentorCtaCard({
    super.key,
    required this.onOpen,
    required this.enabled,
    this.blockedReason,
    this.hasPass = false,
    this.trialUsed = false,
  });

  final VoidCallback onOpen;
  final bool enabled;
  final String? blockedReason;
  final bool hasPass;
  final bool trialUsed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: dark ? AppColors.darkElevated : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.canopy, width: 1.4),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mentor IA',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.canopy,
              ),
            ),
            Text(
              '¿Quieres defender tu postura con un mentor?',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 6),
            Text(_body(), style: theme.textTheme.bodySmall),
            if (!enabled && blockedReason != null) ...[
              const SizedBox(height: 8),
              Text(blockedReason!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 10),
            FilledButton(
              onPressed: enabled ? onOpen : null,
              child: Text(
                trialUsed && !hasPass
                    ? 'Activar pase de 30 días'
                    : 'Hablar con el Mentor IA',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _body() {
    if (hasPass) {
      return 'Pase activo. Charla guiada sobre este caso: 8 turnos, '
          '4 sesiones al día. No es un chat libre.';
    }
    if (trialUsed) {
      return 'Ya usaste la prueba. Con el pase tienes 4 sesiones guiadas '
          'al día, 8 turnos cada una, ancladas a este caso.';
    }
    return 'Tienes 1 sesión de prueba de por vida. 8 turnos sobre ESTE caso. '
        'No es un chat libre.';
  }
}
