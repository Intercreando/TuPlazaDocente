import 'package:flutter/material.dart';

import '../services/tag_mastery_service.dart';
import '../theme/app_colors.dart';

/// Mapa de Maestría por etiquetas (norma/teoría), no conteo de ítems.
class TagMasteryMap extends StatelessWidget {
  const TagMasteryMap({
    super.key,
    required this.rows,
    this.compact = false,
    this.maxItems,
    this.recommendedCode,
  });

  final List<TagMasteryRow> rows;
  final bool compact;
  final int? maxItems;
  final String? recommendedCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final visible = maxItems == null ? rows : rows.take(maxItems!).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final row in visible) ...[
          _MasteryTile(
            row: row,
            compact: compact,
            highlighted: recommendedCode == row.code.name,
            isDark: isDark,
          ),
          SizedBox(height: compact ? 8 : 10),
        ],
        if (maxItems != null && rows.length > maxItems!)
          Text(
            '+ ${rows.length - maxItems!} dominios más en tu currículo de maestría',
            style: theme.textTheme.bodySmall,
          ),
      ],
    );
  }
}

class _MasteryTile extends StatelessWidget {
  const _MasteryTile({
    required this.row,
    required this.compact,
    required this.highlighted,
    required this.isDark,
  });

  final TagMasteryRow row;
  final bool compact;
  final bool highlighted;
  final bool isDark;

  Color _levelColor() {
    switch (row.level) {
      case MasteryLevel.sinDatos:
        return AppColors.textMuted;
      case MasteryLevel.critico:
        return AppColors.coral;
      case MasteryLevel.enDesarrollo:
        return AppColors.goldDeep;
      case MasteryLevel.profesional:
        return AppColors.canopy;
      case MasteryLevel.experto:
        return AppColors.canopy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _levelColor();
    final progress = row.total == 0 ? 0.06 : row.accuracy.clamp(0.08, 1.0);

    return Container(
      padding: EdgeInsets.all(compact ? 12 : 14),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.coral.withValues(alpha: isDark ? 0.14 : 0.08)
            : (isDark ? AppColors.darkSurface : AppColors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted
              ? AppColors.coral.withValues(alpha: 0.45)
              : theme.colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(row.headline, style: theme.textTheme.titleSmall),
              ),
              Text(
                row.level.label,
                style: theme.textTheme.labelMedium?.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(row.subtitle, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: compact ? 6 : 8,
              color: color,
              backgroundColor: color.withValues(alpha: 0.15),
            ),
          ),
          if (highlighted && row.level.needsPractice) ...[
            const SizedBox(height: 8),
            Text(
              'Te recomendamos practicar este tema hoy',
              style: theme.textTheme.labelSmall?.copyWith(color: AppColors.coral),
            ),
          ],
        ],
      ),
    );
  }
}
