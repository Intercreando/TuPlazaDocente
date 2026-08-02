import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/option_tile.dart';

/// Reto rápido: ítems nivel 1 con temporizador por pregunta (~45s).
class SpeedBattleScreen extends StatefulWidget {
  const SpeedBattleScreen({super.key});

  @override
  State<SpeedBattleScreen> createState() => _SpeedBattleScreenState();
}

class _SpeedBattleScreenState extends State<SpeedBattleScreen> {
  Timer? _timer;
  int _remaining = 45;
  int _budget = 45;
  int _score = 0;
  int _attempts = 0;
  bool _finished = false;
  bool _busy = false;
  int _trackedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AppState>();
      if (state.currentMode != SessionMode.speedBattle ||
          state.currentQuestions.isEmpty) {
        state.startSession(mode: SessionMode.speedBattle);
      }
      _armForCurrentQuestion();
    });
  }

  void _armForCurrentQuestion() {
    final state = context.read<AppState>();
    final question = state.currentQuestion;
    if (question == null) return;
    if (state.currentIndex == _trackedIndex && _timer != null) return;
    _trackedIndex = state.currentIndex;
    _timer?.cancel();
    _budget = question.tiempoRecomendadoSeg.clamp(20, 60);
    _remaining = _budget;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted || _finished) return;
      if (_remaining <= 1) {
        timer.cancel();
        // Tiempo agotado: fuerza una opción incorrecta y avanza.
        final app = context.read<AppState>();
        final q = app.currentQuestion;
        if (q != null) {
          final wrong = (q.correctIndex + 1) % q.options.length;
          app.selectOption(wrong);
        }
        setState(() {
          _attempts += 1;
        });
        final depleted = await app.submitAndAdvance();
        if (!mounted) return;
        if (depleted || app.currentQuestion == null) {
          await _finish();
        } else {
          _armForCurrentQuestion();
          setState(() {});
        }
        return;
      }
      setState(() => _remaining -= 1);
    });
  }

  Future<void> _finish() async {
    if (_finished) return;
    setState(() => _finished = true);
    _timer?.cancel();
    await context.read<AppState>().persistNow();
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
    } else {
      _armForCurrentQuestion();
      setState(() {});
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
    final urgent = _remaining <= (_budget * 0.25).ceil().clamp(6, 12);

    if (_finished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reto rápido')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Reto terminado', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  Text(
                    'Aciertos: $_score / $_attempts',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: AppColors.canopy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Modo nivel 1 · tiempo por ítem según tiempo_recomendado_seg',
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
                        _score = 0;
                        _attempts = 0;
                        _busy = false;
                        _trackedIndex = -1;
                      });
                      state.startSession(mode: SessionMode.speedBattle);
                      _armForCurrentQuestion();
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
        appBar: AppBar(title: const Text('Reto rápido')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto rápido · N1'),
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
                  Text(
                    'Nivel ${question.dificultad} · ${question.tiempoRecomendadoSeg}s',
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: _remaining / _budget,
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
