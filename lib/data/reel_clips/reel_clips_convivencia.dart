import '../reel_clip.dart';

/// Casos de convivencia escolar (Ley 1620): protección, ruta y debido proceso.
///
/// En reels no se describen delitos, lesiones ni acoso sexual: TikTok baja o
/// bloquea ese texto aunque el caso sea pedagógico.
const reelClipsConvivencia = <ReelClip>[
  ReelClip(
    id: 'convivencia',
    group: ReelGroup.convivencia,
    label: 'Convivencia · “hacer las paces hoy”',
    hook: '¿Haces las paces hoy y cierras el caso?',
    situation:
        'Un estudiante de 8° reporta burlas repetidas en el patio y en el chat. Hay testigos. Quien señala niega.',
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
    id: 'video',
    group: ReelGroup.convivencia,
    label: 'Celular · “úsalo en ética”',
    hook: '¿Usas el caso mañana en ética?',
    situation:
        'En clase circula un contenido de un compañero y varios se ríen. Una colega propone usarlo mañana como ejemplo en ética.',
    stem: '¿Qué va primero?',
    options: [
      'Parar la circulación, proteger, informar y registrar.',
      'Abrir el debate ya, con su caso como ejemplo.',
      'Retener todos los celulares hasta el viernes.',
      'Llevarlo a un salón vacío y dejar al grupo seguir.',
    ],
    correctIndex: 0,
    revealWhy:
        'Primero se corta el daño. Usar el caso de un estudiante en caliente lo expone otra vez.',
  ),
  ReelClip(
    id: 'acudiente',
    group: ReelGroup.convivencia,
    label: 'Acudiente · “expúlsalo hoy”',
    hook: '¿Lo expulsas hoy porque el acudiente lo exige?',
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
    id: 'chat',
    group: ReelGroup.convivencia,
    label: 'WhatsApp · “no le digas a mi mamá”',
    hook: '¿Respetas el silencio y no avisas a la casa?',
    situation:
        'En el grupo de WhatsApp que creaste para tareas, tres estudiantes se burlan de una compañera. Ella te pide que no pase nada y que no llames a su casa.',
    stem: '¿Qué haces?',
    options: [
      'Guardar evidencia, activar la ruta y acompañarla, aunque pida silencio.',
      'Respetar su silencio: si ella no denuncia, no hay caso que abrir.',
      'Sacar del grupo a los tres y borrar los mensajes para cerrar el tema.',
      'Escribir un llamado general al respeto y observar una semana.',
    ],
    correctIndex: 0,
    revealWhy:
        'Si hay daño a un estudiante no hay silencio pactado: se protege, se registra y se activa la ruta.',
  ),
  ReelClip(
    id: 'revelacion',
    group: ReelGroup.convivencia,
    label: 'Secreto · “no se lo digas a nadie”',
    hook: '¿Guardas el secreto porque te lo pidió?',
    situation:
        'Al terminar la clase, una estudiante de 6° te dice que en casa no se siente segura y te pide secreto. Están solos en el salón.',
    stem: '¿Qué haces primero?',
    options: [
      'Entrevistarla con detalle para confirmar antes de mover el caso.',
      'Reportar de inmediato a rectoría y a la autoridad competente.',
      'Llamar a la casa para escuchar la versión de los adultos.',
      'Esperar a que lo repita ante orientación para no exponerla.',
    ],
    correctIndex: 1,
    revealWhy:
        'El docente no investiga a solas: reporta hoy. Llamar a la casa puede ponerla en más riesgo.',
  ),
  ReelClip(
    id: 'autolesion',
    group: ReelGroup.convivencia,
    label: 'Acompañar · “no avises a nadie”',
    hook: '¿Prometes no avisar a nadie?',
    situation:
        'Un estudiante de 9° se aísla, rinde menos y un compañero te dice que está pasando un mal momento. Él pide que no avises.',
    stem: '¿Cuál es la actuación correcta?',
    options: [
      'Hablar con el grupo sobre bienestar y esperar que él se acerque.',
      'Dejar una nota en el observador y revisarlo al cierre del periodo.',
      'Pedirle que prometa mejorar y no comentarlo con nadie.',
      'Activar hoy la ruta de acompañamiento con orientación y la familia.',
    ],
    correctIndex: 3,
    revealWhy:
        'Un malestar persistente no se guarda en secreto ni se aplaza: se remite y se acompaña.',
  ),
];
