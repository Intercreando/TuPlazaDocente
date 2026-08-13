import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/news_item.dart';
import '../services/news_service.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/news_highlight_strip.dart';

/// Listado completo de avisos publicados.
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _service = NewsService();
  late Future<List<NewsItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.listPublished(limit: 40);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final desktop = LayoutBreakpoints.isDesktop(context);

    return AtmosphericBackground(
      dark: isDark,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: Column(
              children: [
                if (!desktop)
                  AppBar(
                    backgroundColor: Colors.transparent,
                    title: const Text('Noticias'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go('/app'),
                    ),
                  ),
                Expanded(
                  child: FutureBuilder<List<NewsItem>>(
                    future: _future,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final items = snap.data ?? const <NewsItem>[];
                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            'No hay avisos nuevos por ahora.',
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: LayoutBreakpoints.pagePadding(context),
                        itemCount: items.length + (desktop ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          if (desktop && index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Noticias',
                                style: theme.textTheme.headlineSmall,
                              ),
                            );
                          }
                          final item = items[desktop ? index - 1 : index];
                          return _NewsListCard(item: item);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NewsListCard extends StatelessWidget {
  const _NewsListCard({required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final date = formatNewsDate(item.publishedAtMs ?? item.updatedAtMs);

    return Material(
      color: isDark ? AppColors.darkSurface : AppColors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/noticias/${item.id}'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? AppColors.darkStroke : AppColors.stroke,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                Image.network(
                  item.imageUrl!,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.tagLabel}${date.isEmpty ? '' : ' · $date'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.goldDeep,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(item.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(item.summary, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
