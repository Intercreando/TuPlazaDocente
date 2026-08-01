/// Enumeraciones de dominio del concurso docente.
library;

enum CargoAspiracion {
  docenteAula('Docente de Aula'),
  orientador('Orientador'),
  directivo('Directivo / Coordinador');

  const CargoAspiracion(this.label);
  final String label;
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
  basico,
  intermedio,
  avanzado,
}
