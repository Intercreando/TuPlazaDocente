import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../utils/wompi_mentor_checkout.dart';
import 'mentor_pass_benefits.dart';

/// Cierre de la prueba: invita al pase de 30 días (renovación manual).
/// Devuelve true si el usuario disparó el checkout.
Future<bool> showMentorTrialPaywall(BuildContext context) async {
  final goPay = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      final maxH = MediaQuery.sizeOf(ctx).height * 0.7;
      return AlertDialog(
        title: Text(
          AppConfig.mentorPassPaywallTitle,
          style: theme.textTheme.titleLarge,
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: const SingleChildScrollView(child: MentorPassBenefits()),
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
