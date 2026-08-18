import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/progress_practice_launch.dart';
import 'tag_mastery_map.dart';

/// Resumen de progreso en el home: temas + un enlace al detalle.
class HomeProgressPanel extends StatelessWidget {
  const HomeProgressPanel({
    super.key,
    required this.state,
    required this.isDark,
  });

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
          Text('Tu progreso', style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(
            'Toca un tema para practicar justo ahí.',
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
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => launchProgressRecommendation(context),
              child: const Text('Practicar lo que más me falta'),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: () => context.go('/app/radar'),
              child: const Text('Ver detalle'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Aviso de racha: va al final del home para no competir con Continuar hoy.
class HomeReminderTile extends StatelessWidget {
  const HomeReminderTile({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = state.profile;

    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('Recordatorio de racha', style: theme.textTheme.titleSmall),
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
