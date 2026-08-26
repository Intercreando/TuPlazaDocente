import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../data/live_session.dart';
import '../data/reel_clip.dart';
import '../utils/app_snackbars.dart';
import 'live_capture_note.dart';
import 'live_control_deck.dart';
import 'live_host_notes.dart';
import 'reel_clip_picker.dart';

/// Mesa izquierda del estudio: escaleta, catálogo y enlace de OBS.
class LiveStudioSidePanel extends StatelessWidget {
  const LiveStudioSidePanel({
    super.key,
    required this.session,
    required this.clip,
    required this.catalog,
    required this.rundown,
    required this.usedIds,
    required this.obsShareUrl,
    required this.onBeat,
    required this.onStartVote,
    required this.onHighlight,
    required this.onPrevCase,
    required this.onNextCase,
    required this.onRemoveFromRundown,
    required this.onSelectRundown,
    required this.onAddToRundown,
    required this.onLoadClip,
    this.composer,
  });

  final LiveSession session;
  final ReelClip clip;
  final List<ReelClip> catalog;
  final List<ReelClip> rundown;
  final Set<String> usedIds;
  final String obsShareUrl;
  final ValueChanged<LiveBeat> onBeat;
  final VoidCallback onStartVote;
  final ValueChanged<int> onHighlight;
  final VoidCallback onPrevCase;
  final VoidCallback onNextCase;
  final ValueChanged<ReelClip> onRemoveFromRundown;
  final ValueChanged<ReelClip> onSelectRundown;
  final VoidCallback onAddToRundown;
  final ValueChanged<ReelClip> onLoadClip;

  /// Pegar texto (mismo flujo que Reels), opcional en OBS.
  final Widget? composer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        LiveControlDeck(
          beat: session.beat,
          rundown: rundown,
          current: clip,
          onBeat: onBeat,
          onStartVote: onStartVote,
          onHighlight: onHighlight,
          onPrevCase: onPrevCase,
          onNextCase: onNextCase,
          onRemoveFromRundown: onRemoveFromRundown,
          onSelectRundown: onSelectRundown,
        ),
        const SizedBox(height: 12),
        LiveHostNotes(clip: clip),
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: onAddToRundown,
          child: const Text('Sumar caso actual a la escaleta'),
        ),
        const SizedBox(height: 12),
        ReelClipPicker(
          catalog: catalog,
          selected: clip,
          usedIds: usedIds,
          hiddenClips: const [],
          manageCatalog: false,
          title: 'Elige el caso de este directo',
          subtitle:
              'Enunciados largos para 16:9 y casos de alta exigencia '
              'del banco. No son los de Reels. '
              'Pendientes: ${catalog.length}.',
          onSelected: onLoadClip,
          onToggleUsed: (_) {},
          onRemove: (_) {},
        ),
        if (composer != null) ...[
          const SizedBox(height: 12),
          composer!,
        ],
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => context.go('/admin/estudio-directo?obs=1'),
          child: const Text('Ver solo el lienzo en esta pestaña'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: obsShareUrl));
            if (!context.mounted) return;
            AppSnackbars.show(
              context,
              message:
                  'Enlace copiado. Pégalo en OBS → Navegador '
                  '(1920×1080). Este panel manda el directo.',
            );
          },
          child: const Text('Copiar enlace para pegarlo dentro de OBS'),
        ),
        const SizedBox(height: 16),
        const LiveCaptureNote(),
        const SizedBox(height: 16),
        Text(
          'Atajos: espacio = siguiente momento. '
          'Retroceso = anterior. V = votar. '
          'N/P = caso. 1-4 o A-D = señalar. '
          'Enter = revelar. S = espera. R = gancho.',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
