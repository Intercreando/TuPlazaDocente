import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/app_snackbars.dart';
import '../utils/session_launch.dart';
import 'feature_access_badge.dart';
import 'training_mode_card.dart';

/// Entrenamientos del home con nombres de colegio (sin Plan ni «alta exigencia»).
class HomeTrainingModes extends StatelessWidget {
  const HomeTrainingModes({super.key, this.columns});

  final int? columns;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final profile = state.profile;
    final premium = profile.isPremium;

    FeatureAccessLevel practiceAccess() {
      if (premium) return FeatureAccessLevel.open;
      return state.canStartFreePractice
          ? FeatureAccessLevel.limited
          : FeatureAccessLevel.locked;
    }

    FeatureAccessLevel examAccess() {
      if (premium) return FeatureAccessLevel.open;
      return state.canStartShortExam
          ? FeatureAccessLevel.limited
          : FeatureAccessLevel.locked;
    }

    final tutorCard = TrainingModeCard(
      title: 'Tutor personalizado',
      subtitle: premium
          ? 'Te lleva de la mano hasta la clave del tema'
          : 'Incluido en Premium',
      icon: Icons.school_rounded,
      color: AppColors.goldDeep,
      featured: true,
      access: premium ? FeatureAccessLevel.open : FeatureAccessLevel.locked,
      onTap: () {
        if (!premium) {
          AppSnackbars.premiumLocked(
            context,
            'El Tutor personalizado es Premium.',
          );
          return;
        }
        context.push('/tutor');
      },
    );

    final cards = [
      TrainingModeCard(
        title: 'Preguntas cortas',
        subtitle: '45 segundos por pregunta. Siempre libre.',
        icon: Icons.bolt_outlined,
        color: AppColors.goldDeep,
        access: FeatureAccessLevel.open,
        onTap: () {
          final ok = state.startSession(mode: SessionMode.speedBattle);
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/speed',
          );
        },
      ),
      TrainingModeCard(
        title: 'Practicar sin reloj',
        subtitle: premium
            ? '8 preguntas. Ves la explicación al instante.'
            : state.canStartFreePractice
            ? 'Hoy te queda 1 práctica gratis'
            : 'La práctica de hoy ya la usaste · Premium las deja libres',
        icon: Icons.menu_book_rounded,
        color: AppColors.canopy,
        access: practiceAccess(),
        limitedLabel: '1 / día',
        onTap: () {
          final ok = state.startSession(mode: SessionMode.practice, count: 8);
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/practice',
          );
        },
      ),
      TrainingModeCard(
        title: 'Simulacro con tiempo',
        subtitle: state.canStartShortExam
            ? (premium
                  ? 'Como el concurso: un reloj por pregunta.'
                  : '1 simulacro gratis este mes')
            : (state.isPaidCohort
                  ? 'El simulacro con reloj es Premium'
                  : 'Ya usaste el simulacro del mes · Premium'),
        icon: Icons.timer_outlined,
        color: AppColors.coral,
        access: examAccess(),
        limitedLabel: state.isPaidCohort ? 'Premium' : '1 / mes',
        onTap: () {
          final ok = state.startSession(mode: SessionMode.exam, count: 8);
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/exam',
          );
        },
      ),
      TrainingModeCard(
        title: 'Casos del colegio',
        subtitle: state.canAccessCases
            ? 'Situaciones reales. Eliges cómo actuar.'
            : 'Incluido en Premium',
        icon: Icons.groups_2_outlined,
        color: AppColors.skyLine,
        access: state.canAccessCases
            ? FeatureAccessLevel.open
            : FeatureAccessLevel.locked,
        onTap: () {
          if (!state.canAccessCases) {
            AppSnackbars.premiumLocked(
              context,
              'Los casos del colegio son Premium. En Gratis: las 5 del día y 1 práctica.',
            );
            return;
          }
          context.push('/cases');
        },
      ),
      TrainingModeCard(
        title: 'Mi área',
        subtitle: state.canAccessSpecialty
            ? (profile.especialidad == null
                  ? 'Primero elige tu especialidad en el perfil'
                  : 'Preguntas de ${profile.especialidad!.label}')
            : 'Incluido en Premium',
        icon: Icons.school_outlined,
        color: AppColors.inkSoft,
        access: state.canAccessSpecialty
            ? FeatureAccessLevel.open
            : FeatureAccessLevel.locked,
        onTap: () {
          if (!state.canAccessSpecialty) {
            AppSnackbars.premiumLocked(
              context,
              'La práctica de tu área es Premium.',
            );
            return;
          }
          if (profile.especialidad == null) {
            AppSnackbars.show(
              context,
              message: 'Primero elige tu especialidad en Cambiar cargo.',
            );
            return;
          }
          final ok = state.startSession(
            mode: SessionMode.practice,
            specialty: profile.especialidad,
            count: 8,
          );
          launchSessionOrPaywall(
            context: context,
            state: state,
            started: ok,
            route: '/practice',
          );
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = columns ?? (constraints.maxWidth > 620 ? 2 : 1);
            if (cols == 1) {
              return Column(
                children: [
                  tutorCard,
                  const SizedBox(height: 10),
                  for (final card in cards) ...[
                    card,
                    const SizedBox(height: 10),
                  ],
                ],
              );
            }
            const gap = 12.0;
            final rows = <Widget>[];
            for (var i = 0; i < cards.length; i += cols) {
              final slice = cards.sublist(
                i,
                i + cols > cards.length ? cards.length : i + cols,
              );
              final n = slice.length;
              final width = (constraints.maxWidth - gap * (n - 1)) / n;
              rows.add(
                Row(
                  children: [
                    for (var j = 0; j < n; j++) ...[
                      if (j > 0) const SizedBox(width: gap),
                      SizedBox(width: width, child: slice[j]),
                    ],
                  ],
                ),
              );
              if (i + cols < cards.length) {
                rows.add(const SizedBox(height: gap));
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tutorCard,
                const SizedBox(height: gap),
                ...rows,
              ],
            );
          },
        ),
      ],
    );
  }
}
