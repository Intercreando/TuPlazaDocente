import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/question.dart';
import '../services/intelligent_tutor_planner.dart';
import '../state/app_state.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/app_snackbars.dart';
import '../utils/premium_nav.dart';
import '../utils/progress_practice_launch.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/option_tile.dart';
import '../widgets/question_case_context.dart';
import '../widgets/tutor_bank_contrast.dart';
import '../widgets/tutor_remate_panel.dart';

const _kLastCaseKey = 'tutor_inteligente_last_question_id';
const _kLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

/// Sesión guiada: diagnóstico + caso del banco + contraste; Vertex solo en remate.
class IntelligentTutorScreen extends StatefulWidget {
  const IntelligentTutorScreen({super.key});

  @override
  State<IntelligentTutorScreen> createState() => _IntelligentTutorScreenState();
}

class _IntelligentTutorScreenState extends State<IntelligentTutorScreen> {
  IntelligentTutorPlan? _plan;
  String? _loadError;
  int? _chosenIndex;
  var _recorded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final state = context.read<AppState>();
    if (!state.profile.isPremium) {
      if (!mounted) return;
      AppSnackbars.premiumLocked(
        context,
        'El Tutor Inteligente es Premium.',
      );
      setState(() {
        _loadError = 'El Tutor Inteligente está incluido en Premium.';
      });
      openPremium(context);
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final exclude = prefs.getString(_kLastCaseKey);
      final plan = IntelligentTutorPlanner.build(
        state.profile,
        excludeQuestionId: exclude,
      );
      await prefs.setString(_kLastCaseKey, plan.question.id);
      if (!mounted) return;
      setState(() {
        _plan = plan;
        _loadError = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError =
            'No pudimos armar el caso de hoy. Vuelve al inicio e intenta de nuevo.';
      });
      debugPrint('IntelligentTutorScreen: $e');
    }
  }

  Future<void> _choose(int index) async {
    if (_chosenIndex != null || _plan == null) return;
    setState(() => _chosenIndex = index);
    if (_recorded) return;
    _recorded = true;
    try {
      await context.read<AppState>().recordTutorStance(
        question: _plan!.question,
        selectedIndex: index,
      );
    } catch (e) {
      debugPrint('IntelligentTutorScreen record: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final state = context.watch<AppState>();
    final plan = _plan;

    return Scaffold(
      appBar: AppBar(title: const Text('Tutor Inteligente')),
      body: AtmosphericBackground(
        dark: dark,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: _loadError != null
                ? _MessageBody(text: _loadError!)
                : plan == null
                    ? const Center(child: CircularProgressIndicator())
                    : _SessionBody(
                        plan: plan,
                        chosenIndex: _chosenIndex,
                        onChoose: _choose,
                        remateEnabled:
                            state.profile.isPremium && !state.isAnonymousUser,
                        remateBlockedReason: state.isAnonymousUser
                            ? 'Crea una cuenta (Google o correo) para el remate. '
                                'El caso y el contraste ya están arriba.'
                            : null,
                      ),
          ),
        ),
      ),
    );
  }
}

class _MessageBody extends StatelessWidget {
  const _MessageBody({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.go('/app'),
            child: const Text('Volver al inicio'),
          ),
        ],
      ),
    );
  }
}

class _SessionBody extends StatelessWidget {
  const _SessionBody({
    required this.plan,
    required this.chosenIndex,
    required this.onChoose,
    required this.remateEnabled,
    this.remateBlockedReason,
  });

  final IntelligentTutorPlan plan;
  final int? chosenIndex;
  final ValueChanged<int> onChoose;
  final bool remateEnabled;
  final String? remateBlockedReason;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = plan.question;
    final revealed = chosenIndex != null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Text(
          'Hola, ${plan.displayName}.',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(plan.headline, style: theme.textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(plan.body, style: theme.textTheme.bodyMedium),
        if (plan.weakLabels.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final label in plan.weakLabels) Chip(label: Text(label)),
            ],
          ),
        ],
        const SizedBox(height: 18),
        Text('Tu caso de hoy', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: Text(question.pillar.label)),
            Chip(label: Text(question.topic)),
            if (question.isCaseStudy)
              const Chip(label: Text('Caso de aula')),
          ],
        ),
        const SizedBox(height: 12),
        QuestionCaseContext(question: question),
        Text(question.stem, style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        Text('¿Cómo actuarías?', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        ...List.generate(question.options.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: OptionTile(
              letter: _kLetters[i],
              label: question.options[i],
              selected: chosenIndex == i,
              showResult: revealed,
              isCorrect: i == question.correctIndex,
              onTap: revealed ? () {} : () => onChoose(i),
            ),
          );
        }),
        if (chosenIndex != null) ...[
          TutorBankContrast(
            question: question,
            chosenIndex: chosenIndex!,
          ),
          const SizedBox(height: 16),
          TutorRematePanel(
            question: question,
            chosenIndex: chosenIndex!,
            enabled: remateEnabled,
            disabledReason: remateBlockedReason,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => _practiceFocus(context, question),
            child: const Text('Practicar más de este tema'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => context.go('/app'),
            child: const Text('Volver al inicio'),
          ),
        ],
      ],
    );
  }

  void _practiceFocus(BuildContext context, Question question) {
    final code = question.knowledgeTags.isEmpty
        ? null
        : question.knowledgeTags.first.code;
    if (code != null) {
      launchProgressTopic(context, code);
      return;
    }
    launchProgressPillar(context, question.pillar);
  }
}
