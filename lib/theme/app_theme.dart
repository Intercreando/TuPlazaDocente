import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_button_styles.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'reel_type.dart';

/// Tema global claro/oscuro de la aplicación.
abstract final class AppTheme {
  static ThemeData light() {
    final textTheme = AppTypography.lightTextTheme();
    final scheme = ColorScheme.light(
      primary: AppColors.ink,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.mist,
      onPrimaryContainer: AppColors.ink,
      secondary: AppColors.goldDeep,
      onSecondary: AppColors.ink,
      secondaryContainer: const Color(0xFFFFF1C2),
      onSecondaryContainer: AppColors.ink,
      tertiary: AppColors.canopy,
      onTertiary: AppColors.white,
      surface: AppColors.parchment,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      error: AppColors.danger,
      outline: AppColors.stroke,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.parchment,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.stroke),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: AppButtonStyles.filled(
          textStyle: textTheme.labelLarge,
          dark: false,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyles.outlined(
          textStyle: textTheme.labelLarge,
          dark: false,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: AppButtonStyles.text(
          textStyle: textTheme.labelLarge,
          dark: false,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.canopy, width: 1.6),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.mist,
        selectedColor: AppColors.ink,
        disabledColor: AppColors.stroke,
        labelStyle: textTheme.labelMedium?.copyWith(
          color: AppColors.textPrimary,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: AppColors.stroke),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.stroke,
        thickness: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.canopy,
        linearTrackColor: AppColors.mist,
      ),
      extensions: [ReelType.studio()],
    );
  }

  static ThemeData dark() {
    final textTheme = AppTypography.darkTextTheme();
    final scheme = ColorScheme.dark(
      primary: AppColors.seafoam,
      onPrimary: AppColors.ink,
      primaryContainer: AppColors.darkElevated,
      onPrimaryContainer: AppColors.darkText,
      secondary: AppColors.gold,
      onSecondary: AppColors.ink,
      tertiary: AppColors.skyLine,
      surface: AppColors.darkBg,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkTextSecondary,
      error: AppColors.coral,
      outline: AppColors.darkStroke,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBg,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkText,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.darkStroke),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: AppButtonStyles.filled(
          textStyle: textTheme.labelLarge,
          dark: true,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyles.outlined(
          textStyle: textTheme.labelLarge,
          dark: true,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: AppButtonStyles.text(
          textStyle: textTheme.labelLarge,
          dark: true,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.darkStroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.darkStroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.seafoam, width: 1.6),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkElevated,
        selectedColor: AppColors.seafoam,
        disabledColor: AppColors.darkStroke,
        labelStyle: textTheme.labelMedium?.copyWith(color: AppColors.darkText),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: AppColors.ink,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: AppColors.darkStroke),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkStroke,
        thickness: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.seafoam,
        linearTrackColor: AppColors.darkElevated,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: AppColors.darkText,
        textColor: AppColors.darkText,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.ink;
          return AppColors.darkText;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.gold;
          return AppColors.darkElevated;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.gold;
          return AppColors.darkStroke;
        }),
      ),
      extensions: [ReelType.studio()],
    );
  }
}
