import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Tipografía del lienzo Reels (9:16). Solo se usa en el estudio de grabación.
///
/// Las medidas están pensadas para el lienzo de 1080×1920: el vídeo se ve en
/// pantallas pequeñas y sobrevive a la compresión de TikTok/Reels, así que
/// todo va notablemente más grande que en la web.
@immutable
class ReelType extends ThemeExtension<ReelType> {
  const ReelType({
    required this.hook,
    required this.kicker,
    required this.situation,
    required this.stem,
    required this.option,
    required this.letter,
    required this.timer,
    required this.closeTitle,
    required this.closeLetter,
    required this.cta,
    required this.brand,
    required this.ctaBar,
    required this.watermark,
    required this.fineprint,
  });

  final TextStyle hook;
  final TextStyle kicker;
  final TextStyle situation;
  final TextStyle stem;
  final TextStyle option;
  final TextStyle letter;
  final TextStyle timer;

  /// Cierre sin revelar: pregunta gigante y píldoras de letras.
  final TextStyle closeTitle;
  final TextStyle closeLetter;

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
        fontSize: 76,
        height: 1.08,
        letterSpacing: -1.4,
      ),
      kicker: GoogleFonts.plusJakartaSans(
        color: AppColors.goldDeep,
        fontWeight: FontWeight.w800,
        fontSize: 30,
        height: 1.2,
        letterSpacing: 1.6,
      ),
      situation: GoogleFonts.plusJakartaSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 38,
        height: 1.26,
      ),
      stem: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 44,
        height: 1.14,
        letterSpacing: -0.6,
      ),
      option: GoogleFonts.plusJakartaSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 36,
        height: 1.22,
      ),
      letter: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 34,
        height: 1,
      ),
      timer: GoogleFonts.fraunces(
        color: AppColors.goldDeep,
        fontWeight: FontWeight.w700,
        fontSize: 200,
        height: 1,
      ),
      closeTitle: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 104,
        height: 1.02,
        letterSpacing: -2,
      ),
      closeLetter: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 52,
        height: 1,
      ),
      cta: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 52,
        height: 1.14,
      ),
      brand: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 28,
        height: 1.2,
      ),
      ctaBar: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 36,
        height: 1.15,
      ),
      watermark: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 30,
        height: 1.15,
        letterSpacing: -0.3,
      ),
      fineprint: GoogleFonts.plusJakartaSans(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w600,
        fontSize: 24,
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
    TextStyle? kicker,
    TextStyle? situation,
    TextStyle? stem,
    TextStyle? option,
    TextStyle? letter,
    TextStyle? timer,
    TextStyle? closeTitle,
    TextStyle? closeLetter,
    TextStyle? cta,
    TextStyle? brand,
    TextStyle? ctaBar,
    TextStyle? watermark,
    TextStyle? fineprint,
  }) {
    return ReelType(
      hook: hook ?? this.hook,
      kicker: kicker ?? this.kicker,
      situation: situation ?? this.situation,
      stem: stem ?? this.stem,
      option: option ?? this.option,
      letter: letter ?? this.letter,
      timer: timer ?? this.timer,
      closeTitle: closeTitle ?? this.closeTitle,
      closeLetter: closeLetter ?? this.closeLetter,
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
      kicker: TextStyle.lerp(kicker, other.kicker, t) ?? kicker,
      situation: TextStyle.lerp(situation, other.situation, t) ?? situation,
      stem: TextStyle.lerp(stem, other.stem, t) ?? stem,
      option: TextStyle.lerp(option, other.option, t) ?? option,
      letter: TextStyle.lerp(letter, other.letter, t) ?? letter,
      timer: TextStyle.lerp(timer, other.timer, t) ?? timer,
      closeTitle: TextStyle.lerp(closeTitle, other.closeTitle, t) ?? closeTitle,
      closeLetter:
          TextStyle.lerp(closeLetter, other.closeLetter, t) ?? closeLetter,
      cta: TextStyle.lerp(cta, other.cta, t) ?? cta,
      brand: TextStyle.lerp(brand, other.brand, t) ?? brand,
      ctaBar: TextStyle.lerp(ctaBar, other.ctaBar, t) ?? ctaBar,
      watermark: TextStyle.lerp(watermark, other.watermark, t) ?? watermark,
      fineprint: TextStyle.lerp(fineprint, other.fineprint, t) ?? fineprint,
    );
  }
}
