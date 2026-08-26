import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';

/// Catálogo de casos del estudio: búsqueda, usados y borrar (pack o propios).
class ReelClipPicker extends StatefulWidget {
  const ReelClipPicker({
    super.key,
    required this.catalog,
    required this.selected,
    required this.usedIds,
    required this.hiddenClips,
    required this.onSelected,
    required this.onToggleUsed,
    required this.onRemove,
    this.onRestore,
    this.title = 'Elige el caso de este video',
    this.subtitle,
    this.manageCatalog = true,
  });

  final List<ReelClip> catalog;
  final ReelClip selected;
  final Set<String> usedIds;
  final List<ReelClip> hiddenClips;
  final ValueChanged<ReelClip> onSelected;
  final ValueChanged<ReelClip> onToggleUsed;
  final ValueChanged<ReelClip> onRemove;
  final ValueChanged<ReelClip>? onRestore;
  final String title;
  final String? subtitle;

  /// En el estudio de directos solo se elige el caso; no se oculta el pack.
  final bool manageCatalog;

  @override
  State<ReelClipPicker> createState() => _ReelClipPickerState();
}

class _ReelClipPickerState extends State<ReelClipPicker> {
  final _controller = TextEditingController();
  String _query = '';
  late bool _hideUsed = widget.manageCatalog;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final used = widget.usedIds;
    var results = ReelStudioPack.searchIn(widget.catalog, _query);
    if (_hideUsed) {
      results = results.where((clip) => !used.contains(clip.id)).toList();
    }
    final pending = widget.catalog.where((c) => !used.contains(c.id)).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.title, style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          widget.subtitle ??
              'Marca “usado” cuando lo grabes para no repetirlo. '
                  'Pendientes: $pending de ${widget.catalog.length}.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.search, size: 20),
            hintText: 'Buscar por tema o texto del caso',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        if (widget.manageCatalog)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Ocultar ya usados', style: theme.textTheme.bodyMedium),
            value: _hideUsed,
            onChanged: (v) => setState(() => _hideUsed = v),
          ),
        Text(
          'Caso: ${widget.selected.label}'
          '${used.contains(widget.selected.id) ? (widget.manageCatalog ? ' · usado' : ' · en escaleta') : ''}',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 2),
        Text(
          'Abre con: ${widget.selected.hook}',
          style: theme.textTheme.bodySmall,
        ),
        if (results.isEmpty) ...[
          const SizedBox(height: 10),
          Text(
            _hideUsed
                ? 'No quedan casos pendientes. Quita “Ocultar ya usados” '
                    'o restaura alguno oculto.'
                : 'Ningún caso coincide con esa búsqueda.',
            style: theme.textTheme.bodySmall,
          ),
        ],
        for (final group in ReelStudioPack.groupsIn(results)) ...[
          const SizedBox(height: 12),
          Text(group.label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          for (final clip in results.where((c) => c.group == group))
            _ClipRow(
              clip: clip,
              selected: widget.selected.id == clip.id,
              used: used.contains(clip.id),
              usedCaption: widget.manageCatalog ? 'usado' : 'en escaleta',
              onSelected: () => widget.onSelected(clip),
              onToggleUsed: widget.manageCatalog
                  ? () => widget.onToggleUsed(clip)
                  : null,
              onRemove: widget.manageCatalog || used.contains(clip.id)
                  ? () => widget.onRemove(clip)
                  : null,
              removeTooltip: widget.manageCatalog
                  ? null
                  : 'Quitar de la escaleta',
            ),
        ],
        if (widget.hiddenClips.isNotEmpty && widget.onRestore != null) ...[
          const SizedBox(height: 12),
          Text('Ocultos del catálogo', style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          for (final clip in widget.hiddenClips)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(clip.label, style: theme.textTheme.bodyMedium),
              trailing: TextButton(
                onPressed: () => widget.onRestore!(clip),
                child: const Text('Restaurar'),
              ),
            ),
        ],
      ],
    );
  }
}

class _ClipRow extends StatelessWidget {
  const _ClipRow({
    required this.clip,
    required this.selected,
    required this.used,
    required this.usedCaption,
    required this.onSelected,
    this.onToggleUsed,
    this.onRemove,
    this.removeTooltip,
  });

  final ReelClip clip;
  final bool selected;
  final bool used;
  final String usedCaption;
  final VoidCallback onSelected;
  final VoidCallback? onToggleUsed;
  final VoidCallback? onRemove;
  final String? removeTooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: ChoiceChip(
              selected: selected,
              backgroundColor: used ? scheme.tertiaryContainer : null,
              selectedColor: used
                  ? scheme.tertiaryContainer
                  : scheme.secondaryContainer,
              side: used
                  ? BorderSide(color: scheme.tertiary)
                  : BorderSide(color: scheme.outline),
              avatar: Icon(
                clip.isCustom ? Icons.edit_note : Icons.quiz_outlined,
                size: 18,
              ),
              label: Text(used ? '${clip.label} · $usedCaption' : clip.label),
              onSelected: (_) => onSelected(),
            ),
          ),
          if (onToggleUsed != null)
            IconButton(
              tooltip: used ? 'Quitar de usados' : 'Marcar como usado',
              icon: Icon(
                used ? Icons.check_circle : Icons.circle_outlined,
                size: 22,
              ),
              onPressed: onToggleUsed,
            ),
          if (onRemove != null)
            IconButton(
              tooltip: removeTooltip ??
                  (clip.isCustom
                      ? 'Borrar caso'
                      : 'Ocultar del catálogo'),
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
