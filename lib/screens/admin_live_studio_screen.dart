import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/admin_config.dart';
import '../data/live_session.dart';
import '../data/live_studio_pack.dart';
import '../data/reel_studio_pack.dart';
import '../services/live_studio_service.dart';
import '../services/reel_clip_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/app_snackbars.dart';
import '../utils/seo_document.dart';
import '../widgets/live_capture_note.dart';
import '../widgets/live_control_deck.dart';
import '../widgets/live_express_stage.dart';
import '../widgets/reel_clip_picker.dart';

/// Sala de directos YouTube (solo admin). Lienzo 16:9 para OBS.
class AdminLiveStudioScreen extends StatefulWidget {
  const AdminLiveStudioScreen({super.key});

  @override
  State<AdminLiveStudioScreen> createState() => _AdminLiveStudioScreenState();
}

class _AdminLiveStudioScreenState extends State<AdminLiveStudioScreen> {
  final _focus = FocusNode();
  final _clipService = ReelClipService();
  final _liveService = LiveStudioService();

  LiveSession _session = LiveSession(
    clipId: ReelStudioPack.clips.first.id,
    beat: LiveBeat.standby,
  );
  List<ReelClip> _customClips = const [];
  List<ReelClip> _rundown = const [];
  Set<String> _usedIds = {};
  Set<String> _hiddenIds = {};
  Timer? _tick;
  StreamSubscription<LiveSession?>? _remote;

  List<ReelClip> get _catalog {
    final pack = ReelStudioPack.clips
        .where((clip) => !_hiddenIds.contains(clip.id))
        .toList();
    return [...pack, ..._customClips];
  }

  List<ReelClip> get _lookupCatalog => [
    ...ReelStudioPack.clips,
    ..._customClips,
  ];

  ReelClip get _clip =>
      ReelStudioPack.byIdIn(_lookupCatalog, _session.clipId);

  bool get _obs =>
      GoRouterState.of(context).uri.queryParameters['obs'] == '1';

  String get _obsShareUrl =>
      '${Uri.base.origin}/#/admin/estudio-directo?obs=1';

  String? get _nextLabel {
    final nextId = _session.nextClipId;
    if (nextId == null) return null;
    return ReelStudioPack.byIdIn(_lookupCatalog, nextId).label;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final obs =
          GoRouterState.of(context).uri.queryParameters['obs'] == '1';
      final state = context.read<AppState>();
      if (!obs && !AdminConfig.isAdminEmail(state.authEmail)) {
        if (mounted) context.go('/app');
        return;
      }
      SeoDocument.apply(
        title: LiveStudioPack.titleHint,
        description: 'Sala privada de directo YouTube.',
        canonical: 'https://www.tuplazadocente.com/admin/estudio-directo',
        noIndex: true,
      );
      _focus.requestFocus();
      await _loadCatalog();
      if (!mounted) return;
      if (obs) {
        _listenRemote();
      }
    });
  }

  Future<void> _loadCatalog() async {
    final clips = await _clipService.list();
    final meta = await _clipService.loadStudioState();
    if (!mounted) return;
    setState(() {
      _customClips = clips;
      _usedIds = meta.usedIds;
      _hiddenIds = meta.hiddenIds;
    });
  }

  void _listenRemote() {
    _remote?.cancel();
    _remote = _liveService
        .watch(fallbackId: ReelStudioPack.clips.first.id)
        .listen(
          (session) {
            if (!mounted || session == null) return;
            setState(() => _session = session);
            _ensureTick();
          },
          onError: (error) {
            debugPrint('LiveStudio watch: $error');
          },
        );
  }

  @override
  void dispose() {
    _tick?.cancel();
    _remote?.cancel();
    _focus.dispose();
    super.dispose();
  }

  int? get _countdownLeft =>
      _session.countdownLeftAt(DateTime.now());

  double get _countdownProgress => _session.countdownProgressAt(
    DateTime.now(),
    voteMs: LiveStudioPack.voteMs,
  );

  double get _timerPulse {
    if (_session.beat != LiveBeat.vote) return 1;
    final ends = _session.voteEndsAtMs;
    if (ends == null) return 1;
    final into = ends - DateTime.now().millisecondsSinceEpoch;
    if (into <= 0) return 1;
    final frac = (into % 1000) / 1000;
    return 1.0 + (1.0 - frac) * 0.14;
  }

  void _ensureTick() {
    final needsTick = _session.beat == LiveBeat.vote &&
        _session.voteEndsAtMs != null;
    if (!needsTick) {
      _tick?.cancel();
      _tick = null;
      return;
    }
    _tick ??= Timer.periodic(const Duration(milliseconds: 33), (_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  String? _peekNextId(String clipId) {
    if (_rundown.length < 2) return null;
    final index = _rundown.indexWhere((clip) => clip.id == clipId);
    if (index < 0 || index + 1 >= _rundown.length) return null;
    return _rundown[index + 1].id;
  }

  Future<void> _publish(LiveSession session) async {
    final nextId = _peekNextId(session.clipId);
    final next = nextId == null
        ? session.copyWith(clearNext: true)
        : session.copyWith(nextClipId: nextId);
    setState(() => _session = next);
    _ensureTick();
    try {
      await _liveService.publish(next);
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _setBeat(LiveBeat beat) {
    return _publish(
      _session.copyWith(
        beat: beat,
        clearVote: beat != LiveBeat.vote,
        clearHighlight: beat == LiveBeat.standby || beat == LiveBeat.hook,
      ),
    );
  }

  Future<void> _startVote() {
    return _publish(
      _session.copyWith(
        beat: LiveBeat.vote,
        voteEndsAtMs:
            DateTime.now().millisecondsSinceEpoch + LiveStudioPack.voteMs,
        clearHighlight: true,
      ),
    );
  }

  Future<void> _loadClip(ReelClip clip, {LiveBeat beat = LiveBeat.hook}) {
    return _publish(
      _session.copyWith(
        clipId: clip.id,
        beat: beat,
        clearVote: true,
        clearHighlight: true,
      ),
    );
  }

  void _shiftRundown(int delta) {
    if (_rundown.isEmpty) return;
    final index = _rundown.indexWhere((clip) => clip.id == _clip.id);
    final from = index < 0 ? 0 : index;
    final next = (from + delta).clamp(0, _rundown.length - 1);
    _loadClip(_rundown[next]);
  }

  void _addToRundown(ReelClip clip) {
    if (_rundown.any((item) => item.id == clip.id)) {
      AppSnackbars.show(context, message: 'Ese caso ya está en la escaleta.');
      return;
    }
    setState(() => _rundown = [..._rundown, clip]);
    _publish(_session);
    AppSnackbars.show(context, message: 'Sumado a la escaleta.');
  }

  bool get _typingInField {
    final context = FocusManager.instance.primaryFocus?.context;
    if (context == null) return false;
    if (context.widget is EditableText) return true;
    return context.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  void _onKey(KeyEvent event) {
    if (event is! KeyDownEvent || _typingInField || _obs) return;
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.space) {
      _setBeat(_session.beat.next);
    } else if (key == LogicalKeyboardKey.backspace) {
      _setBeat(_session.beat.previous);
    } else if (key == LogicalKeyboardKey.keyV) {
      _startVote();
    } else if (key == LogicalKeyboardKey.keyS) {
      _setBeat(LiveBeat.standby);
    } else if (key == LogicalKeyboardKey.keyR) {
      _setBeat(LiveBeat.hook);
    } else if (key == LogicalKeyboardKey.keyN) {
      _shiftRundown(1);
    } else if (key == LogicalKeyboardKey.keyP) {
      _shiftRundown(-1);
    } else if (key == LogicalKeyboardKey.enter) {
      _setBeat(LiveBeat.reveal);
    } else {
      const digits = [
        LogicalKeyboardKey.digit1,
        LogicalKeyboardKey.digit2,
        LogicalKeyboardKey.digit3,
        LogicalKeyboardKey.digit4,
      ];
      const letters = [
        LogicalKeyboardKey.keyA,
        LogicalKeyboardKey.keyB,
        LogicalKeyboardKey.keyC,
        LogicalKeyboardKey.keyD,
      ];
      final digit = digits.indexOf(key);
      final letter = letters.indexOf(key);
      final index = digit >= 0 ? digit : letter;
      if (index >= 0) {
        _publish(_session.copyWith(highlightedIndex: index));
      }
    }
  }

  Widget _canvas() {
    return FittedBox(
      child: SizedBox(
        width: LiveExpressStage.designSize.width,
        height: LiveExpressStage.designSize.height,
        child: LiveExpressStage(
          clip: _clip,
          beat: _session.beat,
          countdownLeft: _countdownLeft,
          countdownProgress: _countdownProgress,
          highlightedIndex: _session.highlightedIndex,
          nextLabel: _nextLabel,
          timerPulse: _timerPulse,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final canvas = _canvas();

    if (_obs) {
      return KeyboardListener(
        focusNode: _focus,
        autofocus: true,
        onKeyEvent: _onKey,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: canvas),
        ),
      );
    }

    if (!AdminConfig.isAdminEmail(state.authEmail)) {
      return const Scaffold(body: SizedBox.shrink());
    }

    return Theme(
      data: AppTheme.dark(),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return KeyboardListener(
            focusNode: _focus,
            autofocus: true,
            onKeyEvent: _onKey,
            child: Scaffold(
              backgroundColor: AppColors.darkBg,
              appBar: AppBar(
                title: const Text('Estudio Directo'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/app/premium'),
                ),
              ),
              body: Row(
                children: [
                  SizedBox(
                    width: 360,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        LiveControlDeck(
                          beat: _session.beat,
                          rundown: _rundown,
                          current: _clip,
                          onBeat: _setBeat,
                          onStartVote: _startVote,
                          onHighlight: (index) => _publish(
                            _session.copyWith(highlightedIndex: index),
                          ),
                          onPrevCase: () => _shiftRundown(-1),
                          onNextCase: () => _shiftRundown(1),
                          onRemoveFromRundown: (clip) {
                            setState(() {
                              _rundown = [
                                ..._rundown.where((item) => item.id != clip.id),
                              ];
                            });
                            _publish(_session);
                          },
                          onSelectRundown: _loadClip,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.tonal(
                          onPressed: () => _addToRundown(_clip),
                          child: const Text('Sumar caso actual a la escaleta'),
                        ),
                        const SizedBox(height: 12),
                        ReelClipPicker(
                          catalog: _catalog,
                          selected: _clip,
                          usedIds: _usedIds,
                          hiddenClips: const [],
                          manageCatalog: false,
                          title: 'Elige el caso de este directo',
                          subtitle:
                              'Súmalo a la escaleta para tener el orden listo '
                              'antes de ir a YouTube. '
                              'Pendientes visibles: ${_catalog.length}.',
                          onSelected: _loadClip,
                          onToggleUsed: (_) {},
                          onRemove: (_) {},
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () =>
                              context.go('/admin/estudio-directo?obs=1'),
                          child: const Text(
                            'Ver solo el lienzo en esta pestaña',
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: _obsShareUrl),
                            );
                            if (!context.mounted) return;
                            AppSnackbars.show(
                              context,
                              message:
                                  'Enlace copiado. Pégalo en OBS → Navegador '
                                  '(1920×1080). Este panel manda el directo.',
                            );
                          },
                          child: const Text(
                            'Copiar enlace para pegarlo dentro de OBS',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const LiveCaptureNote(),
                        const SizedBox(height: 16),
                        Text(
                          'Atajos: espacio = siguiente momento. '
                          'Retroceso = anterior. V = votar. '
                          'N/P = caso. 1-4 o A-D = señalar. '
                          'Enter = revelar. S = espera. R = gancho.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: ColoredBox(
                      color: Colors.black,
                      child: Center(child: canvas),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
