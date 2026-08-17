import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/reel_type.dart';
import 'atmospheric_background.dart';
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

  /// TikTok: barra “Buscar contenido relacionado” + likes a la derecha.
  static const safeTop = 280.0;
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

    return ClipRect(
      child: AtmosphericBackground(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            safeLeft,
            safeTop,
            safeRight,
            safeBottom,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: beat == ReelBeat.hook
                ? const _ReelHookHero(key: ValueKey('hook-hero'))
                : Column(
                    key: const ValueKey('hook-off-case'),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _ReelWatermark(),
                      if (!showClose) ...[
                        const SizedBox(height: 16),
                        Text(
                          ReelStudioPack.hook,
                          style: type.hookCompact,
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                            letter: i < letters.length
                                ? letters[i]
                                : '${i + 1}',
                            text: clip.options[i],
                            marked: highlight && i == clip.correctIndex,
                            dimmed: highlight && i != clip.correctIndex,
                          ),
                        ],
                      ],
                      if (showTimer) ...[
                        const SizedBox(height: 56),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: SizedBox(
                            height: 8,
                            child: LinearProgressIndicator(
                              value: countdownProgress.clamp(0.0, 1.0),
                              backgroundColor: AppColors.mist,
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
                        const SizedBox(height: 20),
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
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 12),
                      Text(
                        ReelStudioPack.disclaimer,
                        style: type.fineprint,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Primera pantalla: marca + H1 centrados y un poco más grandes.
class _ReelHookHero extends StatelessWidget {
  const _ReelHookHero({super.key});

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _ReelWatermark(large: true),
            const SizedBox(height: 28),
            Text(
              'CONCURSO DOCENTE 2026',
              style: type.kicker,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              ReelStudioPack.hook,
              style: type.hook,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
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
  const _ReelWatermark({this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    final markSize = large ? 48.0 : 32.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BrandLogo(size: markSize),
        SizedBox(width: large ? 14 : 10),
        Text(ReelStudioPack.brand, style: large ? type.brand : type.watermark),
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
    final bg = marked ? AppColors.gold : AppColors.white;
    final border = marked ? AppColors.goldDeep : AppColors.stroke;
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
                    color: marked ? AppColors.ink : AppColors.textPrimary,
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
