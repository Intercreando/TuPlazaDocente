import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/reel_type.dart';
import 'atmospheric_background.dart';
import 'brand_logo.dart';
import 'reel_close_cta.dart';

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

  /// TikTok: caption y “Buscar contenido relacionado” (texto blanco).
  /// El margen queda en tinta oscura para que ese blanco sí contraste.
  static const safeTop = 280.0;
  static const safeBottom = 300.0;
  static const safeRight = 132.0;
  static const safeLeft = 48.0;

  /// Ancho real de trabajo dentro de la tarjeta (márgenes TikTok + padding).
  static const _innerPad = 28.0;
  static const contentWidth =
      1080.0 - safeLeft - safeRight - (_innerPad * 2);

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
                      duration: const Duration(milliseconds: 400),
                      child: switch (beat) {
                        ReelBeat.hook => _ReelHookHero(
                          key: ValueKey('hook-${clip.id}-$revealMode'),
                          clip: clip,
                          revealMode: revealMode,
                        ),
                        _ => Column(
                          key: ValueKey(showClose ? 'close' : 'case'),
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _ReelWatermark(),
                            const SizedBox(height: 18),
                            Expanded(
                              child: showClose
                                  ? _close(context)
                                  : _caseBlock(context),
                            ),
                            if (showTimer) _timer(context),
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

  /// Caso + enunciado + opciones. El `FittedBox` evita desbordes si un clip
  /// futuro trae textos más largos: reduce en bloque en vez de romper el layout.
  Widget _caseBlock(BuildContext context) {
    final type = ReelType.of(context);
    return _ScaleDownBox(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(clip.situation, style: type.situation),
          const SizedBox(height: 16),
          Text(clip.stem, style: type.stem),
          const SizedBox(height: 22),
          for (var i = 0; i < clip.options.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _OptionRow(
              letter: i < letters.length ? letters[i] : '${i + 1}',
              text: clip.options[i],
            ),
          ],
        ],
      ),
    );
  }

  /// Cierre: en el piloto se pide la letra; en el capítulo 2 se revela.
  Widget _close(BuildContext context) {
    if (!revealMode) {
      return const _ScaleDownBox(
        alignment: Alignment.center,
        child: ReelCommentCta(),
      );
    }
    return _ScaleDownBox(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < clip.options.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _OptionRow(
              letter: i < letters.length ? letters[i] : '${i + 1}',
              text: clip.options[i],
              marked: i == clip.correctIndex,
              dimmed: i != clip.correctIndex,
            ),
          ],
          const SizedBox(height: 28),
          ReelRevealClose(
            correctLetter: clip.correctLetter,
            why: clip.revealWhy,
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
        const SizedBox(height: 28),
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
    );
  }
}

/// Reduce el bloque completo si no cabe, manteniendo la proporción del diseño.
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

/// Aviso legal fijo del lienzo.
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

/// Primera pantalla: la trampa del caso. En el capítulo 2 avisa que hoy
/// se revela, sin adelantar la letra.
class _ReelHookHero extends StatelessWidget {
  const _ReelHookHero({
    super.key,
    required this.clip,
    required this.revealMode,
  });

  final ReelClip clip;
  final bool revealMode;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return SizedBox.expand(
      child: Center(
        child: _ScaleDownBox(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _ReelWatermark(large: true),
              const SizedBox(height: 28),
              Text(
                revealMode
                    ? ReelStudioPack.revealKicker
                    : ReelStudioPack.seriesKicker,
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
                revealMode
                    ? ReelStudioPack.revealPromise
                    : ReelStudioPack.closeAsk,
                style: type.cta,
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
    );
  }
}

/// Firma de marca: grande en la portada y mínima durante el caso, para que el
/// contenido respire sin regalar el vídeo a quien lo reposte.
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

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.letter,
    required this.text,
    this.marked = false,
    this.dimmed = false,
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 18, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: marked ? AppColors.ink : AppColors.gold,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    letter,
                    style: type.letter.copyWith(
                      color: marked ? AppColors.white : AppColors.ink,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
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
