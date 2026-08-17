/// Caso recortado para Reels (una línea por opción). No son ítems oficiales.
class ReelClip {
  const ReelClip({
    required this.id,
    required this.label,
    required this.situation,
    required this.stem,
    required this.options,
    required this.correctIndex,
    required this.revealWhy,
  });

  final String id;
  final String label;
  final String situation;
  final String stem;
  final List<String> options;
  final int correctIndex;
  final String revealWhy;

  String get correctLetter {
    const letters = ['A', 'B', 'C', 'D'];
    if (correctIndex < 0 || correctIndex >= letters.length) return '?';
    return letters[correctIndex];
  }
}

/// Pack viral: trampas reales, opciones cortas, debate en comentarios.
/// Letras correctas mezcladas (2 A, 2 B, 2 C, 2 D) para que no “siempre sea C”.
abstract final class ReelStudioPack {
  static const hook = '¿Pasarías esta pregunta del Concurso Docente?';
  static const closeComenta = 'Comenta A, B, C o D';
  static const site = 'tuplazadocente.com';
  static const closeAction = 'Crea tu cuenta gratis';
  static const closeRegister = '$site — $closeAction';
  static const brand = 'TuPlazaDocente';
  static const disclaimer = 'Entrenamiento. No es un ítem oficial de la CNSC.';
  static const hashtags =
      '#ConcursoDocente #ConcursoDocente2026 #CNSC #DocentesColombia '
      '#MagisterioColombia #TuPlazaDocente';
  static const pinnedComment =
      'La explicación y el simulador están en tuplazadocente.com — crea tu cuenta gratis.';

  /// Caption de TikTok/Reels (sin revelar la letra en el capítulo 1).
  static String captionFor(ReelClip clip, {required bool reveal}) {
    final lines = <String>[hook, '', clip.label];
    if (!reveal) {
      lines.addAll([
        clip.situation,
        clip.stem,
        '',
        'Comenta A, B, C o D.',
        'Mañana subo la explicación.',
        '',
        closeRegister,
      ]);
    } else {
      lines.addAll([
        'Respuesta: ${clip.correctLetter}. ${clip.revealWhy}',
        '',
        closeRegister,
      ]);
    }
    lines.addAll(['', hashtags]);
    return lines.join('\n');
  }

  static const clips = <ReelClip>[
    ReelClip(
      id: 'piar',
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
      id: 'zdp',
      label: 'ZDP · el compañero “que enseña”',
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
      id: 'convivencia',
      label: 'Acoso · “hacer las paces hoy”',
      situation:
          'Un estudiante de 8° denuncia acoso reiterado (patio y WhatsApp). Hay testigos. El señalado niega.',
      stem: '¿Primera actuación?',
      options: [
        'Diálogo hoy, disculpas, y se cierra si “hacen las paces”.',
        'Ruta del Manual: proteger, versiones, registro y Comité.',
        'Circular a todas las familias de 8° describiendo el grupo.',
        'Pedir capturas en 8 días; si no llegan, archivar.',
      ],
      correctIndex: 1,
      revealWhy:
          'La conciliación exprés no sustituye protección, registro ni debido proceso.',
    ),
    ReelClip(
      id: 'patio',
      label: 'Patio · conflicto entre docentes',
      situation:
          'Dos docentes discuten fuerte en el patio. Estudiantes miran. Estás de descanso. No eres coordinador.',
      stem: '¿Qué haces ahora?',
      options: [
        'Bajar el tono, apartar la escena e informar a coordinación.',
        'No meterte; al final de la jornada dejas un oficio.',
        'Pedirle a un monitor que disperse al grupo y mirar.',
        'Mediar en público para “modelar” resolución de conflictos.',
      ],
      correctIndex: 0,
      revealWhy:
          'El cuidado del clima es ahora. El oficio de la tarde no borra lo que ya vieron.',
    ),
    ReelClip(
      id: 'acudiente',
      label: 'Acudiente · “expúlsalo hoy”',
      situation:
          'Un acudiente exige apartar hoy a un compañero por una pelea. No hay acta. Amenaza con publicarlo en el grupo de familias.',
      stem: 'Como director de grupo, ¿qué haces?',
      options: [
        'Conciliación entre familias esta tarde, sin versiones aún.',
        'Separación “cautelar” de un día, decidida por ti.',
        'Pedirle denuncia policial primero; el colegio actúa después.',
        'Recibir, no sancionar sin ruta, proteger, registrar y escalar.',
      ],
      correctIndex: 3,
      revealWhy:
          'La amenaza de redes no crea competencia para sancionar ni pausa la ruta escolar.',
    ),
    ReelClip(
      id: 'video',
      label: 'Video · “úsalo en ética”',
      situation:
          'Un estudiante llora: circula un video suyo. Compañeros ríen con el celular. Una colega propone usarlo mañana en ética.',
      stem: '¿Qué va primero?',
      options: [
        'Parar la circulación, proteger, informar y registrar.',
        'Abrir el debate ya, con su caso como ejemplo.',
        'Retener todos los celulares hasta el viernes.',
        'Llevarlo a un salón vacío y dejar al grupo seguir.',
      ],
      correctIndex: 0,
      revealWhy:
          'Primero se corta el daño. Didactizar el caso de un menor en caliente revictimiza.',
    ),
    ReelClip(
      id: 'siee',
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
      id: 'igualdad',
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
  ];

  static ReelClip byId(String? id) {
    if (id == null || id.isEmpty) return clips.first;
    for (final clip in clips) {
      if (clip.id == id) return clip;
    }
    return clips.first;
  }
}
