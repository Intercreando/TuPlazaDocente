import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../models/user_profile.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../widgets/cnsc_score_predictor.dart';
import 'progress_practice_launch.dart';
import 'session_launch.dart';

/// Una frase y un botón: lo que hay que hacer hoy, sin segundo semáforo.
class ProgressTodayAction extends StatelessWidget {
  const ProgressTodayAction({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final plan = _planFor(state.profile);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(plan.message, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 12),
        FilledButton(
          style: AppButtonStyles.filled(
            textStyle: theme.textTheme.labelLarge,
            dark: theme.brightness == Brightness.dark,
          ),
          onPressed: () => plan.run(context),
          child: Text(plan.cta),
        ),
      ],
    );
  }

  static _TodayPlan _planFor(UserProfile profile) {
    if (profile.totalAnswers == 0) {
      return _TodayPlan(
        message:
            'Completa las 5 del día para proyectar tu puntaje con evidencias reales.',
        cta: 'Hacer las 5 del día',
        run: _startDaily,
      );
    }

    final score = CnscScorePredictor.projectedScore(profile);
    final weak = weakestPillarOf(profile);
    final slow = _slowestTimedPillar(profile);

    if (score < 60) {
      return _TodayPlan(
        message:
            'Hoy sube ${weak.label}: es lo que más te aleja del corte 60.',
        cta: 'Practicar ${weak.label}',
        run: (context) => launchProgressPillar(context, weak),
      );
    }

    if (slow != null && slow.tmo > 90) {
      return _TodayPlan(
        message:
            'Ya superas el corte en aciertos. En ${slow.pillar.label} '
            'tardas de más por pregunta: recorta tiempo.',
        cta: 'Entrenar ritmo · ${slow.pillar.label}',
        run: (context) => launchProgressPillar(context, slow.pillar),
      );
    }

    return _TodayPlan(
      message: 'Sigue subiendo el puntaje. Empieza por lo más débil de hoy.',
      cta: 'Practicar lo que más me falta',
      run: launchProgressRecommendation,
    );
  }

  static void _startDaily(BuildContext context) {
    final state = context.read<AppState>();
    final ok = state.startSession(mode: SessionMode.dailyStreak);
    launchSessionOrPaywall(
      context: context,
      state: state,
      started: ok,
      route: '/practice',
    );
  }

  static _SlowPillar? _slowestTimedPillar(UserProfile profile) {
    CompetencyPillar? slowest;
    var maxTmo = 0.0;
    for (final pillar in CompetencyPillar.values) {
      final tmo = profile.pillarTmo(pillar);
      if (tmo == null) continue;
      if (tmo > maxTmo) {
        maxTmo = tmo;
        slowest = pillar;
      }
    }
    if (slowest == null) return null;
    return _SlowPillar(pillar: slowest, tmo: maxTmo);
  }
}

class _TodayPlan {
  const _TodayPlan({
    required this.message,
    required this.cta,
    required this.run,
  });

  final String message;
  final String cta;
  final void Function(BuildContext context) run;
}

class _SlowPillar {
  const _SlowPillar({required this.pillar, required this.tmo});
  final CompetencyPillar pillar;
  final double tmo;
}
