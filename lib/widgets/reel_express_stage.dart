import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/reel_type.dart';
import 'brand_logo.dart';

enum ReelBeat { ready, hook, question, countdown, close }

/// Lienzo 9:16 listo para captura de ventana (1080×1920).
class ReelExpressStage extends StatelessWidget {
  const ReelExpressStage({
    super.key,
    required this.clip,
    required this.beat,
    required this.countdownLeft,
    required this.revealMode,
    this.countdownProgress = 0,
    this.timerPulse = 1,
  });

  final ReelClip clip;
  final ReelBeat beat;
  final int countdownLeft;
  final bool revealMode;
  final double countdownProgress;
  final double timerPulse;

  static const designSize = Size(1080, 1920);
  static const letters = ['A', 'B', 'C', 'D'];

  /// TikTok/Reels: UI nativa come ~180 arriba, ~280 abajo, ~120 a la derecha.
  static const safeTop = 180.0;
  static const safeBottom = 280.0;
  static const safeRight = 120.0;
  static const safeLeft = 48.0;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    final showQuestion =
        beat == ReelBeat.question ||
        beat == ReelBeat.countdown ||
        beat == ReelBeat.close;
    final showTimer = beat == ReelBeat.countdown;
    final showClose = beat == ReelBeat.close;
    final highlight = revealMode && beat == ReelBeat.close;

    return ColoredBox(
      color: AppColors.ink,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          safeLeft,
          safeTop,
          safeRight,
          safeBottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ReelWatermark(),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: beat == ReelBeat.hook
                  ? Column(
                      key: const ValueKey('hook-full'),
                      children: [
                        Text(
                          'CONCURSO DOCENTE 2026',
                          style: type.kicker,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          ReelStudioPack.hook,
                          style: type.hook,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : beat == ReelBeat.close
                  ? const SizedBox.shrink(key: ValueKey('hook-off'))
                  : Text(
                      key: const ValueKey('hook-compact'),
                      ReelStudioPack.hook,
                      style: type.hookCompact,
                      textAlign: TextAlign.center,
                    ),
            ),
            if (showQuestion) ...[
              const SizedBox(height: 18),
              if (!showClose) ...[
                Text(clip.situation, style: type.situation),
                const SizedBox(height: 12),
                Text(clip.stem, style: type.kicker),
                const SizedBox(height: 16),
              ],
              for (var i = 0; i < clip.options.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _OptionRow(
                  letter: i < letters.length ? letters[i] : '${i + 1}',
                  text: clip.options[i],
                  marked: highlight && i == clip.correctIndex,
                  dimmed: highlight && i != clip.correctIndex,
                ),
              ],
            ],
            const Spacer(),
            if (showTimer) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: SizedBox(
                  height: 8,
                  child: LinearProgressIndicator(
                    value: countdownProgress.clamp(0.0, 1.0),
                    backgroundColor: AppColors.white.withValues(alpha: 0.16),
                    color: AppColors.gold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Transform.scale(
                scale: timerPulse,
                child: Text(
                  '$countdownLeft',
                  style: type.timer,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            if (showClose) ...[
              Text(
                revealMode
                    ? 'Respuesta: ${clip.correctLetter}\n${clip.revealWhy}'
                    : ReelStudioPack.closeComenta,
                style: type.cta,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  child: Text(
                    ReelStudioPack.closeRegister,
                    style: type.ctaBar,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(
              ReelStudioPack.disclaimer,
              style: type.fineprint,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Logo mínimo durante el caso: sin pedir registro.
class _ReelWatermark extends StatelessWidget {
  const _ReelWatermark();

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Padding(
            padding: EdgeInsets.all(3),
            child: BrandLogo(size: 28),
          ),
        ),
        const SizedBox(width: 10),
        Text(ReelStudioPack.brand, style: type.watermark),
      ],
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.letter,
    required this.text,
    required this.marked,
    required this.dimmed,
  });

  final String letter;
  final String text;
  final bool marked;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    final bg = marked ? AppColors.gold : AppColors.inkSoft;
    final border = marked ? AppColors.goldDeep : AppColors.canopy;
    return Opacity(
      opacity: dimmed ? 0.38 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: marked ? AppColors.ink : AppColors.gold,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(letter, style: type.letter),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: type.option.copyWith(
                    color: marked ? AppColors.ink : AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
