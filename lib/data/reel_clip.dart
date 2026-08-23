/// Tema del caso. Sirve para agrupar el catálogo en el estudio y para no
/// grabar dos reels seguidos del mismo asunto.
enum ReelGroup {
  convivencia(
    'Convivencia y Ley 1620',
    captionKeyword: 'Caso de convivencia para el Concurso Docente.',
    extraHashtag: '#ConvivenciaEscolar',
  ),
  inclusion(
    'Inclusión y PIAR',
    captionKeyword: 'Caso de inclusión y PIAR para el Concurso Docente.',
    extraHashtag: '#PIAR',
  ),
  evaluacion(
    'Evaluación y SIEE',
    captionKeyword: 'Caso de evaluación y SIEE para el Concurso Docente.',
    extraHashtag: '#SIEE',
  ),
  aula(
    'Gestión de aula',
    captionKeyword: 'Caso de gestión de aula para el Concurso Docente.',
    extraHashtag: '#GestionDeAula',
  ),
  directivo(
    'Directivo docente',
    captionKeyword: 'Caso de gestión directiva para el Concurso Docente.',
    extraHashtag: '#DirectivosDocentes',
  );

  const ReelGroup(
    this.label, {
    required this.captionKeyword,
    required this.extraHashtag,
  });

  final String label;

  /// Palabra clave para el pie de TikTok: el algoritmo categoriza el vídeo.
  final String captionKeyword;

  /// Hashtag de búsqueda del tema, además de los del pack.
  final String extraHashtag;

  /// Reconoce el tema escrito a mano (“convivencia”, “piar”, “rector”…).
  static ReelGroup? tryParse(String? raw) {
    final value = (raw ?? '').trim().toLowerCase();
    if (value.isEmpty) return null;
    for (final group in values) {
      if (value == group.name) return group;
    }
    const alias = <String, ReelGroup>{
      'convivencia': ReelGroup.convivencia,
      '1620': ReelGroup.convivencia,
      'acoso': ReelGroup.convivencia,
      'inclusion': ReelGroup.inclusion,
      'inclusión': ReelGroup.inclusion,
      'piar': ReelGroup.inclusion,
      '1421': ReelGroup.inclusion,
      'evaluacion': ReelGroup.evaluacion,
      'evaluación': ReelGroup.evaluacion,
      'siee': ReelGroup.evaluacion,
      '1290': ReelGroup.evaluacion,
      'aula': ReelGroup.aula,
      'didactica': ReelGroup.aula,
      'didáctica': ReelGroup.aula,
      'clase': ReelGroup.aula,
      'directivo': ReelGroup.directivo,
      'rector': ReelGroup.directivo,
      'coordinador': ReelGroup.directivo,
      'gestion': ReelGroup.directivo,
      'gestión': ReelGroup.directivo,
    };
    for (final entry in alias.entries) {
      if (value.contains(entry.key)) return entry.value;
    }
    return null;
  }

  static String get help => values.map((g) => g.name).join(' · ');
}

/// Caso recortado para Reels (una línea por opción). No son ítems oficiales.
///
/// Regla editorial: las cuatro opciones deben sonar razonables. Si la correcta
/// se adivina de un vistazo, el reel no genera debate en comentarios.
class ReelClip {
  /// Apertura genérica si un caso pegado no trae gancho propio.
  static const fallbackHook = '¿Pasarías esta pregunta del Concurso Docente?';

  const ReelClip({
    required this.id,
    required this.group,
    required this.label,
    required this.situation,
    required this.stem,
    required this.options,
    required this.correctIndex,
    required this.revealWhy,
    this.hook = fallbackHook,
    this.isCustom = false,
  });

  final String id;
  final ReelGroup group;
  final String label;

  /// Primera pregunta del vídeo: la trampa, no el examen.
  final String hook;
  final String situation;
  final String stem;
  final List<String> options;
  final int correctIndex;
  final String revealWhy;

  /// `true` si se creó desde el estudio (vive en Firestore, no en el código).
  final bool isCustom;

  String get correctLetter {
    const letters = ['A', 'B', 'C', 'D'];
    if (correctIndex < 0 || correctIndex >= letters.length) return '?';
    return letters[correctIndex];
  }

  /// Texto plano para buscar en el catálogo del estudio.
  String get searchText =>
      '$label $hook $situation $stem ${group.label}'.toLowerCase();

  Map<String, dynamic> toMap() {
    return {
      'group': group.name,
      'label': label,
      'hook': hook,
      'situation': situation,
      'stem': stem,
      'options': options,
      'correctIndex': correctIndex,
      'revealWhy': revealWhy,
    };
  }

  /// Devuelve `null` si el documento está incompleto, para no romper el estudio.
  static ReelClip? fromMap(String id, Map<String, dynamic> data) {
    final group = ReelGroup.tryParse(data['group'] as String?);
    final options = (data['options'] as List?)
        ?.map((o) => '$o'.trim())
        .where((o) => o.isNotEmpty)
        .toList();
    final correctIndex = data['correctIndex'];
    if (group == null ||
        options == null ||
        options.length != 4 ||
        correctIndex is! int ||
        correctIndex < 0 ||
        correctIndex > 3) {
      return null;
    }
    final label = '${data['label'] ?? ''}'.trim();
    final situation = '${data['situation'] ?? ''}'.trim();
    final stem = '${data['stem'] ?? ''}'.trim();
    if (label.isEmpty || situation.isEmpty || stem.isEmpty) return null;
    final hook = '${data['hook'] ?? ''}'.trim();
    return ReelClip(
      id: id,
      group: group,
      label: label,
      hook: hook.isEmpty ? fallbackHook : hook,
      situation: situation,
      stem: stem,
      options: options,
      correctIndex: correctIndex,
      revealWhy: '${data['revealWhy'] ?? ''}'.trim(),
      isCustom: true,
    );
  }
}
