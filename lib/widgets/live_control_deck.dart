import 'package:flutter/material.dart';

import '../data/live_session.dart';
import '../data/reel_clip.dart';

/// Mesa del anfitrión: momentos, votación, letras y escaleta.
class LiveControlDeck extends StatelessWidget {
  const LiveControlDeck({
    super.key,
    required this.beat,
    required this.rundown,
    required this.current,
    required this.onBeat,
    required this.onStartVote,
    required this.onHighlight,
    required this.onPrevCase,
    required this.onNextCase,
    required this.onRemoveFromRundown,
    required this.onSelectRundown,
  });

  final LiveBeat beat;
  final List<ReelClip> rundown;
  final ReelClip current;
  final ValueChanged<LiveBeat> onBeat;
  final VoidCallback onStartVote;
  final ValueChanged<int> onHighlight;
  final VoidCallback onPrevCase;
  final VoidCallback onNextCase;
  final ValueChanged<ReelClip> onRemoveFromRundown;
  final ValueChanged<ReelClip> onSelectRundown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Momento del directo', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in LiveBeat.values)
              ChoiceChip(
                label: Text(item.label),
                selected: beat == item,
                onSelected: (_) => onBeat(item),
              ),
          ],
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: onStartVote,
          child: const Text('Abrir votación 20 s (V)'),
        ),
        const SizedBox(height: 10),
        Text('Señalar la más votada', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          'No cuenta el chat solo: tú miras YouTube y marcas la letra '
          'que más salió. No revela la correcta.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => onHighlight(i),
                  child: Text(['A', 'B', 'C', 'D'][i]),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: rundown.isEmpty ? null : onPrevCase,
                child: const Text('Caso anterior (P)'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: rundown.isEmpty ? null : onNextCase,
                child: const Text('Siguiente caso (N)'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Escaleta (${rundown.length})',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          rundown.isEmpty
              ? 'Elige un caso abajo y pulsa “Sumar a la escaleta”. '
                    'Así el directo ya tiene el orden listo.'
              : 'Toca un caso para cargarlo. La papelera lo saca de la '
                    'escaleta. N y P recorren esta lista.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        for (final clip in rundown) ...[
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            selected: clip.id == current.id,
            tileColor: theme.colorScheme.tertiaryContainer.withValues(
              alpha: 0.55,
            ),
            selectedTileColor: theme.colorScheme.tertiaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: theme.colorScheme.tertiary),
            ),
            title: Text(clip.label, style: theme.textTheme.bodyMedium),
            subtitle: Text(clip.group.label, style: theme.textTheme.bodySmall),
            onTap: () => onSelectRundown(clip),
            trailing: IconButton(
              tooltip: 'Quitar de la escaleta',
              onPressed: () => onRemoveFromRundown(clip),
              icon: const Icon(Icons.delete_outline),
            ),
          ),
          const SizedBox(height: 6),
        ],
      ],
    );
  }
}
