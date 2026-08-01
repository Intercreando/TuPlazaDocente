import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/competency_radar.dart';

/// Panel de estadísticas y talón de Aquiles.
class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final profile = state.profile;
    final isDark = theme.brightness == Brightness.dark;

    return AtmosphericBackground(
      dark: isDark,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                Text('Tu radar', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(
                  'No es una nota plana: es un mapa táctico de dónde estás fuerte y dónde cedes tiempo.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: CompetencyRadar(profile: profile),
                ),
                const SizedBox(height: 18),
                Text('Detalle por pilar', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                ...CompetencyPillar.values.map((pillar) {
                  final total = profile.pillarTotal[pillar.name] ?? 0;
                  final accuracy = profile.pillarAccuracy(pillar);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colorScheme.outline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(pillar.label, style: theme.textTheme.titleSmall),
                              ),
                              Text(
                                total == 0 ? 'Sin datos' : '${(accuracy * 100).round()}%',
                                style: theme.textTheme.labelLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: total == 0 ? 0.08 : accuracy.clamp(0.05, 1),
                              minHeight: 8,
                              color: accuracy < 0.5 ? AppColors.coral : AppColors.canopy,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            total == 0
                                ? 'Practica este pilar para activar la métrica'
                                : '$total respuestas registradas',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
                  ),
                  child: Text(
                    'Recomendación de hoy: ${state.studyFocusMessage()}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
