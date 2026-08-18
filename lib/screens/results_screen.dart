import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../models/question.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';

/// Resultados + mapa de calor de tiempo (modo examen).
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final result = state.lastResult;

    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Resultados')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/app'),
            child: const Text('Ir al inicio'),
          ),
        ),
      );
    }

    final accuracy = (result.accuracy * 100).round();
    final isExam = result.mode == SessionMode.exam;

    return Scaffold(
      appBar: AppBar(title: const Text('Resultados')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [AppColors.ink, AppColors.canopy],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Precisión',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$accuracy%',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _resultsSummary(result),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(state.studyFocusMessage(), style: theme.textTheme.bodyLarge),
              if (isExam) ...[
                const SizedBox(height: 22),
                Text(
                  'Mapa de calor de tiempo',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Rojo = perdiste demasiado tiempo (≥90s). Verde = ritmo saludable.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < result.answers.length; i++)
                      _HeatCell(
                        index: i + 1,
                        seconds: result.answers[i].secondsSpent,
                        correct: result.answers[i].correct,
                        unanswered: result.answers[i].selectedIndex == null,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                ...result.answers.asMap().entries.map((entry) {
                  final i = entry.key;
                  final a = entry.value;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: _heatColor(
                        a.secondsSpent,
                      ).withValues(alpha: 0.2),
                      child: Text(
                        '${i + 1}',
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    title: Text(
                      a.selectedIndex == null
                          ? 'Sin respuesta · ${a.pillar.label}'
                          : a.correct
                          ? 'Correcta · ${a.pillar.label}'
                          : 'Incorrecta · ${a.pillar.label}',
                      style: theme.textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      '${a.topic} · ${a.secondsSpent}s',
                      style: theme.textTheme.bodySmall,
                    ),
                  );
                }),
              ],
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  state.clearSession();
                  if (result.mode == SessionMode.diagnostic &&
                      state.isPaidCohort &&
                      !state.profile.isPremium) {
                    context.go('/diagnostic-paywall');
                    return;
                  }
                  context.go('/app');
                },
                child: Text(
                  result.mode == SessionMode.diagnostic &&
                          state.isPaidCohort &&
                          !state.profile.isPremium
                      ? 'Ver cómo vas'
                      : 'Volver al inicio',
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  state.clearSession();
                  context.go('/app/radar');
                },
                child: const Text('Ver tu progreso'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _resultsSummary(SessionResult result) {
    final time = '${result.totalSeconds ~/ 60}m ${result.totalSeconds % 60}s';
    final unanswered = result.unansweredCount;
    if (unanswered <= 0) {
      return '${result.correctCount} de ${result.total} correctas · $time';
    }
    return '${result.correctCount} de ${result.total} correctas · '
        '$unanswered sin respuesta · $time';
  }

  static Color _heatColor(int seconds) {
    if (seconds >= 90) return AppColors.danger;
    if (seconds >= 60) return AppColors.warning;
    return AppColors.success;
  }
}

class _HeatCell extends StatelessWidget {
  const _HeatCell({
    required this.index,
    required this.seconds,
    required this.correct,
    required this.unanswered,
  });

  final int index;
  final int seconds;
  final bool correct;
  final bool unanswered;

  @override
  Widget build(BuildContext context) {
    final color = ResultsScreen._heatColor(seconds);
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Q$index', style: Theme.of(context).textTheme.labelMedium),
          Text('${seconds}s', style: Theme.of(context).textTheme.labelLarge),
          Icon(
            unanswered ? Icons.remove : (correct ? Icons.check : Icons.close),
            size: 14,
            color: color,
          ),
        ],
      ),
    );
  }
}
