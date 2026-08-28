import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/mentor_launch_args.dart';
import '../services/mentor_convo_service.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/mentor_case_accordion.dart';
import '../widgets/mentor_chat_bubble.dart';
import '../widgets/mentor_hint_rotator.dart';
import '../widgets/mentor_trial_paywall.dart';
import '../widgets/mentor_turn_progress.dart';

class _ChatLine {
  const _ChatLine({required this.fromMentor, required this.text});
  final bool fromMentor;
  final String text;
}

/// Charla guiada de 8 turnos anclada al caso (no es chat libre).
class MentorConvoScreen extends StatefulWidget {
  const MentorConvoScreen({super.key, this.args});

  final MentorLaunchArgs? args;

  @override
  State<MentorConvoScreen> createState() => _MentorConvoScreenState();
}

class _MentorConvoScreenState extends State<MentorConvoScreen> {
  final _service = MentorConvoService();
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final _lines = <_ChatLine>[];
  late final MentorHintRotator _hints;
  String? _sessionId;
  String? _error;
  var _starting = true;
  var _busy = false;
  var _closed = false;
  var _turnCount = 0;
  var _startRequested = false;

  @override
  void initState() {
    super.initState();
    _hints = MentorHintRotator(
      controller: _input,
      onTick: () {
        if (mounted) setState(() {});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  @override
  void dispose() {
    _hints.dispose();
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (_startRequested) return;
    _startRequested = true;
    final args = widget.args;
    if (args == null) {
      setState(() {
        _starting = false;
        _error =
            'Falta el caso. Vuelve al Tutor personalizado y elige postura.';
      });
      return;
    }
    setState(() {
      _starting = true;
      _error = null;
    });
    try {
      final result = await _service.start(
        question: args.question,
        chosenIndex: args.chosenIndex,
      );
      if (!mounted) return;
      if (result.kind == 'trial') {
        await context.read<AppState>().markMentorTrialUsed();
      }
      if (!mounted) return;
      setState(() {
        _starting = false;
        _sessionId = result.sessionId;
        _turnCount = result.turnCount;
        _closed = result.closed;
        _lines.add(_ChatLine(fromMentor: true, text: result.text));
      });
      _jumpToEnd();
      if (result.paywall) await _onPaywall();
    } on MentorPaywallException {
      if (!mounted) return;
      setState(() => _starting = false);
      await _onPaywall();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _starting = false;
        _error = e.toString().replaceFirst(RegExp(r'^Exception: '), '');
      });
    }
  }

  Future<void> _send() async {
    if (_busy || _closed || _sessionId == null) return;
    final text = _input.text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (text.length < 4) return;
    _input.clear();
    setState(() {
      _busy = true;
      _error = null;
      _lines.add(_ChatLine(fromMentor: false, text: text));
    });
    _jumpToEnd();
    try {
      final result = await _service.turn(sessionId: _sessionId!, text: text);
      if (!mounted) return;
      setState(() {
        _busy = false;
        _turnCount = result.turnCount;
        _closed = result.closed;
        _lines.add(_ChatLine(fromMentor: true, text: result.text));
      });
      _jumpToEnd();
      if (result.paywall) await _onPaywall();
    } on MentorPaywallException {
      if (!mounted) return;
      setState(() => _busy = false);
      await _onPaywall();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = e.toString().replaceFirst(RegExp(r'^Exception: '), '');
      });
    }
  }

  Future<void> _onPaywall() async {
    if (!mounted) return;
    await showMentorTrialPaywall(context);
    if (!mounted) return;
    if (_sessionId == null) context.go('/tutor');
  }

  void _leaveToTutor() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/tutor');
  }

  void _jumpToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final args = widget.args;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor IA'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _leaveToTutor,
        ),
      ),
      body: AtmosphericBackground(
        dark: dark,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: LayoutBreakpoints.contentMaxWidth(context),
            ),
            child: Column(
              children: [
                if (args != null)
                  MentorCaseAccordion(
                    question: args.question,
                    chosenIndex: args.chosenIndex,
                  ),
                MentorTurnProgress(currentTurn: _turnCount),
                Expanded(child: _thread(theme)),
                _closed ? _exitButton(theme, dark) : _composer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _thread(ThemeData theme) {
    if (_starting) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('El mentor está analizando tu postura…'),
            ],
          ),
        ),
      );
    }
    return ListView(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      children: [
        if (_error != null) ...[
          Text(
            _error!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.danger,
            ),
          ),
          const SizedBox(height: 12),
        ],
        for (final line in _lines) ...[
          MentorChatBubble(fromMentor: line.fromMentor, text: line.text),
          const SizedBox(height: 10),
        ],
        if (_busy) ...[
          Text(
            'El mentor está analizando tu postura…',
            style: theme.textTheme.bodySmall,
          ),
        ],
        if (_closed && !_busy)
          Text(
            'Esta tutoría se cerró. El caso del Tutor personalizado sigue disponible.',
            style: theme.textTheme.bodySmall,
          ),
      ],
    );
  }

  Widget _composer() {
    final canSend = !_busy && !_starting && _sessionId != null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _input,
              enabled: canSend,
              maxLength: kMentorMaxUserChars,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) {
                if (canSend) _send();
              },
              decoration: InputDecoration(hintText: _hints.hint),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: canSend ? _send : null,
            icon: const Icon(Icons.send_rounded),
            tooltip: 'Enviar',
          ),
        ],
      ),
    );
  }

  Widget _exitButton(ThemeData theme, bool dark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: AppButtonStyles.filled(
            textStyle: theme.textTheme.labelLarge,
            dark: dark,
          ),
          onPressed: _leaveToTutor,
          child: const Text('Volver al simulacro'),
        ),
      ),
    );
  }
}
