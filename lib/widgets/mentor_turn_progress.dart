import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Total de turnos de una sesión (mismo contrato que el backend).
const int kMentorTurnTotal = 8;

/// «Turno N de 8» con puntos: llenos = primario, el resto gris tenue.
class MentorTurnProgress extends StatelessWidget {
  const MentorTurnProgress({super.key, required this.currentTurn});

  final int currentTurn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final clamped = currentTurn.clamp(0, kMentorTurnTotal);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Column(
        children: [
          Text(
            'Turno $clamped de $kMentorTurnTotal',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 1; i <= kMentorTurnTotal; i++) ...[
                if (i > 1) const SizedBox(width: 6),
                _TurnDot(
                  filled: i <= clamped,
                  fill: scheme.primary,
                  empty: AppColors.textMuted.withValues(alpha: 0.35),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TurnDot extends StatelessWidget {
  const _TurnDot({
    required this.filled,
    required this.fill,
    required this.empty,
  });

  final bool filled;
  final Color fill;
  final Color empty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? fill : empty,
      ),
    );
  }
}
