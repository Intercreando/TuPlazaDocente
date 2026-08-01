import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

/// Radar visual de los 4 pilares de competencia.
class CompetencyRadar extends StatelessWidget {
  const CompetencyRadar({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final values = CompetencyPillar.values
        .map((p) => (profile.pillarAccuracy(p) * 100).clamp(8, 100).toDouble())
        .toList();

    // Si no hay datos, muestra silueta base para no dejar vacío.
    final hasData = CompetencyPillar.values
        .any((p) => (profile.pillarTotal[p.name] ?? 0) > 0);
    final chartValues = hasData ? values : [35.0, 40.0, 28.0, 32.0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Radar de Competencias', style: theme.textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          hasData
              ? profile.weakestPillarLabel.isNotEmpty
                  ? 'Enfócate hoy en: ${profile.weakestPillarLabel}'
                  : 'Tu mapa de fortalezas y talones de Aquiles'
              : 'Vista previa: completa el reto diario para calibrar tu radar',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: RadarChart(
            RadarChartData(
              dataSets: [
                RadarDataSet(
                  fillColor: AppColors.canopy.withValues(alpha: 0.25),
                  borderColor: AppColors.canopy,
                  entryRadius: 3,
                  dataEntries: chartValues
                      .map((v) => RadarEntry(value: v))
                      .toList(),
                  borderWidth: 2.2,
                ),
              ],
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.7),
              ),
              titlePositionPercentageOffset: 0.18,
              titleTextStyle: theme.textTheme.labelMedium,
              getTitle: (index, _) {
                final labels = ['Numérica', 'Lectura', 'Pedagógico', 'Comport.'];
                return RadarChartTitle(text: labels[index]);
              },
              tickCount: 4,
              ticksTextStyle: theme.textTheme.labelSmall,
              tickBorderData: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.35),
              ),
              gridBorderData: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.45),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
