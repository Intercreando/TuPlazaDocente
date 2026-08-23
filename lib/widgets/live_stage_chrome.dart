import 'package:flutter/material.dart';

import '../data/live_session.dart';
import '../data/live_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/live_type.dart';
import 'brand_logo.dart';

/// Cabecera del lienzo: marca, convocatoria y pastilla EN VIVO.
class LiveStageChrome extends StatelessWidget {
  const LiveStageChrome({super.key, required this.beat});

  final LiveBeat beat;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    final live = beat != LiveBeat.standby;
    return Row(
      children: [
        const BrandLogo(size: 44),
        const SizedBox(width: 12),
        Text(LiveStudioPack.brand, style: type.watermark),
        const Spacer(),
        Text(LiveStudioPack.seriesKicker, style: type.kicker),
        const SizedBox(width: 14),
        LiveStagePill(
          text: live ? LiveStudioPack.liveBadge : LiveStudioPack.soonBadge,
          live: live,
        ),
      ],
    );
  }
}

class LiveStagePill extends StatelessWidget {
  const LiveStagePill({super.key, required this.text, required this.live});

  final String text;
  final bool live;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: live ? AppColors.coral : AppColors.gold,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(text, style: type.badge),
      ),
    );
  }
}

/// Pie persistente: la web se ve durante todo el directo, no solo al cierre.
class LiveLowerThird extends StatelessWidget {
  const LiveLowerThird({super.key});

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Row(
              children: [
                Text(LiveStudioPack.site, style: type.lowerThird),
                const Spacer(),
                Text(LiveStudioPack.closeAction, style: type.brand),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          LiveStudioPack.disclaimer,
          style: type.fineprint,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Columna derecha: hueco para la cámara de OBS y reloj o consigna del chat.
class LiveSidePane extends StatelessWidget {
  const LiveSidePane({
    super.key,
    required this.beat,
    required this.countdownLeft,
    required this.countdownProgress,
    required this.timerPulse,
    required this.nextLabel,
  });

  final LiveBeat beat;
  final int? countdownLeft;
  final double countdownProgress;
  final double timerPulse;
  final String? nextLabel;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    final voting = beat == LiveBeat.vote;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.gold, width: 2),
            ),
            child: Center(
              child: Text(
                LiveStudioPack.camLabel,
                style: type.fineprint.copyWith(
                  color: AppColors.white.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          flex: 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.stroke, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: voting
                  ? _VoteClock(
                      left: countdownLeft ?? 0,
                      progress: countdownProgress,
                      pulse: timerPulse,
                    )
                  : _SideCopy(beat: beat, nextLabel: nextLabel),
            ),
          ),
        ),
      ],
    );
  }
}

class _VoteClock extends StatelessWidget {
  const _VoteClock({
    required this.left,
    required this.progress,
    required this.pulse,
  });

  final int left;
  final double progress;
  final double pulse;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    return Column(
      children: [
        Text(
          LiveStudioPack.voteTitle,
          style: type.kicker,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Transform.scale(
          scale: pulse,
          child: Text('$left', style: type.timer, textAlign: TextAlign.center),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: SizedBox(
            height: 8,
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: AppColors.mist,
              color: AppColors.gold,
            ),
          ),
        ),
        const Spacer(),
        Text(
          LiveStudioPack.chatCue,
          style: type.brand,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SideCopy extends StatelessWidget {
  const _SideCopy({required this.beat, required this.nextLabel});

  final LiveBeat beat;
  final String? nextLabel;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    final title = switch (beat) {
      LiveBeat.standby => LiveStudioPack.soonBadge,
      LiveBeat.hook => LiveStudioPack.chatCue,
      LiveBeat.question => LiveStudioPack.chatCue,
      LiveBeat.vote => LiveStudioPack.voteTitle,
      LiveBeat.reveal => LiveStudioPack.holdForChat,
      LiveBeat.cta => LiveStudioPack.closeAction,
    };
    final next = nextLabel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: type.brand, textAlign: TextAlign.center),
        const Spacer(),
        if (next != null && next.isNotEmpty) ...[
          Text(
            LiveStudioPack.nextPrefix,
            style: type.kicker,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(next, style: type.fineprint, textAlign: TextAlign.center),
        ],
      ],
    );
  }
}
