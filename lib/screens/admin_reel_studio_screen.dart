import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/admin_config.dart';
import '../data/reel_studio_pack.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/app_snackbars.dart';
import '../utils/reel_tick.dart';
import '../utils/seo_document.dart';
import '../widgets/reel_express_stage.dart';
import '../widgets/reel_publish_kit.dart';

/// Sala de grabación Reels/TikTok (solo admin). Lienzo 9:16 para OBS.
class AdminReelStudioScreen extends StatefulWidget {
  const AdminReelStudioScreen({super.key});

  @override
  State<AdminReelStudioScreen> createState() => _AdminReelStudioScreenState();
}

class _AdminReelStudioScreenState extends State<AdminReelStudioScreen> {
  /// Ciclo exacto de 15,00 s (hook + caso + cuenta + cierre).
  static const _cycleMs = 15000;
  static const _hookMs = 1600;
  static const _countdownMs = 3000;
  static const _closeMs = 3000;
  static const _questionMs = _cycleMs - _hookMs - _countdownMs - _closeMs;
  static const _fadeMs = 180;

  final _focus = FocusNode();
  Timer? _tick;
  DateTime? _startedAt;
  ReelClip _clip = ReelStudioPack.clips.first;
  bool _revealMode = false;
  bool _loop = true;
  bool _playing = false;
  bool _tickSound = true;
  int? _lastTickSecond;

  String? _appliedQuery;

  bool get _obs {
    return GoRouterState.of(context).uri.queryParameters['obs'] == '1';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AppState>();
      if (!AdminConfig.isAdminEmail(state.authEmail)) {
        if (mounted) context.go('/app');
        return;
      }
      SeoDocument.apply(
        title: 'Estudio Reels (admin)',
        description: 'Sala privada de grabación.',
        canonical: 'https://www.tuplazadocente.com/admin/estudio-reels',
        noIndex: true,
      );
      _focus.requestFocus();
      _syncQuery();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncQuery();
  }

  void _syncQuery() {
    if (!mounted) return;
    final uri = GoRouterState.of(context).uri;
    if (uri.query == _appliedQuery) return;
    _appliedQuery = uri.query;
    final clip = ReelStudioPack.byId(uri.queryParameters['caso']);
    final startObs = uri.queryParameters['obs'] == '1' && !_playing;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _clip = clip);
      if (startObs) _play();
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    _focus.dispose();
    super.dispose();
  }

  int get _elapsedMs {
    if (_startedAt == null || !_playing) return 0;
    return DateTime.now().difference(_startedAt!).inMilliseconds;
  }

  ReelBeat get _beat {
    if (!_playing) return ReelBeat.ready;
    final t = _elapsedMs;
    if (t < _hookMs) return ReelBeat.hook;
    if (t < _hookMs + _questionMs) return ReelBeat.question;
    if (t < _hookMs + _questionMs + _countdownMs) return ReelBeat.countdown;
    return ReelBeat.close;
  }

  int get _countdownLeft {
    if (_beat != ReelBeat.countdown) return 3;
    final into = _elapsedMs - _hookMs - _questionMs;
    final left = ((_countdownMs - into) / 1000).ceil();
    return left.clamp(1, 3);
  }

  double get _countdownProgress {
    if (_beat != ReelBeat.countdown) return 0;
    final into = _elapsedMs - _hookMs - _questionMs;
    return (1 - into / _countdownMs).clamp(0.0, 1.0);
  }

  double get _timerPulse {
    if (_beat != ReelBeat.countdown) return 1;
    final into = _elapsedMs - _hookMs - _questionMs;
    final frac = (into % 1000) / 1000;
    return 1.0 + (1.0 - frac) * 0.16;
  }

  double get _stageOpacity {
    if (!_playing) return 1;
    final t = _elapsedMs;
    if (t < _fadeMs) return t / _fadeMs;
    final remain = _cycleMs - t;
    if (remain < _fadeMs) return remain / _fadeMs;
    return 1;
  }

  void _maybeTick() {
    if (!_tickSound || !_playing) return;
    if (_beat == ReelBeat.countdown) {
      final n = _countdownLeft;
      if (_lastTickSecond != n) {
        _lastTickSecond = n;
        playReelTick(frequency: 880);
      }
    } else if (_beat == ReelBeat.close) {
      if (_lastTickSecond != 0) {
        _lastTickSecond = 0;
        playReelTick(frequency: 1180);
      }
    } else {
      _lastTickSecond = null;
    }
  }

  void _play() {
    _tick?.cancel();
    unlockReelAudio();
    _lastTickSecond = null;
    setState(() {
      _playing = true;
      _startedAt = DateTime.now();
    });
    _tick = Timer.periodic(const Duration(milliseconds: 33), (_) {
      if (!mounted) return;
      if (_elapsedMs >= _cycleMs) {
        if (_loop) {
          _lastTickSecond = null;
          setState(() => _startedAt = DateTime.now());
        } else {
          _reset();
        }
        return;
      }
      _maybeTick();
      setState(() {});
    });
  }

  void _reset() {
    _tick?.cancel();
    _lastTickSecond = null;
    setState(() {
      _playing = false;
      _startedAt = null;
    });
  }

  void _onKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    unlockReelAudio();
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.space) {
      _playing ? _reset() : _play();
    } else if (key == LogicalKeyboardKey.keyR) {
      _reset();
    } else if (key == LogicalKeyboardKey.keyC) {
      setState(() => _revealMode = !_revealMode);
    } else if (key == LogicalKeyboardKey.keyL) {
      setState(() => _loop = !_loop);
    }
  }

  Widget _canvas() {
    return FittedBox(
      child: SizedBox(
        width: ReelExpressStage.designSize.width,
        height: ReelExpressStage.designSize.height,
        child: Opacity(
          opacity: _stageOpacity.clamp(0.0, 1.0),
          child: ReelExpressStage(
            clip: _clip,
            beat: _playing ? _beat : ReelBeat.question,
            countdownLeft: _countdownLeft,
            countdownProgress: _countdownProgress,
            timerPulse: _timerPulse,
            revealMode: _revealMode,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (!AdminConfig.isAdminEmail(state.authEmail)) {
      return const Scaffold(body: SizedBox.shrink());
    }

    final canvas = _canvas();

    if (_obs) {
      return KeyboardListener(
        focusNode: _focus,
        autofocus: true,
        onKeyEvent: _onKey,
        child: GestureDetector(
          onTap: unlockReelAudio,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: canvas),
          ),
        ),
      );
    }

    // Fondo oscuro de sala: usa el tema dark, no el claro de la app.
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
                title: const Text('Estudio Reels'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/app/premium'),
                ),
              ),
              body: Row(
                children: [
                  SizedBox(
                    width: 320,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text(
                          'Elige el caso de este video',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Un reel = un caso. Toca el que quieras grabar. '
                          'El piloto recomendado es PIAR. Ciclo exacto: 15,00 s.',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        for (final clip in ReelStudioPack.clips)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: ChoiceChip(
                              selected: _clip.id == clip.id,
                              label: Text(clip.label),
                              onSelected: (_) {
                                _reset();
                                setState(() => _clip = clip);
                              },
                            ),
                          ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Modo Revela'),
                          subtitle: Text(
                            _revealMode
                                ? 'Marca la correcta al cierre (capítulo 2).'
                                : 'Comenta la letra. No revela (piloto).',
                            style: theme.textTheme.bodySmall,
                          ),
                          value: _revealMode,
                          onChanged: (v) => setState(() => _revealMode = v),
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Bucle'),
                          value: _loop,
                          onChanged: (v) => setState(() => _loop = v),
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Tick de cuenta'),
                          subtitle: Text(
                            'Click en 3-2-1. En OBS captura audio de Chrome.',
                            style: theme.textTheme.bodySmall,
                          ),
                          value: _tickSound,
                          onChanged: (v) => setState(() => _tickSound = v),
                        ),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: _playing ? _reset : _play,
                          child: Text(
                            _playing ? 'Parar (espacio)' : 'Grabar (espacio)',
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () async {
                            final url =
                                'https://www.tuplazadocente.com/admin/estudio-reels?obs=1&caso=${_clip.id}';
                            await Clipboard.setData(ClipboardData(text: url));
                            if (!context.mounted) return;
                            AppSnackbars.show(
                              context,
                              message:
                                  'URL OBS copiada. Fuente de navegador 1080×1920.',
                            );
                          },
                          child: const Text('Copiar URL para OBS'),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () => context.go(
                            '/admin/estudio-reels?obs=1&caso=${_clip.id}',
                          ),
                          child: const Text('Pantalla completa OBS'),
                        ),
                        const SizedBox(height: 16),
                        ReelPublishKit(clip: _clip, revealMode: _revealMode),
                        const SizedBox(height: 16),
                        Text(
                          'OBS: captura la ventana de Chrome en 1080×1920. '
                          'Espacio = play/parar. R = reset. C = revela. L = bucle. '
                          'El registro solo aparece en los últimos 3 s. '
                          'Haz clic una vez en Chrome si quieres el tick en el video.',
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
