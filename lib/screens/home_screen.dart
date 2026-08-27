import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/concurso_config.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../widgets/account_entry_button.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';
import '../widgets/home_premium_invite.dart';
import '../widgets/home_progress_panel.dart';
import '../widgets/home_today_coach.dart';
import '../widgets/home_training_modes.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/welcome_offer_banner.dart';

/// Home: un Continuar hoy + entrenamientos (Tutor Inteligente primero).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final profile = state.profile;
    final isDark = theme.brightness == Brightness.dark;
    final desktop = LayoutBreakpoints.isDesktop(context);
    final name = profile.displayName.isEmpty
        ? 'Aspirante'
        : profile.displayName;

    return AtmosphericBackground(
      dark: isDark,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: ListView(
              padding: LayoutBreakpoints.pagePadding(context),
              children: [
                if (!desktop) ...[
                  Row(
                    children: [
                      const Expanded(child: BrandMark(compact: true)),
                      const AccountEntryButton(compact: true),
                      IconButton(
                        tooltip: 'Modo oscuro',
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        onPressed: () => state.toggleDarkMode(),
                        icon: Icon(
                          isDark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
                if (desktop)
                  _DesktopHome(name: name, state: state)
                else
                  _MobileHome(name: name, state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileHome extends StatelessWidget {
  const _MobileHome({
    required this.name,
    required this.state,
  });

  final String name;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _GreetingBlock(name: name, state: state),
        const SizedBox(height: 12),
        const WelcomeOfferBanner(),
        const SizedBox(height: 18),
        const HomeTodayCoach()
            .animate()
            .fadeIn(duration: 450.ms)
            .slideY(begin: 0.05, end: 0),
        if (state.syncStatus != null) ...[
          const SizedBox(height: 10),
          Text(state.syncStatus!, style: theme.textTheme.bodySmall),
        ],
        const SizedBox(height: 18),
        Text('Más entrenamientos', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        const HomeTrainingModes(),
        if (!profile.isPremium) ...[
          const SizedBox(height: 18),
          const HomePremiumInvite(),
        ],
        const SizedBox(height: 12),
        HomeReminderTile(state: state),
        const SizedBox(height: 28),
        const TestimonialsSection(
          limit: 3,
          showCompose: true,
          compact: true,
          showSubtitle: false,
        ),
      ],
    );
  }
}

class _DesktopHome extends StatelessWidget {
  const _DesktopHome({
    required this.name,
    required this.state,
  });

  final String name;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _GreetingBlock(name: name, state: state, desktop: true),
        const SizedBox(height: 12),
        const WelcomeOfferBanner(),
        const SizedBox(height: 20),
        const HomeTodayCoach(desktop: true),
        if (state.syncStatus != null) ...[
          const SizedBox(height: 10),
          Text(state.syncStatus!, style: theme.textTheme.bodySmall),
        ],
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Más entrenamientos',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                profile.isPremium
                    ? 'Cuando quieras otro tipo de práctica.'
                    : 'Los candados se abren con Premium.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const HomeTrainingModes(columns: 3),
        if (!profile.isPremium) ...[
          const SizedBox(height: 20),
          const HomePremiumInvite(),
        ],
        const SizedBox(height: 16),
        HomeReminderTile(state: state),
        const SizedBox(height: 28),
        const TestimonialsSection(
          limit: 3,
          showCompose: true,
          compact: true,
          showSubtitle: false,
        ),
      ],
    );
  }
}

class _GreetingBlock extends StatelessWidget {
  const _GreetingBlock({
    required this.name,
    required this.state,
    this.desktop = false,
  });

  final String name;
  final AppState state;
  final bool desktop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ConcursoConfig.badgeLabel,
          style: theme.textTheme.labelLarge?.copyWith(
            color: AppColors.canopy,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hola, $name',
          style: desktop
              ? theme.textTheme.headlineLarge
              : theme.textTheme.headlineMedium,
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 6),
        Text(
          profile.especialidad == null
              ? 'Entrenas para el Concurso Docente'
              : '${profile.cargo?.label ?? ''} · ${profile.especialidad!.label}',
          style: theme.textTheme.bodyLarge,
        ),
        if (!desktop && !state.isAnonymousUser && state.authEmail != null) ...[
          const SizedBox(height: 4),
          Text(state.authEmail!, style: theme.textTheme.bodySmall),
        ],
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () => context.push('/onboarding?edit=1'),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Cambiar cargo o especialidad'),
          ),
        ),
      ],
    );
  }
}
