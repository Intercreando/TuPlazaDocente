import '../reel_clip.dart';

/// Casos de directivo docente: clima laboral, debido proceso, gratuidad y
/// vocería. La trampa habitual es actuar por rumor o resolver en público.
const reelClipsDirectivo = <ReelClip>[
  ReelClip(
    id: 'patio',
    group: ReelGroup.directivo,
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
    id: 'llegadas-tarde',
    group: ReelGroup.directivo,
    label: 'Rector · el docente que llega tarde',
    situation:
        'Un docente llega tarde tres veces por semana y su grupo espera en el pasillo. En la sala de profesores ya se comenta el caso.',
    stem: 'Como rector, ¿qué haces?',
    options: [
      'Mencionarlo en la reunión general sin nombres, para que se sienta aludido.',
      'Reasignar su grupo a otro docente mientras se corrige.',
      'Esperar la queja escrita de un acudiente para poder actuar.',
      'Registrar los hechos, dialogar y seguir el debido proceso.',
    ],
    correctIndex: 3,
    revealWhy:
        'El clima no se corrige con alusiones ni esperando quejas: se documenta y se cumple el proceso.',
  ),
  ReelClip(
    id: 'acoso-laboral',
    group: ReelGroup.directivo,
    label: 'Coordinación · humillación entre colegas',
    situation:
        'Una docente te cuenta en privado que un colega la humilla frente a estudiantes. Te pide que no la nombres. Varios estudiantes ya lo comentan.',
    stem: '¿Cómo actúas?',
    options: [
      'Hablarle a él en general sobre trato respetuoso, sin mencionar el caso.',
      'Pedirle a ella que lo ponga por escrito o no puedes hacer nada.',
      'Cambiar horarios para que no coincidan y evitar el roce.',
      'Escuchar, registrar y escalar por el conducto que corresponde.',
    ],
    correctIndex: 3,
    revealWhy:
        'La confidencialidad protege a la persona, no oculta el hecho: hay deber de registrar y escalar.',
  ),
  ReelClip(
    id: 'gratuidad',
    group: ReelGroup.directivo,
    label: 'Rector · “que cada familia aporte”',
    situation:
        'Falta material para el laboratorio. El consejo de padres propone una cuota obligatoria de veinte mil pesos por estudiante para el próximo periodo.',
    stem: '¿Qué decides?',
    options: [
      'Aprobar la cuota: la propuso y la aprobó el consejo de padres.',
      'Cobrarla solo a quien pueda, con una lista de exonerados.',
      'No cobrar: ajustar el plan con recursos del fondo y gestión.',
      'Aceptar aportes voluntarios y publicar quién aportó.',
    ],
    correctIndex: 2,
    revealWhy:
        'La gratuidad no se negocia en el consejo de padres: ni cuota obligatoria ni lista de quién pagó.',
  ),
  ReelClip(
    id: 'prensa',
    group: ReelGroup.directivo,
    label: 'Directivo · la prensa en la puerta',
    situation:
        'Un noticiero llega por el caso de un estudiante de 7°. Piden declaración y el grado exacto. Hay padres grabando en la reja. Rectoría no está.',
    stem: 'Como coordinador, ¿qué haces?',
    options: [
      'Dar una declaración corta, sin nombres, para calmar el rumor.',
      'Dejar que el consejo de padres hable en nombre del colegio.',
      'No entregar datos del menor y remitir a la instancia oficial.',
      'Mostrar el acta del comité para probar que sí actuaron.',
    ],
    correctIndex: 2,
    revealWhy:
        'Ningún dato de un menor se entrega a medios: la vocería tiene canal y la reserva es obligatoria.',
  ),
];
