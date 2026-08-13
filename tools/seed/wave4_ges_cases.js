/**
 * Casos de gestión escolar (directivo): instancia vs costumbre.
 * No inventa artículos; usa marcos ya citados en el ítem (Guía 34, 715, 1620, 1278, 1075).
 */

const HAND_GES = {
  "dir-apt-ges-61": {
    caseContext:
      "Al actualizar el PEI, un rector organiza solo “lo académico y lo disciplinario”. El pagador pide un capítulo financiero aparte, desconectado. El Consejo Directivo exige el mapa de la Guía 34 para la autoevaluación.",
    stem:
      "¿Qué cuatro áreas de gestión debe articular el PEI, según el mapa de la Guía 34?",
    options: [
      "Directiva, académica, administrativa-financiera y comunitaria.",
      "Pedagógica, financiera, disciplinaria y deportiva, como capítulos de imagen.",
      "Directiva, académica, deportiva y cultural, omitiendo lo comunitario y lo financiero.",
      "Administrativa, comunitaria, financiera y tecnológica, sin gestión directiva ni académica.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-64": {
    caseContext:
      "Una secretaría pide “que el coordinador firme como representante legal” mientras el rector está en comisión. El coordinador alega que “en la práctica es lo mismo”. El Consejo Directivo duda quién responde ante terceros.",
    stem:
      "¿Cuál es la diferencia funcional más precisa entre rector y coordinador?",
    options: [
      "El coordinador tiene mayor jerarquía normativa que el rector en representación legal.",
      "El rector es el representante legal; el coordinador apoya la gestión académica y de convivencia bajo su orientación.",
      "El coordinador es elegido por votación estudiantil y sustituye al rector en todo acto.",
      "No hay diferencia funcional: ambos firman indistintamente contratos y actos de personal.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-65": {
    caseContext:
      "En el Día E, un docente presenta el ISCE como “asistencia, disciplina e infraestructura”. Otro trae el desagregado MEN: progreso, desempeño, eficiencia y ambiente escolar. Coordinación pide no mezclar indicadores de planta física con el índice.",
    stem:
      "¿Qué componentes corresponden al ISCE, según el desagregado oficial con el que se diseñó ese índice?",
    options: [
      "Progreso, desempeño, eficiencia y ambiente escolar.",
      "Asistencia, disciplina, infraestructura y presupuesto.",
      "Matrícula, deserción, cobertura y nómina docente.",
      "Evaluación docente, planta física, transporte y PAE.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-71": {
    caseContext:
      "Un concejal afirma que “el colegio contrata toda la planta con recursos propios”. El rector responde que el SGP transfiere recursos con competencias entre Nación y entidades territoriales. La visita pide el marco de la Ley 715, no un relato de caja.",
    stem:
      "En este desacuerdo sobre financiación y competencias, ¿qué establece el SGP para educación?",
    options: [
      "Elimina la financiación estatal de la educación pública.",
      "Define la distribución de recursos entre la Nación y las entidades territoriales para prestar el servicio educativo.",
      "Centraliza toda la contratación docente en el Ministerio de Educación.",
      "Regula exclusivamente la evaluación de estudiantes y deja el financiamiento por fuera.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-72": {
    caseContext:
      "Quieren “autoevaluar” copiando el formato del año anterior y publicando un ranking de sedes. Un coordinador pide identificar fortalezas y brechas en las cuatro áreas de gestión como insumo del PMI. El Consejo Directivo pide evidencia, no imagen.",
    stem:
      "¿Cuál es el propósito principal de la autoevaluación institucional anual en ese ciclo de mejoramiento?",
    options: [
      "Sancionar sedes o docentes con menor percepción de clima, como fin del ejercicio.",
      "Identificar fortalezas y oportunidades de mejora en las cuatro áreas de gestión, como insumo del plan de mejoramiento.",
      "Reemplazar el PEI por un informe de prensa para la secretaría.",
      "Sustituir el PMI y el SIEE por un único promedio de satisfacción familiar.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-77": {
    caseContext:
      "Llega un episodio de convivencia. Un docente lo trata como “indisciplina de aula” sin tipificar. Orientación pide clasificar según la Ley 1620 (Tipo I, II o III) para activar la ruta proporcional. El rector duda si “todos los casos son Tipo III para que se vea firmeza”.",
    stem:
      "Para activar la ruta proporcional, ¿cuál es la clasificación de situaciones que afectan la convivencia escolar?",
    options: [
      "Leve, grave y gravísima, copiada del código penal, sin ruta escolar.",
      "Tipo I, Tipo II y Tipo III, según gravedad e impacto, para orientar la atención.",
      "Académica, disciplinaria y laboral, mezclando faltas de personal con estudiantes.",
      "Solo Tipo III, porque toda agresión debe judicializarse de inmediato.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-80": {
    caseContext:
      "Tras la autoevaluación, el rector quiere “archivar el informe y seguir el PEI como está”. El Consejo Directivo pide un PMI con metas, acciones y responsables. Un docente sugiere que el PMI reemplace al PEI y al SIEE.",
    stem:
      "¿Cuál es el propósito principal del Plan de Mejoramiento Institucional derivado de la autoevaluación?",
    options: [
      "Sustituir el Proyecto Educativo Institucional.",
      "Establecer metas, acciones y responsables para superar las debilidades identificadas.",
      "Definir exclusivamente el calendario académico.",
      "Reemplazar el Sistema Institucional de Evaluación de Estudiantes.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-161": {
    caseContext:
      "En un consejo, alguien cita “el decreto de evaluación” y otro “el 1278” como si fueran el único cuerpo. Un abogado de la secretaría aclara que el 1075 de 2015 compiló decretos reglamentarios del sector en un DUR. Piden no confundirlo con una ley de SGP ni con la CNSC.",
    stem:
      "¿Qué es el Decreto 1075 de 2015 en el sector educativo colombiano?",
    options: [
      "El Decreto Único Reglamentario del Sector Educación, que compila decretos reglamentarios previos.",
      "Una ley que crea el Sistema General de Participaciones.",
      "El decreto que regula exclusivamente la evaluación de estudiantes (SIEE).",
      "El decreto que crea la Comisión Nacional del Servicio Civil.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-165": {
    caseContext:
      "Un elegible pide nombramiento “cuando quiera, porque la lista no vence”. Talento humano cita la regla general de vigencia (habitualmente dos años desde la conformación), salvo que el acto del concurso disponga otra cosa. El rector no puede “guardar” la lista indefinidamente.",
    stem:
      "¿Cuál es, de manera general, la vigencia de las listas de elegibles de un concurso docente?",
    options: [
      "Dos años desde su conformación, salvo disposición distinta en el acto administrativo del concurso.",
      "Diez años, sin posibilidad de vencimiento, como derecho adquirido absoluto.",
      "Seis meses únicamente, aunque el acto del concurso fije otro término.",
      "Vigencia indefinida mientras el elegible conserve el puntaje.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-166": {
    caseContext:
      "Al revisar el manual, solo hay “prohibiciones y sanciones”. Faltan pautas de comportamiento, debido proceso y rutas de la Ley 1620. El comité pide completar el mínimo normativo, no un código penal escolar.",
    stem:
      "¿Qué debe contener, como mínimo, el manual de convivencia según la normatividad de convivencia escolar?",
    options: [
      "Solo el listado de sanciones y el uniforme, sin rutas ni debido proceso.",
      "Pautas de comportamiento esperado, debido proceso ante faltas y rutas de atención integral.",
      "Únicamente el horario de clase y el calendario de izadas de bandera.",
      "El reglamento interno de trabajo del personal administrativo, como si fuera el mismo documento.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-167": {
    caseContext:
      "Quieren usar el manual de convivencia para amonestar a un administrativo por horario laboral. El pagador dice que eso es reglamento interno de trabajo. El comité escolar de convivencia no es el de convivencia laboral.",
    stem:
      "¿Cuál es la diferencia principal entre manual de convivencia y reglamento interno de trabajo?",
    options: [
      "Son el mismo documento con dos carátulas distintas.",
      "El reglamento interno de trabajo regula a los estudiantes y el manual al personal.",
      "El manual regula la relación con estudiantes y comunidad educativa; el RIT, las relaciones laborales del personal.",
      "El manual de convivencia solo aplica a docentes y no a estudiantes.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ges-168": {
    caseContext:
      "Hay un conflicto entre dos docentes por presunto acoso laboral. El rector lo remite al Comité Escolar de Convivencia (estudiantes). Un colega recuerda la Resolución 652 de 2012: el Comité de Convivencia Laboral atiende acoso entre trabajadores.",
    stem:
      "¿Cuál es el propósito principal del Comité de Convivencia Laboral (Res. 652 de 2012)?",
    options: [
      "Sancionar estudiantes por faltas Tipo I como si fueran acoso laboral.",
      "Reemplazar al Comité Escolar de Convivencia en todos los casos de aula.",
      "Adoptar el manual de convivencia institucional en lugar del Consejo Directivo.",
      "Prevenir y atender situaciones de acoso laboral entre los trabajadores de la institución.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ges-169": {
    caseContext:
      "Un docente 1278 quiere “subir de grado” solo con años de servicio, sin evaluación de competencias. Otro cita que esa evaluación es el mecanismo de ascenso/reubicación salarial del estatuto. No equivale a ingresar sin concurso.",
    stem:
      "En el Decreto 1278 de 2002, ¿qué permite la evaluación de competencias?",
    options: [
      "Ascender de grado o de nivel salarial dentro del escalafón, según el desempeño demostrado.",
      "Ingresar a la carrera docente sin concurso de méritos.",
      "Obtener nombramiento definitivo automático al primer año, sin periodo de prueba.",
      "Sustituir la evaluación anual de desempeño por un curso corto de actualización.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-170": {
    caseContext:
      "En nómina, alguien agrupa a todos los 1278 en “un único nivel por antigüedad”. Talento humano explica grados según título y niveles salariales dentro de cada grado. El rector pide no usar el número de estudiantes a cargo como categoría de escalafón.",
    stem:
      "¿Cómo organiza el escalafón docente del Decreto 1278 de 2002 a los educadores?",
    options: [
      "Solo por antigüedad, sin relación con el título académico.",
      "En grados (según título académico) y niveles salariales dentro de cada grado.",
      "En un único nivel salarial para todos los docentes oficiales.",
      "Por el número de estudiantes a cargo en cada jornada.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-172": {
    caseContext:
      "Un docente pide tres días de permiso. El rector “autoriza de palabra”. Talento humano de la secretaría aclara que la autorización formal de permisos y licencias corresponde a la entidad territorial certificada, más allá del reporte inicial al rector.",
    stem:
      "¿Quién tiene la competencia para autorizar formalmente permisos y licencias de un docente oficial?",
    options: [
      "Exclusivamente el Consejo Directivo, como si fuera un acto de gobierno escolar.",
      "La asociación de padres, porque “paga impuestos”.",
      "El Consejo Académico, por ser órgano consultivo del currículo.",
      "La entidad territorial certificada, a través de la dependencia de talento humano de la Secretaría de Educación.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ges-173": {
    caseContext:
      "Proponen “reemplazar la jornada regular por solo danza y fútbol”. El rector aclara que la Jornada Escolar Complementaria suma arte, deporte o cultura en horario adicional, sin sustituir el plan de estudios ni el PAE.",
    stem:
      "¿Qué caracteriza a la Jornada Escolar Complementaria promovida por el MEN?",
    options: [
      "Ofrecer actividades extracurriculares (deportivas, artísticas o culturales) en horario adicional a la jornada regular.",
      "Reemplazar por completo la jornada académica regular.",
      "Ser obligatoria únicamente para grado once como requisito de grado.",
      "Sustituir el Programa de Alimentación Escolar.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-174": {
    caseContext:
      "El calendario marca Día E. Un sector pide “día recreativo sin clases ni análisis”. El equipo de calidad quiere reflexionar el ISCE y ajustar el PMI. No es evaluación de directivos ni reemplazo de las semanas de desarrollo institucional.",
    stem:
      "¿Cuál es el propósito principal del Día E promovido por el MEN?",
    options: [
      "Suspender clases para actividades exclusivamente recreativas.",
      "Dedicar una jornada a la reflexión pedagógica sobre el ISCE y la construcción de planes de mejoramiento.",
      "Evaluar únicamente el desempeño de los directivos docentes.",
      "Reemplazar la semana de desarrollo institucional.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-175": {
    caseContext:
      "En semana de desarrollo institucional, familias exigen “clases normales”. Un docente pide usarla para planeación, autoevaluación y formación, sin atención directa a estudiantes. No es semana de pruebas Saber ni de recreación estudiantil.",
    stem:
      "¿A qué están destinadas principalmente las Semanas de Desarrollo Institucional del calendario?",
    options: [
      "Actividades exclusivamente recreativas para estudiantes.",
      "Aplicar pruebas Saber a todos los grados.",
      "Planeación, evaluación institucional y capacitación docente, sin atención directa a estudiantes.",
      "Sustituir el Día E y la rendición de cuentas a la comunidad.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ges-176": {
    caseContext:
      "Un rector publica “su” calendario (vacaciones distintas a las de la secretaría). El Consejo Directivo cree que le corresponde. La ETC recuerda que el calendario de IE oficiales lo define la secretaría, dentro de parámetros del MEN.",
    stem:
      "¿Quién define el calendario académico de las IE oficiales de un municipio certificado?",
    options: [
      "Cada rector, de manera independiente para su sede.",
      "El Consejo Directivo de cada institución, como acto de autonomía plena.",
      "La Comisión Nacional del Servicio Civil.",
      "La Secretaría de Educación de la entidad territorial certificada, dentro de los parámetros generales del MEN.",
    ],
    correctIndex: 3,
  },
  "dir-apt-ges-177": {
    caseContext:
      "Una familia pide traslado “con una carta al rector de origen”. El rector de destino dice que “si hay cupo, él decide solo”. La secretaría indica que el traslado entre oficiales del mismo municipio certificado se gestiona por el sistema de matrícula, con las IE involucradas.",
    stem:
      "¿A quién corresponde principalmente autorizar ese traslado?",
    options: [
      "A la Secretaría de Educación municipal, mediante su sistema de matrícula, con la gestión de las instituciones involucradas.",
      "Exclusivamente al rector de origen, sin registro en el sistema de matrícula.",
      "Al personero estudiantil, como representante de derechos.",
      "Al Consejo Académico, por ser órgano consultivo del plan de estudios.",
    ],
    correctIndex: 0,
  },
  "dir-apt-ges-178": {
    caseContext:
      "Un docente y un coordinador discuten una orden de servicio. El docente quiere ir mañana a un noticiero. El coordinador propone agotar diálogo interno y, si hay acoso, el Comité de Convivencia Laboral, antes de instancias externas.",
    stem:
      "Ante un desacuerdo administrativo persistente, ¿cuál vía institucional es la más apropiada antes de escalar afuera?",
    options: [
      "Acudir de inmediato a medios de comunicación, sin registro interno.",
      "Agotar espacios internos de diálogo y, si es pertinente, el Comité de Convivencia Laboral, antes de instancias externas.",
      "Imponer la orden por chat, sin acta ni derecho de defensa.",
      "Delegar el conflicto a las familias del curso, para “que presionen”.",
    ],
    correctIndex: 1,
  },
  "dir-apt-ges-179": {
    caseContext:
      "En una vereda sin oferta oficial suficiente, proponen “un acuerdo verbal con un colegio privado” o “cerrar lo oficial”. La secretaría recuerda que la contratación del servicio con particulares tiene marco de calidad, cobertura y supervisión, no un trato de palabra del rector.",
    stem:
      "¿Qué rige principalmente esa contratación del servicio educativo?",
    options: [
      "La libre decisión de cada familia, sin marco de calidad ni supervisión.",
      "La eliminación total de la educación oficial en esa zona, como regla.",
      "La normatividad que regula la prestación por particulares mediante contrato con el Estado, sujeta a calidad y cobertura.",
      "Un acuerdo exclusivamente verbal entre el rector y el particular.",
    ],
    correctIndex: 2,
  },
  "dir-apt-ges-180": {
    caseContext:
      "El rector considera la rendición de cuentas “un acto estético de fin de año”. El Consejo Directivo pide informar uso de recursos y avances del PMI a la comunidad. No sustituye al Consejo Directivo ni a la autoevaluación anual; las complementa.",
    stem:
      "¿Por qué es importante que una IE oficial rinda cuentas a la comunidad educativa?",
    options: [
      "Porque es un requisito exclusivamente estético, sin efecto práctico.",
      "Porque reemplaza la necesidad de un Consejo Directivo.",
      "Porque sustituye la autoevaluación institucional anual.",
      "Porque fortalece la transparencia en el uso de recursos públicos y la participación en el seguimiento a la gestión.",
    ],
    correctIndex: 3,
  },
};

module.exports = {HAND_GES};
