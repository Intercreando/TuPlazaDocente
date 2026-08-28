import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/app_snackbars.dart';

/// Tutor personalizado fuera de «Más entrenamientos»: bloque propio, más visible.
class HomeTutorSpotlight extends StatelessWidget {
  const HomeTutorSpotlight({super.key, this.desktop = false});

  final bool desktop;

  void _open(BuildContext context, AppState state) {
    if (!state.profile.isPremium) {
      AppSnackbars.premiumLocked(context, 'El Tutor personalizado es Premium.');
      return;
    }
    context.push('/tutor');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final premium = state.profile.isPremium;
    final dark = theme.brightness == Brightness.dark;
    final goldFill = AppColors.gold.withValues(alpha: dark ? 0.16 : 0.14);

    final kicker = Text(
      'Guía paso a paso',
      style: theme.textTheme.labelLarge?.copyWith(color: AppColors.goldDeep),
    );
    final title = Text(
      'Tutor personalizado',
      style: desktop
          ? theme.textTheme.headlineSmall
          : theme.textTheme.titleLarge,
    );
    final body = Text(
      'Identifica tus áreas de mejora resolviendo un caso práctico. '
      'Recibe retroalimentación estructurada y pistas pedagógicas '
      'para que aprendas a deducir la respuesta correcta sin perder el enfoque.',
      style: theme.textTheme.bodyMedium,
    );
    final cta = FilledButton.icon(
      style: AppButtonStyles.filled(
        textStyle: theme.textTheme.labelLarge,
        dark: dark,
      ),
      onPressed: () => _open(context, state),
      icon: Icon(premium ? Icons.school_rounded : Icons.arrow_forward_rounded),
      label: Text(premium ? 'Empezar tutoría' : 'Ver en Premium'),
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kicker,
        const SizedBox(height: 6),
        title,
        const SizedBox(height: 6),
        body,
        if (!desktop) ...[const SizedBox(height: 14), cta],
      ],
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _open(context, state),
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            color: goldFill,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.gold, width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              desktop ? 22 : 18,
              desktop ? 20 : 16,
              desktop ? 22 : 18,
              desktop ? 20 : 16,
            ),
            child: desktop
                ? Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: AppColors.goldDeep,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(child: copy),
                      const SizedBox(width: 16),
                      cta,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: AppColors.goldDeep,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: copy),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
