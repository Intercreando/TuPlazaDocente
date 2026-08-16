import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/seo_landing_catalog.dart';
import '../models/seo_landing_page.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/seo_document.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';
import '../widgets/legal_footer_links.dart';
import '../widgets/seo_landing_cta.dart';
import '../widgets/seo_worked_item_card.dart';

/// Landing SEO dentro de la PWA (misma fuente que el HTML estático).
class SeoLandingScreen extends StatefulWidget {
  const SeoLandingScreen({super.key, required this.pageId});

  final String pageId;

  @override
  State<SeoLandingScreen> createState() => _SeoLandingScreenState();
}

class _SeoLandingScreenState extends State<SeoLandingScreen> {
  SeoLandingPage? _page;
  Object? _error;
  final Map<String, int> _choices = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final page = await SeoLandingCatalog.byId(widget.pageId);
      if (!mounted) return;
      setState(() {
        _page = page;
        _error = page == null ? 'missing' : null;
      });
      if (page != null) {
        SeoDocument.apply(
          title: page.title,
          description: page.description,
          canonical: 'https://www.tuplazadocente.com${page.path}',
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loggedIn = !context.watch<AppState>().isAnonymousUser;
    final page = _page;

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: page == null
            ? Center(
                child: _error == null
                    ? const CircularProgressIndicator(color: AppColors.canopy)
                    : Text(
                        'No pudimos cargar esta guía. Vuelve al inicio.',
                        style: theme.textTheme.bodyLarge,
                      ),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: const BrandMark(compact: true),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 36),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 760),
                          child: _Body(
                            page: page,
                            loggedIn: loggedIn,
                            choices: _choices,
                            onChosen: (id, i) =>
                                setState(() => _choices[id] = i),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.page,
    required this.loggedIn,
    required this.choices,
    required this.onChosen,
  });

  final SeoLandingPage page;
  final bool loggedIn;
  final Map<String, int> choices;
  final void Function(String id, int index) onChosen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final answered = page.items.every((i) => choices.containsKey(i.id));
    var hits = 0;
    if (answered) {
      for (final item in page.items) {
        if (choices[item.id] == item.correctIndex) hits += 1;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(page.kicker, style: theme.textTheme.labelSmall),
        const SizedBox(height: 8),
        Text(page.h1, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 12),
        Text(page.lead, style: theme.textTheme.bodyLarge),
        if (page.isQuiz && answered) ...[
          const SizedBox(height: 18),
          Text(
            'Tu puntaje en esta muestra: $hits / ${page.items.length}.',
            style: theme.textTheme.titleSmall,
          ),
        ],
        const SizedBox(height: 22),
        for (final item in page.items) ...[
          SeoWorkedItemCard(
            item: item,
            forceReveal: page.isQuiz && answered,
            lockAfterChoice: true,
            onChosen: (i) => onChosen(item.id, i),
          ),
          const SizedBox(height: 16),
        ],
        SeoLandingCta(page: page, loggedIn: loggedIn),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final link in page.related)
              ActionChip(
                label: Text(link.label),
                onPressed: () => context.go(link.href),
              ),
          ],
        ),
        const SizedBox(height: 28),
        Text('Preguntas frecuentes', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        for (final faq in page.faq)
          ExpansionTile(
            title: Text(faq.question, style: theme.textTheme.titleSmall),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Text(faq.answer, style: theme.textTheme.bodyMedium),
                ),
              ),
            ],
          ),
        const SizedBox(height: 18),
        Text(
          'TuPlazaDocente es un entrenador independiente. No somos la CNSC, '
          'el ICFES ni el Ministerio de Educación. Verifica el acuerdo oficial '
          'de tu convocatoria.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        const LegalFooterLinks(compact: true, prefix: 'Consulta'),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => context.go(loggedIn ? '/app' : '/'),
          child: const Text('Volver al inicio'),
        ),
      ],
    );
  }
}
