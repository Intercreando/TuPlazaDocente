import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../services/session_feedback_service.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/progress_practice_launch.dart';

/// Cierre emocional de la sesión: celebración suave o refuerzo con siguiente paso.
class SessionFeedbackCard extends StatelessWidget {
  const SessionFeedbackCard({
    super.key,
    required this.feedback,
    this.followDiagnosticPaywall = false,
  });

  final SessionFeedback feedback;
  final bool followDiagnosticPaywall;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final celebrate = feedback.celebrate;
    final dark = theme.brightness == Brightness.dark;
    final canLaunchFocus =
        feedback.focus != null &&
        canLaunchSessionFeedbackFocus(state, feedback.focus!);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: celebrate
              ? AppColors.gold.withValues(alpha: dark ? 0.22 : 0.14)
              : (dark ? AppColors.darkElevated : AppColors.mist),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  celebrate ? 'Bien hecho' : 'Siguiente paso',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: celebrate
                        ? AppColors.goldDeep
                        : (dark ? AppColors.seafoam : AppColors.canopy),
                  ),
                ),
                const SizedBox(height: 6),
                Text(feedback.headline, style: theme.textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(feedback.body, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 14),
                if (followDiagnosticPaywall)
                  FilledButton(
                    style: AppButtonStyles.filled(
                      textStyle: theme.textTheme.labelLarge,
                      dark: theme.brightness == Brightness.dark,
                    ),
                    onPressed: () => launchHomeAfterSession(context),
                    child: const Text('Continuar'),
                  )
                else if (celebrate)
                  FilledButton(
                    style: AppButtonStyles.filled(
                      textStyle: theme.textTheme.labelLarge,
                      dark: theme.brightness == Brightness.dark,
                    ),
                    onPressed: () => launchHomeAfterSession(context),
                    child: const Text('Seguir practicando'),
                  )
                else if (feedback.focus != null && canLaunchFocus)
                  FilledButton.icon(
                    style: AppButtonStyles.filled(
                      textStyle: theme.textTheme.labelLarge,
                      dark: theme.brightness == Brightness.dark,
                    ),
                    onPressed: () =>
                        launchSessionFeedbackFocus(context, feedback.focus!),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Practicar este tema'),
                  )
                else if (feedback.focus != null)
                  FilledButton(
                    style: AppButtonStyles.filled(
                      textStyle: theme.textTheme.labelLarge,
                      dark: theme.brightness == Brightness.dark,
                    ),
                    onPressed: () => launchHomeAfterSession(context),
                    child: const Text('Seguir en el inicio'),
                  ),
              ],
            ),
          ),
        ),
        if (celebrate)
          const Positioned(top: 10, right: 14, child: _GoldSparkle()),
      ],
    );
  }
}

/// Destello corto en oro; no tapa botones ni pide atención extra.
class _GoldSparkle extends StatelessWidget {
  const _GoldSparkle();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Icon(Icons.auto_awesome, color: AppColors.gold)
          .animate()
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.6, 0.6), end: const Offset(1, 1))
          .then(delay: 1400.ms)
          .fadeOut(duration: 500.ms),
    );
  }
}
