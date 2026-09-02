import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/reel_type.dart';

/// Una opción A–D del lienzo.
class ReelOptionRow extends StatelessWidget {
  const ReelOptionRow({
    super.key,
    required this.letter,
    required this.text,
    this.marked = false,
    this.dimmed = false,
  });

  final String letter;
  final String text;
  final bool marked;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final type = ReelType.of(context);
    final bg = marked ? AppColors.success : AppColors.white;
    final border = marked ? AppColors.canopy : AppColors.stroke;
    final ink = marked ? AppColors.white : AppColors.textPrimary;
    return Opacity(
      opacity: dimmed ? 0.38 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 18, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: marked ? AppColors.ink : AppColors.gold,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    letter,
                    style: type.letter.copyWith(
                      color: marked ? AppColors.white : AppColors.ink,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(text, style: type.option.copyWith(color: ink)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
