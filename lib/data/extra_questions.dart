import '../models/enums.dart';
import '../models/question.dart';

/// Ampliación del banco (ítems originales adicionales + casos de aula).
abstract final class ExtraQuestions {
  static const List<Question> items = [
    Question(
      id: 'num-06',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Porcentajes',
      stem:
          'De 250 aspirantes, el 36% aprueba la primera fase. ¿Cuántos no aprueban?',
      options: ['80', '90', '160', '170'],
      correctIndex: 2,
      explanation:
          'Aprueban 0.36 × 250 = 90. No aprueban 250 − 90 = 160. '
          'Atajo: 64% de 250 = 0.64 × 250 = 160.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'num-07',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Regla de tres',
      stem:
          'Un simulacro de 80 ítems se responde en 160 minutos. '
          'A ese ritmo, ¿cuántos minutos se necesitan para 50 ítems?',
      options: ['90', '100', '110', '120'],
      correctIndex: 1,
      explanation: '160/80 = 2 min por ítem. 50 × 2 = 100 minutos.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'num-08',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Lógica matemática',
      stem:
          'Si todos los coordinadores son docentes y algunos docentes son orientadores, '
          '¿cuál afirmación es necesariamente verdadera?',
      options: [
        'Todos los orientadores son coordinadores',
        'Algunos coordinadores podrían no ser orientadores',
        'Ningún docente es coordinador',
        'Todos los docentes son coordinadores',
      ],
      correctIndex: 1,
      explanation:
          '“Todos los coordinadores son docentes” no implica que sean orientadores. '
          'Por tanto, algunos coordinadores podrían no serlo.',
      difficulty: QuestionDifficulty.avanzado,
    ),
    Question(
      id: 'lec-06',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Idea principal',
      stem:
          'Un texto argumenta que la calidad educativa mejora cuando el liderazgo '
          'distribuye responsabilidades pedagógicas y no solo administrativas. '
          'La idea principal es:',
      options: [
        'La administración escolar sobra',
        'El liderazgo pedagógico compartido impulsa la calidad',
        'Solo el rector debe decidir el currículo',
        'Las pruebas externas definen el liderazgo',
      ],
      correctIndex: 1,
      explanation:
          'La tesis central vincula calidad con liderazgo pedagógico distribuido, no meramente administrativo.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'lec-07',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Conectores',
      stem:
          '“La institución avanzó en inclusión; sin embargo, la evaluación sigue siendo homogénea.” '
          'El conector introduce:',
      options: ['Ejemplificación', 'Consecuencia', 'Contraste', 'Enumeración'],
      correctIndex: 2,
      explanation: '“Sin embargo” marca oposición entre avance inclusivo y evaluación homogénea.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'lec-08',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Inferencia',
      stem:
          '“Quienes retroalimentan con evidencia concreta elevan la autoeficacia docente.” '
          'Se infiere que:',
      options: [
        'Toda retroalimentación es inútil',
        'La calidad de la retroalimentación puede influir en la autoeficacia',
        'La autoeficacia no se relaciona con la práctica',
        'Solo los directivos dan retroalimentación',
      ],
      correctIndex: 1,
      explanation:
          'La inferencia válida se limita a la relación planteada: evidencia en feedback → posible alza de autoeficacia.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'ped-07',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Decreto 1290',
      stem:
          'Según el Decreto 1290, la evaluación de los estudiantes debe ser, entre otras:',
      options: [
        'Solo sumativa y secreta',
        'Integral, flexible y formativa',
        'Exclusiva de pruebas externas',
        'Homogénea sin ajustes',
      ],
      correctIndex: 1,
      explanation:
          'El Decreto 1290 orienta una evaluación integral, flexible y formativa, al servicio del aprendizaje.',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: ['Decreto 1290 de 2009'],
    ),
    Question(
      id: 'ped-08',
      pillar: CompetencyPillar.pedagogico,
      topic: 'PEI',
      stem:
          'Una institución actualiza su PEI sin consultar a familias ni estudiantes. La práctica es débil porque:',
      options: [
        'El PEI no requiere participación',
        'La legitimidad del PEI se construye con la comunidad educativa',
        'Solo la secretaría puede escribir el PEI',
        'El PEI se reemplaza por el PMI',
      ],
      correctIndex: 1,
      explanation:
          'La Ley 115 y la gestión escolar conciben el PEI como construcción participativa de la comunidad educativa.',
      difficulty: QuestionDifficulty.intermedio,
      normativeRefs: ['Ley 115 de 1994'],
    ),
    Question(
      id: 'com-07',
      pillar: CompetencyPillar.comportamental,
      topic: 'Trabajo en equipo',
      stem:
          'En un consejo de docentes surge una crítica dura a tu propuesta. La mejor respuesta es:',
      options: [
        'Interrumpir y defenderte de inmediato',
        'Escuchar, pedir evidencias y construir un ajuste compartido',
        'Abandonar la reunión',
        'Responder en el grupo de WhatsApp de padres',
      ],
      correctIndex: 1,
      explanation:
          'El perfil valora escucha, orientación a evidencias y construcción colectiva de acuerdos.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'com-08',
      pillar: CompetencyPillar.comportamental,
      topic: 'Orientación al ciudadano',
      stem:
          'Una familia pide explicación sobre una estrategia de apoyo. Debes:',
      options: [
        'Responder con tecnicismos sin ejemplos',
        'Explicar con claridad, empatía y siguiente paso concreto',
        'Decir que “así es la norma” y cerrar',
        'Evitar el contacto',
      ],
      correctIndex: 1,
      explanation:
          'Servicio ciudadano = claridad + empatía + ruta de acción, sin perder el marco institucional.',
      difficulty: QuestionDifficulty.basico,
    ),

    // Casos de aula ampliados
    Question(
      id: 'caso-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem:
          'Tras el reporte, ¿qué secuencia es más coherente con la ruta de atención?',
      options: [
        'Castigo inmediato público y cierre del caso',
        'Escucha a las partes, activa protocolo, registra y hace seguimiento',
        'Trasladar al estudiante sin debido proceso',
        'Publicar nombres para “crear conciencia”',
      ],
      correctIndex: 1,
      explanation:
          'La Ley 1620 exige rutas de atención, debido proceso, registro y seguimiento por el Comité de Convivencia.',
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
      caseContext:
          'Un estudiante de 8° denuncia acoso reiterado en el descanso y en un grupo de WhatsApp. '
          'Hay testigos. El agresor niega todo.',
      normativeRefs: ['Ley 1620 de 2013', 'Manual de Convivencia'],
    ),
    Question(
      id: 'caso-02',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem: '¿Cuál decisión protege mejor el derecho a la educación y la inclusión?',
      options: [
        'Eximir al estudiante de todo aprendizaje esencial',
        'Diseñar ajustes razonables en materiales, tiempo y forma de evaluar',
        'Separarlo permanentemente del aula',
        'Evaluarlo sin criterios conocidos',
      ],
      correctIndex: 1,
      explanation:
          'Inclusión = participación con ajustes razonables, manteniendo expectativas esenciales de aprendizaje.',
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
      caseContext:
          'Llega un estudiante con baja visión. El colegio tiene material visual denso y evaluaciones cronometradas idénticas para todos.',
      specialtyTags: [Especialidad.primaria, Especialidad.preescolar],
    ),
    Question(
      id: 'caso-03',
      pillar: CompetencyPillar.comportamental,
      topic: 'Casos de aula',
      stem: 'Como docente que presencia la escena, ¿qué haces primero?',
      options: [
        'Grabar y subir a redes',
        'Intervenir con calma, proteger a estudiantes y reconducir el conflicto a un espacio privado/institucional',
        'Tomar partido frente al grupo',
        'Ignorar para “no meterte”',
      ],
      correctIndex: 1,
      explanation:
          'Prioriza clima escolar, autocontrol y canales institucionales. Evita espectáculo y omisión.',
      difficulty: QuestionDifficulty.avanzado,
      isCaseStudy: true,
      caseContext:
          'Dos docentes discuten fuerte en el patio mientras estudiantes observan. El tono escala.',
    ),
    Question(
      id: 'caso-04',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem: 'La acción más alineada con evaluación formativa es:',
      options: [
        'Seguir el plan sin cambios para “cumplir temario”',
        'Reenseñar con otra estrategia, usar evidencia y ajustar la secuencia',
        'Bajar la nota a todo el curso por igual',
        'Eliminar el objetivo del periodo',
      ],
      correctIndex: 1,
      explanation:
          'La evaluación formativa convierte la evidencia de error en decisión didáctica: reenseñar y ajustar.',
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
      caseContext:
          'En fracciones, el 60% del grupo falla equivalencias. Quedan dos semanas del periodo.',
      specialtyTags: [Especialidad.matematicas, Especialidad.primaria],
      normativeRefs: ['Decreto 1290 de 2009'],
    ),
    Question(
      id: 'caso-05',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem: '¿Qué debe priorizar el equipo directivo?',
      options: [
        'Responder solo por redes sociales',
        'Activar protocolo, comunicar con respeto a la familia y proteger la intimidad del menor',
        'Minimizar el hecho para evitar “problemas de imagen”',
        'Sancionar sin investigación',
      ],
      correctIndex: 1,
      explanation:
          'Gestión directiva responsable: protocolo, comunicación cuidadosa y protección de derechos.',
      difficulty: QuestionDifficulty.avanzado,
      isCaseStudy: true,
      caseContext:
          'Una familia denuncia en portería que su hijo fue excluido de un trabajo grupal por su acento y origen.',
      specialtyTags: [Especialidad.directivos],
      normativeRefs: ['Ley 1620 de 2013', 'Manual de Convivencia'],
    ),
    Question(
      id: 'caso-06',
      pillar: CompetencyPillar.comportamental,
      topic: 'Casos de aula',
      stem: 'La respuesta más profesional es:',
      options: [
        'Prometer cambiar la nota al instante',
        'Escuchar, mostrar criterios/evidencias y explicar la ruta de aclaración',
        'Responder con el mismo tono de molestia',
        'Cerrar la puerta y no atender',
      ],
      correctIndex: 1,
      explanation:
          'Competencia de servicio: empatía + transparencia de criterios + conducto regular.',
      difficulty: QuestionDifficulty.basico,
      isCaseStudy: true,
      caseContext:
          'Un acudiente llega muy molesto porque considera injusta una nota de desempeño.',
    ),
  ];
}
