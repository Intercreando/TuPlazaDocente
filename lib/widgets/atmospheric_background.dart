import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Fondo con atmósfera (gradientes suaves + patrón) sin aplanar la UI.
class AtmosphericBackground extends StatelessWidget {
  const AtmosphericBackground({
    super.key,
    required this.child,
    this.dark = false,
  });

  final Widget child;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final top = dark ? AppColors.darkBg : AppColors.parchment;
    final mid = dark ? AppColors.darkSurface : AppColors.mist;
    final accent = dark
        ? AppColors.canopy.withValues(alpha: 0.35)
        : AppColors.seafoam.withValues(alpha: 0.28);
    final gold = dark
        ? AppColors.gold.withValues(alpha: 0.12)
        : AppColors.gold.withValues(alpha: 0.18);

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [top, mid, top],
              stops: const [0, 0.45, 1],
            ),
          ),
        ),
        Positioned(
          top: -80,
          right: -40,
          child: _Blob(color: accent, size: 260),
        ),
        Positioned(
          bottom: -60,
          left: -50,
          child: _Blob(color: gold, size: 220),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(
              color: (dark ? AppColors.darkStroke : AppColors.stroke)
                  .withValues(alpha: 0.35),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const step = 28.0;
    for (var x = 0.0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Suaviza con un velo radial.
    final rect = Offset.zero & size;
    final wash = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.2, -0.4),
        radius: 1.1,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          color.withValues(alpha: 0.08),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, wash);

    // Marca sutil de trayectoria (arco).
    final arcPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width * 0.8, size.height * 0.2), radius: 90),
      math.pi * 0.2,
      math.pi * 0.9,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.color != color;
}
