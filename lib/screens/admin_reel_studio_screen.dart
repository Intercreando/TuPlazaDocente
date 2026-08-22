import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/admin_config.dart';
import '../data/reel_studio_pack.dart';
import '../services/reel_clip_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/app_snackbars.dart';
import '../utils/reel_tick.dart';
import '../utils/seo_document.dart';
import '../widgets/reel_capture_note.dart';
import '../widgets/reel_clip_composer.dart';
import '../widgets/reel_clip_picker.dart';
import '../widgets/reel_express_stage.dart';
import '../widgets/reel_publish_kit.dart';

/// Sala de grabación Reels/TikTok (solo admin). Lienzo 9:16 para OBS.
class AdminReelStudioScreen extends StatefulWidget {
  const AdminReelStudioScreen({super.key});

  @override
  State<AdminReelStudioScreen> createState() => _AdminReelStudioScreenState();
}

class _AdminReelStudioScreenState extends State<AdminReelStudioScreen> {
  /// Ciclo cerrado de 15 s: gancho, caso, cuenta y revelación.
  static const _cycleMs = ReelExpressStage.cycleMs;
  static const _hookMs = ReelExpressStage.hookMs;
  static const _countdownMs = ReelExpressStage.countdownMs;
  static const _questionMs = ReelExpressStage.questionMs;
  static const _fadeMs = ReelExpressStage.fadeMs;

  final _focus = FocusNode();
  final _clipService = ReelClipService();
  Timer? _tick;
  DateTime? _startedAt;
  ReelClip _clip = ReelStudioPack.clips.first;
  List<ReelClip> _customClips = const [];
  Set<String> _usedIds = {};
  Set<String> _hiddenIds = {};
  bool _playing = false;
  bool _ended = false;
  bool _tickSound = true;
  int? _lastTickSecond;
  ReelBeat? _lastSfxBeat;
  int _lastOptionSfx = 0;

  String? _appliedQuery;
  bool _catalogReady = false;

  /// Casos visibles en el picker (pack no oculto + creados a mano).
  List<ReelClip> get _catalog {
    final pack = ReelStudioPack.clips
        .where((clip) => !_hiddenIds.contains(clip.id))
        .toList();
    return [...pack, ..._customClips];
  }

  /// Incluye ocultos: OBS puede seguir abriendo un caso que ya se escondió.
  List<ReelClip> get _lookupCatalog => [
    ...ReelStudioPack.clips,
    ..._customClips,
  ];

  List<ReelClip> get _hiddenClips => ReelStudioPack.clips
      .where((clip) => _hiddenIds.contains(clip.id))
      .toList();

  bool get _obs {
    return GoRouterState.of(context).uri.queryParameters['obs'] == '1';
  }

  String get _obsQuery {
    return 'obs=1&caso=${Uri.encodeQueryComponent(_clip.id)}';
  }

  /// Misma forma que la barra de Chrome. Flutter Web guarda la ruta después
  /// de `#/`; si se copia sin ese numeral, OBS carga la landing.
  String get _obsShareUrl {
    return '${Uri.base.origin}/#/admin/estudio-reels?$_obsQuery';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final obs =
          GoRouterState.of(context).uri.queryParameters['obs'] == '1';
      final state = context.read<AppState>();
      // OBS abre un navegador sin sesión: el lienzo debe pintarse igual.
      // El panel de edición sí exige admin.
      if (!obs && !AdminConfig.isAdminEmail(state.authEmail)) {
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
      await _loadStudioData();
      if (!mounted) return;
      _catalogReady = true;
      _appliedQuery = null;
      _syncQuery();
    });
  }

  Future<void> _loadStudioData() async {
    final clips = await _clipService.list();
    final meta = await _clipService.loadStudioState();
    if (!mounted) return;
    setState(() {
      _customClips = clips;
      _usedIds = meta.usedIds;
      _hiddenIds = meta.hiddenIds;
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
    final clip = ReelStudioPack.byIdIn(_lookupCatalog, uri.queryParameters['caso']);
    final startObs =
        uri.queryParameters['obs'] == '1' && !_playing && _catalogReady;
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
    if (_ended) return ReelBeat.close;
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

  double get _cuePulse {
    if (_beat != ReelBeat.question) return 1;
    final phase = (_elapsedMs % 700) / 700;
    final tri = phase < 0.5 ? phase * 2 : (1 - phase) * 2;
    return 0.42 + 0.58 * tri;
  }

  int get _visibleOptions {
    if (!_playing && !_ended) return 4;
    return ReelExpressStage.optionCountAt(
      beat: _beat,
      elapsedMs: _elapsedMs,
    );
  }

  double get _stageOpacity {
    if (!_playing) return 1;
    final t = _elapsedMs;
    if (t < _fadeMs) return t / _fadeMs;
    return 1;
  }

  void _maybeSfx() {
    if (!_tickSound || !_playing) return;
    final beat = _beat;
    if (beat == ReelBeat.close && _lastSfxBeat != ReelBeat.close) {
      playReelDing();
    }
    if (beat == ReelBeat.countdown) {
      final n = _countdownLeft;
      if (_lastTickSecond != n) {
        _lastTickSecond = n;
        playReelTick(frequency: 720 + (3 - n) * 90);
      }
    } else if (beat != ReelBeat.close) {
      _lastTickSecond = null;
    }
    final shown = _visibleOptions;
    if (beat == ReelBeat.question && shown > _lastOptionSfx) {
      playReelPop();
    }
    _lastOptionSfx = shown;
    _lastSfxBeat = beat;
  }

  void _play() {
    _tick?.cancel();
    unlockReelAudio();
    _lastTickSecond = null;
    _lastSfxBeat = null;
    _lastOptionSfx = 0;
    setState(() {
      _playing = true;
      _ended = false;
      _startedAt = DateTime.now();
    });
    _tick = Timer.periodic(const Duration(milliseconds: 33), (_) {
      if (!mounted) return;
      if (_elapsedMs >= _cycleMs) {
        _holdClose();
        return;
      }
      _maybeSfx();
      setState(() {});
    });
  }

  /// Congela el último fotograma (invitación a registrarse).
  void _holdClose() {
    _tick?.cancel();
    _lastTickSecond = null;
    _lastSfxBeat = ReelBeat.close;
    setState(() {
      _playing = false;
      _ended = true;
      _startedAt = null;
    });
  }

  void _reset() {
    _tick?.cancel();
    _lastTickSecond = null;
    _lastSfxBeat = null;
    _lastOptionSfx = 0;
    setState(() {
      _playing = false;
      _ended = false;
      _startedAt = null;
    });
  }

  /// Guarda un caso escrito a mano y lo deja cargado para grabar.
  Future<bool> _saveCustomClip(ReelClip clip) async {
    try {
      await _clipService.save(clip);
      await _loadStudioData();
      if (!mounted) return true;
      _reset();
      setState(() => _clip = clip);
      AppSnackbars.show(context, message: 'Caso guardado y listo para grabar.');
      return true;
    } catch (e) {
      if (!mounted) return false;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  Future<void> _toggleUsed(ReelClip clip) async {
    final used = !_usedIds.contains(clip.id);
    try {
      await _clipService.setUsed(clip.id, used: used);
      if (!mounted) return;
      setState(() {
        if (used) {
          _usedIds = {..._usedIds, clip.id};
        } else {
          _usedIds = {..._usedIds}..remove(clip.id);
        }
      });
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _removeClip(ReelClip clip) async {
    final pack = !clip.isCustom;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(pack ? '¿Ocultar este caso?' : '¿Borrar este caso?'),
        content: Text(
          pack
              ? '“${clip.label}” dejará de salir en el catálogo. '
                    'Puedes restaurarlo más abajo.'
              : 'Se eliminará “${clip.label}” del estudio.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(pack ? 'Ocultar' : 'Borrar'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      if (pack) {
        await _clipService.setHidden(clip.id, hidden: true);
        if (!mounted) return;
        setState(() {
          _hiddenIds = {..._hiddenIds, clip.id};
          if (_clip.id == clip.id) {
            _reset();
            _clip = _catalog.isEmpty
                ? ReelStudioPack.clips.first
                : _catalog.first;
          }
        });
        AppSnackbars.show(context, message: 'Caso oculto del catálogo.');
        return;
      }
      await _clipService.delete(clip.id);
      await _loadStudioData();
      if (!mounted) return;
      if (_clip.id == clip.id) {
        _reset();
        setState(() {
          _clip = _catalog.isEmpty
              ? ReelStudioPack.clips.first
              : _catalog.first;
        });
      }
      AppSnackbars.show(context, message: 'Caso borrado.');
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _restoreClip(ReelClip clip) async {
    try {
      await _clipService.setHidden(clip.id, hidden: false);
      if (!mounted) return;
      setState(() {
        _hiddenIds = {..._hiddenIds}..remove(clip.id);
      });
      AppSnackbars.show(context, message: 'Caso restaurado.');
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _deleteCustomClip(ReelClip clip) => _removeClip(clip);

  /// Los atajos no deben dispararse mientras se escribe: un espacio en el
  /// buscador o en el compositor arrancaría la grabación.
  bool get _typingInField {
    final context = FocusManager.instance.primaryFocus?.context;
    if (context == null) return false;
    if (context.widget is EditableText) return true;
    return context.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  void _onKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    if (_typingInField) return;
    unlockReelAudio();
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.space) {
      _playing ? _reset() : _play();
    } else if (key == LogicalKeyboardKey.keyR) {
      _reset();
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
            beat: (!_playing && !_ended) ? ReelBeat.question : _beat,
            countdownLeft: _countdownLeft,
            countdownProgress: _countdownProgress,
            timerPulse: _timerPulse,
            visibleOptionCount: _visibleOptions,
            cuePulse: _cuePulse,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final canvas = _canvas();

    // Fuente de OBS: lienzo a pantalla completa, sin exigir sesión.
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

    if (!AdminConfig.isAdminEmail(state.authEmail)) {
      return const Scaffold(body: SizedBox.shrink());
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
                        ReelClipPicker(
                          catalog: _catalog,
                          selected: _clip,
                          usedIds: _usedIds,
                          hiddenClips: _hiddenClips,
                          onSelected: (clip) {
                            _reset();
                            setState(() => _clip = clip);
                          },
                          onToggleUsed: _toggleUsed,
                          onRemove: _removeClip,
                          onRestore: _restoreClip,
                        ),
                        const SizedBox(height: 12),
                        ReelClipComposer(
                          customClips: _customClips,
                          onSave: _saveCustomClip,
                          onDelete: _deleteCustomClip,
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Sonidos del ciclo'),
                          subtitle: Text(
                            'Swoosh, pop de letras, tic-tac y campana. '
                            'En OBS captura el audio de Chrome.',
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
                        const SizedBox(height: 12),
                        Text(
                          'Cómo grabar',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'El estudio se abre en Chrome, con tu cuenta. '
                          'OBS es otro programa: o captura esta ventana, '
                          'o abre el enlace en su propio navegador interno.',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () =>
                              context.go('/admin/estudio-reels?$_obsQuery'),
                          child: const Text('Ver solo el lienzo en esta pestaña'),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () async {
                            final url = _obsShareUrl;
                            await Clipboard.setData(ClipboardData(text: url));
                            if (!context.mounted) return;
                            AppSnackbars.show(
                              context,
                              message:
                                  'Enlace copiado. Pégalo dentro de OBS, '
                                  'no en la barra de Chrome.',
                            );
                          },
                          child: const Text(
                            'Copiar enlace para pegarlo dentro de OBS',
                          ),
                        ),
                        const SizedBox(height: 16),
                        const ReelCaptureNote(),
                        const SizedBox(height: 16),
                        ReelPublishKit(clip: _clip),
                        const SizedBox(height: 16),
                        Text(
                          'Atajos: espacio = play/parar. R = reset. '
                          'El vídeo pregunta, pide comentario y revela en 15 s. '
                          'Haz clic una vez en Chrome si quieres el audio en el video.',
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
