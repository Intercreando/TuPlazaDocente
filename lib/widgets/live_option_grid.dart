import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/live_type.dart';

/// Cuatro opciones en 2×2. En 16:9 caben lado a lado y se leen en el televisor.
class LiveOptionGrid extends StatelessWidget {
  const LiveOptionGrid({
    super.key,
    required this.options,
    this.correctIndex,
    this.highlightedIndex,
    this.revealed = false,
  });

  final List<String> options;
  final int? correctIndex;
  final int? highlightedIndex;
  final bool revealed;

  static const letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final shown = options.take(4).toList();
    return Column(
      children: [
        for (var row = 0; row < 2; row++) ...[
          if (row > 0) const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                for (var col = 0; col < 2; col++) ...[
                  if (col > 0) const SizedBox(width: 12),
                  Expanded(
                    child: _LiveOptionTile(
                      index: row * 2 + col,
                      text: shown.length > row * 2 + col
                          ? shown[row * 2 + col]
                          : '',
                      correctIndex: correctIndex,
                      highlightedIndex: highlightedIndex,
                      revealed: revealed,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _LiveOptionTile extends StatelessWidget {
  const _LiveOptionTile({
    required this.index,
    required this.text,
    required this.correctIndex,
    required this.highlightedIndex,
    required this.revealed,
  });

  final int index;
  final String text;
  final int? correctIndex;
  final int? highlightedIndex;
  final bool revealed;

  @override
  Widget build(BuildContext context) {
    final type = LiveType.of(context);
    final marked = revealed && index == correctIndex;
    final discussed = !revealed && index == highlightedIndex;
    final dimmed = revealed && index != correctIndex;
    final bg = marked
        ? AppColors.success
        : discussed
        ? AppColors.gold
        : AppColors.white;
    final border = marked
        ? AppColors.canopy
        : discussed
        ? AppColors.goldDeep
        : AppColors.stroke;
    final ink = marked || discussed ? AppColors.ink : AppColors.textPrimary;
    final letterBg = marked
        ? AppColors.ink
        : discussed
        ? AppColors.ink
        : AppColors.gold;
    final letterColor = marked || discussed ? AppColors.white : AppColors.ink;

    return Opacity(
      opacity: dimmed ? 0.4 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: letterBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Text(
                    index < LiveOptionGrid.letters.length
                        ? LiveOptionGrid.letters[index]
                        : '${index + 1}',
                    style: type.letter.copyWith(color: letterColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: type.option.copyWith(
                    color: marked ? AppColors.white : ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
