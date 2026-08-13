import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Jerarquía tipográfica semántica. Los widgets deben usar estos estilos,
/// nunca fontSize/fontWeight sueltos.
abstract final class AppTypography {
  static TextTheme lightTextTheme() {
    final base = ThemeData.light().textTheme;
    return TextTheme(
      displayLarge: _display(
        base.displayLarge,
        weight: FontWeight.w700,
        letterSpacing: -1.2,
        height: 1.05,
      ),
      displayMedium: _display(
        base.displayMedium,
        weight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.1,
      ),
      displaySmall: _display(
        base.displaySmall,
        weight: FontWeight.w600,
        letterSpacing: -0.4,
        height: 1.15,
      ),
      headlineLarge: _display(
        base.headlineLarge,
        weight: FontWeight.w700,
        height: 1.15,
      ),
      headlineMedium: _display(
        base.headlineMedium,
        weight: FontWeight.w600,
        height: 1.2,
      ),
      headlineSmall: _display(
        base.headlineSmall,
        weight: FontWeight.w600,
        height: 1.25,
      ),
      titleLarge: _body(
        base.titleLarge,
        color: AppColors.textPrimary,
        weight: FontWeight.w700,
        height: 1.3,
      ),
      titleMedium: _body(
        base.titleMedium,
        color: AppColors.textPrimary,
        weight: FontWeight.w600,
        height: 1.35,
      ),
      titleSmall: _body(
        base.titleSmall,
        color: AppColors.textPrimary,
        weight: FontWeight.w600,
        height: 1.35,
      ),
      bodyLarge: _body(
        base.bodyLarge,
        color: AppColors.textPrimary,
        weight: FontWeight.w400,
        height: 1.55,
      ),
      bodyMedium: _body(
        base.bodyMedium,
        color: AppColors.textSecondary,
        weight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: _body(
        base.bodySmall,
        color: AppColors.textMuted,
        weight: FontWeight.w400,
        height: 1.45,
      ),
      labelLarge: _body(
        base.labelLarge,
        color: AppColors.textPrimary,
        weight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
      labelMedium: _body(
        base.labelMedium,
        color: AppColors.textSecondary,
        weight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelSmall: _body(
        base.labelSmall,
        color: AppColors.textMuted,
        weight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }

  static TextTheme darkTextTheme() {
    final base = lightTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(color: AppColors.darkText),
      displayMedium: base.displayMedium?.copyWith(color: AppColors.darkText),
      displaySmall: base.displaySmall?.copyWith(color: AppColors.darkText),
      headlineLarge: base.headlineLarge?.copyWith(color: AppColors.darkText),
      headlineMedium: base.headlineMedium?.copyWith(color: AppColors.darkText),
      headlineSmall: base.headlineSmall?.copyWith(color: AppColors.darkText),
      titleLarge: base.titleLarge?.copyWith(color: AppColors.darkText),
      titleMedium: base.titleMedium?.copyWith(color: AppColors.darkText),
      titleSmall: base.titleSmall?.copyWith(color: AppColors.darkText),
      bodyLarge: base.bodyLarge?.copyWith(color: AppColors.darkText),
      bodyMedium: base.bodyMedium?.copyWith(color: AppColors.darkTextSecondary),
      bodySmall: base.bodySmall?.copyWith(color: AppColors.darkTextSecondary),
      labelLarge: base.labelLarge?.copyWith(color: AppColors.darkText),
      labelMedium:
          base.labelMedium?.copyWith(color: AppColors.darkTextSecondary),
      labelSmall: base.labelSmall?.copyWith(color: AppColors.darkTextSecondary),
    );
  }

  static TextStyle _display(
    TextStyle? base, {
    required FontWeight weight,
    double? letterSpacing,
    required double height,
  }) {
    return GoogleFonts.fraunces(
      textStyle: base,
      color: AppColors.textPrimary,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle _body(
    TextStyle? base, {
    required Color color,
    required FontWeight weight,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.plusJakartaSans(
      textStyle: base,
      color: color,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}
