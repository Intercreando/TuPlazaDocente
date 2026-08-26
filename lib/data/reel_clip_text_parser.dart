import 'reel_clip.dart';

/// Resultado de leer el texto pegado en el estudio.
class ReelClipDraft {
  const ReelClipDraft({
    this.clip,
    this.errors = const [],
    this.warnings = const [],
  });

  /// Caso listo para guardar, o `null` si el texto no alcanza.
  final ReelClip? clip;

  /// Impiden guardar (falta un dato o hay algo inválido).
  final List<String> errors;

  /// No impiden guardar, pero el texto se verá apretado en el lienzo.
  final List<String> warnings;

  bool get isValid => clip != null && errors.isEmpty;
}

/// Umbrales de aviso: no bloquean el guardado; el lienzo encoge el texto.
class ClipParseLimits {
  const ClipParseLimits({
    required this.maxLabel,
    required this.maxHook,
    required this.maxSituation,
    required this.maxStem,
    required this.maxOption,
    required this.maxWhy,
  });

  final int maxLabel;
  final int maxHook;
  final int maxSituation;
  final int maxStem;
  final int maxOption;
  final int maxWhy;

  /// Lienzo vertical de Reels (1080×1920).
  static const reel = ClipParseLimits(
    maxLabel: 44,
    maxHook: 56,
    maxSituation: 260,
    maxStem: 90,
    maxOption: 95,
    maxWhy: 150,
  );

  /// Lienzo 16:9 de YouTube: cabe más enunciado.
  static const live = ClipParseLimits(
    maxLabel: 72,
    maxHook: 110,
    maxSituation: 1400,
    maxStem: 520,
    maxOption: 240,
    maxWhy: 420,
  );
}

/// Lee un caso escrito a mano en texto plano y lo convierte en `ReelClip`.
///
/// El formato es deliberadamente flexible: etiquetas en español con o sin
/// tildes, opciones marcadas con `A)`, `A.`, `A-` o `A:`, y la correcta indicada
/// con `Correcta: B` o con un asterisco al final de la opción.
abstract final class ReelClipTextParser {
  /// Compatibilidad con tests y el compositor de Reels.
  static const maxLabel = 44;
  static const maxHook = 56;
  static const maxSituation = 260;
  static const maxStem = 90;
  static const maxOption = 95;
  static const maxWhy = 150;

  static const plantilla = '''
Tema: convivencia
Título: WhatsApp · el grupo del curso
Hook: ¿Respetas el silencio y no avisas a la casa?
Caso: En el grupo de WhatsApp que creaste para tareas, tres estudiantes se burlan de una compañera. Ella pide que no pase nada y que no llames a su casa.
Pregunta: ¿Qué haces?
A) Guardar evidencia, activar la ruta y acompañarla.
B) Respetar su silencio: si ella no denuncia, no hay caso.
C) Sacar del grupo a los tres y borrar los mensajes.
D) Escribir un llamado general al respeto y observar una semana.
Correcta: A
Porque: Si hay daño a un estudiante no hay silencio pactado: se protege y se registra.
''';

  static const _labels = <String, String>{
    'tema': 'group',
    'grupo': 'group',
    'titulo': 'label',
    'título': 'label',
    'nombre': 'label',
    'hook': 'hook',
    'gancho': 'hook',
    'apertura': 'hook',
    'caso': 'situation',
    'situacion': 'situation',
    'situación': 'situation',
    'contexto': 'situation',
    'pregunta': 'stem',
    'enunciado': 'stem',
    'correcta': 'correct',
    'respuesta': 'correct',
    'porque': 'why',
    'porqué': 'why',
    'por qué': 'why',
    'explicacion': 'why',
    'explicación': 'why',
    'razon': 'why',
    'razón': 'why',
  };

  static ReelClipDraft parse(
    String raw, {
    String? existingId,
    ClipParseLimits limits = ClipParseLimits.reel,
  }) {
    final fields = <String, String>{};
    final options = <String>[];
    var markedOption = -1;
    String? lastKey;

    for (final rawLine in raw.split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty) continue;

      final option = _readOption(line);
      if (option != null) {
        if (option.marked) markedOption = options.length;
        options.add(option.text);
        lastKey = null;
        continue;
      }

      final field = _readField(line);
      if (field != null) {
        fields[field.key] = field.value;
        lastKey = field.key;
        continue;
      }

      // Línea suelta: continúa el último campo (casos de varios párrafos).
      if (lastKey != null) {
        fields[lastKey] = '${fields[lastKey]} $line'.trim();
      }
    }

    final errors = <String>[];
    final warnings = <String>[];

    final group = ReelGroup.tryParse(fields['group']);
    if (group == null) {
      errors.add(
        'Falta el tema. Escribe “Tema:” con uno de estos: ${ReelGroup.help}.',
      );
    }

    final label = fields['label'] ?? '';
    if (label.isEmpty) errors.add('Falta el “Título:” del caso.');

    final situation = fields['situation'] ?? '';
    if (situation.isEmpty) errors.add('Falta el “Caso:” (la situación).');

    final stem = fields['stem'] ?? '';
    if (stem.isEmpty) errors.add('Falta la “Pregunta:”.');

    if (options.length != 4) {
      errors.add(
        'Se necesitan 4 opciones en líneas que empiecen por A) B) C) D). '
        'Encontré ${options.length}.',
      );
    }

    final correctIndex = _readCorrect(fields['correct']) ?? markedOption;
    if (correctIndex < 0 || correctIndex > 3) {
      errors.add('Falta indicar la correcta: “Correcta: B” o un * al final.');
    } else if (options.length == 4 && correctIndex >= options.length) {
      errors.add('La letra correcta no coincide con las opciones.');
    }

    final why = fields['why'] ?? '';
    if (why.isEmpty) {
      warnings.add('Sin “Porque:” el cierre del vídeo queda sin justificación.');
    }

    _warnLength(warnings, 'El título', label, limits.maxLabel);
    final hook = fields['hook'] ?? '';
    _warnLength(warnings, 'El gancho', hook, limits.maxHook);
    _warnLength(warnings, 'El caso', situation, limits.maxSituation);
    _warnLength(warnings, 'La pregunta', stem, limits.maxStem);
    _warnLength(warnings, 'El porqué', why, limits.maxWhy);
    for (final option in options) {
      _warnLength(
        warnings,
        'La opción “${_short(option)}”',
        option,
        limits.maxOption,
      );
    }

    if (errors.isNotEmpty) {
      return ReelClipDraft(errors: errors, warnings: warnings);
    }

    return ReelClipDraft(
      clip: ReelClip(
        id: existingId ?? _slug(label),
        group: group!,
        label: label,
        hook: hook.isEmpty ? ReelClip.fallbackHook : hook,
        situation: situation,
        stem: stem,
        options: options,
        correctIndex: correctIndex,
        revealWhy: why,
        isCustom: true,
      ),
      warnings: warnings,
    );
  }

  static ({String key, String value})? _readField(String line) {
    final index = line.indexOf(':');
    if (index <= 0) return null;
    final name = line.substring(0, index).trim().toLowerCase();
    final key = _labels[name];
    if (key == null) return null;
    return (key: key, value: line.substring(index + 1).trim());
  }

  static ({String text, bool marked})? _readOption(String line) {
    final match = RegExp(r'^([A-Da-d])\s*[\)\.\-:]\s*(.+)$').firstMatch(line);
    if (match == null) return null;
    var text = match.group(2)!.trim();
    var marked = false;
    if (text.startsWith('*')) {
      marked = true;
      text = text.substring(1).trim();
    }
    if (text.endsWith('*')) {
      marked = true;
      text = text.substring(0, text.length - 1).trim();
    }
    if (text.isEmpty) return null;
    return (text: text, marked: marked);
  }

  static int? _readCorrect(String? raw) {
    final value = (raw ?? '').trim().toUpperCase();
    if (value.isEmpty) return null;
    const letters = ['A', 'B', 'C', 'D'];
    final index = letters.indexOf(value[0]);
    return index >= 0 ? index : null;
  }

  static void _warnLength(
    List<String> warnings,
    String what,
    String value,
    int max,
  ) {
    if (value.length <= max) return;
    warnings.add(
      '$what es largo (${value.length} de $max). Se verá más pequeño.',
    );
  }

  static String _short(String value) {
    return value.length <= 18 ? value : '${value.substring(0, 18)}…';
  }

  /// Identificador legible y estable a partir del título.
  static String _slug(String label) {
    const from = 'áàäâãéèëêíìïîóòöôõúùüûñç';
    const to = 'aaaaaeeeeiiiiooooouuuunc';
    var value = label.toLowerCase();
    for (var i = 0; i < from.length; i++) {
      value = value.replaceAll(from[i], to[i]);
    }
    value = value.replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    value = value.replaceAll(RegExp(r'^-+|-+$'), '');
    if (value.length > 40) value = value.substring(0, 40);
    if (value.isEmpty) value = 'caso';
    final stamp = DateTime.now().millisecondsSinceEpoch
        .toRadixString(36)
        .substring(4);
    return '$value-$stamp';
  }
}
