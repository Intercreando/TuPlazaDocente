import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';

/// Paywall freemium (demo local de activación Premium).
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/app');
                        }
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Text('Premium por convocatoria', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Acceso ilimitado al banco explicado, simulacros cronometrados, '
                    'módulo de especialidad y radar avanzado.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 22),
                  _PlanCard(
                    title: 'Gratis',
                    price: '\$0',
                    items: const [
                      'Reto diario de 5 preguntas',
                      '1 simulacro corto al mes',
                      'Estadísticas básicas',
                    ],
                    highlighted: false,
                  ),
                  const SizedBox(height: 12),
                  _PlanCard(
                    title: 'Premium',
                    price: 'Pago único / convocatoria',
                    items: const [
                      'Banco ilimitado con explicación profunda',
                      'Simulacros completos + mapa de calor',
                      'Casos de aula y especialidad',
                      'Radar avanzado y plan hasta el examen',
                    ],
                    highlighted: true,
                  ),
                  const SizedBox(height: 22),
                  if (state.profile.isPremium)
                    FilledButton(
                      onPressed: () => context.go('/app'),
                      child: const Text('Ya eres Premium · Ir a entrenar'),
                    )
                  else
                    FilledButton(
                      onPressed: () async {
                        await state.activatePremiumDemo();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Premium demo activado en este dispositivo. '
                              'Luego conectaremos pagos reales (Mercado Pago/Stripe).',
                            ),
                          ),
                        );
                        context.go('/app');
                      },
                      child: const Text('Activar Premium (demo)'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.items,
    required this.highlighted,
  });

  final String title;
  final String price;
  final List<String> items;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: highlighted ? AppColors.ink : theme.cardTheme.color,
        border: Border.all(
          color: highlighted ? AppColors.gold : theme.colorScheme.outline,
          width: highlighted ? 1.6 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: highlighted ? AppColors.gold : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: theme.textTheme.titleSmall?.copyWith(
              color: highlighted ? AppColors.white : null,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: highlighted ? AppColors.seafoam : AppColors.canopy,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: highlighted
                            ? AppColors.white.withValues(alpha: 0.9)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
