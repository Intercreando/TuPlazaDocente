import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/enums.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import 'testimonials_section.dart';

/// Secciones de credibilidad debajo del hero (sin alterar el copy principal).
class LandingCredibilitySections extends StatelessWidget {
  const LandingCredibilitySections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: LayoutBreakpoints.isDesktop(context) ? 56 : 40),
        const _TrustFactsStrip(),
        SizedBox(height: LayoutBreakpoints.isDesktop(context) ? 64 : 48),
        const _SpecializationSection(),
        SizedBox(height: LayoutBreakpoints.isDesktop(context) ? 64 : 48),
        const _WhyTrustSection(),
        SizedBox(height: LayoutBreakpoints.isDesktop(context) ? 64 : 48),
        const TestimonialsSection(limit: 4, showCompose: true),
        SizedBox(height: LayoutBreakpoints.isDesktop(context) ? 64 : 48),
        const _TransparencyBand(),
        const SizedBox(height: 32),
      ],
    );
  }
}

/// Hechos verificables del producto (sin cifras inventadas).
class _TrustFactsStrip extends StatelessWidget {
  const _TrustFactsStrip();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final facts = [
      (
        '${CargoAspiracion.values.length}',
        'Cargos cubiertos',
      ),
      (
        '${Especialidad.values.length}',
        'Especializaciones',
      ),
      (
        '${CompetencyPillar.values.length}',
        'Componentes de práctica',
      ),
      (
        'Gratis',
        'Para empezar a entrenar',
      ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.stroke,
          ),
          bottom: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.stroke,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 720;
            final children = facts
                .map(
                  (f) => _FactCell(
                    value: f.$1,
                    label: f.$2,
                    compact: !wide,
                  ),
                )
                .toList();

            if (wide) {
              return Row(
                children: [
                  for (var i = 0; i < children.length; i++) ...[
                    if (i > 0)
                      Container(
                        width: 1,
                        height: 44,
                        color: isDark ? AppColors.darkStroke : AppColors.stroke,
                      ),
                    Expanded(child: children[i]),
                  ],
                ],
              );
            }

            return Wrap(
              spacing: 12,
              runSpacing: 16,
              alignment: WrapAlignment.spaceEvenly,
              children: children
                  .map((c) => SizedBox(width: 140, child: c))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

class _FactCell extends StatelessWidget {
  const _FactCell({
    required this.value,
    required this.label,
    required this.compact,
  });

  final String value;
  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: isDark ? AppColors.darkText : AppColors.ink,
          ),
        ),
        SizedBox(height: compact ? 4 : 6),
        Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

/// Especialización por cargo: reduce la sensación de material genérico.
class _SpecializationSection extends StatelessWidget {
  const _SpecializationSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No es un curso para todos. Es el tuyo.',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          'Cada cargo tiene un perfil de pregunta distinto. Aquí entrenas '
          'según tu aspiración y especialidad, no con material genérico.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 22),
        Text(
          'Cargos',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final cargo in CargoAspiracion.values)
              _ChoiceChipButton(
                label: cargo.label,
                onTap: () => context.go('/onboarding'),
              ),
          ],
        ),
        const SizedBox(height: 22),
        Text(
          'Especialidades',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final esp in Especialidad.values)
              _ChoiceChipButton(
                label: esp.label,
                onTap: () => context.go('/onboarding'),
              ),
          ],
        ),
      ],
    );
  }
}

class _ChoiceChipButton extends StatelessWidget {
  const _ChoiceChipButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.darkElevated : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? AppColors.darkStroke : AppColors.stroke,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Text(label, style: theme.textTheme.labelLarge),
        ),
      ),
    );
  }
}

/// Razones concretas de confianza (sin atacar a la competencia).
class _WhyTrustSection extends StatelessWidget {
  const _WhyTrustSection();

  static const _points = [
    (
      Icons.menu_book_outlined,
      'Feedback que enseña',
      'Cada respuesta explica el criterio del ítem y por qué fallan las distractoras.',
    ),
    (
      Icons.school_outlined,
      'Casos de aula reales',
      'Practicas situaciones pedagógicas y de gestión, no solo teoría suelta.',
    ),
    (
      Icons.timer_outlined,
      'Sesiones cortas y constantes',
      'Entrenamiento de 10–15 minutos con racha diaria para sostener el hábito.',
    ),
    (
      Icons.verified_user_outlined,
      'Empieza gratis, sin letra chica',
      'Gratis: reto diario, 1 práctica al día y 1 simulacro al mes. Premium desbloquea el resto sin tope.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Por qué puedes confiar aquí',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          'Sin promesas milagro. Con método claro, práctica guiada y reglas transparentes.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth >= 720;
            if (!desktop) {
              return Column(
                children: [
                  for (final point in _points) _TrustPointRow(point: point),
                ],
              );
            }
            return Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                for (final point in _points)
                  SizedBox(
                    width: (constraints.maxWidth - 24) / 2,
                    child: _TrustPointRow(point: point),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TrustPointRow extends StatelessWidget {
  const _TrustPointRow({required this.point});

  final (IconData, String, String) point;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.stroke,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(point.$1, color: AppColors.canopy),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(point.$2, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(point.$3, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cierre honesto: baja la desconfianza institucional.
class _TransparencyBand extends StatelessWidget {
  const _TransparencyBand();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final desktop = LayoutBreakpoints.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(desktop ? 36 : 24),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: desktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Claridad desde el primer minuto',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'TuPlazaDocente es un entrenador táctico del Concurso Docente. '
                        'No somos una entidad oficial del Estado. Nuestro foco es ayudarte '
                        'a practicar con criterio, entender tus errores y sostener un plan diario.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                FilledButton(
                  onPressed: () => context.go('/auth'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.ink,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 18,
                    ),
                  ),
                  child: const Text('Empezar con confianza'),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Claridad desde el primer minuto',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'TuPlazaDocente es un entrenador táctico del Concurso Docente. '
                  'No somos una entidad oficial del Estado. Nuestro foco es ayudarte '
                  'a practicar con criterio, entender tus errores y sostener un plan diario.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: () => context.go('/auth'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.ink,
                  ),
                  child: const Text('Empezar con confianza'),
                ),
              ],
            ),
    );
  }
}
