import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/reel_type.dart';
import 'atmospheric_background.dart';
import 'brand_logo.dart';
import 'reel_close_cta.dart';
import 'reel_option_row.dart';

enum ReelBeat { ready, hook, question, countdown, close }

/// Lienzo 9:16 listo para captura de ventana (1080×1920).
///
/// Ciclo de 15 s: gancho → caso → cuenta atrás → invitación al comentario.
class ReelExpressStage extends StatelessWidget {
  const ReelExpressStage({
    super.key,
    required this.clip,
    required this.beat,
    required this.countdownLeft,
    this.countdownProgress = 0,
    this.timerPulse = 1,
    this.visibleOptionCount = 4,
    this.cuePulse = 1,
  });

  final ReelClip clip;
  final ReelBeat beat;
  final int countdownLeft;
  final double countdownProgress;
  final double timerPulse;
  final int visibleOptionCount;
  final double cuePulse;

  static const designSize = Size(1080, 1920);
  static const letters = ['A', 'B', 'C', 'D'];

  static const cycleMs = 15000;
  static const hookMs = 2000;
  static const questionMs = 6000;
  static const countdownMs = 3000;
  static const closeMs = 4000;
  static const fadeMs = 80;
  static const optionDelayMs = 1400;
  static const optionGapMs = 1100;

  /// TikTok: caption y “Buscar contenido relacionado” (texto blanco).
  static const safeTop = 280.0;
  static const safeBottom = 300.0;
  static const safeRight = 132.0;
  static const safeLeft = 48.0;
  static const _innerPad = 28.0;
  static const contentWidth =
      1080.0 - safeLeft - safeRight - (_innerPad * 2);

  /// Cuántas opciones se ven según el tiempo del ciclo.
  static int optionCountAt({
    required ReelBeat beat,
    required int elapsedMs,
  }) {
    switch (beat) {
      case ReelBeat.hook:
      case ReelBeat.ready:
        return 0;
      case ReelBeat.countdown:
      case ReelBeat.close:
        return 4;
      case ReelBeat.question:
        final into = elapsedMs - hookMs;
        if (into < optionDelayMs) return 0;
        return ((into - optionDelayMs) ~/ optionGapMs + 1).clamp(0, 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final showTimer = beat == ReelBeat.countdown;
    final showClose = beat == ReelBeat.close;

    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.ink),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              safeLeft,
              safeTop,
              safeRight,
              safeBottom,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.gold, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: AtmosphericBackground(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: switch (beat) {
                        ReelBeat.hook => _ReelHookHero(
                          key: ValueKey('hook-${clip.id}'),
                          clip: clip,
                        ),
                        _ => Column(
                          key: ValueKey(showClose ? 'close' : 'case'),
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _ReelWatermark(),
                            const SizedBox(height: 18),
                            Expanded(
                              child: showClose
                                  ? const Center(child: ReelCommentClose())
                                  : showTimer
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _caseBlock(context),
                                        _timer(context),
                                        const Spacer(),
                                      ],
                                    )
                                  : _caseBlock(context),
                            ),
                            if (showClose) ...[
                              const SizedBox(height: 20),
                              const ReelCloseBrandBar(),
                            ],
                            const SizedBox(height: 14),
                            const _Disclaimer(),
                          ],
                        ),
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _caseBlock(BuildContext context) {
    final type = ReelType.of(context);
    final counting = beat == ReelBeat.countdown;
    final shown = visibleOptionCount.clamp(0, clip.options.length);
    return _ScaleDownBox(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!counting) ...[
            Text(clip.situation, style: type.situation),
            const SizedBox(height: 16),
            Text(clip.stem, style: type.stem),
            const SizedBox(height: 22),
          ],
          for (var i = 0; i < shown; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            ReelOptionRow(
              letter: i < letters.length ? letters[i] : '${i + 1}',
              text: clip.options[i],
            ),
          ],
          const SizedBox(height: 22),
          _ReelCue(
            text: counting
                ? ReelStudioPack.commentNow
                : ReelStudioPack.holdCue,
            pulse: counting ? 1 : cuePulse,
            icon: counting
                ? Icons.keyboard_double_arrow_down_rounded
                : Icons.touch_app_rounded,
          ),
        ],
      ),
    );
  }

  Widget _timer(BuildContext context) {
    final type = ReelType.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 44),
        Transform.scale(
          scale: timerPulse,
          child: Text(
            '$countdownLeft',
            style: type.timer,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: SizedBox(
            height: 10,
            child: LinearProgressIndicator(
              value: countdownProgress.clamp(0.0, 1.0),
              backgroundColor: AppColors.mist,
              color: AppColors.gold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReelCue extends StatelessWidget {
  const _ReelCue({
    required this.text,
    required this.pulse,
    required this.icon,
  });

  final String text;
  final double pulse;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    final size = type.kicker.fontSize ?? 30;
    return Opacity(
      opacity: pulse.clamp(0.42, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.goldDeep, size: size),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: type.kicker,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleDownBox extends StatelessWidget {
  const _ScaleDownBox({required this.child, required this.alignment});

  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: SizedBox(width: ReelExpressStage.contentWidth, child: child),
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return Text(
      ReelStudioPack.disclaimer,
      style: type.fineprint,
      textAlign: TextAlign.center,
    );
  }
}

/// Gancho a golpe: la trampa del caso, sin pedir aún la letra.
class _ReelHookHero extends StatelessWidget {
  const _ReelHookHero({super.key, required this.clip});

  final ReelClip clip;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return SizedBox.expand(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.86, end: 1),
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return Opacity(
            opacity: ((scale - 0.86) / 0.14).clamp(0.0, 1.0),
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: Center(
          child: _ScaleDownBox(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _ReelWatermark(large: true),
                const SizedBox(height: 28),
                Text(
                  ReelStudioPack.seriesKicker,
                  style: type.kicker,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  clip.hook,
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
        ),
      ),
    );
  }
}

class _ReelWatermark extends StatelessWidget {
  const _ReelWatermark({this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return Row(
      mainAxisAlignment: large
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        BrandLogo(size: large ? 80 : 44),
        SizedBox(width: large ? 16 : 12),
        Text(ReelStudioPack.brand, style: type.watermark),
      ],
    );
  }
}
