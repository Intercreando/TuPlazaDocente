import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/progress_today_action.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/cnsc_score_predictor.dart';
import '../widgets/competency_radar.dart';
import '../widgets/tag_mastery_map.dart';
import '../widgets/tmo_dashboard.dart';

/// Progreso: corte CNSC + una acción. El detalle queda en acordeones.
class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);
    final profile = state.profile;
    final isDark = theme.brightness == Brightness.dark;
    final masteryRows = TagMasteryService.buildMap(profile);
    final recommended = TagMasteryService.recommendedToday(profile);
    final expandDetail = LayoutBreakpoints.isTabletUp(context);

    return AtmosphericBackground(
      dark: isDark,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: ListView(
              padding: LayoutBreakpoints.pagePadding(context),
              children: [
                Text('Tu progreso', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(
                  'Una cifra, una acción. El detalle está más abajo si lo necesitas.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                const CnscScorePredictor(),
                const SizedBox(height: 16),
                const ProgressTodayAction(),
                const SizedBox(height: 22),
                _ProgressFold(
                  title: 'Pilares',
                  subtitle: 'Fortalezas y el punto más flojo',
                  initiallyExpanded: expandDetail,
                  child: CompetencyRadar(
                    profile: profile,
                    compact: true,
                  ),
                ),
                _ProgressFold(
                  title: 'Temas a reforzar',
                  subtitle: 'Aciertos por norma y teoría',
                  child: TagMasteryMap(
                    rows: masteryRows,
                    compact: true,
                    maxItems: 6,
                    recommendedCode: recommended?.code.name,
                  ),
                ),
                _ProgressFold(
                  title: 'Velocidad (TMO)',
                  subtitle: 'Tiempo medio por pregunta',
                  child: const TmoDashboardPanel(compact: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressFold extends StatelessWidget {
  const _ProgressFold({
    required this.title,
    required this.subtitle,
    required this.child,
    this.initiallyExpanded = false,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 16),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        children: [child],
      ),
    );
  }
}
