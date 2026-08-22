import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

/// Radar visual de los 4 pilares de competencia.
class CompetencyRadar extends StatelessWidget {
  const CompetencyRadar({
    super.key,
    required this.profile,
    this.onPracticeWeakest,
    this.compact = false,
  });

  final UserProfile profile;
  final VoidCallback? onPracticeWeakest;

  /// Sin título propio: va dentro de un acordeón de Progreso.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final values = CompetencyPillar.values
        .map((p) => (profile.pillarAccuracy(p) * 100).clamp(8, 100).toDouble())
        .toList();

    // Si no hay datos, muestra silueta base para no dejar vacío.
    final hasData = CompetencyPillar.values.any(
      (p) => (profile.pillarTotal[p.name] ?? 0) > 0,
    );
    final chartValues = hasData ? values : [35.0, 40.0, 28.0, 32.0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact) ...[
          Text('Cómo vas en cada pilar', style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
        ],
        _RadarHint(
          hasData: hasData,
          weakestLabel: profile.weakestPillarLabel,
          onPracticeWeakest: compact ? null : onPracticeWeakest,
          compact: compact,
        ),
        if (!compact || hasData) const SizedBox(height: 16),
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
                final labels = [
                  'Numérica',
                  'Lectura',
                  'Pedagógico',
                  'Comport.',
                ];
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

class _RadarHint extends StatelessWidget {
  const _RadarHint({
    required this.hasData,
    required this.weakestLabel,
    this.onPracticeWeakest,
    this.compact = false,
  });

  final bool hasData;
  final String weakestLabel;
  final VoidCallback? onPracticeWeakest;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (!hasData) {
      if (compact) return const SizedBox.shrink();
      return Text(
        'Completa las 5 del día para ver cómo vas',
        style: theme.textTheme.bodyMedium,
      );
    }
    if (weakestLabel.isEmpty || onPracticeWeakest == null) {
      return Text(
        compact
            ? 'Así se ven tus fortalezas y el punto más flojo.'
            : 'Así se ven tus fortalezas y lo que falta',
        style: theme.textTheme.bodyMedium,
      );
    }
    return InkWell(
      onTap: onPracticeWeakest,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Hoy conviene reforzar: $weakestLabel. Toca para practicar.',
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
    );
  }
}
