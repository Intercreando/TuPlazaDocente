import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// Sugerencias si no acertó: desbloquean la reformulación.
const kMentorComposerHintsMiss = [
  'Ej: Yo citaría a los padres porque…',
  'Ej: Según el decreto 1290, la norma dicta que…',
  '¿Qué cambiarías de la decisión del rector?',
  'Ej: En este caso yo aplicaría el SIEE porque…',
];

/// Sugerencias si acertó: anclan el criterio, no piden “corregir”.
const kMentorComposerHintsHit = [
  'Ej: Esa es la exigida porque…',
  'Ej: Si el rector insiste, yo…',
  'Ej: El distractor de sancionar falla porque…',
  'Ej: En el simulacro marcaría esto porque…',
];

/// Rota el hint cada pocos segundos si el campo está vacío.
class MentorHintRotator {
  MentorHintRotator({
    required this.controller,
    required this.onTick,
    this.choseCorrect = false,
    Duration interval = const Duration(seconds: 5),
  }) {
    _hints = choseCorrect ? kMentorComposerHintsHit : kMentorComposerHintsMiss;
    _index = Random().nextInt(_hints.length);
    _timer = Timer.periodic(interval, (_) {
      if (controller.text.trim().isNotEmpty) return;
      _index = (_index + 1) % _hints.length;
      onTick();
    });
  }

  final TextEditingController controller;
  final VoidCallback onTick;
  final bool choseCorrect;
  late final List<String> _hints;
  late final Timer _timer;
  late int _index;

  String get hint => _hints[_index];

  void dispose() {
    _timer.cancel();
  }
}
