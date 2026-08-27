import 'package:flutter/material.dart';

import '../models/question.dart';
import '../services/ai_explain_service.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/ai_bold_markdown.dart';

/// Tutor de caso (Premium): CTA oro + icono de tutor.
class AiExplainPanel extends StatefulWidget {
  const AiExplainPanel({
    super.key,
    required this.question,
    required this.chosenIndex,
  });

  final Question question;
  final int chosenIndex;

  @override
  State<AiExplainPanel> createState() => _AiExplainPanelState();
}

class _AiExplainPanelState extends State<AiExplainPanel> {
  final _service = AiExplainService();
  bool _loading = false;
  String? _text;
  String? _error;
  int? _remaining;

  Future<void> _ampliar() async {
    if (_loading || _text != null) return;
    _loading = true;
    setState(() => _error = null);
    try {
      final result = await _service.explainWrongChoice(
        question: widget.question,
        chosenIndex: widget.chosenIndex,
      );
      if (!mounted) return;
      setState(() {
        _loading = false;
        _text = result.text;
        _remaining = result.remaining;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst(RegExp(r'^Exception: '), '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkElevated : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gold, width: 1.4),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _TutorMark(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.goldDeep,
                          ),
                        ),
                        Text(
                          'Tutor Inteligente de Caso',
                          style: theme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _remaining == null
                    ? 'Si fallaste, el tutor contrasta tu opción con la exigida. 8 al día.'
                    : 'Te quedan $_remaining de 8 hoy.',
                style: theme.textTheme.bodySmall,
              ),
              if (_text == null) ...[
                const SizedBox(height: 12),
                FilledButton.icon(
                  style: AppButtonStyles.filledOnBrand(completed: false),
                  onPressed: _loading ? null : _ampliar,
                  icon: Icon(
                    _loading
                        ? Icons.hourglass_top_rounded
                        : Icons.auto_stories_rounded,
                  ),
                  label: Text(_loading ? 'Redactando…' : 'Ampliar explicación'),
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
              if (_text != null) ...[
                const SizedBox(height: 12),
                _AiExplainBody(text: _text!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TutorMark extends StatelessWidget {
  const _TutorMark();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.school_rounded, color: AppColors.gold),
      ),
    );
  }
}

class _AiExplainBody extends StatelessWidget {
  const _AiExplainBody({required this.text});

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
