import 'package:flutter/material.dart';

import '../data/reel_clip_text_parser.dart';
import '../data/reel_studio_pack.dart';

/// Crea casos nuevos pegando texto, sin tocar el código.
///
/// El texto se interpreta en vivo: la vista previa muestra qué entendió y qué
/// falta, y solo se puede guardar cuando el caso está completo.
class ReelClipComposer extends StatefulWidget {
  const ReelClipComposer({
    super.key,
    required this.customClips,
    required this.onSave,
    required this.onDelete,
  });

  final List<ReelClip> customClips;

  /// Devuelve `true` si el caso quedó guardado.
  final Future<bool> Function(ReelClip clip) onSave;
  final Future<void> Function(ReelClip clip) onDelete;

  @override
  State<ReelClipComposer> createState() => _ReelClipComposerState();
}

class _ReelClipComposerState extends State<ReelClipComposer> {
  final _controller = TextEditingController();
  ReelClipDraft _draft = const ReelClipDraft();
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => _draft = ReelClipTextParser.parse(value));
  }

  void _fillTemplate() {
    _controller.text = ReelClipTextParser.plantilla.trim();
    _onChanged(_controller.text);
  }

  Future<void> _save() async {
    final clip = _draft.clip;
    if (clip == null || _saving) return;
    setState(() => _saving = true);
    final ok = await widget.onSave(clip);
    if (!mounted) return;
    setState(() {
      _saving = false;
      if (ok) {
        _controller.clear();
        _draft = const ReelClipDraft();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        initiallyExpanded: widget.customClips.isNotEmpty,
        leading: const Icon(Icons.playlist_add),
        title: Text(
          'Agregar caso pegando texto',
          style: theme.textTheme.titleSmall,
        ),
        subtitle: Text(
          widget.customClips.isEmpty
              ? 'Se guarda en la nube y aparece al instante'
              : '${widget.customClips.length} creados por ti',
          style: theme.textTheme.bodySmall,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        children: [
          Text(
            'Pega el caso con estas etiquetas: Tema, Título, Caso, Pregunta, '
            'las cuatro opciones (A) B) C) D)), Correcta y Porque. '
            'Temas válidos: ${ReelGroup.help}.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            minLines: 8,
            maxLines: 16,
            style: theme.textTheme.bodySmall,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Tema: convivencia\nTítulo: …\nCaso: …',
            ),
            onChanged: _onChanged,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _fillTemplate,
                  icon: const Icon(Icons.content_paste_go, size: 18),
                  label: const Text('Plantilla'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _draft.isValid && !_saving ? _save : null,
                  icon: const Icon(Icons.save, size: 18),
                  label: Text(_saving ? 'Guardando…' : 'Guardar'),
                ),
              ),
            ],
          ),
          if (_controller.text.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            _DraftPreview(draft: _draft),
          ],
          if (widget.customClips.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text('Casos creados por ti', style: theme.textTheme.labelLarge),
            for (final clip in widget.customClips)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(clip.label, style: theme.textTheme.bodySmall),
                subtitle: Text(
                  '${clip.group.label} · respuesta ${clip.correctLetter}',
                  style: theme.textTheme.bodySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Borrar caso',
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () => widget.onDelete(clip),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// Qué entendió el estudio del texto pegado.
class _DraftPreview extends StatelessWidget {
  const _DraftPreview({required this.draft});

  final ReelClipDraft draft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clip = draft.clip;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (clip != null) ...[
            Text(
              '${clip.group.label} · ${clip.label}',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(clip.stem, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            for (var i = 0; i < clip.options.length; i++)
              Text(
                '${'ABCD'[i]}${i == clip.correctIndex ? ' ✓' : ''} '
                '${clip.options[i]}',
                style: theme.textTheme.bodySmall,
              ),
          ],
          for (final error in draft.errors)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                error,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          for (final warning in draft.warnings)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(warning, style: theme.textTheme.bodySmall),
            ),
        ],
      ),
    );
  }
}
