import 'package:flutter/material.dart';

import '../data/reel_clip.dart';

/// Párrafo para leer en voz alta si el chat pregunta por qué.
///
/// Usa la letra y el “porque” de este caso, en tono de conversación, para
/// que no se note que estás leyendo un apunte genérico.
String liveHostSpokenWhy(ReelClip clip) {
  final letter = clip.correctLetter;
  var why = clip.revealWhy.trim();
  if (why.isNotEmpty && !why.endsWith('.')) why = '$why.';
  final nucleo = why.isEmpty
      ? 'Gana la que no se salta el proceso ni deja a alguien desprotegido.'
      : why;

  return 'Bueno, fíjense: la correcta es la $letter. $nucleo '
      'Si muchos se fueron por otra, es normal: casi siempre es la que suena '
      'más humana o más estricta, y por eso enreda. No estoy citando un '
      'artículo de memoria; es el criterio de este caso. Y recuerden: esto '
      'es entrenamiento, no un ítem oficial de la CNSC.';
}

/// Clave del anfitrión: la letra y el texto para leer (no sale en OBS).
class LiveHostNotes extends StatelessWidget {
  const LiveHostNotes({super.key, required this.clip});

  final ReelClip clip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tu clave (no sale en OBS)',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Text(
            'Correcta: ${clip.correctLetter}',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Léelo si preguntan por qué',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 6),
          Text(
            liveHostSpokenWhy(clip),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
