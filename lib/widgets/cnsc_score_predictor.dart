import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../models/user_profile.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';

/// Simulador de puntaje ponderado (prueba escrita, 0–100).
/// Pedagógico 50 %; el resto de pilares se reparte el 50 % restante.
class CnscScorePredictor extends StatelessWidget {
  const CnscScorePredictor({super.key});

  static const double _pedagogicalWeight = 0.50;
  static const double _passThreshold = 60;

  static double projectedScore(UserProfile profile) {
    final others = CompetencyPillar.values
        .where((p) => p != CompetencyPillar.pedagogico)
        .toList();
    final otherWeight =
        others.isEmpty ? 0.0 : (1 - _pedagogicalWeight) / others.length;

    var total = 0.0;
    for (final pillar in CompetencyPillar.values) {
      final weight = pillar == CompetencyPillar.pedagogico
          ? _pedagogicalWeight
          : otherWeight;
      total += profile.pillarAccuracy(pillar) * weight;
    }
    return (total * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    final theme = Theme.of(context);
    final score = projectedScore(profile);
    final hasEvidence = profile.totalAnswers > 0;
    final classified = hasEvidence && score >= _passThreshold;
    final color = !hasEvidence
        ? theme.colorScheme.onSurfaceVariant
        : (classified ? AppColors.success : AppColors.danger);
    final label = hasEvidence ? score.toStringAsFixed(1) : '—';

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: color.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: color.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
        child: Column(
          children: [
            Text(
              'Proyección de Puntaje CNSC',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '$label / 100',
              style: theme.textTheme.displaySmall?.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              !hasEvidence
                  ? 'Aún no hay evidencias. El corte de la prueba escrita es 60.0 / 100. '
                      'Practica primero; este número no te elimina ni te clasifica todavía.'
                  : classified
                      ? 'Estado: CLASIFICADO. Estás superando el corte eliminatorio. '
                          'Sigue subiendo tu puntaje para asegurar tu plaza.'
                      : 'Estado: ELIMINADO. No alcanzas el umbral mínimo para pasar '
                          'a la revisión de hoja de vida.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Nota: Cálculo basado en ponderación estimada del acuerdo de la CNSC.',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
