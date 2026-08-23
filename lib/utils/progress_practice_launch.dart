import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/user_profile.dart';
import '../services/tag_mastery_service.dart';
import '../services/session_feedback_service.dart';
import '../state/app_state.dart';
import 'app_snackbars.dart';
import 'progress_gaps.dart';
import 'session_launch.dart';

/// Temas que se entrenan en Casos del colegio (Premium).
bool isCaseKnowledgeTopic(KnowledgeCode code) {
  switch (code) {
    case KnowledgeCode.decreto1421:
    case KnowledgeCode.ley1620:
    case KnowledgeCode.guiaMen49:
    case KnowledgeCode.guiaMen51:
      return true;
    default:
      return false;
  }
}

CompetencyPillar weakestPillarOf(UserProfile profile) =>
    ProgressGaps.weakestPillar(profile);

/// Abre práctica del pilar o avisa si el cupo de hoy ya se usó (Premium).
void launchProgressPillar(BuildContext context, CompetencyPillar pillar) {
  final state = context.read<AppState>();
  final ok = state.startSession(
    mode: SessionMode.practice,
    pillar: pillar,
    count: 8,
  );
  launchSessionOrPaywall(
    context: context,
    state: state,
    started: ok,
    route: '/practice',
  );
}

/// Abre el tema: casos si aplica (Premium) o práctica filtrada por etiqueta.
void launchProgressTopic(BuildContext context, KnowledgeCode code) {
  final state = context.read<AppState>();

  if (isCaseKnowledgeTopic(code)) {
    if (!state.canAccessCases) {
      AppSnackbars.premiumLocked(
        context,
        'Este tema se trabaja en Casos del colegio, y esa sección es Premium.',
      );
      return;
    }
    context.push('/cases');
    return;
  }

  final ok = state.startSession(
    mode: SessionMode.practice,
    count: 8,
    knowledgeCode: code,
  );
  launchSessionOrPaywall(
    context: context,
    state: state,
    started: ok,
    route: '/practice',
  );
}

/// Recomendación de hoy: tema débil o pilar más flojo.
void launchProgressRecommendation(BuildContext context) {
  final state = context.read<AppState>();
  final gaps = ProgressGaps.unmeasuredCognitive(state.profile);
  if (gaps.isNotEmpty) {
    launchProgressPillar(context, gaps.first);
    return;
  }
  final row = TagMasteryService.recommendedToday(state.profile);
  if (row != null) {
    launchProgressTopic(context, row.code);
    return;
  }
  launchProgressPillar(context, weakestPillarOf(state.profile));
}

/// Tras celebrar: vuelve al inicio para elegir el siguiente bloque.
void launchHomeAfterSession(BuildContext context) {
  final state = context.read<AppState>();
  final result = state.lastResult;
  final toPaywall =
      result?.mode == SessionMode.diagnostic &&
      state.isPaidCohort &&
      !state.profile.isPremium;
  state.clearSession();
  if (toPaywall) {
    context.go('/diagnostic-paywall');
    return;
  }
  context.go('/app');
}

/// Si no se puede abrir sin paywall, no vendemos Premium en Resultados.
bool canLaunchSessionFeedbackFocus(AppState state, SessionPracticeFocus focus) {
  if (state.profile.isPremium) return true;
  if (focus.code != null && isCaseKnowledgeTopic(focus.code!)) {
    return false;
  }
  return state.canStartFreePractice;
}

/// Refuerzo: abre el tema o pilar que más se falló en esa sesión.
void launchSessionFeedbackFocus(
  BuildContext context,
  SessionPracticeFocus focus,
) {
  final state = context.read<AppState>();
  if (!canLaunchSessionFeedbackFocus(state, focus)) {
    launchHomeAfterSession(context);
    return;
  }

  if (focus.code != null && isCaseKnowledgeTopic(focus.code!)) {
    state.clearSession();
    context.go('/cases');
    return;
  }

  final ok = focus.code != null
      ? state.startSession(
          mode: SessionMode.practice,
          count: 8,
          knowledgeCode: focus.code,
        )
      : state.startSession(
          mode: SessionMode.practice,
          pillar: focus.pillar,
          count: 8,
        );

  if (ok) {
    context.go('/practice');
    return;
  }
  launchHomeAfterSession(context);
}
