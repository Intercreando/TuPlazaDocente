import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// Sugerencias cortas para desbloquear la primera frase.
const kMentorComposerHints = [
  'Ej: Yo citaría a los padres porque…',
  'Ej: Según el decreto 1290, la norma dicta que…',
  '¿Qué cambiarías de la decisión del rector?',
  'Ej: En este caso yo aplicaría el SIEE porque…',
];

/// Rota el hint cada pocos segundos si el campo está vacío.
class MentorHintRotator {
  MentorHintRotator({
    required this.controller,
    required this.onTick,
    Duration interval = const Duration(seconds: 5),
  }) {
    _index = Random().nextInt(kMentorComposerHints.length);
    _timer = Timer.periodic(interval, (_) {
      if (controller.text.trim().isNotEmpty) return;
      _index = (_index + 1) % kMentorComposerHints.length;
      onTick();
    });
  }

  final TextEditingController controller;
  final VoidCallback onTick;
  late final Timer _timer;
  late int _index;

  String get hint => kMentorComposerHints[_index];

  void dispose() {
    _timer.cancel();
  }
}
