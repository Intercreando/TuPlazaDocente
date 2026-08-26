import 'reel_clip.dart';

/// Casos escritos para el lienzo 16:9: enunciado largo, no recorte de Reels.
const liveClipsEnunciado = <ReelClip>[
  ReelClip(
    id: 'live-1620-ruta',
    group: ReelGroup.convivencia,
    label: 'Ley 1620 · ruta Tipo II',
    hook: '¿El comité “ya sabe” o hay que abrir la ruta?',
    situation:
        'En un colegio rural, dos estudiantes de noveno se agreden en el descanso. '
        'Hay un hematoma y versiones cruzadas. Varios docentes piden “cerrar el tema '
        'en privado” para no dañar la imagen de la institución ni “armar un '
        'escándalo” con las familias. El coordinador propone una disculpa verbal '
        'y no dejar registro “porque ya se calmaron”.',
    stem:
        'Según la Ley 1620 y las rutas de atención, ¿cuál es la actuación '
        'institucional más alineada al debido proceso?',
    options: [
      'Mediar en secreto, sin acta, para proteger la reputación del colegio.',
      'Activar la ruta, registrar hechos, roles y seguimiento, y garantizar '
          'el derecho de las partes a ser oídas.',
      'Publicar los nombres en el grupo de WhatsApp de padres “para que sirva '
          'de ejemplo”.',
      'Sancionar de inmediato al más señalado, sin indagación, para “dar un '
          'escarmiento”.',
    ],
    correctIndex: 1,
    revealWhy:
        'La 1620 exige ruta, trazabilidad y debido proceso. El silencio informal '
        'no protege derechos; la exposición pública los vulnera.',
  ),
  ReelClip(
    id: 'live-1421-cupo',
    group: ReelGroup.inclusion,
    label: 'Decreto 1421 · ingreso y PIAR',
    hook: '¿La falta de formación autoriza a negar el cupo?',
    situation:
        'Llega a matrícula un estudiante con discapacidad. Varios docentes '
        'sostienen que “no estamos formados” y piden negar el cupo “hasta que '
        'llegue capacitación” o enviarlo a otra sede. La familia insiste en el '
        'derecho a educarse en la institución de su territorio. El rector teme '
        'que supervisión señale falta de ajustes.',
    stem:
        '¿Qué postura rectoral se alinea con el Decreto 1421 (educación inclusiva)?',
    options: [
      'Negar el cupo mientras el equipo no certifique formación en inclusión.',
      'Garantizar el ingreso, activar PIAR y ajustes razonables, y acompañar '
          'la cualificación del equipo.',
      'Aceptarlo “sin ajustes” para que “se adapte solo” y no generar carga.',
      'Trasladarlo de inmediato a otra IE, sin plan ni articulación.',
    ],
    correctIndex: 1,
    revealWhy:
        'La falta de formación no habilita exclusión. El 1421 orienta ingreso, '
        'PIAR y ajustes; la barrera se gestiona en el entorno, no en el cupo.',
  ),
  ReelClip(
    id: 'live-siee-promedio',
    group: ReelGroup.evaluacion,
    label: 'SIEE · misma prueba para todos',
    hook: '¿El mismo examen es equidad o barrera?',
    situation:
        'El área de lenguaje unifica un examen cronometrado idéntico para todo '
        'el grado, incluida una estudiante con baja visión que trabaja con PIAR. '
        'La jefatura dice que “si cambiamos el instrumento, perdemos rigor y '
        'comparabilidad”. El SIEE habla de criterios, no de fotocopia del mismo '
        'formato. Hay que decidir si se ajusta formato y tiempo sin bajar la meta.',
    stem:
        '¿Cuál decisión es coherente con evaluación inclusiva y con el SIEE?',
    options: [
      'Mantener el mismo formato y tiempo para “no discriminar” a nadie.',
      'Eximirla de la prueba escrita y calificar solo “actitud y esfuerzo”.',
      'Ajustar formato y tiempo (PIAR) conservando la meta de aprendizaje '
          'esencial del grado.',
      'Esperar un dictamen médico nuevo antes de cualquier ajuste.',
    ],
    correctIndex: 2,
    revealWhy:
        'Equidad no es igualdad de instrumento. Se ajusta el cómo, no se baja '
        'la meta ni se sustituye por “actitud”.',
  ),
  ReelClip(
    id: 'live-aula-recuperacion',
    group: ReelGroup.aula,
    label: 'Aula · recuperación vs. repetir taller',
    hook: '¿Recuperar es volver a copiar el mismo taller?',
    situation:
        'Un grupo de octavo pierde una prueba de fracciones. El docente anuncia '
        'que “recuperan copiando el mismo taller en casa” y que quien no lo '
        'entregue pierde la materia. Varias familias no tienen acompañamiento '
        'en casa. El coordinador académico pide evidencia de reenseñanza, no '
        'solo de tarea extra. El SIEE institucional habla de superación de '
        'debilidades con nuevas oportunidades de aprendizaje.',
    stem:
        '¿Qué práctica se acerca más a una recuperación pedagógica seria?',
    options: [
      'Repetir el mismo taller como único requisito, sin volver a enseñar.',
      'Diagnosticar errores, reenseñar con otra estrategia y evaluar de nuevo '
          'el aprendizaje, no la copia.',
      'Bajar el estándar del período para que “todos pasen” y no haya conflicto.',
      'Publicar el ranking de notas en el pasillo para “motivar” al grupo.',
    ],
    correctIndex: 1,
    revealWhy:
        'Recuperar es volver a enseñar y volver a evidenciar el aprendizaje. '
        'Copiar el mismo taller no diagnostica ni enseña de nuevo.',
  ),
  ReelClip(
    id: 'live-pei-pmi',
    group: ReelGroup.directivo,
    label: 'Directivo · PEI y PMI',
    hook: '¿El PMI puede ser una lista de compras?',
    situation:
        'El Plan de Mejoramiento Institucional detalla compras de tabletas y '
        'pintura de aulas. No se articula con las metas del PEI ni con '
        'indicadores de aprendizaje. En el Consejo Directivo insisten en que '
        '“supervisión pide evidencias de gasto”, no de pedagogía. El rector '
        'debe presentar un ajuste del PMI antes de la siguiente visita.',
    stem:
        '¿Cuál mejora de gestión es más sólida para la calidad del servicio '
        'educativo?',
    options: [
      'Dejar el PMI como inventario de compras, independiente del PEI.',
      'Alinear el PMI a prioridades del PEI, con indicadores de aprendizaje '
          'y seguimiento, no solo de ejecución presupuestal.',
      'Eliminar el PEI porque el PMI “ya basta” para la supervisión.',
      'Reescribir el PEI cada mes según la moda pedagógica del momento.',
    ],
    correctIndex: 1,
    revealWhy:
        'La gestión institucional articula PEI, mejoramiento y evidencia de '
        'aprendizaje. El gasto sin rumbo pedagógico no es mejora.',
  ),
  ReelClip(
    id: 'live-1290-promocion',
    group: ReelGroup.evaluacion,
    label: 'Decreto 1290 · promoción',
    hook: '¿Se promociona “por humanidad” a mitad de año?',
    situation:
        'Un acudiente exige que su hijo de sexto sea promovido en junio porque '
        '“ya es grande” y “en el otro colegio lo iban a pasar”. El estudiante '
        'no alcanza desempeños mínimos en matemáticas ni en lenguaje, según '
        'el SIEE. El rector siente presión de la secretaría local. El Decreto '
        '1290 deja la promoción en el SIEE, con criterios públicos y '
        'comisión de evaluación.',
    stem:
        '¿Cuál actuación respeta el marco de evaluación de los aprendizajes?',
    options: [
      'Promoverlo de inmediato para evitar un conflicto con la familia.',
      'Aplicar el SIEE: evidencias, comisión y criterios de promoción, con '
          'plan de apoyo si no hay promoción.',
      'Cambiar las notas del período sin registro, “por equidad social”.',
      'Negar cualquier plan de apoyo porque “ya se le dio la oportunidad”.',
    ],
    correctIndex: 1,
    revealWhy:
        'La promoción no es un favor. El 1290 y el SIEE exigen criterios, '
        'evidencias y apoyo; no atajos ni abandono.',
  ),
  ReelClip(
    id: 'live-1620-tipo-iii',
    group: ReelGroup.convivencia,
    label: 'Convivencia · presunto delito',
    hook: '¿Esto se “queda en el colegio”?',
    situation:
        'Una estudiante de décimo reporta tocamientos reiterados por parte de '
        'un compañero mayor de edad en un espacio poco vigilado. Hay temor de '
        'denunciar. Un docente sugiere “llamar a los papás y pactar que no se '
        'vuelva a hablar del tema”. El Manual menciona el Comité, pero no el '
        'paso a autoridades cuando hay presunto delito.',
    stem:
        '¿Cuál es la prioridad institucional más alineada a la ruta de '
        'atención integral?',
    options: [
      'Acordar silencio con las familias para “no revictimizar en público”.',
      'Activar la ruta, proteger a la presunta víctima, registrar y, si hay '
          'presunto delito, articular con autoridades competentes.',
      'Confrontar a ambos en asamblea de grado para “aclarar versiones”.',
      'Trasladar a la estudiante de jornada sin informe ni seguimiento.',
    ],
    correctIndex: 1,
    revealWhy:
        'Hay deber de protección, registro y articulación cuando el hecho puede '
        'ser delito. El pacto de silencio no es ruta.',
  ),
  ReelClip(
    id: 'live-integridad-cupos',
    group: ReelGroup.directivo,
    label: 'Integridad · favor en matrícula',
    hook: '¿Un “cupo de confianza” es gestión o falta?',
    situation:
        'Un concejal pide al rector “agilizar” un cupo para un sobrino, saltando '
        'la lista de espera, a cambio de “apoyo en el presupuesto de la sede”. '
        'El proceso de matrícula está publicado. Hay más de veinte familias '
        'en espera con igual o mayor derecho. El rector teme represalias '
        'políticas si se niega.',
    stem:
        '¿Qué conducta se alinea con integridad del servidor público y con el '
        'derecho a la educación en igualdad de condiciones?',
    options: [
      'Aceptar el cupo extraoficial porque “el colegio gana recursos”.',
      'Rechazar el atajo, aplicar el procedimiento publicado y dejar trazabilidad '
          'de la solicitud.',
      'Negociar un segundo cupo para “compensar” a otra familia de la lista.',
      'Publicar en redes el nombre del concejal sin agotar el conducto regular.',
    ],
    correctIndex: 1,
    revealWhy:
        'El cupo no se negocia. Integridad es procedimiento igual para todos y '
        'registro; el trueque político es una falta, no gestión.',
  ),
];
