import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/option_tile.dart';

/// Reto de agilidad mental: 60 segundos, máxima cantidad de aciertos.
class SpeedBattleScreen extends StatefulWidget {
  const SpeedBattleScreen({super.key});

  @override
  State<SpeedBattleScreen> createState() => _SpeedBattleScreenState();
}

class _SpeedBattleScreenState extends State<SpeedBattleScreen> {
  static const _totalSeconds = 60;
  Timer? _timer;
  int _remaining = _totalSeconds;
  int _score = 0;
  int _attempts = 0;
  bool _finished = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AppState>();
      if (state.currentMode != SessionMode.speedBattle ||
          state.currentQuestions.isEmpty) {
        state.startSession(mode: SessionMode.speedBattle);
      }
      _startTimer();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _finished) return;
      if (_remaining <= 1) {
        timer.cancel();
        _finish();
        return;
      }
      setState(() => _remaining -= 1);
    });
  }

  Future<void> _finish() async {
    if (_finished) return;
    setState(() => _finished = true);
    _timer?.cancel();
    final state = context.read<AppState>();
    await state.persistNow();
  }

  Future<void> _answer(int index) async {
    if (_finished || _busy) return;
    final state = context.read<AppState>();
    final question = state.currentQuestion;
    if (question == null) return;

    setState(() => _busy = true);
    state.selectOption(index);
    final correct = question.isCorrect(index);
    setState(() {
      _attempts += 1;
      if (correct) _score += 1;
    });

    final depleted = await state.submitAndAdvance();
    if (!mounted) return;
    setState(() => _busy = false);

    if (depleted || state.currentQuestion == null) {
      await _finish();
    }
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
    final letters = ['A', 'B', 'C', 'D'];
    final urgent = _remaining <= 10;

    if (_finished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reto 60s')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tiempo terminado', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  Text(
                    'Aciertos: $_score / $_attempts',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: AppColors.canopy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _score >= 8
                        ? 'Agilidad alta. Mantén este ritmo en lectura y numérica.'
                        : 'Buen intento. Practica bloques cortos para subir velocidad sin perder criterio.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),
                  FilledButton(
                    onPressed: () {
                      state.clearSession();
                      context.go('/app');
                    },
                    child: const Text('Volver al inicio'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _finished = false;
                        _remaining = _totalSeconds;
                        _score = 0;
                        _attempts = 0;
                        _busy = false;
                      });
                      state.startSession(mode: SessionMode.speedBattle);
                      _startTimer();
                    },
                    child: const Text('Repetir reto'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reto 60s')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto 60s'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            await state.persistNow();
            state.clearSession();
            if (context.mounted) context.go('/app');
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_remaining}s',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: urgent ? AppColors.danger : AppColors.canopy,
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
              Row(
                children: [
                  Text('Aciertos: $_score', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  Text('Intentos: $_attempts', style: theme.textTheme.labelLarge),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: _remaining / _totalSeconds,
                  minHeight: 8,
                  color: urgent ? AppColors.coral : AppColors.goldDeep,
                ),
              ),
              const SizedBox(height: 18),
              Text(question.stem, style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              ...List.generate(question.options.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OptionTile(
                    letter: letters[i],
                    label: question.options[i],
                    selected: false,
                    onTap: _busy ? () {} : () => _answer(i),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
