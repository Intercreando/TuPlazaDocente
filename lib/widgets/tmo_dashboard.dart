import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';

/// Semáforo de TMO histórico por pilar (segundos acumulados / evidencias).
class TmoDashboardPanel extends StatelessWidget {
  const TmoDashboardPanel({super.key, this.compact = false});

  /// Sin título propio: va dentro de un acordeón de Progreso.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact) ...[
          Text(
            'Análisis de Velocidad (TMO)',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Tiempo medio por pregunta en cada pilar. El examen pide ritmo, no solo acierto.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
        ],
        ...CompetencyPillar.values.map((pilar) {
          final totalTime = profile.pillarTimeSpent[pilar.name] ?? 0;
          final totalAnswers = profile.pillarTotal[pilar.name] ?? 0;
          final divisor = totalAnswers < 1 ? 1 : totalAnswers;
          final tmoPromedio = totalTime / divisor;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _TmoPilarCard(
              pillarLabel: pilar.label,
              totalAnswers: totalAnswers,
              tmoPromedio: tmoPromedio,
              compact: compact,
            ),
          );
        }),
      ],
    );
  }
}

class _TmoPilarCard extends StatelessWidget {
  const _TmoPilarCard({
    required this.pillarLabel,
    required this.totalAnswers,
    required this.tmoPromedio,
    this.compact = false,
  });

  final String pillarLabel;
  final int totalAnswers;
  final double tmoPromedio;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final empty = totalAnswers == 0 || tmoPromedio == 0;
    final tone = empty
        ? _TmoTone.empty
        : tmoPromedio > 90
            ? _TmoTone.danger
            : tmoPromedio > 60
                ? _TmoTone.warning
                : _TmoTone.success;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: tone.color.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: tone.color.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(tone.icon, color: tone.color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pillarLabel, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    empty
                        ? 'Sin datos suficientes.'
                        : compact
                            ? _formatTmo(tmoPromedio)
                            : 'TMO promedio: ${_formatTmo(tmoPromedio)}',
                    style: theme.textTheme.labelLarge,
                  ),
                  if (!compact) ...[
                    const SizedBox(height: 4),
                    Text(tone.message, style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTmo(double seconds) {
    final total = seconds.round();
    final minutes = total ~/ 60;
    final rest = total % 60;
    if (minutes <= 0) return '${rest}s';
    return '${minutes}m ${rest}s';
  }
}

enum _TmoTone {
  empty(
    AppColors.textMuted,
    Icons.hourglass_empty,
    'Sin datos suficientes.',
  ),
  danger(
    AppColors.danger,
    Icons.warning_amber_rounded,
    'Peligro: Estás superando el tiempo límite. Debes acelerar.',
  ),
  warning(
    AppColors.warning,
    Icons.timer_outlined,
    'Buen ritmo, pero en el examen real estarás justo de tiempo.',
  ),
  success(
    AppColors.success,
    Icons.check_circle_outline,
    'Velocidad óptima. ¡Sigue así!',
  );

  const _TmoTone(this.color, this.icon, this.message);
  final Color color;
  final IconData icon;
  final String message;
}
