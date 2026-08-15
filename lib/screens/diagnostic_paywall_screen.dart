import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../widgets/tag_mastery_map.dart';

/// Tras el diagnóstico de pauta: mapa real + oferta, sin copy inventado.
class DiagnosticPaywallScreen extends StatelessWidget {
  const DiagnosticPaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final rows = TagMasteryService.buildMap(state.profile)
        .where((row) => row.total > 0)
        .take(6)
        .toList();
    final message = TagMasteryService.diagnosticPaywallMessage(state.profile);
    final price = AppConfig.formatCop(state.displayedPremiumPriceCop);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu diagnóstico'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/app'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
              children: [
                Text(
                  'Mapa de maestría según tus respuestas',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(message, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 18),
                if (rows.isEmpty)
                  Text(
                    'Aún hay pocos datos en el mapa. El reto diario sigue abierto.',
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  TagMasteryMap(rows: rows, compact: true),
                const SizedBox(height: 22),
                FilledButton(
                  style: AppButtonStyles.premiumCheckout(
                    textStyle: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.ink,
                    ),
                  ),
                  onPressed: () => context.go('/premium'),
                  child: Text('Desbloquear Premium · $price'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () => context.go('/app'),
                  child: const Text('Seguir con el reto diario'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
