import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/pwa_install_service.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/paid_traffic.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';
import '../widgets/concurso_phase_badge.dart';
import '../widgets/landing_credibility_sections.dart';
import '../widgets/landing_hero_visual.dart';
import '../widgets/legal_footer_links.dart';
import '../widgets/news_highlight_strip.dart';
import '../widgets/premium_chrome.dart';
import '../widgets/seo_guides_strip.dart';

/// Landing premium: hero editorial en desktop + secciones de confianza.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pwa = context.watch<PwaInstallService>();
    final isDark = theme.brightness == Brightness.dark;
    final desktop = LayoutBreakpoints.isDesktop(context);
    final wide = LayoutBreakpoints.isWide(context);

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: Column(
          children: [
            if (desktop) const LandingHeader(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxW = LayoutBreakpoints.contentMaxWidth(context);
                  final hPad = desktop ? (wide ? 48.0 : 36.0) : 22.0;

                  return SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxW),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: hPad,
                            vertical: desktop ? 8 : 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (desktop)
                                SizedBox(
                                  height: math.max(
                                    560.0,
                                    math.min(720.0, constraints.maxHeight - 24),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 11,
                                        child: _HeroCopy(
                                          pwa: pwa,
                                          showBrand: false,
                                          desktop: true,
                                        ),
                                      ),
                                      SizedBox(width: wide ? 56 : 40),
                                      const Expanded(
                                        flex: 9,
                                        child: LandingHeroVisual(),
                                      ),
                                    ],
                                  ),
                                )
                              else ...[
                                const BrandMark(),
                                const SizedBox(height: 28),
                                _HeroCopy(pwa: pwa, showBrand: false),
                                const SizedBox(height: 28),
                                const LandingHeroVisual(compact: true),
                              ],
                              SizedBox(height: desktop ? 32 : 40),
                              const NewsHighlightStrip(compact: true),
                              const SizedBox(height: 8),
                              const LandingCredibilitySections(),
                              const SizedBox(height: 28),
                              const SeoGuidesStrip(),
                              const SizedBox(height: 28),
                              const LegalFooterLinks(
                                compact: true,
                                prefix: 'Consulta nuestros',
                                showNews: true,
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.pwa,
    this.showBrand = true,
    this.desktop = false,
  });

  final PwaInstallService pwa;
  final bool showBrand;
  final bool desktop;

  Future<void> _install(BuildContext context) async {
    if (pwa.canInstall) {
      final ok = await pwa.promptInstall();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? 'Confirma en el diálogo del sistema. Luego busca el icono en tu inicio.'
                : pwa.fallbackInstallMessage,
          ),
        ),
      );
      return;
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(pwa.fallbackInstallMessage)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paid = PaidTraffic.isPaid;
    final gap = desktop ? 18.0 : 14.0;
    final titleStyle = desktop
        ? theme.textTheme.displayMedium
        : theme.textTheme.displaySmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showBrand) ...[const BrandMark(), const SizedBox(height: 28)],
        ConcursoPhaseBadge(showDetail: desktop),
        SizedBox(height: gap),
        Text(
              'No estudies más horas.\n'
              'Entrena inteligente y asegura tu plaza en propiedad.',
              style: titleStyle,
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 80.ms)
            .slideY(begin: 0.06, end: 0),
        SizedBox(height: gap),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: desktop ? 520 : double.infinity,
          ),
          child: Text(
            'El concurso docente no se pasa memorizando leyes, se pasa dominando '
            'la lógica de evaluación de la CNSC. Practica con casos de aula reales, '
            'domina la norma y entiende exactamente por qué fallan las respuestas '
            'incorrectas en sesiones de 10 minutos al día.',
            style: theme.textTheme.bodyLarge,
          ).animate().fadeIn(duration: 600.ms, delay: 160.ms),
        ),
        SizedBox(height: desktop ? 32 : 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.38),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: FilledButton.icon(
                style: AppButtonStyles.premiumCheckout(
                  textStyle: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.ink,
                  ),
                ),
                onPressed: () => context.go('/auth'),
                icon: const Icon(Icons.play_circle_filled_rounded),
                label: Text(
                  paid ? 'Haz tu diagnóstico inicial gratis' : 'Comenzar ahora',
                ),
              ),
            ),
            if (paid) ...[
              const SizedBox(height: 10),
              Text(
                '20 preguntas de diagnóstico. Luego ves tu mapa real. '
                'El simulacro cronometrado (Examen Real) es Premium.',
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (!paid) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  OutlinedButton(
                    onPressed: () => context.go('/onboarding'),
                    child: const Text('Continuar como invitado'),
                  ),
                  if (!desktop)
                    OutlinedButton.icon(
                      onPressed: () => _install(context),
                      icon: const Icon(Icons.download_for_offline_outlined),
                      label: const Text('Instalar en el inicio'),
                    ),
                ],
              ),
            ],
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 260.ms),
      ],
    );
  }
}
