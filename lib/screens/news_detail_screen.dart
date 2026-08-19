import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/news_item.dart';
import '../services/news_service.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/seo_document.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/news_highlight_strip.dart';
import '../widgets/news_official_links.dart';

/// Detalle de un aviso (público: landing o app).
class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key, required this.id});

  final String id;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final _service = NewsService();
  late Future<NewsItem?> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.getBySlugOrId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aviso'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/app');
            }
          },
        ),
      ),
      body: AtmosphericBackground(
        dark: isDark,
        child: FutureBuilder<NewsItem?>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final item = snap.data;
            if (item == null) {
              return Center(
                child: Text(
                  'Este aviso ya no está disponible.',
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }
            SeoDocument.apply(
              title: item.title,
              description: item.summary.trim().isEmpty
                  ? item.title
                  : item.summary,
              canonical: item.publicUrl,
            );
            final date = formatNewsDate(item.publishedAtMs ?? item.updatedAtMs);
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView(
                  padding: LayoutBreakpoints.pagePadding(context),
                  children: [
                    Text(
                      '${item.tagLabel}${date.isEmpty ? '' : ' · $date'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.goldDeep,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(item.title, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      item.body.isEmpty ? item.summary : item.body,
                      style: theme.textTheme.bodyLarge,
                    ),
                    if (item.links.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      NewsOfficialLinks(links: item.links),
                    ],
                    const SizedBox(height: 28),
                    FilledButton(
                      onPressed: () => context.go('/app'),
                      child: const Text('Ir a entrenar'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
