import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/question_bank.dart';
import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';

/// Módulo Casos de Aula (situacional interactivo).
class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final cases = QuestionBank.caseStudies();
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Casos de Aula')),
      body: AtmosphericBackground(
        dark: isDark,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                Text(
                  'Situaciones reales de colegio. Eliges cómo actuar y ves el debido proceso.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: () {
                    state.startSession(
                      mode: SessionMode.practice,
                      count: 4,
                      casesOnly: true,
                    );
                    context.push('/practice');
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Entrenar 4 casos ahora'),
                ),
                const SizedBox(height: 18),
                Text('Banco de casos', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                ...cases.map((q) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: theme.colorScheme.outline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Chip(label: Text(q.pillar.label)),
                              const SizedBox(width: 8),
                              if (q.normativeRefs.isNotEmpty)
                                Flexible(
                                  child: Text(
                                    q.normativeRefs.first,
                                    style: theme.textTheme.labelMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            q.caseContext ?? q.stem,
                            style: theme.textTheme.titleSmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                state.startSingleQuestion(q);
                                context.push('/practice');
                              },
                              child: const Text('Resolver este caso'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
