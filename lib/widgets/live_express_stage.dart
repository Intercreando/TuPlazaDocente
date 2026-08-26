import 'package:flutter/material.dart';

import '../data/live_clip_mapper.dart';
import '../data/live_session.dart';
import '../data/live_studio_pack.dart';
import '../data/reel_clip.dart';
import '../theme/app_colors.dart';
import '../theme/live_type.dart';
import 'atmospheric_background.dart';
import 'live_option_grid.dart';
import 'live_stage_chrome.dart';

/// Lienzo 16:9 listo para OBS → YouTube (1920×1080).
///
/// El anfitrión avanza los momentos; el reloj solo corre en la votación.
class LiveExpressStage extends StatelessWidget {
  const LiveExpressStage({
    super.key,
    required this.clip,
    required this.beat,
    this.countdownLeft,
    this.countdownProgress = 0,
    this.highlightedIndex,
    this.nextLabel,
    this.timerPulse = 1,
  });

  final ReelClip clip;
  final LiveBeat beat;
  final int? countdownLeft;
  final double countdownProgress;
  final int? highlightedIndex;
  final String? nextLabel;
  final double timerPulse;

  static const designSize = Size(1920, 1080);
  static const pad = 36.0;
  static const sideWidth = 380.0;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ColoredBox(
        color: AppColors.ink,
        child: Padding(
          padding: const EdgeInsets.all(pad),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.gold, width: 3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: AtmosphericBackground(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 22, 28, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LiveStageChrome(beat: beat),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _mainPane()),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: sideWidth,
                              child: LiveSidePane(
                                beat: beat,
                                countdownLeft: countdownLeft,
                                countdownProgress: countdownProgress,
                                timerPulse: timerPulse,
                                nextLabel: nextLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const LiveLowerThird(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainPane() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: LiveStudioPack.fadeMs),
      child: switch (beat) {
        LiveBeat.standby => const LiveStandbyHero(key: ValueKey('standby')),
        LiveBeat.hook => LiveHookHero(
          key: ValueKey('hook-${clip.id}'),
          clip: clip,
        ),
        LiveBeat.cta => const LiveCtaHero(key: ValueKey('cta')),
        LiveBeat.reveal => LiveCasePane(
          key: ValueKey('reveal-${clip.id}'),
          clip: clip,
          revealed: true,
        ),
        LiveBeat.question || LiveBeat.vote => LiveCasePane(
          key: ValueKey('case-${clip.id}'),
          clip: clip,
          highlightedIndex: highlightedIndex,
        ),
      },
    );
  }
}

class LiveStandbyHero extends StatelessWidget {
  const LiveStandbyHero({super.key});

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return LiveFitBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LiveStudioPack.seriesKicker,
            style: type.kicker,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Text(
            LiveStudioPack.standbyTitle,
            style: type.hook,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            LiveStudioPack.standbyHint,
            style: type.situation,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class LiveHookHero extends StatelessWidget {
  const LiveHookHero({super.key, required this.clip});

  final ReelClip clip;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return LiveFitBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            clip.group.label,
            style: type.kicker,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(clip.hook, style: type.hook, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class LiveCtaHero extends StatelessWidget {
  const LiveCtaHero({super.key});

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return LiveFitBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LiveStudioPack.site,
            style: type.hook,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Text(
            LiveStudioPack.closeAction,
            style: type.cta,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class LiveCasePane extends StatelessWidget {
  const LiveCasePane({
    super.key,
    required this.clip,
    this.revealed = false,
    this.highlightedIndex,
  });

  final ReelClip clip;
  final bool revealed;
  final int? highlightedIndex;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LiveFitBox(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (clip.id.startsWith(liveAltaIdPrefix)) ...[
                Text('ALTA EXIGENCIA', style: type.kicker),
                const SizedBox(height: 8),
              ],
              Text(clip.situation, style: type.situation),
              const SizedBox(height: 10),
              Text(clip.stem, style: type.stem),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: LiveOptionGrid(
            options: clip.options,
            correctIndex: clip.correctIndex,
            highlightedIndex: highlightedIndex,
            revealed: revealed,
          ),
        ),
        if (revealed && clip.revealWhy.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(clip.revealWhy, style: type.cta, textAlign: TextAlign.center),
        ],
      ],
    );
  }
}

/// Encoge el bloque si un caso largo no cabe, sin romper el 16:9.
class LiveFitBox extends StatelessWidget {
  const LiveFitBox({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: SizedBox(width: 1400, child: child),
    );
  }
}
