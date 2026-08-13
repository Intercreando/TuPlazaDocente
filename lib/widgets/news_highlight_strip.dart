import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/news_item.dart';
import '../services/news_service.dart';
import '../theme/app_colors.dart';

String formatNewsDate(int? ms) {
  if (ms == null || ms <= 0) return '';
  final d = DateTime.fromMillisecondsSinceEpoch(ms);
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  return '$dd/$mm/${d.year}';
}

/// Franja compacta de avisos (landing e inicio).
class NewsHighlightStrip extends StatefulWidget {
  const NewsHighlightStrip({
    super.key,
    this.limit = 3,
    this.compact = false,
    this.onSeeAll,
  });

  final int limit;
  final bool compact;
  final VoidCallback? onSeeAll;

  @override
  State<NewsHighlightStrip> createState() => _NewsHighlightStripState();
}

class _NewsHighlightStripState extends State<NewsHighlightStrip> {
  final _service = NewsService();
  late Future<List<NewsItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.listPublished(limit: widget.limit);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<List<NewsItem>>(
      future: _future,
      builder: (context, snap) {
        final items = snap.data ?? const <NewsItem>[];
        if (snap.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (items.isEmpty) {
          return _NewsEmptyPlaceholder(compact: widget.compact);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Avisos de la convocatoria',
                    style: widget.compact
                        ? theme.textTheme.titleMedium
                        : theme.textTheme.titleLarge,
                  ),
                ),
                if (widget.onSeeAll != null)
                  TextButton(
                    onPressed: widget.onSeeAll,
                    child: const Text('Ver todas'),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            for (final item in items) ...[
              _NewsTeaserCard(item: item),
              const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }
}

class _NewsEmptyPlaceholder extends StatelessWidget {
  const _NewsEmptyPlaceholder({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Avisos de la convocatoria',
          style: compact ? theme.textTheme.titleMedium : theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.gold.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.campaign_outlined,
                color: AppColors.goldDeep,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pronto avisos de la convocatoria',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cuando haya fechas, cambios o novedades del CNSC, las verás aquí.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewsTeaserCard extends StatelessWidget {
  const _NewsTeaserCard({required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final date = formatNewsDate(item.publishedAtMs ?? item.updatedAtMs);

    return Material(
      color: isDark ? AppColors.darkSurface : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/noticias/${item.id}'),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.darkStroke : AppColors.stroke,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.tagLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.goldDeep,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      item.summary,
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (date.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(date, style: theme.textTheme.labelSmall),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
