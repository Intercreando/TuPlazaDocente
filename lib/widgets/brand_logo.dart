import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

/// Logo vectorial (SVG) de TuPlazaDocente — nítido en cualquier escala.
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.size = 52,
    this.asset = markAsset,
  });

  /// Solo el isotipo (libro + flama).
  static const markAsset = 'assets/brand/logo.svg';

  /// Logo completo con wordmark (requiere fuentes del SVG).
  static const fullAsset = 'assets/brand/logo2.svg';

  final double size;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => SizedBox(
        width: size,
        height: size,
        child: const ColoredBox(color: AppColors.mist),
      ),
    );
  }
}
