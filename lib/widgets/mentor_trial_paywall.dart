import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../utils/wompi_mentor_checkout.dart';

/// Cierre de la prueba: invita al pase de 30 días (renovación manual).
/// Devuelve true si el usuario disparó el checkout.
Future<bool> showMentorTrialPaywall(BuildContext context) async {
  final goPay = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      return AlertDialog(
        title: Text('¡Excelente análisis!', style: theme.textTheme.titleLarge),
        content: Text(
          'Has completado tu sesión de prueba. Para tener 4 sesiones guiadas '
          'todos los días, activa tu pase de 30 días por '
          '${AppConfig.mentorPassPriceLabel}.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Ahora no'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Activar pase de 30 días'),
          ),
        ],
      );
    },
  );
  if (goPay == true && context.mounted) {
    await openMentorPassCheckout(context);
    return true;
  }
  return false;
}
