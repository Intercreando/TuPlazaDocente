import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';

/// Catálogo de casos del estudio: búsqueda y agrupación por tema.
///
/// Con dos docenas de casos una lista plana de chips deja de ser navegable, así
/// que se filtra por texto y se separa por tema.
class ReelClipPicker extends StatefulWidget {
  const ReelClipPicker({
    super.key,
    required this.catalog,
    required this.selected,
    required this.onSelected,
    this.onDeleteCustom,
  });

  /// Casos del código más los creados a mano.
  final List<ReelClip> catalog;
  final ReelClip selected;
  final ValueChanged<ReelClip> onSelected;
  final ValueChanged<ReelClip>? onDeleteCustom;

  @override
  State<ReelClipPicker> createState() => _ReelClipPickerState();
}

class _ReelClipPickerState extends State<ReelClipPicker> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final catalog = widget.catalog;
    final results = ReelStudioPack.searchIn(catalog, _query);
    final total = catalog.length;
    final propios = catalog.where((clip) => clip.isCustom).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Elige el caso de este video', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          'Un reel = un caso. Ciclo exacto: 15,00 s. '
          'Hay $total casos${propios > 0 ? ' ($propios creados por ti)' : ''}: '
          'alterna temas para no repetir.',
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
        const SizedBox(height: 6),
        Text(
          _query.trim().isEmpty
              ? 'Grabando: ${widget.selected.label} '
                    '(respuesta ${widget.selected.correctLetter})'
              : '${results.length} de $total casos',
          style: theme.textTheme.bodySmall,
        ),
        if (widget.selected.isCustom && widget.onDeleteCustom != null) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => widget.onDeleteCustom!(widget.selected),
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text('Borrar este caso'),
          ),
        ],
        if (results.isEmpty) ...[
          const SizedBox(height: 10),
          Text(
            'Ningún caso coincide con esa búsqueda.',
            style: theme.textTheme.bodySmall,
          ),
        ],
        for (final group in ReelStudioPack.groupsIn(results)) ...[
          const SizedBox(height: 12),
          Text(group.label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          for (final clip in results.where((c) => c.group == group))
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      selected: widget.selected.id == clip.id,
                      avatar: clip.isCustom
                          ? const Icon(Icons.edit_note, size: 18)
                          : null,
                      label: Text(clip.label),
                      onSelected: (_) => widget.onSelected(clip),
                    ),
                  ),
                  if (clip.isCustom && widget.onDeleteCustom != null)
                    IconButton(
                      tooltip: 'Borrar caso',
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () => widget.onDeleteCustom!(clip),
                    ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}
