import 'dart:convert';
import 'dart:js_interop';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

/// Lectura en voz: neural (Edge vía Cloud Function) con fallback al navegador.
class TtsService extends ChangeNotifier {
  TtsService({FirebaseFunctions? functions})
      : _functions = functions ??
            FirebaseFunctions.instanceFor(region: 'southamerica-east1') {
    if (kIsWeb) {
      _warmVoices();
    }
  }

  final FirebaseFunctions _functions;

  bool _speaking = false;
  bool _loading = false;
  bool _disposed = false;
  bool _useNeural = true;
  String? _lastError;
  String? _activeKey;
  String _lang = 'es-ES';
  final List<String> _queue = [];
  web.SpeechSynthesisVoice? _spanishVoice;
  web.HTMLAudioElement? _audio;
  String? _objectUrl;

  bool get ready => kIsWeb;
  bool get isSpeaking => _speaking;
  bool get isLoading => _loading;
  String? get lastError => _lastError;
  String? get activeKey => _activeKey;

  web.SpeechSynthesis get _synth => web.window.speechSynthesis;

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  void _warmVoices() {
    try {
      _pickSpanishVoice();
      web.window.speechSynthesis.addEventListener(
        'voiceschanged',
        (web.Event _) {
          _pickSpanishVoice();
        }.toJS,
      );
    } catch (e) {
      debugPrint('TtsService warm voices: $e');
    }
  }

  void _pickSpanishVoice() {
    try {
      final voices = _synth.getVoices().toDart;
      if (voices.isEmpty) return;

      int score(web.SpeechSynthesisVoice v) {
        final name = v.name.toLowerCase();
        final lang = v.lang.toLowerCase();
        var s = 0;
        if (lang.startsWith('es-co')) s += 50;
        if (lang.startsWith('es-es')) s += 40;
        if (lang.startsWith('es-mx')) s += 35;
        if (lang.startsWith('es')) s += 20;
        if (name.contains('neural') ||
            name.contains('natural') ||
            name.contains('premium') ||
            name.contains('enhanced') ||
            name.contains('google') ||
            name.contains('microsoft') ||
            name.contains('sabina') ||
            name.contains('paulina') ||
            name.contains('salome')) {
          s += 30;
        }
        if (v.localService) s += 5;
        return s;
      }

      voices.sort((a, b) => score(b).compareTo(score(a)));
      final best = voices.first;
      if (score(best) > 0) {
        _spanishVoice = best;
        _lang = best.lang;
      }
    } catch (e) {
      debugPrint('TtsService pick voice: $e');
    }
  }

  bool isPlaying(String key) => (_speaking || _loading) && _activeKey == key;

  String _humanize(String text) {
    return text
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll('·', ',')
        .replaceAll(' | ', '. ')
        .replaceAll('/', ', ')
        // Pausas naturales para que no suene tan corrido.
        .replaceAllMapped(
          RegExp(r'\b(Decreto|Ley|Guía|Artículo|PEI|SIEE|PIAR|CNSC|ICFES)\b'),
          (m) => '${m.group(0)},',
        )
        .replaceAll(RegExp(r',\s*,'), ',')
        .replaceAll(RegExp(r'\s{2,}'), ' ')
        .trim();
  }

  List<String> _chunk(String text, {int maxLen = 1600}) {
    final cleaned = _humanize(text);
    if (cleaned.length <= maxLen) return [cleaned];

    final parts = <String>[];
    final sentences = cleaned.split(RegExp(r'(?<=[.!?¡¿;:])\s+'));
    final buffer = StringBuffer();
    for (final sentence in sentences) {
      final piece = sentence.trim();
      if (piece.isEmpty) continue;
      if (buffer.length + piece.length + 1 > maxLen && buffer.isNotEmpty) {
        parts.add(buffer.toString().trim());
        buffer.clear();
      }
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(piece);
    }
    if (buffer.isNotEmpty) parts.add(buffer.toString().trim());
    return parts.isEmpty ? [cleaned] : parts;
  }

  void _revokeObjectUrl() {
    final url = _objectUrl;
    if (url != null) {
      try {
        web.URL.revokeObjectURL(url);
      } catch (_) {}
      _objectUrl = null;
    }
  }

  /// Desbloquea audio en el mismo gesto del usuario (iOS/Android).
  void _unlockAudioElement() {
    _audio ??= web.HTMLAudioElement()..preload = 'auto';
    _audio!.src =
        'data:audio/wav;base64,UklGRigAAABXQVZFZm10IBIAAAABAAEARKwAAIhYAQACABAAAABkYXRhAgAAAAEA';
    try {
      _audio!.play();
    } catch (_) {}
  }

  void speak(String text, {required String key}) {
    if (!kIsWeb) {
      _lastError = 'La lectura en voz solo está disponible en la versión web.';
      _safeNotify();
      return;
    }

    final cleaned = _humanize(text);
    if (cleaned.isEmpty) return;

    if (isPlaying(key)) {
      stop();
      return;
    }

    _lastError = null;
    _activeKey = key;
    _queue
      ..clear()
      ..addAll(_chunk(cleaned));
    _unlockAudioElement();
    try {
      _synth.cancel();
    } catch (_) {}

    _speaking = false;
    _loading = true;
    _safeNotify();
    // ignore: discarded_futures
    _playNext();
  }

  Future<void> _playNext() async {
    if (_disposed) return;
    if (_queue.isEmpty) {
      _loading = false;
      _speaking = false;
      _activeKey = null;
      _safeNotify();
      return;
    }

    final chunk = _queue.removeAt(0);
    _loading = true;
    _safeNotify();

    if (_useNeural) {
      final ok = await _playNeuralChunk(chunk);
      if (ok) return;
      _useNeural = false;
    }

    _loading = false;
    _speaking = true;
    _safeNotify();
    _speakLocalChunk(chunk);
  }

  Future<bool> _playNeuralChunk(String chunk) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        await FirebaseAuth.instance.signInAnonymously();
      }

      final callable = _functions.httpsCallable(
        'synthesizeSpeech',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 55)),
      );
      final result = await callable.call(<String, dynamic>{
        'text': chunk,
        'voice': 'es-CO-SalomeNeural',
      });
      final data = Map<String, dynamic>.from(result.data as Map);
      final base64Audio = data['base64'] as String?;
      if (base64Audio == null || base64Audio.isEmpty) return false;

      final bytes = Uint8List.fromList(base64Decode(base64Audio));
      await _playMp3Bytes(bytes);
      return true;
    } catch (e) {
      debugPrint('TtsService neural falló: $e');
      return false;
    }
  }

  Future<void> _playMp3Bytes(Uint8List bytes) async {
    _revokeObjectUrl();
    final audio = _audio ?? web.HTMLAudioElement()
      ..preload = 'auto';
    _audio = audio;

    final jsBytes = bytes.toJS;
    final blob = web.Blob(
      [jsBytes].toJS,
      web.BlobPropertyBag(type: 'audio/mpeg'),
    );
    final url = web.URL.createObjectURL(blob);
    _objectUrl = url;
    audio.src = url;

    audio.onended = ((web.Event _) {
      // ignore: discarded_futures
      _playNext();
    }).toJS;

    audio.onerror = ((web.Event _) {
      _loading = false;
      _speaking = false;
      if (_queue.isNotEmpty) {
        // ignore: discarded_futures
        _playNext();
        return;
      }
      _activeKey = null;
      _lastError = 'No se pudo reproducir el audio neural.';
      _safeNotify();
    }).toJS;

    _loading = false;
    _speaking = true;
    _safeNotify();
    try {
      await audio.play().toDart;
    } catch (e) {
      debugPrint('TtsService audio.play: $e');
      _speaking = false;
      _loading = false;
      _lastError =
          'Activa el sonido y toca Escuchar otra vez (el navegador bloqueó el audio).';
      _safeNotify();
    }
  }

  void _speakLocalChunk(String chunk) {
    _pickSpanishVoice();
    try {
      if (_synth.paused) {
        _synth.resume();
      }
    } catch (_) {}

    try {
      final utterance = web.SpeechSynthesisUtterance(chunk);
      utterance.lang = _lang;
      // Más pausado y un tono un poco más cálido (lo máximo que permite el navegador).
      utterance.rate = 0.86;
      utterance.pitch = 1.05;
      utterance.volume = 1;
      if (_spanishVoice != null) {
        utterance.voice = _spanishVoice;
      }

      utterance.onend = ((web.Event _) {
        // ignore: discarded_futures
        _playNext();
      }).toJS;

      utterance.onerror = ((web.Event event) {
        var code = '';
        try {
          code = (event as web.SpeechSynthesisErrorEvent).error;
        } catch (_) {}
        if (code == 'interrupted' || code == 'canceled') return;
        if (_queue.isNotEmpty) {
          // ignore: discarded_futures
          _playNext();
          return;
        }
        _speaking = false;
        _activeKey = null;
        _lastError =
            'No se pudo reproducir. Revisa el volumen y el modo silencio.';
        _safeNotify();
      }).toJS;

      _synth.speak(utterance);
    } catch (e) {
      _speaking = false;
      _activeKey = null;
      _queue.clear();
      _lastError = 'Tu navegador no pudo iniciar la voz.';
      debugPrint('TtsService local speak: $e');
      _safeNotify();
    }
  }

  void stop() {
    _queue.clear();
    try {
      _synth.cancel();
    } catch (_) {}
    try {
      _audio?.pause();
      if (_audio != null) {
        _audio!.currentTime = 0;
      }
    } catch (_) {}
    _revokeObjectUrl();
    _speaking = false;
    _loading = false;
    _activeKey = null;
    _safeNotify();
  }

  void toggle(String text, {required String key}) {
    if (isPlaying(key)) {
      stop();
      return;
    }
    speak(text, key: key);
  }

  @override
  void dispose() {
    _disposed = true;
    stop();
    super.dispose();
  }
}
