import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/seo_landing_routes.dart';

/// Atajos desde la home hacia las tres guías públicas.
class SeoGuidesStrip extends StatelessWidget {
  const SeoGuidesStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const guides = [
      (SeoLandingRoutes.casos, 'Casos de aula resueltos'),
      (SeoLandingRoutes.psicotecnica, 'Prueba psicotécnica: ejemplos'),
      (SeoLandingRoutes.simulacro, 'Simulacro gratis'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Guías gratis del concurso', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Entra, lee y practica sin cuenta. El registro es solo si quieres el simulador.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 14),
        for (final g in guides) ...[
          OutlinedButton(
            onPressed: () => context.go(g.$1),
            child: Text(g.$2),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
