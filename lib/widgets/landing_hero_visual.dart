import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';

/// Foto del hero: llena el recuadro (móvil 3:4, escritorio a altura completa).
class LandingHeroVisual extends StatelessWidget {
  const LandingHeroVisual({super.key, this.compact = false});

  static const assetPath = 'assets/landing/landing-hero-triunfo-lagrimas.jpg';

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(compact ? 22 : 28);
    final photo = _HeroPhotoFrame(radius: radius, compact: compact);

    if (compact) {
      return AspectRatio(aspectRatio: 3 / 4, child: photo);
    }
    return photo;
  }
}

class _HeroPhotoFrame extends StatelessWidget {
  const _HeroPhotoFrame({required this.radius, required this.compact});

  final BorderRadius radius;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    return Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: AppColors.gold.withValues(alpha: dark ? 0.55 : 0.42),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink.withValues(alpha: dark ? 0.45 : 0.16),
                blurRadius: compact ? 18 : 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: AppColors.ink),
              Image.asset(
                LandingHeroVisual.assetPath,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.12),
                filterQuality: FilterQuality.medium,
                cacheWidth: 900,
                gaplessPlayback: true,
                semanticLabel:
                    'Docente celebrando el nombramiento en propiedad '
                    'en el concurso docente.',
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(color: AppColors.ink);
                },
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      AppColors.ink,
                    ],
                    stops: [0, 0.42, 1],
                  ),
                ),
              ),
              Positioned(
                left: compact ? 16 : 20,
                right: compact ? 16 : 20,
                bottom: compact ? 16 : 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 36, height: 2, color: AppColors.gold),
                    SizedBox(height: compact ? 8 : 10),
                    Text(
                      'Un día será tu turno de alzar los brazos.',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '¡Comienza a prepararte hoy!',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 700.ms, delay: 120.ms)
        .scale(begin: const Offset(0.98, 0.98), end: const Offset(1, 1));
  }
}
