import 'concurso_config.dart';

/// Estructura típica de puntajes del concurso (referencia para UI).
/// Actualizar cuando salga el acuerdo/anexo técnico de la convocatoria vigente.
abstract final class ConcursoScoringConfig {
  static const String sectionTitle = 'La radiografía del concurso';

  static const String sectionSubtitle =
      'Qué te elimina, qué pesa más y hacia dónde apuntar en el entrenamiento.';

  static const String disclaimer =
      'Estructura típica CNSC/ICFES para orientación. Los pesos exactos '
      'pueden variar por convocatoria y cargo: verifica el acuerdo oficial '
      'en cnsc.gov.co (${ConcursoConfig.year}).';

  /// Tarjeta principal: mínimo aprobatorio.
  static const String eliminatoryTitle =
      'Prueba eliminatoria · Aptitudes y competencias básicas';
  static const String eliminatoryScore = '60.0';
  static const String eliminatoryScoreSuffix = '/ 100';
  static const String eliminatoryBody =
      'Puntaje mínimo para Docentes de Aula. Si sacas menos, quedas fuera.';
  static const String eliminatoryNote =
      'Directivos docentes: mínimo 70.0 / 100';

  /// Pesos orientativos del proceso.
  static const String pedagogicalTitle = 'Conocimientos y aptitudes';
  static const String pedagogicalWeight = '55–60%';
  static const String pedagogicalBody =
      'La prueba que más pesa: lectura crítica, aptitud numérica, '
      'pedagogía y tu especialidad.';

  static const String softSkillsTitle = 'Competencias blandas';
  static const String softSkillsWeight = '10–15%';
  static const String softSkillsBody =
      'No te elimina por bajo puntaje, pero define desempates '
      'en tu municipio o zona.';

  static const String antecedentsTitle = 'Hoja de vida';
  static const String antecedentsWeight = '25–30%';
  static const String antecedentsBody =
      'Estudios y experiencia en SIMO: especialización, maestría '
      'y años de servicio suman puntos clasificatorios.';

  /// Gancho a la app.
  static const String goalTitle = 'Tu objetivo de entrenamiento';
  static const String goalScore = '+75';
  static const String goalScoreSuffix = 'puntos';
  static const String goalBody =
      'En zonas urbanas muy competidas, mantén tu promedio en '
      'simulacros por encima de 75 para acercarte a vacante.';
  static const String goalCta = 'Empezar a entrenar';
}
