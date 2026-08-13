import 'package:flutter/material.dart';

import '../models/news_item.dart';
import '../services/news_service.dart';
import '../utils/app_snackbars.dart';
import '../utils/pick_news_image.dart';
import '../widgets/news_link_editor.dart';

/// Formulario admin para crear o editar un aviso.
class NewsEditDialog extends StatefulWidget {
  const NewsEditDialog({super.key, required this.service, this.item});

  final NewsService service;
  final NewsItem? item;

  @override
  State<NewsEditDialog> createState() => _NewsEditDialogState();
}

class _NewsEditDialogState extends State<NewsEditDialog> {
  late final TextEditingController _title;
  late final TextEditingController _summary;
  late final TextEditingController _body;
  late String _tag;
  late bool _published;
  late bool _pinned;
  String? _imageUrl;
  bool _saving = false;
  final List<NewsLinkDraft> _linkDrafts = [];

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _title = TextEditingController(text: item?.title ?? '');
    _summary = TextEditingController(text: item?.summary ?? '');
    _body = TextEditingController(text: item?.body ?? '');
    _tag = item?.tag ?? 'aviso';
    _published = item?.published ?? true;
    _pinned = item?.pinned ?? false;
    _imageUrl = item?.imageUrl;
    final existing = item?.links ?? const <NewsLink>[];
    if (existing.isEmpty) {
      _linkDrafts.add(NewsLinkDraft());
    } else {
      for (final link in existing) {
        _linkDrafts.add(NewsLinkDraft(label: link.label, url: link.url));
      }
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _summary.dispose();
    _body.dispose();
    for (final draft in _linkDrafts) {
      draft.dispose();
    }
    super.dispose();
  }

  List<NewsLink> _collectedLinks() {
    return _linkDrafts
        .map((d) => d.toLink())
        .whereType<NewsLink>()
        .toList();
  }

  Future<void> _pickImage(String newsId) async {
    try {
      final picked = await pickNewsImage();
      if (picked == null || !mounted) return;
      final url = await widget.service.uploadCover(
        newsId: newsId,
        bytes: picked.bytes,
      );
      if (!mounted) return;
      setState(() => _imageUrl = url);
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await widget.service.adminUpsert(
        id: widget.item?.id,
        title: _title.text,
        summary: _summary.text,
        body: _body.text,
        tag: _tag,
        imageUrl: _imageUrl,
        links: _collectedLinks(),
        published: _published,
        pinned: _pinned,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        widget.item == null ? 'Nuevo aviso' : 'Editar aviso',
        style: theme.textTheme.titleLarge,
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _summary,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Resumen (landing e inicio)',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _body,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Texto completo',
                ),
              ),
              const SizedBox(height: 16),
              NewsLinkEditor(
                drafts: _linkDrafts,
                onAdd: () {
                  if (_linkDrafts.length >= kMaxNewsOfficialLinks) return;
                  setState(() => _linkDrafts.add(NewsLinkDraft()));
                },
                onRemove: (index) {
                  setState(() {
                    _linkDrafts[index].dispose();
                    _linkDrafts.removeAt(index);
                    if (_linkDrafts.isEmpty) {
                      _linkDrafts.add(NewsLinkDraft());
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _tag,
                decoration: const InputDecoration(labelText: 'Etiqueta'),
                items: const [
                  DropdownMenuItem(value: 'aviso', child: Text('Aviso')),
                  DropdownMenuItem(
                    value: 'convocatoria',
                    child: Text('Convocatoria'),
                  ),
                  DropdownMenuItem(value: 'fecha', child: Text('Fechas')),
                  DropdownMenuItem(value: 'cambio', child: Text('Cambio')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _tag = v);
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Publicado', style: theme.textTheme.bodyMedium),
                value: _published,
                onChanged: (v) => setState(() => _published = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Fijar arriba', style: theme.textTheme.bodyMedium),
                value: _pinned,
                onChanged: (v) => setState(() => _pinned = v),
              ),
              if (_imageUrl != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(_imageUrl!, height: 120, fit: BoxFit.cover),
                ),
              ],
              TextButton.icon(
                onPressed: _saving
                    ? null
                    : () async {
                        var id = widget.item?.id;
                        id ??= await widget.service.adminUpsert(
                          title: _title.text.isEmpty ? 'Borrador' : _title.text,
                          summary: _summary.text.isEmpty
                              ? 'Resumen pendiente'
                              : _summary.text,
                          body: _body.text,
                          tag: _tag,
                          imageUrl: _imageUrl,
                          links: _collectedLinks(),
                          published: false,
                          pinned: _pinned,
                        );
                        await _pickImage(id);
                      },
                icon: const Icon(Icons.image_outlined),
                label: Text(_imageUrl == null ? 'Agregar imagen' : 'Cambiar imagen'),
              ),
              Text(
                'Se comprime a JPEG (máx. 1600 px) y se guarda en Firebase Storage.',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Guardando…' : 'Guardar'),
        ),
      ],
    );
  }
}
