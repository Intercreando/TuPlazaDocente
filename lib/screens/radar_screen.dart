import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/progress_practice_launch.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/competency_radar.dart';
import '../widgets/tag_mastery_map.dart';

/// Panel de estadísticas: pilares + temas (ruta /app/radar).
class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final profile = state.profile;
    final isDark = theme.brightness == Brightness.dark;
    final masteryRows = TagMasteryService.buildMap(profile);
    final recommended = TagMasteryService.recommendedToday(profile);

    return AtmosphericBackground(
      dark: isDark,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: ListView(
              padding: LayoutBreakpoints.pagePadding(context),
              children: [
                Text('Tu progreso', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(
                  'Toca un tema o un pilar para practicar justo ahí.',
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
                  child: CompetencyRadar(
                    profile: profile,
                    onPracticeWeakest: () =>
                        launchProgressPillar(context, weakestPillarOf(profile)),
                  ),
                ),
                const SizedBox(height: 22),
                Text('Temas del concurso', style: theme.textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(
                  'El porcentaje es de aciertos. Toca el tema que debas reforzar.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                TagMasteryMap(
                  rows: masteryRows,
                  recommendedCode: recommended?.code.name,
                ),
                const SizedBox(height: 10),
                Material(
                  color: AppColors.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => launchProgressRecommendation(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Recomendación de hoy: ${state.studyFocusMessage()} '
                              'Toca para ir a practicarlo.',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text('Detalle por pilar', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                ...CompetencyPillar.values.map((pillar) {
                  final total = profile.pillarTotal[pillar.name] ?? 0;
                  final accuracy = profile.pillarAccuracy(pillar);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _PillarDetailCard(
                      pillar: pillar,
                      total: total,
                      accuracy: accuracy,
                      isDark: isDark,
                      onTap: () => launchProgressPillar(context, pillar),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PillarDetailCard extends StatelessWidget {
  const _PillarDetailCard({
    required this.pillar,
    required this.total,
    required this.accuracy,
    required this.isDark,
    required this.onTap,
  });

  final CompetencyPillar pillar;
  final int total;
  final double accuracy;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weak = total > 0 && accuracy < 0.5;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
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
                    child: Text(
                      pillar.label,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Text(
                    total == 0 ? 'Sin datos' : '${(accuracy * 100).round()}%',
                    style: theme.textTheme.labelLarge,
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0.08 : accuracy.clamp(0.05, 1),
                  minHeight: 8,
                  color: weak ? AppColors.coral : AppColors.canopy,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                total == 0
                    ? 'Toca para practicar este pilar'
                    : '$total evidencias · Toca para practicar',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
