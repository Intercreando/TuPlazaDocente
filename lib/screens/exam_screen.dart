import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/option_tile.dart';

/// Modo examen real: temporizador por ítem según `tiempo_recomendado_seg`.
class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  Timer? _timer;
  int _remaining = 90;
  int _budget = 90;
  int _trackedIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.watch<AppState>();
    if (state.currentIndex != _trackedIndex) {
      _trackedIndex = state.currentIndex;
      _restartTimer(state.currentQuestion?.tiempoRecomendadoSeg ?? 90);
    }
  }

  void _restartTimer(int seconds) {
    _timer?.cancel();
    _budget = seconds.clamp(20, 180);
    _remaining = _budget;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) return;
      if (_remaining <= 1) {
        timer.cancel();
        final state = context.read<AppState>();
        state.selectedOption ??= 0;
        final finished = await state.submitAndAdvance();
        if (!mounted) return;
        if (finished) {
          context.go('/results');
        }
        return;
      }
      setState(() => _remaining -= 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final question = state.currentQuestion;

    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Examen')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/app'),
            child: const Text('Volver al inicio'),
          ),
        ),
      );
    }

    final letters = ['A', 'B', 'C', 'D'];
    final urgent = _remaining <= (_budget * 0.2).ceil().clamp(8, 25);
    final progress = (state.currentIndex + 1) / state.currentQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen real'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            final leave = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('¿Salir del examen?'),
                content: const Text('Se perderá el progreso de esta sesión.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
                  FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salir')),
                ],
              ),
            );
            if (leave == true && context.mounted) {
              context.read<AppState>().clearSession();
              context.go('/app');
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${(_remaining ~/ 60).toString().padLeft(1, '0')}:${(_remaining % 60).toString().padLeft(2, '0')}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: urgent ? AppColors.danger : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: urgent ? AppColors.coral : AppColors.canopy,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Ítem ${state.currentIndex + 1}/${state.currentQuestions.length} · '
                '${question.pillar.label} · Nivel ${question.dificultad} · '
                '${question.tiempoRecomendadoSeg}s',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 16),
              Text(question.stem, style: theme.textTheme.titleLarge),
              const SizedBox(height: 18),
              ...List.generate(question.options.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OptionTile(
                    letter: letters[i],
                    label: question.options[i],
                    selected: state.selectedOption == i,
                    onTap: () => state.selectOption(i),
                  ),
                );
              }),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: state.selectedOption == null
                    ? null
                    : () async {
                        final finished = await state.submitAndAdvance();
                        if (!context.mounted) return;
                        if (finished) context.go('/results');
                      },
                child: const Text('Confirmar y continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
