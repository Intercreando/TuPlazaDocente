import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/reel_type.dart';

/// Cierre del reel cuando NO se revela la respuesta.
///
/// El objetivo del último fotograma es uno solo: que la persona comente su
/// letra. Por eso no se repiten las opciones (ya se leyeron y compiten con el
/// mensaje); se dejan las cuatro letras como recordatorio y una acción única.
class ReelCommentCta extends StatelessWidget {
  const ReelCommentCta({super.key, this.letters = const ['A', 'B', 'C', 'D']});

  final List<String> letters;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('TU TURNO', style: type.kicker, textAlign: TextAlign.center),
        const SizedBox(height: 18),
        Text(
          ReelStudioPack.closeAsk,
          style: type.closeTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final letter in letters) ...[
              if (letter != letters.first) const SizedBox(width: 18),
              _LetterChip(letter: letter),
            ],
          ],
        ),
        const SizedBox(height: 36),
        Text(
          ReelStudioPack.closeComenta,
          style: type.cta,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          ReelStudioPack.closeDebate,
          style: type.brand,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        // La caja de comentarios queda abajo en TikTok/Reels: la flecha guía el dedo.
        const Icon(
          Icons.keyboard_double_arrow_down_rounded,
          size: 72,
          color: AppColors.goldDeep,
        ),
        const SizedBox(height: 10),
        Text(
          ReelStudioPack.closeFollow,
          style: type.brand,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Recordatorio visual de las cuatro letras posibles.
class _LetterChip extends StatelessWidget {
  const _LetterChip({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.goldDeep, width: 4),
      ),
      child: SizedBox(
        width: 150,
        height: 112,
        child: Center(child: Text(letter, style: type.closeLetter)),
      ),
    );
  }
}

/// Cierre del capítulo 2: se marca la letra correcta y se explica el porqué.
class ReelRevealClose extends StatelessWidget {
  const ReelRevealClose({
    super.key,
    required this.correctLetter,
    required this.why,
  });

  final String correctLetter;
  final String why;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return Column(
      children: [
        Text(
          'RESPUESTA CORRECTA',
          style: type.kicker,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Text(
          correctLetter,
          style: type.closeTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Text(why, style: type.cta, textAlign: TextAlign.center),
      ],
    );
  }
}

/// Barra de marca del cierre: sitio + acción gratuita.
class ReelCloseBrandBar extends StatelessWidget {
  const ReelCloseBrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            Text(
              ReelStudioPack.site,
              style: type.ctaBar,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              ReelStudioPack.closeAction,
              style: type.brand,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
