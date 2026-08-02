/// Taxonomía oficial del "cerebro" TuPlazaDocente (CNSC/ICFES + MEN).
library;

/// Familia de conocimiento que sustenta el ítem.
enum KnowledgeFamily {
  marcoNormativo('Marco normativo'),
  teoriasAprendizaje('Teorías del aprendizaje'),
  referentesCalidad('Referentes de calidad MEN'),
  aptitudCognitiva('Aptitud cognitiva'),
  competenciasComportamentales('Competencias comportamentales');

  const KnowledgeFamily(this.label);
  final String label;
}

/// Código canónico de norma / teoría / referente.
enum KnowledgeCode {
  // Normativo
  decreto1278('D.1278/2002', 'Estatuto de Profesionalización Docente', KnowledgeFamily.marcoNormativo),
  decreto1860('D.1860/1994', 'Reglamentación Ley 115 (PEI y gobierno escolar)', KnowledgeFamily.marcoNormativo),
  decreto1290('D.1290/2009', 'Evaluación del aprendizaje y promoción', KnowledgeFamily.marcoNormativo),
  decreto1421('D.1421/2017', 'Educación inclusiva, PIAR y ajustes razonables', KnowledgeFamily.marcoNormativo),
  ley115('Ley 115/1994', 'Ley General de Educación', KnowledgeFamily.marcoNormativo),
  ley1620('Ley 1620/2013', 'Convivencia escolar', KnowledgeFamily.marcoNormativo),
  guiaMen49('Guía MEN 49', 'Convivencia escolar y manual de convivencia', KnowledgeFamily.marcoNormativo),
  guiaMen50('Guía MEN 50', 'Educación inicial / gestión', KnowledgeFamily.marcoNormativo),
  guiaMen51('Guía MEN 51', 'Convivencia y rutas de atención', KnowledgeFamily.marcoNormativo),

  // Teorías
  piaget('Piaget', 'Constructivismo y estadios del desarrollo', KnowledgeFamily.teoriasAprendizaje),
  vygotsky('Vygotsky', 'ZDP, andamiaje y aprendizaje sociocultural', KnowledgeFamily.teoriasAprendizaje),
  ausubel('Ausubel', 'Aprendizaje significativo y saberes previos', KnowledgeFamily.teoriasAprendizaje),
  bruner('Bruner', 'Descubrimiento y representación', KnowledgeFamily.teoriasAprendizaje),

  // Calidad MEN
  ebc('EBC', 'Estándares Básicos de Competencias', KnowledgeFamily.referentesCalidad),
  dba('DBA', 'Derechos Básicos de Aprendizaje', KnowledgeFamily.referentesCalidad),
  lineamientos('Lineamientos', 'Lineamientos curriculares por área', KnowledgeFamily.referentesCalidad);

  const KnowledgeCode(this.shortLabel, this.title, this.family);
  final String shortLabel;
  final String title;
  final KnowledgeFamily family;
}

/// Módulo curricular del banco (capa de producto).
enum ContentModule {
  pedagogiaEvaluacion('Pedagogía y evaluación formativa'),
  inclusionConvivencia('Inclusión y convivencia escolar'),
  curriculumReferentes('Currículo y referentes MEN'),
  gestionInstitucional('Gestión institucional y PEI'),
  aptitudNumerica('Aptitud numérica'),
  lecturaCritica('Lectura crítica'),
  comportamental('Competencias comportamentales');

  const ContentModule(this.label);
  final String label;
}

/// Etiqueta de conocimiento ligada a un ítem.
class KnowledgeTag {
  const KnowledgeTag({
    required this.code,
    this.articleOrFocus,
  });

  final KnowledgeCode code;
  final String? articleOrFocus;

  String get display {
    if (articleOrFocus == null || articleOrFocus!.isEmpty) {
      return code.shortLabel;
    }
    return '${code.shortLabel} · $articleOrFocus';
  }
}
