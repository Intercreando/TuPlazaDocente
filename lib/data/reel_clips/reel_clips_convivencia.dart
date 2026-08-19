import '../reel_clip.dart';

/// Casos de convivencia escolar (Ley 1620): protección, ruta y debido proceso.
/// La trampa habitual es cerrar el caso con un diálogo exprés o pedir pruebas
/// antes de proteger.
const reelClipsConvivencia = <ReelClip>[
  ReelClip(
    id: 'convivencia',
    group: ReelGroup.convivencia,
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
    id: 'video',
    group: ReelGroup.convivencia,
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
    id: 'acudiente',
    group: ReelGroup.convivencia,
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
    id: 'chat',
    group: ReelGroup.convivencia,
    label: 'WhatsApp · “no le digas a mi mamá”',
    situation:
        'En el grupo de WhatsApp que creaste para tareas, tres estudiantes se burlan de una compañera con memes. Ella te pide que no pase nada y que no llames a su casa.',
    stem: '¿Qué haces?',
    options: [
      'Guardar evidencia, activar la ruta y acompañarla, aunque pida silencio.',
      'Respetar su silencio: si ella no denuncia, no hay caso que abrir.',
      'Sacar del grupo a los tres y borrar los mensajes para cerrar el tema.',
      'Escribir un llamado general al respeto y observar una semana.',
    ],
    correctIndex: 0,
    revealWhy:
        'Ante el acoso a un menor no hay silencio pactado: se protege, se registra y se activa la ruta.',
  ),
  ReelClip(
    id: 'revelacion',
    group: ReelGroup.convivencia,
    label: 'Revelación · presunto delito',
    situation:
        'Al terminar la clase, una estudiante de 6° te cuenta que un adulto de su casa la toca. Te pide que no le digas a nadie. Están solos en el salón.',
    stem: '¿Qué haces primero?',
    options: [
      'Entrevistarla con detalle para confirmar antes de mover el caso.',
      'Reportar de inmediato a rectoría y a la autoridad competente.',
      'Llamar a la casa para escuchar la versión del adulto señalado.',
      'Esperar a que lo repita ante orientación para no exponerla.',
    ],
    correctIndex: 1,
    revealWhy:
        'El docente no investiga: reporta hoy. Buscar la versión del hogar pone en riesgo a la niña.',
  ),
  ReelClip(
    id: 'autolesion',
    group: ReelGroup.convivencia,
    label: 'Alerta · señales de autolesión',
    situation:
        'Ves cortes recientes en el brazo de un estudiante de 9°. Él minimiza y pide que no digas nada. Un compañero comenta que “lleva meses así”.',
    stem: '¿Cuál es la actuación correcta?',
    options: [
      'Hablar con el grupo sobre salud mental y esperar que él se acerque.',
      'Dejarlo en el observador y revisarlo al cierre del periodo.',
      'Pedirle que firme un compromiso de no volver a hacerlo.',
      'Activar hoy la ruta de salud con orientación y la familia.',
    ],
    correctIndex: 3,
    revealWhy:
        'Una señal de riesgo vital no se aplaza ni se arregla con compromisos: se remite y se acompaña.',
  ),
];
