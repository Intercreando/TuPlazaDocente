/// Textos legales del producto (plantilla operativa; no es asesoría jurídica).
abstract final class LegalDocuments {
  static const String responsibleName = 'TuPlazaDocente';
  static const String contactEmail = 'soporte@tuplazadocente.com';
  static const String siteUrl = 'https://www.tuplazadocente.com';
  static const String lastUpdatedLabel = '3 de agosto de 2026';

  static const List<LegalSection> terms = [
    LegalSection(
      title: '1. Qué es TuPlazaDocente',
      body:
          'TuPlazaDocente es una aplicación web (PWA) de entrenamiento para aspirantes '
          'al Concurso Docente en Colombia. Ofrece práctica, simulacros, plan de estudio '
          'y feedback pedagógico. No somos CNSC, ICFES, MEN ni ninguna entidad oficial del Estado.',
    ),
    LegalSection(
      title: '2. Aceptación',
      body:
          'Al usar el sitio o crear una cuenta aceptas estos Términos. Si no estás de acuerdo, '
          'no uses el servicio. Podemos actualizar estos textos; la fecha de actualización '
          'aparece al inicio de esta página.',
    ),
    LegalSection(
      title: '3. Cuentas y uso permitido',
      body:
          'Puedes usar el servicio como invitado o con cuenta (Google o correo). Eres responsable '
          'de la confidencialidad de tu acceso. La cuenta es de uso personal: no compartas tu '
          'contraseña ni el acceso Premium con terceros para que varios aspirantes entren a la vez. '
          'Cada persona aprende distinto; la app construye un perfil propio (racha, radar, plan y '
          'maestría). Si varias personas usan la misma cuenta, ese perfil se contamina y el '
          'entrenamiento deja de ser útil para nadie. Está prohibido: abusar de la plataforma, '
          'eludir límites freemium de forma fraudulenta, revender el acceso Premium, o usar el '
          'contenido para entrenar sistemas ajenos a tu preparación personal. Podemos limitar el '
          'número de dispositivos concurrentes por cuenta.',
    ),
    LegalSection(
      title: '4. Plan Gratis y Premium',
      body:
          'El plan Gratis incluye cupos diarios/mensuales y modos limitados. Premium es un pago '
          'único por convocatoria vigente (no es suscripción automática). El precio vigente se '
          'muestra en la pantalla Premium. Premium puede usarse en hasta 3 dispositivos de la '
          'misma cuenta; si abres un cuarto, el más antiguo puede cerrarse. Códigos de acceso '
          'pueden existir con fines internos o promocionales y pueden revocarse.',
    ),
    LegalSection(
      title: '5. Pagos',
      body:
          'Los cobros los procesa Wompi (pasarela de pagos). TuPlazaDocente no almacena números '
          'completos de tarjeta. Un pago aprobado activa Premium en tu cuenta. Si el pago se '
          'aprueba y Premium no aparece, contáctanos con el correo de la cuenta y la referencia '
          'de la transacción.',
    ),
    LegalSection(
      title: '6. Reembolsos',
      body:
          'Por ser un bien digital de acceso inmediato, los reembolsos se evalúan caso a caso '
          '(pago duplicado, error técnico demostrable, o cuando la ley aplicable lo exija). '
          'Solicítalo a $contactEmail dentro de los 5 días calendario siguientes al pago, '
          'con soporte de la transacción.',
    ),
    LegalSection(
      title: '7. Contenido educativo',
      body:
          'Las preguntas, explicaciones y referencias normativas se elaboran con fines de '
          'entrenamiento. No garantizan resultados en el concurso ni sustituyen la lectura '
          'oficial de leyes, decretos, guías CNSC/ICFES o material del Ministerio de Educación.',
    ),
    LegalSection(
      title: '8. Disponibilidad',
      body:
          'Buscamos alta disponibilidad, pero el servicio puede interrumpirse por mantenimiento, '
          'fallas de terceros (Firebase, Wompi, redes) o fuerza mayor. No respondemos por daños '
          'indirectos derivados de la indisponibilidad.',
    ),
    LegalSection(
      title: '9. Contacto',
      body:
          'Responsable del servicio: $responsibleName.\n'
          'Correo: $contactEmail\n'
          'Sitio: $siteUrl',
    ),
  ];

  static const List<LegalSection> privacy = [
    LegalSection(
      title: '1. Responsable del tratamiento',
      body:
          '$responsibleName trata datos personales para operar TuPlazaDocente '
          '($siteUrl). Contacto: $contactEmail. Marco aplicable en Colombia: Ley 1581 de 2012 '
          'y normas complementarias.',
    ),
    LegalSection(
      title: '2. Datos que tratamos',
      body:
          'Según cómo uses la app podemos tratar: correo electrónico, nombre mostrado, '
          'identificador de usuario (UID), preferencias (especialidad, fecha de examen, tema), '
          'progreso de estudio (racha, maestría, respuestas), registros de pago (referencia, '
          'estado, monto; sin datos sensibles de tarjeta), y datos técnicos básicos del '
          'navegador necesarios para Auth y seguridad.',
    ),
    LegalSection(
      title: '3. Finalidades',
      body:
          'Autenticarte y sincronizar tu progreso; prestar el servicio freemium/Premium; '
          'procesar y confirmar pagos vía Wompi; mejorar el producto; cumplir obligaciones '
          'legales; y atender soporte. No vendemos tus datos personales.',
    ),
    LegalSection(
      title: '4. Encargados / proveedores',
      body:
          'Usamos infraestructura de Google Firebase (Auth, Firestore, Cloud Functions, Hosting) '
          'y Wompi para pagos. Estos proveedores tratan datos según sus propios términos y '
          'solo en la medida necesaria para el servicio.',
    ),
    LegalSection(
      title: '5. Bases del tratamiento',
      body:
          'Ejecución del servicio que solicitas, interés legítimo en operar y proteger la '
          'plataforma, y consentimiento cuando aplique (p. ej. notificaciones del navegador). '
          'El pago implica el tratamiento necesario para completar la transacción y activar Premium.',
    ),
    LegalSection(
      title: '6. Conservación',
      body:
          'Conservamos la cuenta y el progreso mientras uses el servicio o hasta que pidas '
          'eliminación, salvo retención exigida por ley (p. ej. registros de transacciones).',
    ),
    LegalSection(
      title: '7. Tus derechos',
      body:
          'Puedes solicitar acceso, actualización, rectificación o eliminación de datos, y '
          'revocar consentimientos no esenciales, escribiendo a $contactEmail. También puedes '
          'presentar quejas ante la Superintendencia de Industria y Comercio (SIC) cuando '
          'corresponda.',
    ),
    LegalSection(
      title: '8. Menores de edad',
      body:
          'El servicio está orientado a aspirantes adultos al concurso docente. Si un menor '
          'usa la plataforma, debe hacerlo con supervisión de un adulto responsable.',
    ),
    LegalSection(
      title: '9. Cambios',
      body:
          'Podemos actualizar esta Política. La fecha de la última versión aparece al inicio '
          'de esta página. El uso continuado tras un cambio relevante implica que fuiste informado '
          'por este medio; cambios sustanciales se comunicarán también en la app cuando sea viable.',
    ),
  ];
}

class LegalSection {
  const LegalSection({required this.title, required this.body});

  final String title;
  final String body;
}
