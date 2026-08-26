/// Enumeraciones de dominio del concurso docente.
library;

enum CargoAspiracion {
  docenteAula('Docente de Aula'),
  orientador('Orientador'),

  /// Incluye coordinador, rector y otros cargos de gestión institucional.
  directivo('Directivo');

  const CargoAspiracion(this.label);
  final String label;

  /// Especialidad sugerida al calibrar el plan (directivo → gestión).
  Especialidad? get especialidadSugerida {
    switch (this) {
      case CargoAspiracion.directivo:
        return Especialidad.directivos;
      case CargoAspiracion.docenteAula:
      case CargoAspiracion.orientador:
        return null;
    }
  }

  /// Cargos de liderazgo institucional (banco de gestión directiva).
  bool get esGestionInstitucional => this == CargoAspiracion.directivo;
}

/// Familia visual del catálogo (nivel, área o apoyo).
enum EspecialidadGrupo {
  nivel('Nivel educativo'),
  area('Área o asignatura'),
  apoyo('Apoyo e inclusión');

  const EspecialidadGrupo(this.label);
  final String label;
}

/// Familia de ítems cuando aún no hay banco propio de esa etiqueta.
enum EspecialidadBanco {
  pedagogico,
  preescolar,
  primaria,
  matematicas,
  ciencias,
  lenguaje,
  sociales,
  directivos,
}

enum Especialidad {
  preescolar(
    'Preescolar',
    grupo: EspecialidadGrupo.nivel,
    banco: EspecialidadBanco.preescolar,
    atajo: true,
    aliases: ['transicion', 'jardin', 'primera infancia'],
  ),
  primaria(
    'Primaria',
    grupo: EspecialidadGrupo.nivel,
    banco: EspecialidadBanco.primaria,
    atajo: true,
  ),
  secundaria(
    'Secundaria',
    grupo: EspecialidadGrupo.nivel,
    banco: EspecialidadBanco.primaria,
    aliases: ['basica secundaria', 'sexto', 'noveno'],
  ),
  media(
    'Media académica',
    grupo: EspecialidadGrupo.nivel,
    banco: EspecialidadBanco.lenguaje,
    aliases: ['bachillerato', 'decimo', 'once', 'media tecnica'],
  ),
  matematicas(
    'Matemáticas',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.matematicas,
    atajo: true,
    aliases: ['mate'],
  ),
  ciencias(
    'Ciencias Naturales',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.ciencias,
    atajo: true,
    aliases: ['biologia general', 'naturales'],
  ),
  lenguaje(
    'Lenguaje',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.lenguaje,
    atajo: true,
    aliases: ['espanol', 'castellano', 'humanidades'],
  ),
  sociales(
    'Ciencias Sociales',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.sociales,
    atajo: true,
    aliases: ['historia', 'geografia', 'economia'],
  ),
  ingles(
    'Inglés',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.lenguaje,
    aliases: ['idiomas', 'lengua extranjera'],
  ),
  artistica(
    'Educación artística',
    grupo: EspecialidadGrupo.area,
    aliases: ['artes', 'musica', 'danza', 'teatro'],
  ),
  educacionFisica(
    'Educación física',
    grupo: EspecialidadGrupo.area,
    aliases: ['ed fisica', 'deporte', 'recreacion'],
  ),
  tecnologia(
    'Tecnología e informática',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.matematicas,
    aliases: ['informatica', 'sistemas', 'tic'],
  ),
  etica(
    'Ética y valores',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.sociales,
    aliases: ['religion', 'etica y religion'],
  ),
  filosofia(
    'Filosofía',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.sociales,
  ),
  quimica(
    'Química',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.ciencias,
  ),
  fisica(
    'Física',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.ciencias,
  ),
  biologia(
    'Biología',
    grupo: EspecialidadGrupo.area,
    banco: EspecialidadBanco.ciencias,
  ),
  educacionEspecial(
    'Educación especial',
    grupo: EspecialidadGrupo.apoyo,
    banco: EspecialidadBanco.primaria,
    aliases: ['inclusion', 'nea', 'discapacidad'],
  ),
  orientacion(
    'Orientación escolar',
    grupo: EspecialidadGrupo.apoyo,
    banco: EspecialidadBanco.directivos,
    aliases: ['orientador', 'psicoorientacion'],
  ),
  directivos(
    'Gestión directiva',
    grupo: EspecialidadGrupo.apoyo,
    banco: EspecialidadBanco.directivos,
    aula: false,
    aliases: ['rector', 'coordinador', 'directivo docente'],
  );

  const Especialidad(
    this.label, {
    required this.grupo,
    this.banco = EspecialidadBanco.pedagogico,
    this.atajo = false,
    this.aula = true,
    this.aliases = const [],
  });

  final String label;
  final EspecialidadGrupo grupo;
  final EspecialidadBanco banco;
  final bool atajo;

  /// Visible en el catálogo de docente/orientador (no en directivo).
  final bool aula;
  final List<String> aliases;

  /// Etiqueta de banco con ítems ya escritos; `null` = pedagógico general.
  Especialidad? get especialidadDeBanco {
    switch (banco) {
      case EspecialidadBanco.pedagogico:
        return null;
      case EspecialidadBanco.preescolar:
        return Especialidad.preescolar;
      case EspecialidadBanco.primaria:
        return Especialidad.primaria;
      case EspecialidadBanco.matematicas:
        return Especialidad.matematicas;
      case EspecialidadBanco.ciencias:
        return Especialidad.ciencias;
      case EspecialidadBanco.lenguaje:
        return Especialidad.lenguaje;
      case EspecialidadBanco.sociales:
        return Especialidad.sociales;
      case EspecialidadBanco.directivos:
        return Especialidad.directivos;
    }
  }

  bool coincideBusqueda(String needle) {
    if (needle.isEmpty) return true;
    if (_sinTilde(label).contains(needle)) return true;
    for (final alias in aliases) {
      if (_sinTilde(alias).contains(needle)) return true;
    }
    return false;
  }

  static const portada = [
    preescolar,
    primaria,
    matematicas,
    ciencias,
    lenguaje,
    sociales,
    directivos,
  ];

  static List<Especialidad> paraCargo(CargoAspiracion? cargo) {
    if (cargo != null && cargo.esGestionInstitucional) {
      return const [Especialidad.directivos];
    }
    return [...values.where((e) => e.aula), Especialidad.directivos];
  }

  static List<Especialidad> atajosPara(CargoAspiracion? cargo) {
    return paraCargo(cargo).where((e) => e.atajo).toList();
  }

  static List<Especialidad> buscar(String query, {CargoAspiracion? cargo}) {
    final needle = _sinTilde(query);
    return paraCargo(cargo).where((e) => e.coincideBusqueda(needle)).toList();
  }
}

String _sinTilde(String raw) {
  const from = 'áàäâãéèëêíìïîóòöôõúùüûñç';
  const to = 'aaaaaeeeeiiiiooooouuuunc';
  var value = raw.toLowerCase().trim();
  for (var i = 0; i < from.length; i++) {
    value = value.replaceAll(from[i], to[i]);
  }
  return value
      .replaceAll(RegExp(r'[^a-z0-9ñ\s]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

enum CompetencyPillar {
  aptitudNumerica('Aptitud Numérica', 'num'),
  lecturaCritica('Lectura Crítica', 'lec'),
  pedagogico('Componente Pedagógico', 'ped'),
  comportamental('Prueba Comportamental', 'com');

  const CompetencyPillar(this.label, this.shortCode);
  final String label;
  final String shortCode;
}

enum SessionMode { practice, exam, dailyStreak, diagnostic, speedBattle }

enum QuestionDifficulty {
  /// Nivel 1 — Reto rápido (~45s).
  basico(1, 45, 'Rápida'),

  /// Nivel 2 — Simulacro estándar (~90s).
  intermedio(2, 90, 'Estándar'),

  /// Nivel 3 — Alta exigencia / casos largos (~120s).
  avanzado(3, 120, 'Alta exigencia');

  const QuestionDifficulty(this.level, this.defaultSeconds, this.label);
  final int level;
  final int defaultSeconds;
  final String label;

  static QuestionDifficulty fromLevel(int level) {
    return QuestionDifficulty.values.firstWhere(
      (d) => d.level == level,
      orElse: () => QuestionDifficulty.intermedio,
    );
  }
}
