/// Enumeraciones de dominio del concurso docente.
library;

enum CargoAspiracion {
  docenteAula('Docente de Aula'),
  orientador('Orientador'),
  directivo('Directivo / Coordinador'),
  rector('Rector');

  const CargoAspiracion(this.label);
  final String label;

  /// Especialidad sugerida al calibrar el plan (rector/directivo → gestión).
  Especialidad? get especialidadSugerida {
    switch (this) {
      case CargoAspiracion.rector:
      case CargoAspiracion.directivo:
        return Especialidad.directivos;
      case CargoAspiracion.docenteAula:
      case CargoAspiracion.orientador:
        return null;
    }
  }

  /// Cargos de liderazgo institucional (banco de gestión directiva).
  bool get esGestionInstitucional =>
      this == CargoAspiracion.rector || this == CargoAspiracion.directivo;
}

enum Especialidad {
  preescolar('Preescolar'),
  primaria('Primaria'),
  matematicas('Matemáticas'),
  ciencias('Ciencias Naturales'),
  lenguaje('Lenguaje'),
  sociales('Ciencias Sociales'),
  directivos('Gestión directiva');

  const Especialidad(this.label);
  final String label;
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

enum SessionMode {
  practice,
  exam,
  dailyStreak,
  diagnostic,
  speedBattle,
}

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
