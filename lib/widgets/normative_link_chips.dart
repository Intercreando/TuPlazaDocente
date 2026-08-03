import 'package:flutter/material.dart';
import '../config/normative_links.dart';
import '../models/question.dart';
import '../theme/app_colors.dart';
import '../utils/open_external_url.dart';


/// Chips bajo la explicación para abrir la norma o guía oficial en la web.
class NormativeLinkChips extends StatelessWidget {
  const NormativeLinkChips({super.key, required this.question});

  final Question question;

  Future<void> _open(BuildContext context, NormativeSource source) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final ok = await openExternalUrl(source.uri.toString());
      if (!ok && context.mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('No pudimos abrir ${source.label}. Intenta de nuevo.'),
          ),
        );
      }
    } catch (_) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'No pudimos abrir el documento oficial de ${source.label}.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sources = NormativeLinks.forQuestion(question);
    if (sources.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Consultar norma oficial',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final source in sources)
              ActionChip(
                avatar: Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.gold
                      : AppColors.ink,
                ),
                label: Text(source.label),
                onPressed: () => _open(context, source),
              ),
          ],
        ),
      ],
    );
  }
}
