import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_snackbars.dart';
import '../utils/news_slug.dart';
import '../utils/open_site_page.dart';

/// Campo de la URL pública de una noticia, con la dirección final a la vista.
///
/// La URL es lo primero que lee Google y lo que la gente comparte, así que se
/// edita aquí en vez de dejar el identificador aleatorio de la base de datos.
class NewsSlugField extends StatelessWidget {
  const NewsSlugField({super.key, required this.slug, required this.title});

  final TextEditingController slug;
  final TextEditingController title;

  /// Lo que quedará en la URL: lo escrito o, si está vacío, el título.
  String get _resolved {
    final escrito = slug.text.trim();
    return newsSlugify(escrito.isEmpty ? title.text : escrito);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: Listenable.merge([slug, title]),
      builder: (context, _) {
        final url = 'tuplazadocente.com/noticias/$_resolved/';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: slug,
              decoration: InputDecoration(
                labelText: 'URL de la noticia',
                hintText: 'fechas-inscripcion-concurso-docente',
                suffixIcon: IconButton(
                  tooltip: 'Sugerir desde el título',
                  icon: const Icon(Icons.auto_fix_high_outlined),
                  onPressed: () {
                    slug.text = newsSlugify(title.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: Text(url, style: theme.textTheme.bodySmall)),
                IconButton(
                  tooltip: 'Copiar enlace',
                  icon: const Icon(Icons.copy_outlined, size: 18),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: 'https://$url'),
                    );
                    if (!context.mounted) return;
                    AppSnackbars.show(context, message: 'Enlace copiado.');
                  },
                ),
                IconButton(
                  tooltip: 'Abrir página SEO',
                  icon: const Icon(Icons.open_in_new, size: 18),
                  onPressed: () {
                    openSitePage('https://$url', newTab: true);
                  },
                ),
              ],
            ),
            Text(
              'Si la cambias, la dirección anterior seguirá funcionando y '
              'llevará a la nueva. Usa palabras de búsqueda, no un recorte: '
              'opec-preliminar-concurso-docente-2026.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
