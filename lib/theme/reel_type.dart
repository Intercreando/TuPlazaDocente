import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Tipografía del lienzo Reels (9:16). Solo se usa en el estudio de grabación.
@immutable
class ReelType extends ThemeExtension<ReelType> {
  const ReelType({
    required this.hook,
    required this.hookCompact,
    required this.kicker,
    required this.situation,
    required this.option,
    required this.letter,
    required this.timer,
    required this.cta,
    required this.brand,
    required this.ctaBar,
    required this.watermark,
    required this.fineprint,
  });

  final TextStyle hook;
  final TextStyle hookCompact;
  final TextStyle kicker;
  final TextStyle situation;
  final TextStyle option;
  final TextStyle letter;
  final TextStyle timer;
  final TextStyle cta;
  final TextStyle brand;
  final TextStyle ctaBar;
  final TextStyle watermark;
  final TextStyle fineprint;

  /// Lienzo 1080×1920: misma paleta que la web (pergamino, tinta, oro).
  static ReelType studio() {
    return ReelType(
      hook: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 68,
        height: 1.08,
        letterSpacing: -1.4,
      ),
      hookCompact: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 28,
        height: 1.15,
        letterSpacing: -0.4,
      ),
      kicker: GoogleFonts.plusJakartaSans(
        color: AppColors.goldDeep,
        fontWeight: FontWeight.w700,
        fontSize: 26,
        height: 1.2,
        letterSpacing: 1.6,
      ),
      situation: GoogleFonts.plusJakartaSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 28,
        height: 1.28,
      ),
      option: GoogleFonts.plusJakartaSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 26,
        height: 1.25,
      ),
      letter: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 26,
        height: 1,
      ),
      timer: GoogleFonts.fraunces(
        color: AppColors.goldDeep,
        fontWeight: FontWeight.w700,
        fontSize: 176,
        height: 1,
      ),
      cta: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 42,
        height: 1.15,
      ),
      brand: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 22,
        height: 1.2,
      ),
      ctaBar: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 26,
        height: 1.15,
      ),
      watermark: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 32,
        height: 1.15,
        letterSpacing: -0.3,
      ),
      fineprint: GoogleFonts.plusJakartaSans(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        height: 1.3,
      ),
    );
  }

  static ReelType of(BuildContext context) {
    return Theme.of(context).extension<ReelType>() ?? ReelType.studio();
  }

  @override
  ReelType copyWith({
    TextStyle? hook,
    TextStyle? hookCompact,
    TextStyle? kicker,
    TextStyle? situation,
    TextStyle? option,
    TextStyle? letter,
    TextStyle? timer,
    TextStyle? cta,
    TextStyle? brand,
    TextStyle? ctaBar,
    TextStyle? watermark,
    TextStyle? fineprint,
  }) {
    return ReelType(
      hook: hook ?? this.hook,
      hookCompact: hookCompact ?? this.hookCompact,
      kicker: kicker ?? this.kicker,
      situation: situation ?? this.situation,
      option: option ?? this.option,
      letter: letter ?? this.letter,
      timer: timer ?? this.timer,
      cta: cta ?? this.cta,
      brand: brand ?? this.brand,
      ctaBar: ctaBar ?? this.ctaBar,
      watermark: watermark ?? this.watermark,
      fineprint: fineprint ?? this.fineprint,
    );
  }

  @override
  ReelType lerp(ThemeExtension<ReelType>? other, double t) {
    if (other is! ReelType) return this;
    return ReelType(
      hook: TextStyle.lerp(hook, other.hook, t) ?? hook,
      hookCompact:
          TextStyle.lerp(hookCompact, other.hookCompact, t) ?? hookCompact,
      kicker: TextStyle.lerp(kicker, other.kicker, t) ?? kicker,
      situation: TextStyle.lerp(situation, other.situation, t) ?? situation,
      option: TextStyle.lerp(option, other.option, t) ?? option,
      letter: TextStyle.lerp(letter, other.letter, t) ?? letter,
      timer: TextStyle.lerp(timer, other.timer, t) ?? timer,
      cta: TextStyle.lerp(cta, other.cta, t) ?? cta,
      brand: TextStyle.lerp(brand, other.brand, t) ?? brand,
      ctaBar: TextStyle.lerp(ctaBar, other.ctaBar, t) ?? ctaBar,
      watermark: TextStyle.lerp(watermark, other.watermark, t) ?? watermark,
      fineprint: TextStyle.lerp(fineprint, other.fineprint, t) ?? fineprint,
    );
  }
}
