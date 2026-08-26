import 'package:flutter/material.dart';

import '../data/reel_clip.dart';

/// Clave del anfitrión: la letra y el porqué, solo en este panel (no en OBS).
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
          if (clip.revealWhy.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(clip.revealWhy, style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 8),
          Text(
            'Si preguntan “¿por qué?”: di el principio (protección, debido '
            'proceso, inclusión sin bajar la meta, SIEE), luego por qué esta '
            'letra y por qué la trampa más votada. Si no estás seguro: '
            '“Es entrenamiento, no clave oficial; el criterio es este”. '
            'Nunca inventes un artículo.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
