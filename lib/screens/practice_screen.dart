import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/normative_link_chips.dart';
import '../widgets/option_tile.dart';
import '../widgets/question_case_context.dart';

/// Modo práctica / racha / diagnóstico con explicación inmediata.
class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final question = state.currentQuestion;

    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Práctica')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.lastError ?? 'No hay una sesión activa.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go('/app'),
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final letters = ['A', 'B', 'C', 'D'];
    final progress = (state.currentIndex + 1) / state.currentQuestions.length;
    final title = switch (state.currentMode) {
      SessionMode.dailyStreak => 'Reto diario',
      SessionMode.diagnostic => 'Diagnóstico inicial',
      _ => 'Modo práctica',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            final paidGate = state.needsPaidDiagnostic;
            if (!paidGate) {
              state.clearSession();
            }
            context.go(paidGate ? '/diagnostico' : '/app');
          },
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(value: progress, minHeight: 8),
              ),
              const SizedBox(height: 10),
              Text(
                'Pregunta ${state.currentIndex + 1} de ${state.currentQuestions.length}',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text(question.pillar.label)),
                  Chip(label: Text(question.topic)),
                  if (question.isCaseStudy)
                    const Chip(
                      avatar: Icon(Icons.apartment_outlined, size: 16),
                      label: Text('Caso de aula'),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              QuestionCaseContext(question: question),
              Text(question.stem, style: theme.textTheme.titleLarge)
                  .animate(key: ValueKey(question.id))
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.04, end: 0),
              const SizedBox(height: 18),
              ...List.generate(question.options.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OptionTile(
                    letter: letters[i],
                    label: question.options[i],
                    selected: state.selectedOption == i,
                    showResult: state.revealed,
                    isCorrect: i == question.correctIndex,
                    onTap: () => state.selectOption(i),
                  ),
                );
              }),
              if (state.revealed) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.mist.withValues(
                      alpha: theme.brightness == Brightness.dark ? 0.12 : 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.canopy.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cerebro pedagógico TuPlazaDocente',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${question.moduleLabel} · ${question.subtopicLabel}',
                        style: theme.textTheme.labelMedium,
                      ),
                      if (question.knowledgeTags.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          question.knowledgeTags
                              .map((t) => t.display)
                              .join(' · '),
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                      if (question.normativeJustification != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Justificación normativa',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          question.normativeJustification!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                      if (question.theoreticalJustification != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Justificación teórica',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          question.theoreticalJustification!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                      if (question.normativeJustification == null &&
                          question.theoreticalJustification == null) ...[
                        const SizedBox(height: 8),
                        Text(
                          question.explanation,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                      if (state.selectedOption != null &&
                          question.distractorAnalysis[state.selectedOption!] !=
                              null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Por qué tu opción no es la mejor',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          question.distractorAnalysis[state.selectedOption!]!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                      if (question.referenceLabels.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Referentes: ${question.referenceLabels.join(' · ')}',
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                      const SizedBox(height: 12),
                      NormativeLinkChips(question: question),
                    ],
                  ),
                ).animate().fadeIn(duration: 280.ms),
              ],
              const SizedBox(height: 20),
              FilledButton(
                onPressed: state.selectedOption == null
                    ? null
                    : () async {
                        if (!state.revealed) {
                          state.revealPracticeAnswer();
                          return;
                        }
                        final finished = await state.submitAndAdvance();
                        if (!context.mounted) return;
                        if (finished) context.go('/results');
                      },
                child: Text(
                  state.revealed ? 'Continuar' : 'Comprobar respuesta',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
