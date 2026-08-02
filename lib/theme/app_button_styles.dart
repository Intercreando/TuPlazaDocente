import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Estilos de botón con contraste explícito (activo y deshabilitado).
/// Evita el gris al 38% de Material, que falla sobre fondos atmosféricos.
abstract final class AppButtonStyles {
  static ButtonStyle filled({
    required TextStyle? textStyle,
    required bool dark,
  }) {
    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textStyle: WidgetStatePropertyAll(textStyle),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return dark ? AppColors.darkElevated : AppColors.mist;
        }
        return dark ? AppColors.seafoam : AppColors.ink;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return dark ? AppColors.darkTextSecondary : AppColors.textSecondary;
        }
        return dark ? AppColors.ink : AppColors.white;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return (dark ? AppColors.ink : AppColors.white).withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return (dark ? AppColors.ink : AppColors.white).withValues(alpha: 0.08);
        }
        return null;
      }),
    );
  }

  static ButtonStyle outlined({
    required TextStyle? textStyle,
    required bool dark,
  }) {
    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textStyle: WidgetStatePropertyAll(textStyle),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return dark ? AppColors.darkTextSecondary : AppColors.textSecondary;
        }
        return dark ? AppColors.darkText : AppColors.ink;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide(
            color: dark ? AppColors.darkStroke : AppColors.stroke,
            width: 1.4,
          );
        }
        return BorderSide(
          color: dark ? AppColors.seafoam : AppColors.inkSoft,
          width: 1.4,
        );
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return (dark ? AppColors.seafoam : AppColors.canopy)
              .withValues(alpha: 0.10);
        }
        return null;
      }),
    );
  }

  static ButtonStyle text({
    required TextStyle? textStyle,
    required bool dark,
  }) {
    return ButtonStyle(
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textStyle: WidgetStatePropertyAll(textStyle),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return dark ? AppColors.darkTextSecondary : AppColors.textMuted;
        }
        return dark ? AppColors.seafoam : AppColors.canopy;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return (dark ? AppColors.seafoam : AppColors.canopy)
              .withValues(alpha: 0.10);
        }
        return null;
      }),
    );
  }

  /// CTA sobre fondos oscuros/marca (racha, hero oscuro).
  static ButtonStyle filledOnBrand({required bool completed}) {
    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      backgroundColor: WidgetStatePropertyAll(
        completed ? AppColors.white : AppColors.gold,
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.ink),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return AppColors.ink.withValues(alpha: 0.08);
        }
        return null;
      }),
    );
  }
}
