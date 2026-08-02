import 'package:flutter/material.dart';

/// Breakpoints de layout para experiencia premium en escritorio.
abstract final class LayoutBreakpoints {
  static const double tablet = 720;
  static const double desktop = 1024;
  static const double wide = 1280;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktop;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= wide;

  static bool isTabletUp(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  /// Ancho máximo del contenido editorial / hub.
  static double contentMaxWidth(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= wide) return 1240;
    if (w >= desktop) return 1120;
    return 860;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= wide) {
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 28);
    }
    if (w >= desktop) {
      return const EdgeInsets.symmetric(horizontal: 36, vertical: 24);
    }
    return const EdgeInsets.fromLTRB(20, 12, 20, 28);
  }
}
