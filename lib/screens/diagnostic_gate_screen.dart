import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';

/// Puerta de pauta: el diagnóstico de 20 ítems no se puede saltar.
class DiagnosticGateScreen extends StatelessWidget {
  const DiagnosticGateScreen({super.key});

  void _start(BuildContext context, AppState state) {
    try {
      if (state.currentMode == SessionMode.diagnostic &&
          state.currentQuestion != null) {
        context.go('/practice');
        return;
      }
      final ok = state.startSession(mode: SessionMode.diagnostic, count: 20);
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.lastError ?? 'No se pudo iniciar el diagnóstico.',
            ),
          ),
        );
        return;
      }
      context.go('/practice');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el diagnóstico. Intenta de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final isDark = theme.brightness == Brightness.dark;
    final resume = state.currentMode == SessionMode.diagnostic &&
        state.currentQuestion != null;

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tu primera simulación',
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Es un diagnóstico de 20 preguntas (gratis). '
                      'Al terminar verás tu mapa de maestría real: no inventamos fallas. '
                      'El Examen Real cronometrado queda en Premium.',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 28),
                    FilledButton(
                      onPressed: () => _start(context, state),
                      child: Text(
                        resume
                            ? 'Continuar diagnóstico'
                            : 'Empezar diagnóstico',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Luego puedes usar el reto diario y el reto rápido sin pagar.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
