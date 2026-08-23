import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';

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
