import 'dart:js_interop';

/// Contexto Web Audio reutilizado entre efectos (Chrome / OBS).
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
/// Gain alto: OBS mezcla el tab con el resto y a 0.07 se oía casi nada.
void playReelTick({double frequency = 920, double gain = 0.34}) {
  _tone(frequency: frequency, seconds: 0.11, gain: gain, type: 'square');
}

/// El gancho (0–2 s) va en silencio a propósito.
void playReelSwoosh() {}

/// Pop al aparecer cada letra.
void playReelPop() {
  _tone(frequency: 640, seconds: 0.06, gain: 0.24, type: 'triangle');
}

/// Campana de acierto (reserva; el cierre ya no revela la letra).
void playReelDing() {
  _tone(frequency: 1046, seconds: 0.32, gain: 0.22, type: 'sine');
  _tone(
    frequency: 1568,
    seconds: 0.38,
    gain: 0.16,
    type: 'sine',
    delay: 0.04,
  );
}

void _tone({
  required double frequency,
  required double seconds,
  required double gain,
  required String type,
  double toFrequency = 0,
  double delay = 0,
}) {
  try {
    unlockReelAudio();
    final ctx = _ctx;
    if (ctx == null) return;
    final osc = ctx.createOscillator();
    final amp = ctx.createGain();
    osc.type = type;
    final now = ctx.currentTime + delay;
    osc.frequency.setValueAtTime(frequency, now);
    if (toFrequency > 0) {
      osc.frequency.exponentialRampToValueAtTime(toFrequency, now + seconds);
    }
    amp.gain.setValueAtTime(gain, now);
    amp.gain.exponentialRampToValueAtTime(0.001, now + seconds);
    osc.connect(amp);
    amp.connect(ctx.destination);
    osc.start(now);
    osc.stop(now + seconds + 0.02);
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
