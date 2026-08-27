import 'package:flutter/material.dart';

import '../models/question.dart';
import '../services/tutor_remate_service.dart';
import '../theme/app_colors.dart';
import '../utils/ai_bold_markdown.dart';

/// 1 o 2 réplicas Vertex tras elegir postura. Si Gemini falla, el caso sigue.
class TutorRematePanel extends StatefulWidget {
  const TutorRematePanel({
    super.key,
    required this.question,
    required this.chosenIndex,
    required this.enabled,
    this.disabledReason,
  });

  final Question question;
  final int chosenIndex;
  final bool enabled;
  final String? disabledReason;

  @override
  State<TutorRematePanel> createState() => _TutorRematePanelState();
}

class _TutorRematePanelState extends State<TutorRematePanel> {
  final _service = TutorRemateService();
  final _replies = <_RemateReply>[];
  final _attempted = <TutorRemateChip>{};
  TutorRemateChip? _loadingChip;
  String? _error;
  var _busy = false;

  static const _maxRemates = 2;

  Future<void> _ask(TutorRemateChip chip) async {
    if (!widget.enabled || _busy) return;
    if (_replies.length >= _maxRemates) return;
    if (_attempted.contains(chip)) return;
    _busy = true;
    _attempted.add(chip);
    setState(() {
      _loadingChip = chip;
      _error = null;
    });
    try {
      final text = await _service.remate(
        question: widget.question,
        chosenIndex: widget.chosenIndex,
        chip: chip,
      );
      if (!mounted) return;
      setState(() {
        _busy = false;
        _loadingChip = null;
        _replies.add(_RemateReply(chip: chip, text: text));
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _loadingChip = null;
        _error = e.toString().replaceFirst(RegExp(r'^Exception: '), '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final leftover = _maxRemates - _replies.length;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: dark ? AppColors.darkElevated : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold, width: 1.4),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.goldDeep,
              ),
            ),
            Text('Un remate del tutor', style: theme.textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(
              leftover <= 0
                  ? 'Ya usaste los 2 remates de esta sesión.'
                  : 'Opcional. El caso de arriba no depende de esto. '
                      'Te quedan $leftover de $_maxRemates hoy.',
              style: theme.textTheme.bodySmall,
            ),
            if (!widget.enabled && widget.disabledReason != null) ...[
              const SizedBox(height: 8),
              Text(widget.disabledReason!, style: theme.textTheme.bodySmall),
            ],
            if (leftover > 0 && widget.enabled) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final chip in TutorRemateChip.values)
                    if (!_attempted.contains(chip))
                      ActionChip(
                        avatar: _loadingChip == chip
                            ? const Icon(Icons.hourglass_top_rounded)
                            : const Icon(Icons.auto_stories_rounded),
                        label: Text(chip.label),
                        onPressed: _busy ? null : () => _ask(chip),
                      ),
                ],
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.danger,
                ),
              ),
            ],
            for (final reply in _replies) ...[
              const SizedBox(height: 12),
              Text(reply.chip.label, style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              _RemateMarkdown(text: reply.text),
            ],
            if (_loadingChip != null) ...[
              const SizedBox(height: 8),
              Text('Redactando…', style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}

class _RemateReply {
  const _RemateReply({required this.chip, required this.text});
  final TutorRemateChip chip;
  final String text;
}

class _RemateMarkdown extends StatelessWidget {
  const _RemateMarkdown({required this.text});

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
