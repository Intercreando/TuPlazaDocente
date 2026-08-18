import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/user_profile.dart';
import '../services/tag_mastery_service.dart';
import '../state/app_state.dart';
import 'app_snackbars.dart';
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

CompetencyPillar weakestPillarOf(UserProfile profile) {
  CompetencyPillar weakest = CompetencyPillar.pedagogico;
  var lowest = 2.0;
  var found = false;
  for (final pillar in CompetencyPillar.values) {
    final total = profile.pillarTotal[pillar.name] ?? 0;
    if (total == 0) continue;
    found = true;
    final acc = profile.pillarAccuracy(pillar);
    if (acc < lowest) {
      lowest = acc;
      weakest = pillar;
    }
  }
  return found ? weakest : CompetencyPillar.pedagogico;
}

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
  final row = TagMasteryService.recommendedToday(state.profile);
  if (row != null) {
    launchProgressTopic(context, row.code);
    return;
  }
  launchProgressPillar(context, weakestPillarOf(state.profile));
}
