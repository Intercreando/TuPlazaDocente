import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';
import '../widgets/tag_mastery_map.dart';

/// Home: racha, plan del día y accesos a modos estrella.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final profile = state.profile;
    final isDark = theme.brightness == Brightness.dark;
    final name = profile.displayName.isEmpty ? 'Aspirante' : profile.displayName;

    return AtmosphericBackground(
      dark: isDark,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Row(
                  children: [
                    const Expanded(child: BrandMark(compact: true)),
                    IconButton(
                      tooltip: state.isAnonymousUser ? 'Guardar cuenta' : 'Cuenta',
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
                        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text('Hola, $name', style: theme.textTheme.headlineMedium)
                    .animate()
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: 6),
                Text(
                  profile.especialidad == null
                      ? 'Tu entrenador táctico del magisterio'
                      : '${profile.cargo?.label ?? ''} · ${profile.especialidad!.label}',
                  style: theme.textTheme.bodyLarge,
                ),
                if (!state.isAnonymousUser && state.authEmail != null) ...[
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
                const SizedBox(height: 18),
                _StreakCard(
                  streak: profile.streakDays,
                  doneToday: profile.dailyCompletedToday,
                  onStart: () {
                    state.startSession(mode: SessionMode.dailyStreak);
                    context.push('/practice');
                  },
                ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.05, end: 0),
                const SizedBox(height: 14),
                Builder(
                  builder: (context) {
                    final masteryRows =
                        TagMasteryService.buildMap(profile);
                    final recommended =
                        TagMasteryService.recommendedToday(profile);
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
                          Text(
                            'Mapa de Maestría',
                            style: theme.textTheme.titleMedium,
                          ),
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
                          Text(
                            state.studyFocusMessage(),
                            style: theme.textTheme.labelLarge,
                          ),
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
                  },
                ),
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
                SwitchListTile(
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
                              state.lastError ??
                                  'No se pudo activar el recordatorio.',
                            ),
                          ),
                        );
                      }
                    } else {
                      await state.disableStreakReminders();
                    }
                  },
                ),
                const SizedBox(height: 22),
                Text('Entrenar ahora', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth > 620;
                    final cards = [
                      _ModeCard(
                        title: 'Modo Práctica',
                        subtitle: 'Sin reloj. Explicación inmediata.',
                        icon: Icons.menu_book_rounded,
                        color: AppColors.canopy,
                        onTap: () {
                          state.startSession(mode: SessionMode.practice, count: 8);
                          context.push('/practice');
                        },
                      ),
                      _ModeCard(
                        title: 'Examen Real',
                        subtitle: 'Tiempo por ítem + mapa de calor.',
                        icon: Icons.timer_outlined,
                        color: AppColors.coral,
                        onTap: () {
                          if (!state.canStartShortExam) {
                            context.push('/premium');
                            return;
                          }
                          state.startSession(mode: SessionMode.exam, count: 8);
                          context.push('/exam');
                        },
                      ),
                      _ModeCard(
                        title: 'Alta exigencia',
                        subtitle: 'Casos nivel 3 · ~120s por ítem.',
                        icon: Icons.whatshot_outlined,
                        color: AppColors.danger,
                        onTap: () {
                          if (!state.canStartShortExam) {
                            context.push('/premium');
                            return;
                          }
                          state.startSession(
                            mode: SessionMode.exam,
                            count: 6,
                            minDifficultyLevel: 3,
                          );
                          context.push('/exam');
                        },
                      ),
                      _ModeCard(
                        title: 'Casos de Aula',
                        subtitle: 'Situaciones con debido proceso.',
                        icon: Icons.groups_2_outlined,
                        color: AppColors.skyLine,
                        onTap: () => context.push('/cases'),
                      ),
                      _ModeCard(
                        title: 'Reto rápido',
                        subtitle: 'Nivel 1 · ~45s por pregunta.',
                        icon: Icons.bolt_outlined,
                        color: AppColors.goldDeep,
                        onTap: () {
                          state.startSession(mode: SessionMode.speedBattle);
                          context.push('/speed');
                        },
                      ),
                      _ModeCard(
                        title: 'Mi especialidad',
                        subtitle: profile.especialidad == null
                            ? 'Práctica del módulo de área'
                            : 'Enfocado en ${profile.especialidad!.label}',
                        icon: Icons.school_outlined,
                        color: AppColors.inkSoft,
                        onTap: () {
                          state.startSession(
                            mode: SessionMode.practice,
                            specialty: profile.especialidad,
                            count: 8,
                          );
                          context.push('/practice');
                        },
                      ),
                      _ModeCard(
                        title: 'Plan diario',
                        subtitle: 'Ruta hasta tu fecha de examen.',
                        icon: Icons.route_outlined,
                        color: AppColors.canopy,
                        onTap: () => context.go('/app/plan'),
                      ),
                    ];

                    if (!wide) {
                      return Column(
                        children: [
                          for (final card in cards) ...[
                            card,
                            const SizedBox(height: 10),
                          ],
                        ],
                      );
                    }

                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: cards
                          .map((c) => SizedBox(width: (constraints.maxWidth - 12) / 2, child: c))
                          .toList(),
                    );
                  },
                ),
                if (!profile.isPremium) ...[
                  const SizedBox(height: 18),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: theme.colorScheme.outline),
                    ),
                    tileColor: AppColors.gold.withValues(alpha: 0.12),
                    leading: const Icon(Icons.workspace_premium_outlined, color: AppColors.goldDeep),
                    title: Text('Desbloquear Premium', style: theme.textTheme.titleSmall),
                    subtitle: Text(
                      'Banco ilimitado, especialidad y estadísticas avanzadas',
                      style: theme.textTheme.bodySmall,
                    ),
                    onTap: () => context.push('/premium'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({
    required this.streak,
    required this.doneToday,
    required this.onStart,
  });

  final int streak;
  final bool doneToday;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
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
            style: theme.textTheme.headlineSmall?.copyWith(color: AppColors.white),
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

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.cardTheme.color,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(subtitle, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
