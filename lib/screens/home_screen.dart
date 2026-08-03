import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../config/concurso_config.dart';
import '../models/enums.dart';
import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/session_launch.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';
import '../widgets/feature_access_badge.dart';
import '../widgets/freemium_scope_banner.dart';
import '../widgets/tag_mastery_map.dart';
import '../widgets/training_mode_card.dart';

/// Home: hub de entrenamiento (dashboard en escritorio, lista en móvil).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final profile = state.profile;
    final isDark = theme.brightness == Brightness.dark;
    final desktop = LayoutBreakpoints.isDesktop(context);
    final name = profile.displayName.isEmpty ? 'Aspirante' : profile.displayName;

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
                      IconButton(
                        tooltip: state.isAnonymousUser
                            ? 'Guardar cuenta'
                            : 'Cuenta',
                        onPressed: () => context.push('/auth'),
                        icon: Icon(
                          state.isAnonymousUser
                              ? Icons.person_add_alt_1_outlined
                              : Icons.person_outline,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Modo oscuro',
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
                  _DesktopHome(
                    name: name,
                    state: state,
                    isDark: isDark,
                  )
                else
                  _MobileHome(
                    name: name,
                    state: state,
                    isDark: isDark,
                  ),
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
    required this.isDark,
  });

  final String name;
  final AppState state;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _GreetingBlock(name: name, state: state),
        const SizedBox(height: 18),
        _StreakCard(
          streak: profile.streakDays,
          doneToday: profile.dailyCompletedToday,
          onStart: () {
            final ok = state.startSession(mode: SessionMode.dailyStreak);
            launchSessionOrPaywall(
              context: context,
              state: state,
              started: ok,
              route: '/practice',
            );
          },
        ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.05, end: 0),
        const SizedBox(height: 14),
        _MasteryPanel(state: state, isDark: isDark),
        if (state.syncStatus != null) ...[
          const SizedBox(height: 10),
          Text(state.syncStatus!, style: theme.textTheme.bodySmall),
        ],
        Text(
          'Cerebro pedagógico activo · norma + teoría + distractores'
          '${state.questionSource.isNotEmpty ? ' · ${state.questionSource}' : ''}',
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(height: 12),
        _ReminderTile(state: state),
        const SizedBox(height: 22),
        Text('Entrenar ahora', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        if (!profile.isPremium) ...[
          const FreemiumScopeBanner(),
          const SizedBox(height: 12),
        ],
        _ModesGrid(state: state),
        if (!profile.isPremium) ...[
          const SizedBox(height: 18),
          _PremiumTile(),
        ],
      ],
    );
  }
}

class _DesktopHome extends StatelessWidget {
  const _DesktopHome({
    required this.name,
    required this.state,
    required this.isDark,
  });

  final String name;
  final AppState state;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _GreetingBlock(name: name, state: state, desktop: true),
        const SizedBox(height: 28),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _StreakCard(
                      streak: profile.streakDays,
                      doneToday: profile.dailyCompletedToday,
                      desktop: true,
                      onStart: () {
                        final ok =
                            state.startSession(mode: SessionMode.dailyStreak);
                        launchSessionOrPaywall(
                          context: context,
                          state: state,
                          started: ok,
                          route: '/practice',
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _MasteryPanel(state: state, isDark: isDark),
                    const SizedBox(height: 12),
                    _ReminderTile(state: state),
                    if (state.syncStatus != null) ...[
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.syncStatus!,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Entrenar ahora', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 6),
                    Text(
                      profile.isPremium
                          ? 'Elige el modo según tu energía de hoy.'
                          : 'Los modos con candado o chip Premium se desbloquean al pagar.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (!profile.isPremium) ...[
                      const SizedBox(height: 12),
                      const FreemiumScopeBanner(),
                    ],
                    const SizedBox(height: 16),
                    _ModesGrid(state: state, columns: 2),
                    if (!profile.isPremium) ...[
                      const SizedBox(height: 18),
                      _PremiumTile(),
                    ],
                  ],
                ),
              ),
            ],
          ),
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
              ? 'Tu entrenador táctico del magisterio'
              : '${profile.cargo?.label ?? ''} · ${profile.especialidad!.label}',
          style: theme.textTheme.bodyLarge,
        ),
        if (!desktop &&
            !state.isAnonymousUser &&
            state.authEmail != null) ...[
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

class _MasteryPanel extends StatelessWidget {
  const _MasteryPanel({required this.state, required this.isDark});

  final AppState state;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;
    final masteryRows = TagMasteryService.buildMap(profile);
    final recommended = TagMasteryService.recommendedToday(profile);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mapa de Maestría', style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            'No contamos ítems: medimos dominio por norma y teoría. '
            'Tu currículo de competencias se construye con cada respuesta.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          TagMasteryMap(
            rows: masteryRows,
            compact: true,
            maxItems: 4,
            recommendedCode: recommended?.code.name,
          ),
          const SizedBox(height: 8),
          Text(state.studyFocusMessage(), style: theme.textTheme.labelLarge),
          const SizedBox(height: 12),
          Text(
            'Plan de hoy: ${state.todayPlan.completedCount}/'
            '${state.todayPlan.tasks.length} bloques · '
            '${state.todayPlan.intensityLabel}',
            style: theme.textTheme.labelMedium,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(
                onPressed: () => context.go('/app/radar'),
                child: const Text('Ver mapa de dominio'),
              ),
              OutlinedButton(
                onPressed: () => context.go('/app/plan'),
                child: const Text('Abrir plan diario'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Recordatorio de racha',
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        profile.streakRemindersEnabled
            ? 'Te avisaremos si aún no completas las 5 preguntas del día'
            : 'Activa notificaciones del navegador para no romper la racha',
        style: theme.textTheme.bodySmall,
      ),
      value: profile.streakRemindersEnabled,
      activeThumbColor: AppColors.gold,
      onChanged: (value) async {
        if (value) {
          final ok = await state.enableStreakReminders();
          if (!context.mounted) return;
          if (!ok) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.lastError ?? 'No se pudo activar el recordatorio.',
                ),
              ),
            );
          }
        } else {
          await state.disableStreakReminders();
        }
      },
    );
  }
}

class _ModesGrid extends StatelessWidget {
  const _ModesGrid({required this.state, this.columns});

  final AppState state;
  final int? columns;

  @override
  Widget build(BuildContext context) {
    final profile = state.profile;
    final premium = profile.isPremium;

    FeatureAccessLevel practiceAccess() {
      if (premium) return FeatureAccessLevel.open;
      return state.canStartFreePractice
          ? FeatureAccessLevel.limited
          : FeatureAccessLevel.locked;
    }

    FeatureAccessLevel examAccess() {
      if (premium) return FeatureAccessLevel.open;
      return state.canStartShortExam
          ? FeatureAccessLevel.limited
          : FeatureAccessLevel.locked;
    }

    final cards = [
      TrainingModeCard(
        title: 'Modo Práctica',
        subtitle: premium
            ? 'Sin reloj. Explicación inmediata.'
            : state.canStartFreePractice
                ? 'Hoy te queda 1 sesión gratis'
                : 'Cupo de hoy agotado · desbloquea con Premium',
        icon: Icons.menu_book_rounded,
        color: AppColors.canopy,
        access: practiceAccess(),
        limitedLabel: '1 / día',
        onTap: () {
          final ok = state.startSession(mode: SessionMode.practice, count: 8);
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/practice',
          );
        },
      ),
      TrainingModeCard(
        title: 'Examen Real',
        subtitle: state.canStartShortExam
            ? (premium
                ? 'Tiempo por ítem + mapa de calor.'
                : '1 simulacro gratis este mes')
            : 'Cupo mensual usado · desbloquea con Premium',
        icon: Icons.timer_outlined,
        color: AppColors.coral,
        access: examAccess(),
        limitedLabel: '1 / mes',
        onTap: () {
          final ok = state.startSession(mode: SessionMode.exam, count: 8);
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/exam',
          );
        },
      ),
      TrainingModeCard(
        title: 'Alta exigencia',
        subtitle: premium
            ? 'Casos nivel 3 · simulacro intensivo'
            : state.canStartShortExam
                ? 'Nivel 3 · consume tu 1 simulacro/mes'
                : 'Cupo de simulacro usado · Premium',
        icon: Icons.whatshot_outlined,
        color: AppColors.danger,
        access: examAccess(),
        limitedLabel: '1 / mes',
        onTap: () {
          final ok = state.startSession(
            mode: SessionMode.exam,
            count: 6,
            minDifficultyLevel: 3,
          );
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/exam',
          );
        },
      ),
      TrainingModeCard(
        title: 'Casos de Aula',
        subtitle: state.canAccessCases
            ? 'Situaciones con debido proceso.'
            : 'Bloqueado en Gratis · incluido en Premium',
        icon: Icons.groups_2_outlined,
        color: AppColors.skyLine,
        access: state.canAccessCases
            ? FeatureAccessLevel.open
            : FeatureAccessLevel.locked,
        onTap: () {
          if (!state.canAccessCases) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Casos de Aula es Premium. En Gratis: reto diario + 1 práctica al día.',
                ),
                action: SnackBarAction(
                  label: 'Premium',
                  onPressed: () => context.push('/premium'),
                ),
              ),
            );
            return;
          }
          context.push('/cases');
        },
      ),
      TrainingModeCard(
        title: 'Reto rápido',
        subtitle: 'Nivel 1 · ~45s por pregunta · siempre gratis',
        icon: Icons.bolt_outlined,
        color: AppColors.goldDeep,
        access: FeatureAccessLevel.open,
        onTap: () {
          final ok = state.startSession(mode: SessionMode.speedBattle);
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/speed',
          );
        },
      ),
      TrainingModeCard(
        title: 'Mi especialidad',
        subtitle: state.canAccessSpecialty
            ? (profile.especialidad == null
                ? 'Práctica del módulo de área'
                : 'Enfocado en ${profile.especialidad!.label}')
            : 'Bloqueado en Gratis · incluido en Premium',
        icon: Icons.school_outlined,
        color: AppColors.inkSoft,
        access: state.canAccessSpecialty
            ? FeatureAccessLevel.open
            : FeatureAccessLevel.locked,
        onTap: () {
          if (!state.canAccessSpecialty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'La práctica por especialidad es Premium.',
                ),
                action: SnackBarAction(
                  label: 'Premium',
                  onPressed: () => context.push('/premium'),
                ),
              ),
            );
            return;
          }
          if (profile.especialidad == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Primero elige tu especialidad en el perfil.'),
              ),
            );
            return;
          }
          final ok = state.startSession(
            mode: SessionMode.practice,
            specialty: profile.especialidad,
            count: 8,
          );
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/practice',
          );
        },
      ),
      TrainingModeCard(
        title: 'Plan diario',
        subtitle: premium
            ? 'Ruta hasta tu fecha de examen.'
            : 'Ruta gratis · algunas tareas piden Premium',
        icon: Icons.route_outlined,
        color: AppColors.canopy,
        access: premium
            ? FeatureAccessLevel.open
            : FeatureAccessLevel.limited,
        limitedLabel: 'Mixto',
        onTap: () => context.go('/app/plan'),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = columns ?? (constraints.maxWidth > 620 ? 2 : 1);
        if (cols == 1) {
          return Column(
            children: [
              for (final card in cards) ...[
                card,
                const SizedBox(height: 10),
              ],
            ],
          );
        }

        final gap = 12.0;
        final width = (constraints.maxWidth - gap) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: cards
              .map((c) => SizedBox(width: width, child: c))
              .toList(),
        );
      },
    );
  }
}

class _PremiumTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outline),
      ),
      tileColor: AppColors.gold.withValues(alpha: 0.12),
      leading: const Icon(
        Icons.workspace_premium_outlined,
        color: AppColors.goldDeep,
      ),
      title: Text('Desbloquear Premium', style: theme.textTheme.titleSmall),
      subtitle: Text(
        '${AppConfig.premiumPriceLabel} · ${AppConfig.premiumBillingLabel}. '
        'Práctica y simulacros sin tope, casos y especialidad.',
        style: theme.textTheme.bodySmall,
      ),
      onTap: () => context.push('/premium'),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({
    required this.streak,
    required this.doneToday,
    required this.onStart,
    this.desktop = false,
  });

  final int streak;
  final bool doneToday;
  final VoidCallback onStart;
  final bool desktop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(desktop ? 24 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.ink, AppColors.canopy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Racha diaria',
            style: theme.textTheme.labelLarge?.copyWith(color: AppColors.gold),
          ),
          const SizedBox(height: 6),
          Text(
            streak <= 0 ? 'Empieza hoy tu racha' : '$streak días seguidos',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            doneToday
                ? 'Ya completaste las 5 preguntas de hoy. ¡Mantén el ritmo mañana!'
                : '5 preguntas · 10 minutos · Feedback pedagógico',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            style: AppButtonStyles.filledOnBrand(completed: doneToday),
            onPressed: doneToday ? null : onStart,
            icon: Icon(
              doneToday ? Icons.check_circle_rounded : Icons.bolt_rounded,
            ),
            label: Text(
              doneToday ? 'Reto completado' : 'Iniciar reto de hoy',
            ),
          ),
        ],
      ),
    );
  }
}
