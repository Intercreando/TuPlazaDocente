import 'package:flutter/material.dart';

import '../models/news_item.dart';

const int kMaxNewsOfficialLinks = 8;

/// Borrador de un enlace en el formulario admin.
class NewsLinkDraft {
  NewsLinkDraft({String label = '', String url = ''})
      : label = TextEditingController(text: label),
        url = TextEditingController(text: url);

  final TextEditingController label;
  final TextEditingController url;

  void dispose() {
    label.dispose();
    url.dispose();
  }

  NewsLink? toLink() {
    final name = label.text.trim();
    var href = url.text.trim();
    if (name.isEmpty || href.isEmpty) return null;
    if (!href.startsWith('http://') && !href.startsWith('https://')) {
      href = 'https://$href';
    }
    return NewsLink(label: name, url: href);
  }
}

/// Campos para agregar o quitar enlaces oficiales del aviso.
class NewsLinkEditor extends StatelessWidget {
  const NewsLinkEditor({
    super.key,
    required this.drafts,
    required this.onAdd,
    required this.onRemove,
  });

  final List<NewsLinkDraft> drafts;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Enlaces y fuentes oficiales', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          'El usuario los toca y abre la página oficial (CNSC, decreto, etc.).',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < drafts.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: drafts[i].label,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del enlace',
                        hintText: 'Ej. CNSC — Acuerdo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: drafts[i].url,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        labelText: 'URL',
                        hintText: 'https://www.cnsc.gov.co/...',
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Quitar enlace',
                onPressed: () => onRemove(i),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: drafts.length >= kMaxNewsOfficialLinks ? null : onAdd,
            icon: const Icon(Icons.add_link),
            label: const Text('Agregar enlace'),
          ),
        ),
      ],
    );
  }
}
