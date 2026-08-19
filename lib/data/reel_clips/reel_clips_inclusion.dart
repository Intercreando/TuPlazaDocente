import '../reel_clip.dart';

/// Casos de inclusión (Decreto 1421 y PIAR). La trampa habitual es esperar un
/// diagnóstico o “bajar la meta” en nombre de la inclusión.
const reelClipsInclusion = <ReelClip>[
  ReelClip(
    id: 'piar',
    group: ReelGroup.inclusion,
    label: 'PIAR · inclusión (piloto)',
    situation:
        'Entra a 4° una niña con discapacidad visual. El grado usa guías impresas densas y pruebas cronometradas iguales para todos.',
    stem: '¿Qué hace el colegio?',
    options: [
      'Mismas guías; solo extra de tiempo en la prueba final.',
      'Un “PIAR” que la exima de escritos y califique solo actitud.',
      'PIAR: ajustar formato y tiempo, misma meta esencial.',
      'Esperar el dictamen de apoyo para no improvisar.',
    ],
    correctIndex: 2,
    revealWhy:
        'Incluir es quitar barreras ya, sin bajar la meta ni esperar un informe.',
  ),
  ReelClip(
    id: 'igualdad',
    group: ReelGroup.inclusion,
    label: 'Inclusión · “el mismo examen”',
    situation:
        'Un texto dice: cupo y rampa no agotan la inclusión si evaluación y convivencia siguen diseñadas para un estudiante promedio.',
    stem: '¿Cuál es la idea principal?',
    options: [
      'La rampa es el indicador más confiable, porque se verifica.',
      'Para no discriminar, el examen debe ser idéntico para todos.',
      'La convivencia es de orientación; no se mezcla con el aula.',
      'Incluir es transformar evaluación y convivencia, no solo el acceso.',
    ],
    correctIndex: 3,
    revealWhy:
        'Igualdad de instrumento no es equidad. El texto ataca el diseño para el “promedio”.',
  ),
  ReelClip(
    id: 'tdah',
    group: ReelGroup.inclusion,
    label: 'Sin diagnóstico · “que traiga el papel”',
    situation:
        'Un estudiante de 5° no termina nada, se levanta y pierde el hilo. La familia no tiene cita de neurología hasta dentro de tres meses.',
    stem: '¿Qué haces mientras llega el diagnóstico?',
    options: [
      'Ajustar ya: instrucciones cortas, tiempos y apoyos, y dejarlo por escrito.',
      'Esperar el diagnóstico para no etiquetarlo sin fundamento.',
      'Sentarlo adelante y bajarle la exigencia hasta que haya informe.',
      'Remitir a orientación y dejar su valoración en suspenso.',
    ],
    correctIndex: 0,
    revealWhy:
        'El ajuste razonable no depende de un diagnóstico: depende de la barrera que ya estás viendo.',
  ),
  ReelClip(
    id: 'interprete',
    group: ReelGroup.inclusion,
    label: 'Estudiante sordo · el intérprete',
    situation:
        'En 7° hay un estudiante sordo con intérprete de lengua de señas. Notas que le hablas al intérprete y que tus pruebas dependen de textos largos.',
    stem: '¿Qué corriges?',
    options: [
      'Dejar que el intérprete resuma y valore su comprensión.',
      'Dirigirte al estudiante y ajustar el formato de la evaluación.',
      'Cambiar los escritos por notas de actitud y participación.',
      'Pedir que el intérprete se ubique atrás para no distraer al grupo.',
    ],
    correctIndex: 1,
    revealWhy:
        'El intérprete es un apoyo, no el interlocutor: la comunicación y la evaluación siguen siendo tuyas.',
  ),
  ReelClip(
    id: 'migrante',
    group: ReelGroup.inclusion,
    label: 'Migrante · “sin papeles no hay cupo”',
    situation:
        'Llega una familia a matricular a dos niños. No traen certificados de estudio ni documento colombiano. La secretaría del colegio duda.',
    stem: '¿Qué procede?',
    options: [
      'Negar el cupo hasta que legalicen documentos y certificados.',
      'Recibirlos como oyentes, sin notas, hasta que lleguen los papeles.',
      'Matricular y ubicarlos por valoración académica, sin exigir apostilla.',
      'Ubicarlos un grado abajo por precaución mientras se valida todo.',
    ],
    correctIndex: 2,
    revealWhy:
        'El derecho a la educación no se suspende por trámites: se matricula y se ubica por valoración.',
  ),
];
