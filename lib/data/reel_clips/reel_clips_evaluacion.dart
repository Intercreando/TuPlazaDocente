import '../reel_clip.dart';

/// Casos de evaluación (Decreto 1290 y SIEE). La trampa habitual es usar la
/// nota como premio o castigo, o decidir por fuera de los criterios acordados.
const reelClipsEvaluacion = <ReelClip>[
  ReelClip(
    id: 'siee',
    group: ReelGroup.evaluacion,
    label: 'SIEE · cada uno con su peso',
    situation:
        'En el área, dos docentes pelean el peso de un taller. Uno alega libertad de cátedra; el otro, el SIEE. Tú moderas.',
    stem: '¿Qué haces?',
    options: [
      'Cierras y esa noche mandas el peso que tú decidiste.',
      'Dejas que discutan hasta que uno ceda.',
      'Pausas y vuelves el conflicto a los criterios del SIEE, con acta.',
      'Cada quien pondera distinto: “autonomía didáctica”.',
    ],
    correctIndex: 2,
    revealWhy:
        'El estudiante no puede tener dos sistemas de nota en el mismo grado.',
  ),
  ReelClip(
    id: 'nota-castigo',
    group: ReelGroup.evaluacion,
    label: 'Nota · “les bajo por indisciplina”',
    situation:
        'Un grupo de 10° saboteó la clase. Un colega propone bajar dos puntos de la nota del periodo a los que participaron, “para que aprendan”.',
    stem: '¿Qué sustentas en la reunión de área?',
    options: [
      'Evaluar el aprendizaje y llevar la convivencia por su propia ruta.',
      'Aceptar: la disciplina también es parte de la nota del área.',
      'Bajar solo a los identificados, con acta firmada por ellos.',
      'Dejar la nota y poner un trabajo extra como sanción académica.',
    ],
    correctIndex: 0,
    revealWhy:
        'La nota mide aprendizaje. Usarla como castigo vicia la evaluación y no corrige la convivencia.',
  ),
  ReelClip(
    id: 'incapacidad',
    group: ReelGroup.evaluacion,
    label: 'Incapacidad · el cero del viernes',
    situation:
        'Una estudiante no presentó la prueba final por una incapacidad médica de tres días. La plataforma ya cerró y el promedio la deja perdiendo el área.',
    stem: '¿Qué corresponde?',
    options: [
      'Dejar el cero: la fecha la conocía todo el grupo.',
      'Promediar lo que tenga y anotar la ausencia como justificada.',
      'Subirle la nota mínima de aprobación por la incapacidad.',
      'Reprogramar la prueba según el SIEE y ajustar el registro.',
    ],
    correctIndex: 3,
    revealWhy:
        'La ausencia justificada da derecho a presentar: no a un cero ni a una nota regalada.',
  ),
  ReelClip(
    id: 'promocion',
    group: ReelGroup.evaluacion,
    label: 'Comisión · promoción anticipada',
    situation:
        'Un estudiante de 6° demuestra dominio muy por encima del grado. La familia pide promoción anticipada. Dos docentes se oponen por su edad y madurez.',
    stem: 'En la comisión, ¿qué sustentas?',
    options: [
      'Negarla: la edad y la convivencia pesan más que el desempeño.',
      'Decidir con evidencias de desempeño y dejarlo en acta.',
      'Aplazarla al año siguiente para observar su comportamiento.',
      'Autorizarla si la familia firma que asume las consecuencias.',
    ],
    correctIndex: 1,
    revealWhy:
        'La promoción anticipada se decide con evidencia y en comisión, no por percepciones ni firmas.',
  ),
  ReelClip(
    id: 'retroalimentacion',
    group: ReelGroup.evaluacion,
    label: 'Entrega · solo el número en rojo',
    situation:
        'Entregas la prueba con la nota en rojo. Los estudiantes miran el número y guardan la hoja. Los mismos errores reaparecen en la siguiente prueba.',
    stem: '¿Qué cambias en la entrega?',
    options: [
      'Publicar el promedio del curso para generar sana competencia.',
      'Devolver con la pista del error y una tarea para corregirlo.',
      'Dejar que quien quiera pase a preguntar en el descanso.',
      'Repetir la misma prueba en la clase siguiente.',
    ],
    correctIndex: 1,
    revealWhy:
        'Sin retroalimentación que diga qué falló y qué sigue, la nota no enseña nada.',
  ),
];
