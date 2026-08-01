import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/pwa_install_service.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';

/// Primera vista: marca hero + CTA + instalar PWA.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pwa = context.watch<PwaInstallService>();
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 900;

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 40 : 22,
                  vertical: 18,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 36,
                    maxWidth: 1100,
                  ),
                  child: Center(
                    child: isWide
                        ? SizedBox(
                            height: math.max(560.0, constraints.maxHeight - 36),
                            child: Row(
                              children: [
                                Expanded(child: _HeroCopy(pwa: pwa)),
                                const SizedBox(width: 36),
                                Expanded(child: _HeroVisual(theme: theme)),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BrandMark(),
                              const SizedBox(height: 28),
                              _HeroCopy(pwa: pwa, showBrand: false),
                              const SizedBox(height: 28),
                              SizedBox(
                                height: 360,
                                child: _HeroVisual(theme: theme),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.pwa, this.showBrand = true});

  final PwaInstallService pwa;
  final bool showBrand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showBrand) ...[
          const BrandMark(),
          const SizedBox(height: 28),
        ],
        Text(
          'Entrena como se piensa\nel concurso, no como se vende.',
          style: theme.textTheme.displaySmall,
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 80.ms)
            .slideY(begin: 0.06, end: 0),
        const SizedBox(height: 14),
        Text(
          'Microlearning táctico para CNSC/ICFES: feedback pedagógico, '
          'radar de competencias y simulacros con control de tiempo.',
          style: theme.textTheme.bodyLarge,
        ).animate().fadeIn(duration: 600.ms, delay: 160.ms),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () => context.go('/auth'),
              child: const Text('Empezar ahora'),
            ),
            OutlinedButton(
              onPressed: () => context.go('/onboarding'),
              child: const Text('Continuar como invitado'),
            ),
            OutlinedButton.icon(
              onPressed: pwa.canInstall
                  ? () async {
                      final ok = await pwa.promptInstall();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            ok
                                ? 'Instalación iniciada. Busca el icono en tu inicio.'
                                : pwa.iosHintVisible
                                    ? 'En iPhone: Compartir → Añadir a pantalla de inicio.'
                                    : 'Si no aparece el diálogo, usa el menú del navegador → Instalar app.',
                          ),
                        ),
                      );
                    }
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            pwa.isStandalone
                                ? 'Ya estás en modo app instalada.'
                                : pwa.iosHintVisible
                                    ? 'En iPhone: Compartir → Añadir a pantalla de inicio.'
                                    : 'Abre el menú del navegador y elige “Instalar app” o “Instalar en el inicio”.',
                          ),
                        ),
                      );
                    },
              icon: const Icon(Icons.download_for_offline_outlined),
              label: const Text('Instalar en el inicio'),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 260.ms),
        const SizedBox(height: 18),
        Text(
          'Gratis: reto diario de 5 preguntas · Premium: banco ilimitado y simulacros.',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
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
            right: -30,
            bottom: -20,
            child: Icon(
              Icons.school_rounded,
              size: 220,
              color: AppColors.white.withValues(alpha: 0.06),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TuPlazaDocente',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sesiones de 10–15 minutos.\nExplicaciones que enseñan el criterio del ítem.',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.92),
                  ),
                ),
                const Spacer(),
                _MetricChip(label: 'Racha', value: 'Día 1'),
                const SizedBox(height: 10),
                _MetricChip(label: 'Foco hoy', value: 'Evaluación formativa'),
                const SizedBox(height: 10),
                _MetricChip(label: 'Modo', value: 'Práctica táctica'),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
