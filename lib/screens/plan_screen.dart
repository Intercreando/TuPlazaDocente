import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../models/study_plan.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/session_launch.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/feature_access_badge.dart';

/// Plan de estudio diario hasta la fecha del examen.
class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final plan = state.todayPlan;
    final isDark = theme.brightness == Brightness.dark;
    final exam = state.profile.examDate;

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
                Text('Plan de hoy', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(plan.summary, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [AppColors.ink, AppColors.canopy],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intensidad: ${plan.intensityLabel}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        plan.daysRemaining == 0
                            ? 'Día de examen'
                            : '${plan.daysRemaining} días restantes',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Foco: ${plan.focusPillar.label} · ~${plan.totalMinutes} min',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.86),
                        ),
                      ),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: plan.progress == 0 ? 0.04 : plan.progress,
                          minHeight: 8,
                          color: AppColors.gold,
                          backgroundColor: AppColors.white.withValues(alpha: 0.18),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${plan.completedCount}/${plan.tasks.length} bloques completados',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 800)),
                      initialDate: exam ?? now.add(const Duration(days: 90)),
                    );
                    if (picked != null && context.mounted) {
                      await state.updateExamDate(picked);
                    }
                  },
                  icon: const Icon(Icons.event_outlined),
                  label: Text(
                    exam == null
                        ? 'Definir fecha de examen'
                        : 'Examen: ${exam.day}/${exam.month}/${exam.year}',
                  ),
                ),
                const SizedBox(height: 18),
                Text('Bloques del día', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                ...plan.tasks.map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _PlanTaskTile(
                      task: task,
                      premiumLocked: !state.profile.isPremium &&
                          task.isCaseStudy,
                      onStart: () {
                        final ok = state.startPlanTask(task);
                        launchSessionOrPaywall(
                          context: context,
                          state: state,
                          started: ok,
                          route: task.mode == SessionMode.exam
                              ? '/exam'
                              : '/practice',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanTaskTile extends StatelessWidget {
  const _PlanTaskTile({
    required this.task,
    required this.onStart,
    this.premiumLocked = false,
  });

  final StudyTask task;
  final VoidCallback onStart;
  final bool premiumLocked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: premiumLocked && !task.completed ? 0.78 : 1,
      child: Material(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: task.completed ? null : onStart,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: task.completed
                    ? AppColors.success
                    : premiumLocked
                        ? AppColors.gold.withValues(alpha: 0.55)
                        : theme.colorScheme.outline,
              ),
              color: premiumLocked && !task.completed
                  ? AppColors.gold.withValues(alpha: 0.06)
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  task.completed
                      ? Icons.check_circle
                      : premiumLocked
                          ? Icons.lock_outline_rounded
                          : task.isCaseStudy
                              ? Icons.apartment_outlined
                              : Icons.play_circle_outline,
                  color: task.completed
                      ? AppColors.success
                      : premiumLocked
                          ? AppColors.goldDeep
                          : AppColors.canopy,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: theme.textTheme.titleSmall),
                      const SizedBox(height: 2),
                      Text(
                        '${task.subtitle} · ${task.questionCount}Q · ${task.minutes} min',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (task.completed)
                  Text(
                    'Hecho',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.success,
                    ),
                  )
                else if (premiumLocked)
                  const FeatureAccessBadge(
                    level: FeatureAccessLevel.locked,
                  )
                else
                  Text(
                    'Empezar',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.canopy,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
