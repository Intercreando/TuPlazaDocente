import '../models/enums.dart';
import '../models/question.dart';

/// Segundo bloque calibrado al estilo CNSC/ICFES (ítems originales).
abstract final class CalibratedBank {
  static const List<Question> items = [
    // Numérica
    Question(
      id: 'cal-num-01',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Porcentajes',
      stem:
          'Un docente mejora su precisión de 60% a 75% en un pilar. '
          '¿Cuál fue el aumento porcentual relativo sobre el valor inicial?',
      options: ['15%', '20%', '25%', '30%'],
      correctIndex: 2,
      explanation:
          'Aumento absoluto = 15 puntos. Relativo: 15/60 = 0.25 = 25%. '
          'No confundas puntos porcentuales con variación relativa.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-num-02',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Regla de tres',
      stem:
          'Si 15 aspirantes resuelven un taller en 6 horas, ¿cuántas horas '
          'necesitarían 9 aspirantes al mismo ritmo (trabajo inverso)?',
      options: ['4', '8', '9', '10'],
      correctIndex: 3,
      explanation:
          'Más personas → menos tiempo. 15×6 = 90 “aspirante-hora”; 90/9 = 10 horas.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-num-03',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Promedios',
      stem:
          'Los puntajes de cuatro simulacros son 62, 70, 74 y 66. '
          '¿Qué puntaje se necesita en el quinto para promedio 70?',
      options: ['70', '74', '78', '82'],
      correctIndex: 2,
      explanation: 'Suma actual 272. Para promedio 70 en 5 pruebas: 350. Falta 350−272 = 78.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-num-04',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Proporciones',
      stem:
          'En un aula la razón niñas:niños es 5:3. Si hay 24 niños, ¿cuántas niñas hay?',
      options: ['30', '35', '40', '45'],
      correctIndex: 2,
      explanation: '3 partes = 24 → 1 parte = 8. Niñas = 5×8 = 40.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-num-05',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Lógica matemática',
      stem:
          'Un reloj se atrasa 3 minutos cada hora real. Si se sincroniza a las 12:00, '
          '¿qué hora marcará cuando sean las 16:00 reales?',
      options: ['15:48', '15:50', '15:52', '16:12'],
      correctIndex: 0,
      explanation: 'En 4 horas se atrasa 12 minutos → marca 15:48.',
      difficulty: QuestionDifficulty.avanzado,
    ),

    // Lectura
    Question(
      id: 'cal-lec-01',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Premisas',
      stem:
          '“Todo plan de aula coherente parte de evidencias de aprendizaje. '
          'Este plan no usó evidencias. Por tanto, no es coherente.” La estructura es:',
      options: [
        'Analogía',
        'Modus tollens',
        'Generalización apresurada',
        'Falsa causa',
      ],
      correctIndex: 1,
      explanation:
          'Si P→Q y no Q, entonces no P. Aquí: evidencia→coherencia; no evidencia ⇒ no coherente.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-lec-02',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Conectores',
      stem:
          '“La inclusión exige ajustes; por consiguiente, evaluar igual a todos sin criterios '
          'diferenciados puede vulnerar derechos.” “Por consiguiente” indica:',
      options: ['Concesión', 'Ejemplo', 'Consecuencia', 'Oposición'],
      correctIndex: 2,
      explanation: '“Por consiguiente” introduce una conclusión/consecuencia lógica.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-lec-03',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Idea principal',
      stem:
          'Un texto sostiene que la convivencia escolar no se reduce a sanción, sino a '
          'formación ciudadana y restauración. La idea principal es:',
      options: [
        'La sanción es inútil siempre',
        'La convivencia exige enfoque formativo y restaurativo',
        'Solo el comité decide todo',
        'Las familias no participan',
      ],
      correctIndex: 1,
      explanation:
          'La tesis amplía convivencia más allá del castigo: formación y restauración.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-lec-04',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Inferencia',
      stem:
          '“Los colegios que acompañan la planeación entre pares mejoran la coherencia curricular.” '
          'Se puede inferir que:',
      options: [
        'El trabajo colaborativo docente puede fortalecer coherencia',
        'Sin pares no hay currículo',
        'Solo directivos planean',
        'Las pruebas externas sobran',
      ],
      correctIndex: 0,
      explanation:
          'La inferencia válida se limita a la relación planteada: acompañamiento entre pares ↔ coherencia.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-lec-05',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Supuestos',
      stem:
          '“Sin evaluación formativa no hay mejora sostenible del aprendizaje.” '
          'Un supuesto implícito es:',
      options: [
        'La evaluación formativa contribuye a sostener mejoras',
        'Solo las pruebas externas importan',
        'Los estudiantes no necesitan retroalimentación',
        'El currículo es irrelevante',
      ],
      correctIndex: 0,
      explanation:
          'El enunciado asume que la evaluación formativa es condición relevante de mejora sostenible.',
      difficulty: QuestionDifficulty.avanzado,
    ),

    // Pedagógico
    Question(
      id: 'cal-ped-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Evaluación formativa',
      stem:
          'Una rúbrica compartida antes de la producción y usada para reenseñar es evidencia de:',
      options: [
        'Evaluación punitiva',
        'Evaluación formativa',
        'Promoción automática',
        'Homologación externa',
      ],
      correctIndex: 1,
      explanation:
          'Criterios previos + uso de evidencia para ajustar enseñanza = evaluación formativa (D.1290).',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: ['Decreto 1290 de 2009'],
    ),
    Question(
      id: 'cal-ped-02',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Ley 115',
      stem:
          'Según la Ley 115, la educación es un proceso que busca, entre otros fines:',
      options: [
        'Solo empleabilidad inmediata',
        'Formación integral de la persona y ejercicio de la ciudadanía',
        'Eliminar la autonomía escolar',
        'Sustituir a la familia',
      ],
      correctIndex: 1,
      explanation:
          'La Ley General de Educación orienta a formación integral y ciudadanía, no a un fin único laboral.',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: ['Ley 115 de 1994'],
    ),
    Question(
      id: 'cal-ped-03',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Inclusión',
      stem:
          'Un ajuste razonable correcto en evaluación implica:',
      options: [
        'Eliminar aprendizajes esenciales',
        'Cambiar forma/tiempo/apoyos manteniendo metas esenciales',
        'Separar permanentemente al estudiante',
        'No evaluar nunca',
      ],
      correctIndex: 1,
      explanation:
          'Ajuste razonable ≠ bajar expectativa esencial; cambia condiciones de acceso y demostración.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-ped-04',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Currículo',
      stem:
          'La coherencia horizontal del currículo se observa cuando:',
      options: [
        'Las áreas se ignoran entre sí',
        'Hay articulación entre áreas/proyectos en el mismo grado o ciclo',
        'Solo se enseña para la prueba',
        'Cada docente inventa sin acuerdos',
      ],
      correctIndex: 1,
      explanation:
          'Coherencia horizontal = diálogo entre áreas/proyectos en un mismo nivel o ciclo.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-ped-05',
      pillar: CompetencyPillar.pedagogico,
      topic: 'PEI',
      stem:
          'El PEI pierde legitimidad principalmente cuando:',
      options: [
        'Se construye con la comunidad educativa',
        'Se impone sin participación ni sentido compartido',
        'Orienta la gestión institucional',
        'Se revisa periódicamente',
      ],
      correctIndex: 1,
      explanation:
          'El PEI es pacto de identidad institucional; sin participación pierde apropiación y legitimidad.',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: ['Ley 115 de 1994'],
    ),
    Question(
      id: 'cal-ped-06',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem:
          'Ante un conflicto grave entre estudiantes, la institución debe priorizar:',
      options: [
        'Exposición pública en redes',
        'Ruta del Manual de Convivencia y debido proceso',
        'Silencio absoluto sin registro',
        'Sanción sin investigación',
      ],
      correctIndex: 1,
      explanation:
          'Ley 1620: rutas, debido proceso, registro y seguimiento institucional.',
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
      caseContext:
          'Dos estudiantes de 9° tuvieron una agresión física en el descanso. Hay lesionados leves y versiones cruzadas.',
      normativeRefs: ['Ley 1620 de 2013', 'Manual de Convivencia'],
    ),

    // Comportamental
    Question(
      id: 'cal-com-01',
      pillar: CompetencyPillar.comportamental,
      topic: 'Integridad',
      stem:
          'Te ofrecen adelantar resultados de una selección interna a cambio de un favor. Debes:',
      options: [
        'Aceptar si es “de confianza”',
        'Rechazar y seguir el conducto regular',
        'Negociar otro favor',
        'Publicarlo anónimamente',
      ],
      correctIndex: 1,
      explanation:
          'Integridad y confidencialidad son centrales en el perfil del servidor público.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-com-02',
      pillar: CompetencyPillar.comportamental,
      topic: 'Trabajo en equipo',
      stem:
          'Hay desacuerdo técnico en el área. La conducta más alineada es:',
      options: [
        'Imponer sin escuchar',
        'Aportar evidencia, escuchar y construir acuerdo institucional',
        'Sabotear la reunión',
        'Quejarte con padres',
      ],
      correctIndex: 1,
      explanation:
          'Se valora colaboración, evidencia y orientación a acuerdos útiles para el servicio educativo.',
      difficulty: QuestionDifficulty.intermedio,
    ),
    Question(
      id: 'cal-com-03',
      pillar: CompetencyPillar.comportamental,
      topic: 'Orientación al ciudadano',
      stem:
          'Una familia no comprende una estrategia de apoyo. La mejor respuesta es:',
      options: [
        'Usar tecnicismos sin ejemplos',
        'Explicar con claridad, empatía y siguiente paso concreto',
        'Evitar la conversación',
        'Prometer resultados garantizados',
      ],
      correctIndex: 1,
      explanation:
          'Servicio ciudadano: claridad + empatía + ruta de acción, con apego institucional.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-com-04',
      pillar: CompetencyPillar.comportamental,
      topic: 'Liderazgo',
      stem:
          'Baja apropiación de una meta institucional. El liderazgo pedagógico inicia por:',
      options: [
        'Sancionar de inmediato',
        'Diagnosticar, dar sentido compartido y acordar rutinas',
        'Ignorar hasta supervisión',
        'Cambiar la meta sin diálogo',
      ],
      correctIndex: 1,
      explanation:
          'Liderazgo eficaz: diagnóstico → sentido → rutinas de implementación.',
      difficulty: QuestionDifficulty.avanzado,
      specialtyTags: [Especialidad.directivos],
    ),
    Question(
      id: 'cal-com-05',
      pillar: CompetencyPillar.comportamental,
      topic: 'Resolución de conflictos',
      stem:
          'Un colega eleva el tono frente a estudiantes. Tu mejor primera acción es:',
      options: [
        'Escalárlo en redes',
        'Intervenir con calma y reconducir a espacio privado/institucional',
        'Tomar partido público',
        'Ignorar por completo',
      ],
      correctIndex: 1,
      explanation:
          'Prioriza clima escolar, autocontrol y canales formales.',
      difficulty: QuestionDifficulty.intermedio,
      isCaseStudy: true,
      caseContext:
          'En un cambio de clase, un docente increpa con gritos a otro frente a un corredor lleno.',
    ),

    // Más especialidad / casos
    Question(
      id: 'cal-esp-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Didáctica de matemáticas',
      stem:
          'Para superar un error conceptual de valor posicional, conviene:',
      options: [
        'Solo más hojas de algoritmos',
        'Material concreto + representación + contraste de errores frecuentes',
        'Omitir el tema',
        'Castigar el error',
      ],
      correctIndex: 1,
      explanation:
          'El error conceptual se aborda con representaciones múltiples y análisis del error, no con repetición ciega.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.matematicas, Especialidad.primaria],
    ),
    Question(
      id: 'cal-esp-02',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Lenguaje',
      stem:
          'Una secuencia potente para argumentar en secundaria es:',
      options: [
        'Copiar un ensayo modelo sin análisis',
        'Identificar tesis ajena → construir tesis propia → soportar con evidencia',
        'Solo dictado',
        'Evitar textos controversiales siempre',
      ],
      correctIndex: 1,
      explanation:
          'La escritura argumentativa se enseña con modelado de estructura y evidencia, no con copia pasiva.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.lenguaje],
    ),
    Question(
      id: 'cal-esp-03',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Ciencias',
      stem:
          'En un laboratorio escolar, el foco de evaluación formativa debería incluir:',
      options: [
        'Solo el resultado final correcto',
        'Pregunta, procedimiento, registro de evidencia y explicación',
        'Solo limpieza del puesto',
        'Memorizar la receta sin sentido',
      ],
      correctIndex: 1,
      explanation:
          'La indagación evalúa el proceso científico completo, no únicamente el “dato final”.',
      difficulty: QuestionDifficulty.intermedio,
      specialtyTags: [Especialidad.ciencias],
    ),
    Question(
      id: 'cal-esp-04',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Primera infancia',
      stem:
          'En preescolar, documentar el aprendizaje con sentido implica:',
      options: [
        'Exámenes escritos diarios',
        'Registros de observación, producciones y relatos del juego',
        'Rankings públicos',
        'Solo asistencia',
      ],
      correctIndex: 1,
      explanation:
          'La documentación pedagógica observa procesos naturales de juego, lenguaje e interacción.',
      difficulty: QuestionDifficulty.basico,
      specialtyTags: [Especialidad.preescolar],
    ),
    Question(
      id: 'cal-caso-01',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Casos de aula',
      stem:
          'La decisión más coherente con inclusión y debido proceso es:',
      options: [
        'Negar el cupo por “no estar preparados”',
        'Matricular, caracterizar y definir ajustes con el equipo de apoyo',
        'Aceptar sin ningún plan',
        'Separar al estudiante en otra jornada sin análisis',
      ],
      correctIndex: 1,
      explanation:
          'Inclusión operativa: acceso + caracterización + plan de apoyos/ajustes razonables.',
      difficulty: QuestionDifficulty.avanzado,
      isCaseStudy: true,
      caseContext:
          'Solicitan cupo para un estudiante con discapacidad cognitiva leve. Hay resistencia de algunos docentes por “no tener formación”.',
    ),
    Question(
      id: 'cal-caso-02',
      pillar: CompetencyPillar.comportamental,
      topic: 'Casos de aula',
      stem:
          'Como orientador/directivo, ¿qué priorizas?',
      options: [
        'Minimizar el hecho para proteger imagen',
        'Activar ruta, proteger al menor y comunicar con respeto a la familia',
        'Exponer nombres en asamblea',
        'Delegar solo a redes sociales',
      ],
      correctIndex: 1,
      explanation:
          'Protección, protocolo y comunicación cuidadosa son el estándar de servicio público educativo.',
      difficulty: QuestionDifficulty.avanzado,
      isCaseStudy: true,
      caseContext:
          'Una familia denuncia discriminación por origen étnico en un trabajo grupal. Hay testigos parciales.',
      specialtyTags: [Especialidad.directivos],
      normativeRefs: ['Ley 1620 de 2013'],
    ),
    Question(
      id: 'cal-num-06',
      pillar: CompetencyPillar.aptitudNumerica,
      topic: 'Porcentajes',
      stem:
          'De 180 docentes, el 40% ya completó el diagnóstico. ¿Cuántos faltan?',
      options: ['72', '88', '108', '120'],
      correctIndex: 2,
      explanation: 'Completaron 72; faltan 180−72 = 108 (60%).',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-lec-06',
      pillar: CompetencyPillar.lecturaCritica,
      topic: 'Idea principal',
      stem:
          'Un autor afirma que microlearning + retroalimentación normativa supera a las clases largas pasivas '
          'para aspirantes trabajadores. La idea principal es:',
      options: [
        'Las clases largas son siempre mejores',
        'El diseño de práctica breve con feedback de calidad es más efectivo para este público',
        'No hace falta estudiar',
        'Solo importan los PDFs',
      ],
      correctIndex: 1,
      explanation:
          'La tesis compara formatos y privilegia práctica breve con feedback normativo.',
      difficulty: QuestionDifficulty.basico,
    ),
    Question(
      id: 'cal-ped-07',
      pillar: CompetencyPillar.pedagogico,
      topic: 'Decreto 1290',
      stem:
          'El Decreto 1290 enfatiza que la evaluación debe servir principalmente para:',
      options: [
        'Castigar el bajo desempeño',
        'Formar, diagnosticar y mejorar aprendizajes',
        'Reemplazar la enseñanza',
        'Homogeneizar sin criterios',
      ],
      correctIndex: 1,
      explanation:
          'La evaluación se entiende como parte del proceso formativo, no como fin punitivo.',
      difficulty: QuestionDifficulty.basico,
      normativeRefs: ['Decreto 1290 de 2009'],
    ),
    Question(
      id: 'cal-com-06',
      pillar: CompetencyPillar.comportamental,
      topic: 'Autocontrol',
      stem:
          'Recibes una crítica injusta en consejo de docentes. La respuesta más profesional es:',
      options: [
        'Responder con ataques personales',
        'Escuchar, pedir evidencias y proponer revisión con datos',
        'Abandonar la reunión',
        'Quejarte con estudiantes',
      ],
      correctIndex: 1,
      explanation:
          'Autocontrol + orientación a evidencia sostiene el clima institucional.',
      difficulty: QuestionDifficulty.intermedio,
    ),
  ];
}
