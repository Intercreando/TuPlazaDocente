import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/session_launch.dart';

/// Bloque único del home: qué hacer ahora (racha o plan).
class HomeTodayCoach extends StatelessWidget {
  const HomeTodayCoach({super.key, this.desktop = false});

  final bool desktop;

  void _continueToday(BuildContext context, AppState state) {
    final done = state.profile.dailyCompletedToday;
    if (done) {
      context.go('/app/plan');
      return;
    }
    final ok = state.startSession(mode: SessionMode.dailyStreak);
    launchSessionOrPaywall(
      context: context,
      state: state,
      started: ok,
      route: '/practice',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final profile = state.profile;
    final done = profile.dailyCompletedToday;
    final streak = profile.streakDays;

    final kicker = Text(
      'Hoy',
      style: theme.textTheme.labelLarge?.copyWith(color: AppColors.gold),
    );
    final title = Text(
      done
          ? 'Ya hiciste las 5 preguntas del día'
          : 'Te tocan 5 preguntas del día',
      style: theme.textTheme.headlineSmall?.copyWith(color: AppColors.white),
    );
    final body = Text(
      done
          ? (streak <= 0
                ? 'Sigue con el plan cuando quieras.'
                : 'Llevas $streak ${streak == 1 ? 'día' : 'días'} seguidos. '
                      'Abre el plan para el siguiente bloque.')
          : 'Sin reloj. Al responder ves la explicación. Unos 10 minutos.',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: AppColors.white.withValues(alpha: 0.88),
      ),
    );
    final cta = FilledButton.icon(
      style: AppButtonStyles.filledOnBrand(completed: done),
      onPressed: () => _continueToday(context, state),
      icon: Icon(done ? Icons.route_outlined : Icons.play_arrow_rounded),
      label: Text(done ? 'Ver el plan de hoy' : 'Continuar hoy'),
    );

    final inner = desktop
        ? Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kicker,
                    const SizedBox(height: 6),
                    title,
                    const SizedBox(height: 6),
                    body,
                  ],
                ),
              ),
              const SizedBox(width: 28),
              cta,
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kicker,
              const SizedBox(height: 6),
              title,
              const SizedBox(height: 6),
              body,
              const SizedBox(height: 16),
              cta,
            ],
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.ink, AppColors.canopy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(desktop ? 28 : 20),
        child: inner,
      ),
    );
  }
}
