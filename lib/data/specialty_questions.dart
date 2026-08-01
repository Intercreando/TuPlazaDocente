import '../models/enums.dart';
import '../models/question.dart';

/// Ítems orientados a especialidad / nivel.
abstract final class SpecialtyQuestions {
  static const List<Question> items = [
    Question(
      id: 'esp-mat-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Didáctica de matemáticas',
      stem:
          'Para introducir fracciones equivalentes en primaria, la secuencia más sólida es:',
      options: [
        'Definición formal → ejercicios abstractos → concreto',
        'Material concreto → representación gráfica → simbolización',
        'Solo algoritmos de amplificación',
        'Memorizar tablas sin sentido',
      ],
      correctIndex: 1,
      explanation:
          'La trayectoria concreto → pictórico → simbólico favorece comprensión conceptual antes del algoritmo.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.matematicas, Especialidad.primaria],
    ),
    Question(
      id: 'esp-mat-02',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Razonamiento proporcional',
      stem:
          'Si 3/5 de un grupo de 40 estudiantes domina un indicador, ¿cuántos aún no lo dominan?',
      options: ['8', '16', '24', '32'],
      correctIndex: 1,
      explanation: 'Dominan (3/5)×40 = 24. No dominan 40 − 24 = 16.',
      difficulty: QuestionDifficulty.basico,
      specialtyTags: [Especialidad.matematicas],
    ),
    Question(
      id: 'esp-len-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Comprensión lectora',
      stem:
          'En lenguaje, una estrategia formativa potente tras una lectura argumentativa es:',
      options: [
        'Solo calificar ortografía',
        'Pedir que identifiquen tesis, argumentos y contraargumentos con evidencia del texto',
        'Copiar el texto completo',
        'Evitar el debate',
      ],
      correctIndex: 1,
      explanation:
          'Enseña estructura argumentativa y metacognición lectora, alineada a lectura crítica del concurso.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.lenguaje],
    ),
    Question(
      id: 'esp-len-02',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Género discursivo',
      stem:
          'Un texto que presenta una tesis, argumentos y una conclusión persuasiva pertenece principalmente a:',
      options: [
        'Narración literaria',
        'Discurso argumentativo',
        'Instructivo técnico',
        'Descripción científica pura',
      ],
      correctIndex: 1,
      explanation:
          'La presencia de tesis + argumentos + conclusión persuasiva tipifica el discurso argumentativo.',
      difficulty: QuestionDifficulty.basico,
      specialtyTags: [Especialidad.lenguaje],
    ),
    Question(
      id: 'esp-cie-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Indagación científica',
      stem:
          'En ciencias naturales, el enfoque de indagación prioriza que el estudiante:',
      options: [
        'Memorice definiciones sin experimentación',
        'Formule preguntas, explore evidencias y construya explicaciones',
        'Copie el informe del docente',
        'Evite el error experimental',
      ],
      correctIndex: 1,
      explanation:
          'La indagación centra el aprendizaje en preguntas, evidencia y explicación, no en la memorización aislada.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.ciencias],
    ),
    Question(
      id: 'esp-soc-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Pensamiento social',
      stem:
          'Una clase de sociales sobre conflicto escolar gana potencia cuando:',
      options: [
        'Se impone una sola versión histórica',
        'Se analizan causas, actores, normas y posibles resoluciones pacíficas',
        'Se evita cualquier controversia',
        'Solo se memorizan fechas',
      ],
      correctIndex: 1,
      explanation:
          'El pensamiento social crítico articula contexto, actores, normatividad y alternativas de resolución.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.sociales],
    ),
    Question(
      id: 'esp-pre-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Primera infancia',
      stem:
          'En preescolar, la evaluación más coherente con el desarrollo es:',
      options: [
        'Exámenes escritos estandarizados diarios',
        'Observación sistemática del juego, el lenguaje y la interacción',
        'Rankings públicos de niños',
        'Solo calificación numérica final',
      ],
      correctIndex: 1,
      explanation:
          'En primera infancia prima la observación del desarrollo en contextos naturales de juego y lenguaje.',
      difficulty: QuestionDifficulty.basico,
      specialtyTags: [Especialidad.preescolar],
    ),
    Question(
      id: 'esp-pri-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Gestión de aula',
      stem:
          'Para un grupo de primaria con alta dispersión, la mejor primera medida es:',
      options: [
        'Aumentar castigos colectivos',
        'Establecer rutinas claras, expectativas compartidas y acompañamiento cercano',
        'Ignorar la dispersión',
        'Eliminar el recreo',
      ],
      correctIndex: 1,
      explanation:
          'La gestión preventiva (rutinas + expectativas + presencia pedagógica) reduce dispersión mejor que el castigo reactivo.',
      difficulty: QuestionDifficulty.basico,
      specialtyTags: [Especialidad.primaria],
    ),
    Question(
      id: 'esp-dir-01',
      pillar: CompetencyPillar.comportamental,
      topic: 'Liderazgo directivo',
      stem:
          'Un coordinador quiere mejorar resultados de lectura. La acción inicial más estratégica es:',
      options: [
        'Sancionar docentes sin diagnóstico',
        'Analizar evidencias por grado, acordar meta común y acompañar aulas',
        'Comprar software sin plan',
        'Cambiar el PEI sin la comunidad',
      ],
      correctIndex: 1,
      explanation:
          'Liderazgo pedagógico: evidencia → meta compartida → acompañamiento situacional en el aula.',
      difficulty: QuestionDifficulty.avanzado,
      specialtyTags: [Especialidad.directivos],
    ),
    Question(
      id: 'esp-dir-02',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Gestión escolar',
      stem:
          'El PMI y el PEI se relacionan mejor cuando:',
      options: [
        'Son documentos aislados',
        'El PMI opera mejoras alineadas a la identidad y metas del PEI',
        'Solo el PMI importa para supervisión',
        'El PEI se actualiza cada semana sin criterios',
      ],
      correctIndex: 1,
      explanation:
          'Coherencia institucional: el plan de mejoramiento debe servir a la visión y prioridades del PEI.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.directivos],
    ),
  ];
}
