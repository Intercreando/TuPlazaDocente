import 'package:flutter/material.dart';

import '../models/news_item.dart';
import '../theme/app_colors.dart';
import '../utils/app_snackbars.dart';
import '../utils/open_external_url.dart';

/// Lista de fuentes oficiales; al tocar se abre la página en una pestaña nueva.
class NewsOfficialLinks extends StatelessWidget {
  const NewsOfficialLinks({super.key, required this.links});

  final List<NewsLink> links;

  Future<void> _open(BuildContext context, NewsLink link) async {
    try {
      final ok = await openExternalUrl(link.url);
      if (!ok && context.mounted) {
        AppSnackbars.show(
          context,
          message: 'No pudimos abrir ${link.label}. Revisa el enlace.',
        );
      }
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbars.show(
        context,
        message: 'No pudimos abrir el documento oficial.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enlaces y fuentes oficiales', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final link in links)
              ActionChip(
                avatar: Icon(
                  Icons.open_in_new_rounded,
                  color: isDark ? AppColors.gold : AppColors.ink,
                ),
                label: Text(link.label),
                onPressed: () => _open(context, link),
              ),
          ],
        ),
      ],
    );
  }
}
