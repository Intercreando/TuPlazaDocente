import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/legal_documents.dart';
import '../theme/app_colors.dart';

/// Enlaces compactos a Términos y Privacidad.
class LegalFooterLinks extends StatelessWidget {
  const LegalFooterLinks({
    super.key,
    this.compact = false,
    this.prefix,
  });

  final bool compact;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lead = prefix ??
        (compact
            ? 'Al continuar aceptas'
            : 'Al pagar o crear cuenta aceptas');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('$lead ', style: theme.textTheme.bodySmall),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: AppColors.canopy,
              ),
              onPressed: () => context.push('/legal/terms'),
              child: const Text('Términos'),
            ),
            Text(' y ', style: theme.textTheme.bodySmall),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: AppColors.canopy,
              ),
              onPressed: () => context.push('/legal/privacy'),
              child: const Text('Privacidad'),
            ),
            Text('.', style: theme.textTheme.bodySmall),
          ],
        ),
        if (!compact) ...[
          const SizedBox(height: 4),
          Text(
            'Soporte / reembolsos: ${LegalDocuments.contactEmail}',
            style: theme.textTheme.labelMedium,
          ),
        ],
      ],
    );
  }
}
