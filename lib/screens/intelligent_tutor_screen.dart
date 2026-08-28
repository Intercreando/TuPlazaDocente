import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/question_bank.dart';
import '../models/mentor_launch_args.dart';
import '../services/intelligent_tutor_guide.dart';
import '../services/intelligent_tutor_planner.dart';
import '../services/tutor_day_balance.dart';
import '../state/app_state.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/app_snackbars.dart';
import '../utils/mentor_pass_return.dart';
import '../utils/premium_nav.dart';
import '../utils/progress_practice_launch.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/mentor_cta_card.dart';
import '../widgets/mentor_trial_paywall.dart';
import '../widgets/tutor_guide_session.dart';

const _kLastCaseKey = 'tutor_inteligente_last_question_id';

/// Tutoría guiada: pistas y clave del banco. La charla Vertex es el Mentor IA.
class IntelligentTutorScreen extends StatefulWidget {
  const IntelligentTutorScreen({super.key});

  @override
  State<IntelligentTutorScreen> createState() => _IntelligentTutorScreenState();
}

class _IntelligentTutorScreenState extends State<IntelligentTutorScreen> {
  IntelligentTutorPlan? _plan;
  IntelligentTutorGuide? _guide;
  String? _loadError;
  var _recordedPrimary = false;
  var _recordedFollowUp = false;
  var _showMixNudge = false;
  var _consecutiveClosed = 0;
  var _handledMentorReturn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_handledMentorReturn) return;
    final uri = GoRouterState.of(context).uri;
    if (uri.queryParameters['mentorPass'] != 'pending') return;
    _handledMentorReturn = true;
    final status = uri.queryParameters['status'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleMentorPassReturn(context, status: status);
    });
  }

  Future<void> _load({Set<String>? extraExcludeIds}) async {
    final state = context.read<AppState>();
    if (!state.profile.isPremium) {
      if (!mounted) return;
      AppSnackbars.premiumLocked(context, 'El Tutor personalizado es Premium.');
      setState(() {
        _loadError = 'El Tutor personalizado está incluido en Premium.';
      });
      openPremium(context);
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastId = prefs.getString(_kLastCaseKey);
      final plan = IntelligentTutorPlanner.build(
        state.profile,
        excludeQuestionId: lastId,
        excludeQuestionIds: extraExcludeIds,
      );
      await prefs.setString(_kLastCaseKey, plan.question.id);
      if (!mounted) return;
      setState(() {
        _plan = plan;
        _guide = IntelligentTutorGuide(primary: plan.question);
        _loadError = null;
        _showMixNudge = false;
        _recordedPrimary = false;
        _recordedFollowUp = false;
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

  Future<void> _nextCase() async {
    final extra = <String>{
      if (_guide != null) _guide!.primary.id,
      if (_guide?.followUp != null) _guide!.followUp!.id,
    };
    if (mounted) {
      setState(() {
        _plan = null;
        _guide = null;
        _loadError = null;
      });
    }
    await _load(extraExcludeIds: extra);
  }

  Future<void> _choose(int index) async {
    final guide = _guide;
    if (guide == null) return;
    final wasPrimaryClosed = guide.primaryClosed;
    final outcome = guide.choose(index);
    if (outcome == TutorChoiceOutcome.ignored) return;
    setState(() {});
    if (!wasPrimaryClosed && guide.primaryClosed) {
      await _onPrimaryClosed();
    }
    if (guide.followUpClosed) {
      await _recordFollowUp();
    }
  }

  Future<void> _onPrimaryClosed() async {
    final guide = _guide;
    final plan = _plan;
    if (guide == null || plan == null) return;
    final next = IntelligentTutorPlanner.pickFollowUp(
      pool: QuestionBank.all,
      primary: guide.primary,
      preferHarder: guide.firstTryCorrect,
    );
    guide.attachFollowUp(next);
    _consecutiveClosed += 1;
    var mixedOther = false;
    try {
      await TutorDayBalance.recordTutorVisit();
      mixedOther = await TutorDayBalance.hasOtherTrainingToday();
    } catch (e) {
      debugPrint('IntelligentTutorScreen tutor visit: $e');
    }
    if (!mounted) return;
    setState(() {
      _showMixNudge = TutorDayBalance.nudgeForStreak(
        consecutiveClosed: _consecutiveClosed,
        mixedOtherToday: mixedOther,
      );
    });
    await _recordPrimary();
  }

  Future<void> _recordPrimary() async {
    if (_recordedPrimary) return;
    final guide = _guide;
    final choice = guide?.primaryChoice;
    if (guide == null || choice == null) return;
    _recordedPrimary = true;
    try {
      await context.read<AppState>().recordTutorStance(
        question: guide.primary,
        selectedIndex: choice,
      );
    } catch (e) {
      debugPrint('IntelligentTutorScreen record primary: $e');
    }
  }

  Future<void> _recordFollowUp() async {
    if (_recordedFollowUp) return;
    final guide = _guide;
    final choice = guide?.followUpChoice;
    final item = guide?.followUp;
    if (guide == null || choice == null || item == null) return;
    _recordedFollowUp = true;
    try {
      await context.read<AppState>().recordTutorStance(
        question: item,
        selectedIndex: choice,
      );
    } catch (e) {
      debugPrint('IntelligentTutorScreen record follow-up: $e');
    }
  }

  void _startFollowUp() {
    _guide?.startFollowUp();
    setState(() {});
  }

  void _practiceFocus() {
    final question = _guide?.primary ?? _plan?.question;
    if (question == null) return;
    final code = question.knowledgeTags.isEmpty
        ? null
        : question.knowledgeTags.first.code;
    if (code != null) {
      launchProgressTopic(context, code);
      return;
    }
    launchProgressPillar(context, question.pillar);
  }

  Future<void> _openMentor() async {
    final guide = _guide;
    final choice = guide?.primaryChoice;
    if (guide == null || choice == null) return;
    final state = context.read<AppState>();
    if (state.isAnonymousUser) return;
    if (state.profile.mentorTrialUsed && !state.profile.hasMentorPass) {
      await showMentorTrialPaywall(context);
      return;
    }
    if (!context.mounted) return;
    context.push(
      '/tutor/mentor',
      extra: MentorLaunchArgs(question: guide.primary, chosenIndex: choice),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final state = context.watch<AppState>();
    final plan = _plan;
    final guide = _guide;

    return Scaffold(
      appBar: AppBar(title: const Text('Tutor personalizado')),
      body: AtmosphericBackground(
        dark: dark,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: _loadError != null
                ? _MessageBody(text: _loadError!)
                : plan == null || guide == null
                ? const Center(child: CircularProgressIndicator())
                : TutorGuideSession(
                    key: ValueKey(guide.primary.id),
                    plan: plan,
                    guide: guide,
                    onChoose: _choose,
                    onStartFollowUp: _startFollowUp,
                    onPracticeMore: _practiceFocus,
                    onBackHome: () => context.go('/app'),
                    onNextCase: _nextCase,
                    showMixNudge: _showMixNudge,
                    mentorCta:
                        guide.primaryClosed && guide.primaryChoice != null
                        ? MentorCtaCard(
                            enabled: !state.isAnonymousUser,
                            blockedReason: state.isAnonymousUser
                                ? 'Crea una cuenta (Google o correo) para '
                                      'hablar con el mentor.'
                                : null,
                            hasPass: state.profile.hasMentorPass,
                            trialUsed: state.profile.mentorTrialUsed,
                            choseCorrect: guide.primary.isCorrect(
                              guide.primaryChoice!,
                            ),
                            onOpen: _openMentor,
                          )
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
