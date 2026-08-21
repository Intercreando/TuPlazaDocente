import '../reel_clip.dart';

/// Casos de gestión de aula y didáctica. La trampa habitual es sacar el
/// problema de la vista (del salón, de la clase) en vez de rediseñar la clase.
const reelClipsAula = <ReelClip>[
  ReelClip(
    id: 'zdp',
    group: ReelGroup.aula,
    label: 'ZDP · el compañero “que enseña”',
    hook: '¿Lo dejas fijo con el compañero que le enseña?',
    situation:
        'En 3° no logra la suma con llevadas solo. En pareja con un compañero más avanzado, sí la explica y la aplica.',
    stem: '¿Qué planeas la próxima semana?',
    options: [
      'Más talleres iguales, para la casa, hasta que lo haga solo.',
      'Tareas con roles, modelar y retirar el apoyo de a poco.',
      'Dejarlo fijo con ese compañero para que “le enseñe”.',
      'Sacarlo a recuperaciones para no frenar al grado.',
    ],
    correctIndex: 1,
    revealWhy:
        'Andamiaje es intencionado. Delegar en el par o sacarlo del aula no es ZDP.',
  ),
  ReelClip(
    id: 'fuera-de-clase',
    group: ReelGroup.aula,
    label: 'Aula · “fuera de mi clase”',
    hook: '¿Otra vez lo sacas al pasillo?',
    situation:
        'Un estudiante de 8° interrumpe todo el tiempo. Llevas tres clases sacándolo al pasillo y su rendimiento cayó. Coordinación te pide otra estrategia.',
    stem: '¿Qué haces la próxima clase?',
    options: [
      'Sacarlo, pero con taller en la biblioteca para que no pierda.',
      'Sentarlo solo al frente y anotar cada interrupción en el observador.',
      'Pactar señales y un rol en la clase, y ajustar la tarea a su nivel.',
      'Citar al acudiente y condicionar su regreso a un compromiso firmado.',
    ],
    correctIndex: 2,
    revealWhy:
        'Sacarlo quita el problema de la vista y suma pérdida de aprendizaje: hay que rediseñar la clase.',
  ),
  ReelClip(
    id: 'nadie-participa',
    group: ReelGroup.aula,
    label: 'Aula · “¿entendieron?” y nadie responde',
    hook: '¿Con un “entendieron” ya puedes seguir?',
    situation:
        'En 9° preguntas “¿entendieron?” y todos asienten. En la prueba, la mitad falla lo básico. Tienes el tema atrasado y 45 minutos por clase.',
    stem: '¿Qué cambias?',
    options: [
      'Usar preguntas que exijan explicar y mostrar quién no va.',
      'Avanzar y dejar el repaso para la semana de refuerzo.',
      'Preguntar por lista, para que todos tengan que responder.',
      'Repetir la explicación completa y volver a preguntar si entendieron.',
    ],
    correctIndex: 0,
    revealWhy:
        '“¿Entendieron?” no es evaluación formativa: sin evidencia de quién falla, no hay ajuste posible.',
  ),
];
