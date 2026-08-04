import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/question_bank.dart';
import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/app_snackbars.dart';
import '../utils/session_launch.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/feature_access_badge.dart';

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
                  state.canAccessCases
                      ? 'Situaciones reales de colegio. Eliges cómo actuar y ves el debido proceso.'
                      : 'Vista previa del banco. Resolver casos requiere Premium '
                          '(candado en cada ficha).',
                  style: theme.textTheme.bodyLarge,
                ),
                if (!state.canAccessCases) ...[
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: FeatureAccessBadge(
                      level: FeatureAccessLevel.locked,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: () {
                    if (!state.canAccessCases) {
                      AppSnackbars.premiumLocked(
                        context,
                        'Casos de Aula es Premium.',
                      );
                      return;
                    }
                    final ok = state.startSession(
                      mode: SessionMode.practice,
                      count: 4,
                      casesOnly: true,
                    );
                    launchSessionOrPaywall(
                      context: context,
                      state: state,
                      started: ok,
                      route: '/practice',
                    );
                  },
                  icon: Icon(
                    state.canAccessCases
                        ? Icons.play_arrow_rounded
                        : Icons.lock_outline_rounded,
                  ),
                  label: Text(
                    state.canAccessCases
                        ? 'Practicar 4 casos'
                        : 'Desbloquear Casos · Premium',
                  ),
                ),
                const SizedBox(height: 18),
                Text('Banco de casos', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                ...cases.map((q) {
                  final locked = !state.canAccessCases;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Opacity(
                      opacity: locked ? 0.75 : 1,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isDark ? AppColors.darkSurface : AppColors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: locked
                                ? AppColors.gold.withValues(alpha: 0.5)
                                : theme.colorScheme.outline,
                          ),
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
                                if (locked) ...[
                                  const SizedBox(width: 8),
                                  const FeatureAccessBadge(
                                    level: FeatureAccessLevel.locked,
                                  ),
                                ],
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
                              child: TextButton.icon(
                                onPressed: () {
                                  if (locked) {
                                    AppSnackbars.premiumLocked(
                                      context,
                                      'Resolver casos es Premium.',
                                    );
                                    return;
                                  }
                                  final ok = state.startSingleQuestion(q);
                                  launchSessionOrPaywall(
                                    context: context,
                                    state: state,
                                    started: ok,
                                    route: '/practice',
                                  );
                                },
                                icon: Icon(
                                  locked
                                      ? Icons.lock_outline_rounded
                                      : Icons.play_arrow_rounded,
                                ),
                                label: Text(
                                  locked ? 'Premium' : 'Resolver caso',
                                ),
                              ),
                            ),
                          ],
                        ),
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
