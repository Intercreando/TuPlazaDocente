import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/wompi_checkout.dart';

/// Bloquea justificación y respuesta correcta en el plan Gratis.
class LockedExplanationPanel extends StatefulWidget {
  const LockedExplanationPanel({super.key, this.compact = false});

  /// En resultados: sin barras difuminadas; el puntaje ya está visible.
  final bool compact;

  @override
  State<LockedExplanationPanel> createState() => _LockedExplanationPanelState();
}

class _LockedExplanationPanelState extends State<LockedExplanationPanel> {
  bool _busy = false;

  Future<void> _unlock() async {
    if (_busy) return;
    setState(() => _busy = true);
    await openWompiCheckout(context);
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mist.withValues(alpha: dark ? 0.12 : 1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.canopy.withValues(alpha: 0.35)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!widget.compact)
            Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Justificación normativa y teórica',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 10),
                        _PlaceholderBar(widthFactor: 0.92, dark: dark),
                        const SizedBox(height: 8),
                        _PlaceholderBar(widthFactor: 0.78, dark: dark),
                        const SizedBox(height: 8),
                        _PlaceholderBar(widthFactor: 0.84, dark: dark),
                        const SizedBox(height: 14),
                        _PlaceholderBar(widthFactor: 0.62, dark: dark),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ColoredBox(
                    color: (dark ? AppColors.darkBg : AppColors.parchment)
                        .withValues(alpha: 0.28),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      Icons.lock_rounded,
                      color: dark ? AppColors.gold : AppColors.inkSoft,
                    ),
                  ),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'La respuesta correcta y el porqué (norma y teoría) son Premium.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  style: AppButtonStyles.premiumCheckout(
                    textStyle: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.ink,
                    ),
                  ),
                  onPressed: _busy ? null : _unlock,
                  child: Text(
                    _busy
                        ? 'Abriendo el pago…'
                        : 'Desbloquea las explicaciones y casos de área con Premium',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderBar extends StatelessWidget {
  const _PlaceholderBar({required this.widthFactor, required this.dark});

  final double widthFactor;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: Alignment.centerLeft,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          color: dark ? AppColors.darkElevated : AppColors.stroke,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
