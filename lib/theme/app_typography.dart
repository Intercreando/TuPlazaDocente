import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Jerarquía tipográfica semántica. Los widgets deben usar estos estilos,
/// nunca fontSize/fontWeight sueltos.
abstract final class AppTypography {
  static TextTheme lightTextTheme() {
    final display = GoogleFonts.frauncesTextTheme();
    final body = GoogleFonts.plusJakartaSansTextTheme();

    return body.copyWith(
      displayLarge: display.displayLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        height: 1.05,
      ),
      displayMedium: display.displayMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.1,
      ),
      displaySmall: display.displaySmall?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.4,
        height: 1.15,
      ),
      headlineLarge: display.headlineLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        height: 1.15,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      headlineSmall: display.headlineSmall?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      titleLarge: body.titleLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleMedium: body.titleMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      titleSmall: body.titleSmall?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      bodyLarge: body.bodyLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
        height: 1.55,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: body.bodySmall?.copyWith(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),
      labelLarge: body.labelLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
      labelMedium: body.labelMedium?.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelSmall: body.labelSmall?.copyWith(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w600,
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
      labelMedium: base.labelMedium?.copyWith(color: AppColors.darkTextSecondary),
      labelSmall: base.labelSmall?.copyWith(color: AppColors.darkTextSecondary),
    );
  }
}
