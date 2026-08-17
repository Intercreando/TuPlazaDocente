import 'dart:js_interop';

/// Contexto Web Audio reutilizado entre ticks (Chrome / OBS).
_JsAudioContext? _ctx;

/// Desbloquea el audio tras un gesto (clic o Espacio). OBS autoplay no basta.
void unlockReelAudio() {
  try {
    _ctx ??= _JsAudioContext();
    final ctx = _ctx;
    if (ctx == null) return;
    if (ctx.state == 'suspended') {
      ctx.resume();
    }
  } catch (_) {
    // Autoplay bloqueado o AudioContext no disponible.
  }
}

/// Click corto (onda cuadrada) para la cuenta atrás.
void playReelTick({double frequency = 920}) {
  try {
    unlockReelAudio();
    final ctx = _ctx;
    if (ctx == null) return;
    final osc = ctx.createOscillator();
    final gain = ctx.createGain();
    osc.type = 'square';
    final now = ctx.currentTime;
    osc.frequency.setValueAtTime(frequency, now);
    gain.gain.setValueAtTime(0.07, now);
    gain.gain.exponentialRampToValueAtTime(0.001, now + 0.07);
    osc.connect(gain);
    gain.connect(ctx.destination);
    osc.start(now);
    osc.stop(now + 0.08);
  } catch (_) {
    // Sin audio: el video sigue; OBS a veces no captura el tab.
  }
}

@JS('AudioContext')
extension type _JsAudioContext._(JSObject _) implements JSObject {
  external factory _JsAudioContext();
  external String get state;
  external JSPromise<JSAny?> resume();
  external _JsOscillator createOscillator();
  external _JsGain createGain();
  external _JsAudioNode get destination;
  external double get currentTime;
}

@JS()
extension type _JsAudioNode._(JSObject _) implements JSObject {
  external _JsAudioNode connect(_JsAudioNode dest);
}

@JS()
extension type _JsOscillator._(JSObject _) implements _JsAudioNode {
  external set type(String value);
  external _JsParam get frequency;
  external void start([double when]);
  external void stop([double when]);
}

@JS()
extension type _JsGain._(JSObject _) implements _JsAudioNode {
  external _JsParam get gain;
}

@JS()
extension type _JsParam._(JSObject _) implements JSObject {
  external void setValueAtTime(num value, num time);
  external void exponentialRampToValueAtTime(num value, num time);
}
