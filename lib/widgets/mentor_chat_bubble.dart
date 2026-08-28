import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/ai_bold_markdown.dart';

/// Burbuja de la charla guiada (mentor o docente).
class MentorChatBubble extends StatelessWidget {
  const MentorChatBubble({
    super.key,
    required this.fromMentor,
    required this.text,
  });

  final bool fromMentor;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final bg = fromMentor
        ? (dark ? AppColors.darkElevated : AppColors.mist)
        : (dark ? AppColors.inkSoft : AppColors.ink);
    final align = fromMentor ? Alignment.centerLeft : Alignment.centerRight;
    return Align(
      alignment: align,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: fromMentor
                ? _MentorMarkdown(text: text)
                : Text(
                    text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _MentorMarkdown extends StatelessWidget {
  const _MentorMarkdown({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base = theme.textTheme.bodyMedium;
    final emphasis = theme.textTheme.labelLarge;
    final spans = parseAiBoldMarkdown(text);
    return Text.rich(
      TextSpan(
        children: [
          for (final span in spans)
            TextSpan(text: span.text, style: span.bold ? emphasis : base),
        ],
      ),
    );
  }
}
