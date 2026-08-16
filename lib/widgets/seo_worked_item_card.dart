import 'package:flutter/material.dart';

import '../models/seo_landing_page.dart';
import '../theme/app_colors.dart';

const _letters = ['A', 'B', 'C', 'D', 'E', 'F'];

/// Ítem público: elige opción y ves el criterio (también queda en texto para SEO).
class SeoWorkedItemCard extends StatefulWidget {
  const SeoWorkedItemCard({
    super.key,
    required this.item,
    this.lockAfterChoice = true,
    this.forceReveal = false,
    this.onChosen,
  });

  final SeoLandingItem item;
  final bool lockAfterChoice;
  final bool forceReveal;
  final ValueChanged<int>? onChosen;

  @override
  State<SeoWorkedItemCard> createState() => _SeoWorkedItemCardState();
}

class _SeoWorkedItemCardState extends State<SeoWorkedItemCard> {
  int? _chosen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = widget.item;
    final revealed = widget.forceReveal || _chosen != null;
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.white;
    final stroke = isDark ? AppColors.darkStroke : AppColors.stroke;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: stroke),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(item.eyebrow, style: theme.textTheme.labelSmall),
            if (item.context.trim().isNotEmpty) ...[
              const SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkElevated : AppColors.mist,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(item.context, style: theme.textTheme.bodyMedium),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(item.stem, style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            for (var i = 0; i < item.options.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              _OptionTile(
                letter: i < _letters.length ? _letters[i] : '${i + 1}',
                label: item.options[i],
                selected: _chosen == i,
                showResult: revealed,
                isCorrect: i == item.correctIndex,
                onTap: (_chosen != null && widget.lockAfterChoice)
                    ? null
                    : () {
                        setState(() => _chosen = i);
                        widget.onChosen?.call(i);
                      },
              ),
            ],
            if (revealed) ...[
              const SizedBox(height: 16),
              Text('Criterio del ítem', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(item.theory, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(item.normative, style: theme.textTheme.bodyMedium),
              for (var i = 0; i < item.distractors.length; i++)
                if (i != item.correctIndex &&
                    (item.distractors[i] ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Por qué no ${_letters[i]}. ${item.distractors[i]}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
            ],
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.letter,
    required this.label,
    required this.selected,
    required this.showResult,
    required this.isCorrect,
    required this.onTap,
  });

  final String letter;
  final String label;
  final bool selected;
  final bool showResult;
  final bool isCorrect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    Color border = isDark ? AppColors.darkStroke : AppColors.stroke;
    Color bg = Colors.transparent;
    if (showResult && isCorrect) {
      border = AppColors.success;
      bg = AppColors.success.withValues(alpha: 0.12);
    } else if (showResult && selected && !isCorrect) {
      border = AppColors.danger;
      bg = AppColors.danger.withValues(alpha: 0.10);
    } else if (selected) {
      border = AppColors.canopy;
    }

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border, width: 1.4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  letter,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.canopy,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
