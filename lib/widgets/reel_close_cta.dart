import 'package:flutter/material.dart';

import '../data/reel_studio_pack.dart';
import '../theme/app_colors.dart';
import '../theme/reel_type.dart';

/// Justificación corta al revelar la letra.
class ReelRevealClose extends StatelessWidget {
  const ReelRevealClose({super.key, required this.why});

  final String why;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return Text(why, style: type.cta, textAlign: TextAlign.center);
  }
}

/// Barra de marca del cierre: sitio + simulacros gratis.
class ReelCloseBrandBar extends StatelessWidget {
  const ReelCloseBrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            Text(
              ReelStudioPack.site,
              style: type.ctaBar,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              ReelStudioPack.closeAction,
              style: type.brand,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
