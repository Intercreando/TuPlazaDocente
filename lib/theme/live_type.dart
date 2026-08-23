import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Tipografía del lienzo de YouTube (16:9). Solo se usa en el estudio en vivo.
///
/// Las medidas están pensadas para 1920×1080: el chat de YouTube no tapa el
/// vídeo, así que se puede leer más texto que en un reel 9:16, pero el tipo
/// sigue siendo grande para verse en un televisor.
@immutable
class LiveType extends ThemeExtension<LiveType> {
  const LiveType({
    required this.hook,
    required this.kicker,
    required this.situation,
    required this.stem,
    required this.option,
    required this.letter,
    required this.timer,
    required this.title,
    required this.cta,
    required this.brand,
    required this.badge,
    required this.watermark,
    required this.fineprint,
    required this.lowerThird,
  });

  final TextStyle hook;
  final TextStyle kicker;
  final TextStyle situation;
  final TextStyle stem;
  final TextStyle option;
  final TextStyle letter;
  final TextStyle timer;
  final TextStyle title;
  final TextStyle cta;
  final TextStyle brand;
  final TextStyle badge;
  final TextStyle watermark;
  final TextStyle fineprint;
  final TextStyle lowerThird;

  static LiveType studio() {
    return LiveType(
      hook: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 54,
        height: 1.1,
        letterSpacing: -1,
      ),
      kicker: GoogleFonts.plusJakartaSans(
        color: AppColors.goldDeep,
        fontWeight: FontWeight.w800,
        fontSize: 20,
        height: 1.2,
        letterSpacing: 1.4,
      ),
      situation: GoogleFonts.plusJakartaSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 26,
        height: 1.28,
      ),
      stem: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.16,
        letterSpacing: -0.4,
      ),
      option: GoogleFonts.plusJakartaSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 22,
        height: 1.22,
      ),
      letter: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 24,
        height: 1,
      ),
      timer: GoogleFonts.fraunces(
        color: AppColors.goldDeep,
        fontWeight: FontWeight.w700,
        fontSize: 92,
        height: 1,
      ),
      title: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 44,
        height: 1.08,
        letterSpacing: -0.8,
      ),
      cta: GoogleFonts.fraunces(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 36,
        height: 1.16,
      ),
      brand: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 1.2,
      ),
      badge: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 16,
        height: 1,
        letterSpacing: 1.1,
      ),
      watermark: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 20,
        height: 1.15,
        letterSpacing: -0.2,
      ),
      fineprint: GoogleFonts.plusJakartaSans(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.3,
      ),
      lowerThird: GoogleFonts.plusJakartaSans(
        color: AppColors.ink,
        fontWeight: FontWeight.w800,
        fontSize: 22,
        height: 1.15,
      ),
    );
  }

  static LiveType of(BuildContext context) {
    return Theme.of(context).extension<LiveType>() ?? LiveType.studio();
  }

  @override
  LiveType copyWith({
    TextStyle? hook,
    TextStyle? kicker,
    TextStyle? situation,
    TextStyle? stem,
    TextStyle? option,
    TextStyle? letter,
    TextStyle? timer,
    TextStyle? title,
    TextStyle? cta,
    TextStyle? brand,
    TextStyle? badge,
    TextStyle? watermark,
    TextStyle? fineprint,
    TextStyle? lowerThird,
  }) {
    return LiveType(
      hook: hook ?? this.hook,
      kicker: kicker ?? this.kicker,
      situation: situation ?? this.situation,
      stem: stem ?? this.stem,
      option: option ?? this.option,
      letter: letter ?? this.letter,
      timer: timer ?? this.timer,
      title: title ?? this.title,
      cta: cta ?? this.cta,
      brand: brand ?? this.brand,
      badge: badge ?? this.badge,
      watermark: watermark ?? this.watermark,
      fineprint: fineprint ?? this.fineprint,
      lowerThird: lowerThird ?? this.lowerThird,
    );
  }

  @override
  LiveType lerp(ThemeExtension<LiveType>? other, double t) {
    if (other is! LiveType) return this;
    return LiveType(
      hook: TextStyle.lerp(hook, other.hook, t) ?? hook,
      kicker: TextStyle.lerp(kicker, other.kicker, t) ?? kicker,
      situation: TextStyle.lerp(situation, other.situation, t) ?? situation,
      stem: TextStyle.lerp(stem, other.stem, t) ?? stem,
      option: TextStyle.lerp(option, other.option, t) ?? option,
      letter: TextStyle.lerp(letter, other.letter, t) ?? letter,
      timer: TextStyle.lerp(timer, other.timer, t) ?? timer,
      title: TextStyle.lerp(title, other.title, t) ?? title,
      cta: TextStyle.lerp(cta, other.cta, t) ?? cta,
      brand: TextStyle.lerp(brand, other.brand, t) ?? brand,
      badge: TextStyle.lerp(badge, other.badge, t) ?? badge,
      watermark: TextStyle.lerp(watermark, other.watermark, t) ?? watermark,
      fineprint: TextStyle.lerp(fineprint, other.fineprint, t) ?? fineprint,
      lowerThird: TextStyle.lerp(lowerThird, other.lowerThird, t) ?? lowerThird,
    );
  }
}
