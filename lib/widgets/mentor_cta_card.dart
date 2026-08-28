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
            Text(_title(), style: theme.textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(_body(), style: theme.textTheme.bodySmall),
            if (!enabled && blockedReason != null) ...[
              const SizedBox(height: 8),
              Text(blockedReason!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 10),
            FilledButton(
              onPressed: enabled ? onOpen : null,
              child: Text(_buttonLabel()),
            ),
          ],
        ),
      ),
    );
  }

  String _title() {
    if (choseCorrect) {
      return '¿Quieres dominar el porqué de esta respuesta?';
    }
    if (trialUsed && !hasPass) {
      return '¿Quieres entender por qué esta opción es incorrecta?';
    }
    return '¿Quieres analizar por qué esta opción es incorrecta?';
  }

  String _body() {
    if (hasPass) {
      return 'Pase activo. Charla guiada sobre este caso: 8 turnos, '
          '4 sesiones al día. No es un chat libre.';
    }
    if (trialUsed) {
      return 'Ya usaste tu prueba gratuita. Activa tu pase de 30 días '
          'para debatir a fondo el criterio pedagógico de cada caso. '
          'Incluye 4 tutorías diarias por 30 días (sin cobros automáticos).';
    }
    if (choseCorrect) {
      return 'Inicia tu sesión de prueba gratuita. Aprovecha 8 turnos de '
          'debate exclusivo sobre este caso para desglosar el criterio '
          'de la CNSC y no dudar en el examen real.';
    }
    return 'Disfruta de 1 sesión de prueba gratuita. Tendrás hasta 8 turnos '
        'de debate enfocado exclusivamente en este caso para deducir '
        'la respuesta correcta.';
  }

  String _buttonLabel() {
    if (trialUsed && !hasPass) {
      return 'Activar pase por ${AppConfig.mentorPassPriceLabel}';
    }
    return 'Hablar con el Mentor';
  }
}
