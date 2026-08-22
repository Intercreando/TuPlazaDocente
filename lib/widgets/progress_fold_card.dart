import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Sección plegable de Progreso: se ve como tarjeta tocable, no como fila de lista.
class ProgressFoldCard extends StatefulWidget {
  const ProgressFoldCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.child,
    this.initiallyExpanded = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Widget child;
  final bool initiallyExpanded;

  @override
  State<ProgressFoldCard> createState() => _ProgressFoldCardState();
}

class _ProgressFoldCardState extends State<ProgressFoldCard> {
  late bool _open = widget.initiallyExpanded;

  void _toggle() => setState(() => _open = !_open);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.white;
    final border = _open
        ? widget.accent.withValues(alpha: isDark ? 0.55 : 0.45)
        : theme.colorScheme.outline;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: _open ? 1.4 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _toggle,
                borderRadius: _open
                    ? const BorderRadius.vertical(top: Radius.circular(20))
                    : BorderRadius.circular(20),
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed) ||
                      states.contains(WidgetState.hovered)) {
                    return widget.accent.withValues(alpha: isDark ? 0.12 : 0.08);
                  }
                  return null;
                }),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: widget.accent.withValues(
                            alpha: isDark ? 0.18 : 0.14,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(widget.icon, color: widget.accent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title, style: theme.textTheme.titleSmall),
                            const SizedBox(height: 2),
                            Text(
                              widget.subtitle,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: _open ? 0.5 : 0,
                        duration: const Duration(milliseconds: 220),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: widget.accent.withValues(
                              alpha: isDark ? 0.16 : 0.10,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.expand_more,
                            color: widget.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity, height: 0),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                child: widget.child,
              ),
              crossFadeState: _open
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 220),
              sizeCurve: Curves.easeOut,
            ),
          ],
        ),
      ),
    );
  }
}
