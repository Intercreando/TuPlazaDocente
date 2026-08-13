import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/concurso_scoring_config.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';

/// Bento grid: radiografía del concurso (Landing). Responsive PC / móvil.
class ConcursoBentoGrid extends StatelessWidget {
  const ConcursoBentoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final desktop = LayoutBreakpoints.isDesktop(context);
    final tablet = LayoutBreakpoints.isTabletUp(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          ConcursoScoringConfig.sectionTitle,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          ConcursoScoringConfig.sectionSubtitle,
          style: theme.textTheme.bodyLarge,
        ),
        SizedBox(height: desktop ? 28 : 20),
        LayoutBuilder(
          builder: (context, constraints) {
            if (tablet) {
              return _DesktopBento(width: constraints.maxWidth);
            }
            return const _MobileBento();
          },
        ),
        const SizedBox(height: 14),
        Text(
          ConcursoScoringConfig.disclaimer,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

enum _BadgeKind { eliminatory, classificatory, goal }

class _DesktopBento extends StatelessWidget {
  const _DesktopBento({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    const gap = 14.0;
    final wide = width >= 980;

    return Column(
      children: [
        SizedBox(
          height: wide ? 300 : 288,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: wide ? 7 : 6,
                child: const _BentoTile(
                  title: ConcursoScoringConfig.eliminatoryTitle,
                  heroValue: ConcursoScoringConfig.eliminatoryScore,
                  heroSuffix: ConcursoScoringConfig.eliminatoryScoreSuffix,
                  body: ConcursoScoringConfig.eliminatoryBody,
                  note: ConcursoScoringConfig.eliminatoryNote,
                  badge: 'Eliminatorio',
                  badgeKind: _BadgeKind.eliminatory,
                  featured: true,
                  fill: true,
                ),
              ),
              const SizedBox(width: gap),
              Expanded(
                flex: wide ? 5 : 4,
                child: const _BentoTile(
                  title: ConcursoScoringConfig.pedagogicalTitle,
                  heroValue: ConcursoScoringConfig.pedagogicalWeight,
                  body: ConcursoScoringConfig.pedagogicalBody,
                  badge: 'Eliminatorio',
                  badgeKind: _BadgeKind.eliminatory,
                  fill: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: gap),
        SizedBox(
          height: wide ? 280 : 300,
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _BentoTile(
                  title: ConcursoScoringConfig.softSkillsTitle,
                  heroValue: ConcursoScoringConfig.softSkillsWeight,
                  body: ConcursoScoringConfig.softSkillsBody,
                  badge: 'Clasificatorio',
                  badgeKind: _BadgeKind.classificatory,
                  fill: true,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _BentoTile(
                  title: ConcursoScoringConfig.antecedentsTitle,
                  heroValue: ConcursoScoringConfig.antecedentsWeight,
                  body: ConcursoScoringConfig.antecedentsBody,
                  badge: 'Clasificatorio',
                  badgeKind: _BadgeKind.classificatory,
                  fill: true,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _BentoTile(
                  title: ConcursoScoringConfig.goalTitle,
                  heroValue: ConcursoScoringConfig.goalScore,
                  heroSuffix: ConcursoScoringConfig.goalScoreSuffix,
                  body: ConcursoScoringConfig.goalBody,
                  badge: 'Tu meta',
                  badgeKind: _BadgeKind.goal,
                  accentGold: true,
                  showCta: true,
                  fill: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileBento extends StatelessWidget {
  const _MobileBento();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _BentoTile(
          title: ConcursoScoringConfig.eliminatoryTitle,
          heroValue: ConcursoScoringConfig.eliminatoryScore,
          heroSuffix: ConcursoScoringConfig.eliminatoryScoreSuffix,
          body: ConcursoScoringConfig.eliminatoryBody,
          note: ConcursoScoringConfig.eliminatoryNote,
          badge: 'Eliminatorio',
          badgeKind: _BadgeKind.eliminatory,
          featured: true,
        ),
        SizedBox(height: 12),
        _BentoTile(
          title: ConcursoScoringConfig.pedagogicalTitle,
          heroValue: ConcursoScoringConfig.pedagogicalWeight,
          body: ConcursoScoringConfig.pedagogicalBody,
          badge: 'Eliminatorio',
          badgeKind: _BadgeKind.eliminatory,
        ),
        SizedBox(height: 12),
        _BentoTile(
          title: ConcursoScoringConfig.softSkillsTitle,
          heroValue: ConcursoScoringConfig.softSkillsWeight,
          body: ConcursoScoringConfig.softSkillsBody,
          badge: 'Clasificatorio',
          badgeKind: _BadgeKind.classificatory,
        ),
        SizedBox(height: 12),
        _BentoTile(
          title: ConcursoScoringConfig.antecedentsTitle,
          heroValue: ConcursoScoringConfig.antecedentsWeight,
          body: ConcursoScoringConfig.antecedentsBody,
          badge: 'Clasificatorio',
          badgeKind: _BadgeKind.classificatory,
        ),
        SizedBox(height: 12),
        _BentoTile(
          title: ConcursoScoringConfig.goalTitle,
          heroValue: ConcursoScoringConfig.goalScore,
          heroSuffix: ConcursoScoringConfig.goalScoreSuffix,
          body: ConcursoScoringConfig.goalBody,
          badge: 'Tu meta',
          badgeKind: _BadgeKind.goal,
          accentGold: true,
          showCta: true,
        ),
      ],
    );
  }
}

class _BentoTile extends StatelessWidget {
  const _BentoTile({
    required this.title,
    required this.heroValue,
    required this.body,
    required this.badge,
    required this.badgeKind,
    this.heroSuffix,
    this.note,
    this.featured = false,
    this.accentGold = false,
    this.showCta = false,
    this.fill = false,
  });

  final String title;
  final String heroValue;
  final String? heroSuffix;
  final String body;
  final String? note;
  final String badge;
  final _BadgeKind badgeKind;
  final bool featured;
  final bool accentGold;
  final bool showCta;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = accentGold
        ? (isDark
            ? AppColors.gold.withValues(alpha: 0.12)
            : AppColors.gold.withValues(alpha: 0.10))
        : (isDark ? AppColors.darkSurface : AppColors.white);
    final border = accentGold
        ? AppColors.gold.withValues(alpha: 0.55)
        : (isDark ? AppColors.darkStroke : AppColors.stroke);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(featured ? 24 : 20),
        border: Border.all(color: border, width: accentGold ? 1.4 : 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(featured ? 20 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _KindBadge(label: badge, kind: badgeKind),
            const SizedBox(height: 10),
            Text(
              title,
              style: theme.textTheme.titleSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: featured ? 12 : 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: heroValue,
                    style: (featured
                            ? theme.textTheme.displaySmall
                            : theme.textTheme.headlineMedium)
                        ?.copyWith(
                      color: accentGold
                          ? AppColors.goldDeep
                          : (isDark ? AppColors.darkText : AppColors.ink),
                    ),
                  ),
                  if (heroSuffix != null)
                    TextSpan(
                      text: ' $heroSuffix',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textMuted,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (fill)
              Expanded(
                child: Text(
                  body,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            else
              Text(body, style: theme.textTheme.bodyMedium),
            if (note != null) ...[
              const SizedBox(height: 8),
              Text(
                note!,
                style: theme.textTheme.labelMedium,
                maxLines: fill ? 2 : null,
                overflow: fill ? TextOverflow.ellipsis : TextOverflow.visible,
              ),
            ],
            if (showCta) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.tonal(
                  onPressed: () => context.go('/onboarding'),
                  child: const Text(ConcursoScoringConfig.goalCta),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _KindBadge extends StatelessWidget {
  const _KindBadge({required this.label, required this.kind});

  final String label;
  final _BadgeKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color bg;
    final Color fg;
    switch (kind) {
      case _BadgeKind.eliminatory:
        bg = AppColors.coral.withValues(alpha: 0.14);
        fg = AppColors.coral;
        break;
      case _BadgeKind.classificatory:
        bg = AppColors.skyLine.withValues(alpha: 0.14);
        fg = AppColors.skyLine;
        break;
      case _BadgeKind.goal:
        bg = AppColors.gold.withValues(alpha: 0.18);
        fg = AppColors.goldDeep;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.28)),
      ),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(color: fg),
      ),
    );
  }
}
