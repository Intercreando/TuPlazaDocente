import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Opción de respuesta con estados correcto/incorrecto/seleccionado.
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.letter,
    required this.selected,
    required this.onTap,
    this.showResult = false,
    this.isCorrect = false,
  });

  final String label;
  final String letter;
  final bool selected;
  final VoidCallback onTap;
  final bool showResult;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color border;
    Color background;
    Color letterBg;
    Color letterFg = AppColors.white;

    if (showResult && isCorrect) {
      border = AppColors.success;
      background = AppColors.success.withValues(alpha: isDark ? 0.18 : 0.10);
      letterBg = AppColors.success;
    } else if (showResult && selected && !isCorrect) {
      border = AppColors.danger;
      background = AppColors.danger.withValues(alpha: isDark ? 0.18 : 0.10);
      letterBg = AppColors.danger;
    } else if (selected) {
      border = AppColors.canopy;
      background = AppColors.canopy.withValues(alpha: isDark ? 0.22 : 0.10);
      letterBg = AppColors.canopy;
    } else {
      border = isDark ? AppColors.darkStroke : AppColors.stroke;
      background = isDark ? AppColors.darkSurface : AppColors.white;
      letterBg = isDark ? AppColors.darkElevated : AppColors.mist;
      letterFg = isDark ? AppColors.darkText : AppColors.ink;
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border, width: selected || showResult ? 1.6 : 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: letterBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  letter,
                  style: theme.textTheme.labelLarge?.copyWith(color: letterFg),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(label, style: theme.textTheme.bodyLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
