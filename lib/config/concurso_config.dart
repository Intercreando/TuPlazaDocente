/// Datos públicos del concurso vigente (actualizar cuando CNSC/MEN cambien etapa).
abstract final class ConcursoConfig {
  static const String year = '2026';

  static const String shortName = 'Concurso Docente CNSC $year';

  static const String fullName =
      'Concurso de Ingreso a la Carrera Docente $year';

  /// Fase corta para badge del hero.
  static const String phaseShort = 'Planeación finalizada';

  /// Detalle honesto de la etapa (sujeto a cronograma oficial).
  static const String phaseDetail =
      'CNSC/MEN cerraron la planeación. Próximo: proyectos de acuerdo, '
      'anexo técnico y OPEC (proyectado sept. $year). Inscripciones '
      'estimadas nov–dic $year.';

  static const String badgeLabel =
      '$shortName · $phaseShort';
}
