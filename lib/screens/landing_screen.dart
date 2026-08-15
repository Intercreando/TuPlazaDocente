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
import '../widgets/brand_logo.dart';
import '../widgets/brand_mark.dart';
import '../widgets/concurso_phase_badge.dart';
import '../widgets/landing_credibility_sections.dart';
import '../widgets/legal_footer_links.dart';
import '../widgets/news_highlight_strip.dart';
import '../widgets/premium_chrome.dart';

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
                                    math.min(
                                      720.0,
                                      constraints.maxHeight - 24,
                                    ),
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
                                      Expanded(
                                        flex: 9,
                                        child: _HeroVisual(
                                          theme: theme,
                                          desktop: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else ...[
                                const BrandMark(),
                                const SizedBox(height: 28),
                                _HeroCopy(pwa: pwa, showBrand: false),
                                const SizedBox(height: 28),
                                _HeroVisual(theme: theme, compact: true),
                              ],
                              SizedBox(height: desktop ? 32 : 40),
                              const NewsHighlightStrip(compact: true),
                              const SizedBox(height: 8),
                              const LandingCredibilitySections(),
                              const SizedBox(height: 28),
                              const LegalFooterLinks(
                                compact: true,
                                prefix: 'Consulta nuestros',
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pwa.fallbackInstallMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paid = PaidTraffic.isPaid;
    final gap = desktop ? 18.0 : 14.0;
    final titleStyle =
        desktop ? theme.textTheme.displayMedium : theme.textTheme.displaySmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showBrand) ...[
          const BrandMark(),
          const SizedBox(height: 28),
        ],
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
          constraints: BoxConstraints(maxWidth: desktop ? 520 : double.infinity),
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
                  paid
                      ? 'Haz tu diagnóstico inicial gratis'
                      : 'Comenzar ahora',
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

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({
    required this.theme,
    this.compact = false,
    this.desktop = false,
  });

  final ThemeData theme;
  final bool compact;
  final bool desktop;

  @override
  Widget build(BuildContext context) {
    final pad = compact ? 18.0 : (desktop ? 32.0 : 28.0);
    final markSize = compact ? 48.0 : (desktop ? 72.0 : 64.0);
    final watermark = compact ? 140.0 : (desktop ? 280.0 : 240.0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(compact ? 22 : 28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.ink, AppColors.inkSoft, AppColors.canopy],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: compact ? -24 : -10,
            bottom: compact ? -28 : -10,
            child: Opacity(
              opacity: 0.12,
              child: BrandLogo(size: watermark),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(compact ? 14 : 18),
                  child: BrandLogo(size: markSize),
                ),
                SizedBox(height: compact ? 10 : 14),
                Text(
                  'TuPlazaDocente',
                  style: (compact
                          ? theme.textTheme.titleLarge
                          : theme.textTheme.headlineMedium)
                      ?.copyWith(color: AppColors.gold),
                ),
                const SizedBox(height: 6),
                Text(
                  compact
                      ? 'Sesiones de 10–15 min con explicaciones del criterio del ítem.'
                      : 'Sesiones de 10–15 minutos.\nExplicaciones que enseñan el criterio del ítem.',
                  style: (compact
                          ? theme.textTheme.bodyMedium
                          : theme.textTheme.titleMedium)
                      ?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.92),
                  ),
                ),
                if (compact)
                  const SizedBox(height: 16)
                else
                  const Spacer(),
                const _MetricChip(label: 'Racha', value: 'Día 1'),
                const SizedBox(height: 8),
                const _MetricChip(label: 'Foco hoy', value: 'Evaluación formativa'),
                const SizedBox(height: 8),
                const _MetricChip(label: 'Modo', value: 'Práctica táctica'),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 700.ms, delay: 120.ms).scale(
          begin: const Offset(0.98, 0.98),
          end: const Offset(1, 1),
        );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
