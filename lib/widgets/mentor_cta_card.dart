import 'package:flutter/material.dart';

import '../config/app_config.dart';
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
    this.choseCorrect = false,
  });

  final VoidCallback onOpen;
  final bool enabled;
  final String? blockedReason;
  final bool hasPass;
  final bool trialUsed;
  final bool choseCorrect;

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
              choseCorrect
                  ? '¿Quieres dominar el porqué de esta respuesta?'
                  : '¿Quieres entender por qué esa no era la exigida?',
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
      return 'Ya usaste tu prueba gratuita. Activa tu pase de 30 días '
          'para debatir a fondo el criterio pedagógico de cada caso. '
          'Incluye 4 tutorías diarias por 30 días. '
          '${AppConfig.mentorPassPriceLabel} (sin cobros automáticos).';
    }
    return 'Tienes 1 sesión de prueba de por vida. 8 turnos sobre ESTE caso. '
        'No es un chat libre.';
  }
}
