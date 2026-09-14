# -*- coding: utf-8 -*-
"""Reescribe oro-soc-25..32 y dir-apt-lec-01..02 y valida el lote 741-750."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
INP = ROOT / "_tmp_in_741_750.json"
OUT = ROOT / "_tmp_out_741_750.json"

FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)
OBVIOUS = (
    "ignorar",
    "sin planear",
    "aunque rompa",
    "aunque se presente como",
    "aunque ahorre",
    "aunque parezca",
    "actividad recreativa",
    "eliminar toda evidencia",
    "para que se note liderazgo",
    "castigo del rincón",
)
KEYS_OK = {
    "id",
    "options",
    "explanation",
    "normativeJustification",
    "theoreticalJustification",
    "distractorAnalysis",
}
CI = {
    "oro-soc-25": 1,
    "oro-soc-26": 1,
    "oro-soc-27": 1,
    "oro-soc-28": 1,
    "oro-soc-29": 1,
    "oro-soc-30": 1,
    "oro-soc-31": 1,
    "oro-soc-32": 1,
    "dir-apt-lec-01": 1,
    "dir-apt-lec-02": 2,
}

ITEMS = [
    {
        "id": "oro-soc-25",
        "options": [
            "Valorar en el debate evaluado la fluidez y el «hablar mucho» como liderazgo oral, y exhibir esa seguridad en el habla como respuesta inmediata al sector de la comunidad, sin socializar de antemano el uso de fuentes ni el respeto argumentativo.",
            "Socializar antes del debate una rúbrica conocida de argumentos, evidencia de fuentes, escucha y respeto, de modo que el desempeño deje de medirse por «hablar mucho» y quede trazable en criterios, evidencias e instancias del SIEE.",
            "Entregar la rúbrica del debate el día de los resultados, argumentando que adelantarla revelaría la respuesta y que «tratar a todos igual» consiste en no mostrar criterios hasta cerrar las notas del episodio.",
            "Grabar el debate con consentimiento de la Ley 1581, archivar el audio en la carpeta de calidad y tomarlo como evidencia evaluativa completa, sin rúbrica previa de fuentes, argumentos ni respeto deliberativo.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente cuando, en un debate evaluado, el grupo no sabía si contaban las fuentes, el respeto o el «hablar mucho». El Decreto 1290 exige criterios claros y conocidos antes de recoger evidencia; los EBC de ciencias sociales orientan la argumentación con fuentes y la deliberación respetuosa. Socializar la rúbrica previa media el desempeño durante el debate y deja trazabilidad de criterios, evidencias e instancias, no una ocurrencia. Premiar la fluidez como liderazgo calma el pedido visible de la comunidad y conserva la opacidad. Mostrar la rúbrica con las notas finge equidad y anula lo formativo. El audio con Ley 1581 legaliza el archivo y no sustituye el criterio.",
        "normativeJustification": "El Decreto 1290 obliga a criterios conocidos por los estudiantes y a evaluación formativa. Los EBC de sociales valoran argumentar con evidencia y participar con respeto. La Ley 1581 regula el dato personal de la grabación, no el juicio de calidad del debate.",
        "theoreticalJustification": "La transparencia evaluativa orienta la deliberación: quien conoce argumentos, evidencia y escucha puede desempeñarlos. El liderazgo oral sin rúbrica mide volumen. La rúbrica tardía mide nota. El consentimiento de imagen mide archivo, no aprendizaje.",
        "distractorAnalysis": {
            "0": "Trampa del liderazgo oral visible: premiar el «hablar mucho» parece respuesta inmediata al sector de la comunidad y evidencia de seguridad. Omite fuentes, respeto y criterios previos que el 1290 exige conocer antes del debate.",
            "2": "Trampa de la equidad como opacidad: entregar la rúbrica con los resultados parece «no adelantar la respuesta» y tratar a todos igual. Anula la función formativa y deja intacta la duda sobre qué se valoraba.",
            "3": "Trampa de dominio cruzado del habeas data: grabar el debate con Ley 1581 y archivar el audio luce como evidencia legal y carpeta de calidad. Documenta el evento y no socializa argumentos, fuentes ni respeto.",
        },
    },
    {
        "id": "oro-soc-26",
        "options": [
            "Entregar un listado de monumentos y «cosas viejas» del municipio para recitar nombres y fechas, aplicar una prueba comparable de nomenclátor y dar por cubierto el patrimonio ante el reclamo de rigor de la comunidad.",
            "Relacionar el patrimonio material e inmaterial del territorio con identidad, memoria y responsabilidades ciudadanas de cuidado, de modo que deje de enseñarse como «cosa vieja» y quede evidencia de valoración cultural trazable.",
            "Organizar una caminata turística al monumento local con fotografías para la cartelera, tomarla como experiencia vivencial de patrimonio y omitir el vínculo con identidad, memoria y deberes de cuidado comunitario.",
            "Levantar el inventario de bienes de la institución para la visita de calidad, fotografiar activos y archivar fichas patrimoniales, dando por cubierto el aprendizaje de identidad y de cuidado comunitario del caso.",
        ],
        "explanation": "La condición de calidad pide lo más defendible pedagógica e institucionalmente cuando el patrimonio local se aborda como «cosa vieja», sin identidad ni cuidado comunitario. Los EBC y DBA de ciencias sociales conciben el patrimonio como construcción social viva —material e inmaterial— articulada a memoria y a responsabilidades ciudadanas. Relacionar esos planos deja criterios y evidencias trazables, no una ocurrencia ornamental. El listado de monumentos cubre imagen de rigor comparable y momifica el objeto. La caminata con fotos responde al pedido visible de la comunidad y no formaliza la competencia. El inventario de bienes de la IE es gestión de calidad: confunde activo institucional con aprendizaje cultural.",
        "normativeJustification": "Los EBC de identidad y de pluralidad y los DBA de ciencias sociales exigen valorar el patrimonio en vínculo con el territorio. La Ley 115 orienta el conocimiento de la realidad cultural local. Un inventario de bienes para la visita no sustituye esos referentes de aula.",
        "theoreticalJustification": "El patrimonio se comprende como práctica de memoria y de cuidado, no como objeto muerto ni como nomenclátor. La caminata turística mide desplazamiento. La ficha de activos mide gestión. Ninguna enseña responsabilidades ciudadanas sobre lo heredado.",
        "distractorAnalysis": {
            "0": "Trampa del nomenclátor patrimonial: el listado de monumentos y la prueba de nombres parecen cobertura comparable y rigor ante la comunidad. Conservan el patrimonio como «cosa vieja» y omiten identidad, memoria y cuidado.",
            "2": "Trampa de la vivencia turística: la caminata y las fotos del monumento parecen experiencia situada y salida visible. No articulan patrimonio inmaterial, identidad ni deberes de cuidado comunitario.",
            "3": "Trampa de dominio cruzado del inventario de bienes: las fichas de activos para la visita de calidad lucen trazables y profesionales. Confunden patrimonio contable de la IE con el aprendizaje de identidad cultural.",
        },
    },
    {
        "id": "oro-soc-27",
        "options": [
            "Seguir el temario de cobertura de la clase y tratar los comentarios xenófobos hacia estudiantes migrantes como ruido de pasillo ajeno al área, para no salirse del programa y responder con «tratar a todos igual».",
            "Abordar el hecho con enfoque de derechos, cuidado a las víctimas migrantes y formación antidiscriminación en el aula de sociales, con registro pedagógico y ruta, de modo que deje de decirse que «no es tema de la clase».",
            "Ofrecer una charla general de valores y un cambio de puesto de los implicados, sin registro pedagógico ni trabajo de derechos, y presentarlo como salida inmediata y visible ante el sector de la comunidad.",
            "Remitir el caso al Comité Escolar de Convivencia de la Ley 1620 y a orientación, archivar el acta y dar por cerrado el aprendizaje de sociales, como si la gestión de ruta sustituyera la mediación de aula.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible cuando hay estudiantes migrantes, comentarios xenófobos y el docente afirma que «no es tema de la clase». La Ley 1620 y el marco de derechos obligan a prevenir y atender discriminación; el aula de sociales es espacio privilegiado para dignidad, pluralidad y convivencia, con registro y ruta. Abordar el hecho con cuidado a las víctimas y formación antidiscriminación es mediación pedagógica trazable, no una ocurrencia. Seguir el temario y llamar «ruido de pasillo» al agravio protege la cobertura y niega el objeto. La charla de valores y el cambio de puesto calman a la comunidad sin evidencia de aprendizaje. Remitir al Comité 1620 es gestión correcta de convivencia: no cierra, por sí sola, la enseñanza del área.",
        "normativeJustification": "La Ley 1620 y su decreto reglamentario exigen prevención, atención y seguimiento de discriminación. Los EBC de competencias ciudadanas y de pluralidad obligan a trabajar dignidad en el aula. El Comité de Convivencia activa la ruta; no reemplaza la mediación de ciencias sociales.",
        "theoreticalJustification": "La xenofobia en el aula es contenido y clima a la vez: se atiende a la víctima y se forma al grupo. El temario como refugio evade el objeto. La charla genérica produce clima verbal. El acta del Comité produce trámite y deja intacto el aprendizaje.",
        "distractorAnalysis": {
            "0": "Trampa de la cobertura del temario: seguir el programa y tratar el comentario xenófobo como ruido de pasillo parece profesionalidad académica y equidad. Niega el enfoque de derechos que el aula de sociales y la Ley 1620 exigen.",
            "2": "Trampa de la charla de valores: el discurso genérico y el cambio de puesto parecen salida inmediata y visible para la comunidad. No registran el hecho, no cuidan a las víctimas migrantes ni forman antidiscriminación.",
            "3": "Trampa de dominio cruzado de la ruta 1620: remitir al Comité y a orientación es gestión correcta de convivencia. Dar por cerrado el aprendizaje de sociales sustituye la mediación de aula por el acta administrativa.",
        },
    },
    {
        "id": "oro-soc-28",
        "options": [
            "Validar el juicio del estudiante que aplica criterios del presente a la sociedad del siglo XIX como pensamiento crítico y derechos humanos, y calificar esa condena actual como logro de ciudadanía comparable.",
            "Enseñar a historicizar: situar prácticas del siglo XIX en su contexto de época, sin justificar opresiones, y distinguir presente y pasado, de modo que el juicio deje de ser anacrónico y quede evidencia de pensamiento histórico.",
            "Pedir que el grupo se abstenga de valorar éticamente el siglo XIX, presentar esa abstención como respeto histórico de época y dar por superado el anacronismo al silenciar cualquier juicio sobre opresiones del pasado.",
            "Encargar un ensayo de opinión sobre un debate actual del personero, con rúbrica de argumentación ciudadana, y tomarlo como evidencia de pensamiento histórico, sin historicizar la sociedad del siglo XIX del caso.",
        ],
        "explanation": "La condición de calidad pide lo más defendible cuando un estudiante juzga el siglo XIX con criterios del presente y el docente valida ese anacronismo. Los EBC de ciencias sociales forman pensamiento histórico: comprender el contexto de época, distinguir presente y pasado y explicar sin justificar opresiones. Historicizar es rigor, no relativismo ciego; deja criterios y evidencias trazables. Sellar la condena presente como «crítica y derechos humanos» parece ética exigente y congela el anacronismo. Abstenerse de todo juicio ético finge respeto histórico y cancela la evaluación moral informada. El ensayo sobre el personero es ciudadanía viva del gobierno escolar: desplaza el objeto del caso.",
        "normativeJustification": "Los EBC y los Lineamientos de ciencias sociales exigen historicidad, contextualización y análisis de procesos, no la proyección acrítica del presente ni el silencio valorativo. El gobierno escolar (Ley 115) no sustituye el objeto de estudio del siglo XIX.",
        "theoreticalJustification": "Historicizar comprende para explicar: sitúa normas de época y conserva el juicio informado sobre dominación. El presente como vara única es anacronismo. El relativismo como respeto es evasión. El ensayo del personero es deliberación actual, no pensamiento histórico del caso.",
        "distractorAnalysis": {
            "0": "Trampa del presente como crítica: validar el juicio al siglo XIX con criterios actuales parece derechos humanos y pensamiento crítico. Es anacronismo: condena sin historicizar y el docente lo sella como logro de ciudadanía.",
            "2": "Trampa del relativismo como respeto: abstenerse de valorar éticamente el pasado parece rigurosidad histórica. Impide distinguir comprender el contexto de justificar opresiones, que es el esencial del episodio.",
            "3": "Trampa de dominio cruzado del gobierno escolar: el ensayo sobre el debate del personero parece ciudadanía viva y argumentación. Desplaza el objeto —la sociedad del siglo XIX— y no enseña a historicizar.",
        },
    },
    {
        "id": "oro-soc-29",
        "options": [
            "Dejar el conflicto por el uso del río en la calidad del agua y en el PRAE de ciencias, sin actores sociales ni normas, argumentando que el objeto es biológico y que sociales no debe mezclar el tema del territorio.",
            "Analizar actores, intereses, normas y conflictos socioambientales del territorio en torno al río, articulando poder, ciudadanía y evidencia, de modo que el episodio deje de enseñarse como «tema de biología».",
            "Convocar una jornada de limpieza del río con fotografías para la comunidad, y dar por cubierto el conflicto socioambiental, sin categorías de poder, territorio ni normas que organicen a los actores del caso.",
            "Radicar un oficio a la Alcaldía y a la CAR describiendo el conflicto del río, archivar el radicado como evidencia de que el área intervino, y omitir en el aula el análisis de actores, intereses y normas.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible cuando el conflicto por el uso del río se enseña como «tema de biología», sin actores sociales ni normas. Los EBC y los Lineamientos de ciencias sociales explican conflictos socioambientales con categorías de poder, territorio y ciudadanía; la interdisciplinariedad potencia, no reemplaza, esa lectura. Analizar actores, intereses y normas deja evidencia trazable del esencial del área. Ceder el río al PRAE de ciencias parece respeto disciplinar y borra el conflicto. La jornada de limpieza responde al pedido visible y no formaliza la competencia. El oficio a la Alcaldía y a la CAR es gestión pública impecable: interviene el trámite y no el aula.",
        "normativeJustification": "Los EBC de ciencias sociales y los Lineamientos de territorio exigen leer conflictos ambientales como relaciones de poder y de norma, no como calidad del agua aislada. El PRAE articula áreas; no autoriza a evacuar el objeto de sociales hacia biología o hacia un oficio externo.",
        "theoreticalJustification": "Un conflicto de uso del río es socioambiental: hay actores, intereses y reglas. Biologizarlo mide un indicador físico. Limpiar un día mide imagen. El radicado a la CAR mide gestión. Ninguno enseña a explicar el territorio.",
        "distractorAnalysis": {
            "0": "Trampa de la biologización del conflicto: dejar el río en la calidad del agua y en el PRAE de ciencias parece interdisciplinariedad responsable. Omite actores, intereses y normas que el área de sociales debe enseñar.",
            "2": "Trampa de la jornada visible: la limpieza del río con fotos parece PRAE y respuesta inmediata a la comunidad. No analiza poder, territorio ni conflicto de usos entre actores.",
            "3": "Trampa de dominio cruzado de la gestión pública: el oficio a la Alcaldía y a la CAR acredita intervención institucional trazable. No forma la competencia de explicar el conflicto socioambiental en el aula.",
        },
    },
    {
        "id": "oro-soc-30",
        "options": [
            "Publicar en la cartelera los relatos de los abuelos como la verdadera historia del barrio, sin contrastar archivos ni contextualizar el testimonio, y calificar esa publicación como historia oral auténtica y visible para la comunidad.",
            "Tratar la entrevista a los abuelos como fuente: triangular con archivos del barrio, analizar el contexto y el sesgo del testimonio, y dejar evidencia de crítica de fuentes, no de transcripción emotiva del episodio.",
            "Transcribir de forma literal las entrevistas a los abuelos y calificar extensión y ortografía del texto, presentando esa pulcritud formal como rigor de la historia oral, sin triangular ni situar el testimonio.",
            "Recoger consentimientos de la Ley 1581, archivar los audios de los abuelos en la carpeta de calidad y dar por cubierto el rigor metodológico, sin contraste con archivos ni análisis del contexto del testimonio.",
        ],
        "explanation": "La condición de calidad pide lo más defendible cuando el grupo entrevista a abuelos sobre el barrio y no contrasta con archivos ni contextualiza. Los EBC de ciencias sociales tratan la historia oral como fuente válida si se critica y se triangular: toda fuente tiene sesgo, y el método fortalece la explicación. Tratar la entrevista como fuente, con archivos y contexto, deja criterios y evidencias trazables. Publicar los relatos como «la verdadera historia» responde al pedido visible y canoniza un testimonio. Calificar extensión y ortografía finge rigor de lengua y evacua el objeto histórico. Los consentimientos 1581 y el archivo de audios son gestión del dato: legalizan el repositorio y no analizan el testimonio.",
        "normativeJustification": "Los EBC y los Lineamientos de ciencias sociales exigen crítica de fuentes orales y escritas, no la canonización de un relato. La Ley 1581 protege el dato de los abuelos entrevistados; no acredita triangulación ni historicidad del barrio.",
        "theoreticalJustification": "La historia oral se vuelve conocimiento cuando se interroga procedencia, contexto e interés y se contrasta. La cartelera de «verdad» mide memoria emotiva. La transcripción medida en extensión mide forma. El audio consentido mide archivo.",
        "distractorAnalysis": {
            "0": "Trampa de la oralidad como verdad: publicar los relatos de los abuelos como la verdadera historia del barrio parece valoración de la memoria y salida visible. Convierte el testimonio en crónica única y niega la crítica de fuentes.",
            "2": "Trampa de la transcripción formal: calificar extensión y ortografía parece rigor de lengua y evidencia comparable. No trata la entrevista como fuente ni la triangula con archivos del barrio.",
            "3": "Trampa de dominio cruzado del archivo 1581: consentimientos y audios lucen como método y protección de datos. Legalizan el repositorio y no analizan contexto ni sesgo del testimonio de los abuelos.",
        },
    },
    {
        "id": "oro-soc-31",
        "options": [
            "Entregar a Secretaría la planilla de horas firmadas del servicio social estudiantil como cumplimiento, y dar por formada la ciudadanía porque el recuento de horas quedó trazable, comparable y a salvo de reclamos.",
            "Articular el servicio social con un diagnóstico comunitario y una reflexión ética sobre el impacto, de modo que las horas dejen de ser firma vacía y queden evidencias de solidaridad y de participación ciudadana.",
            "Organizar una jornada masiva de recolección visible para la comunidad, sin diagnóstico del territorio ni reflexión sobre el impacto, y tomarla como servicio social cumplido ante el pedido de una salida inmediata.",
            "Expedir certificaciones y actas de horas del servicio social, archivarlas para la visita de calidad y presentarlas como evidencia de formación ciudadana, sin diagnóstico comunitario ni reflexión ética estudiantil.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible cuando el servicio social se cumple como «horas firmadas» sin reflexión sobre el impacto comunitario. La Ley 115 asigna al servicio social un sentido formativo de solidaridad y de participación; la experiencia educa cuando hay diagnóstico, acción y reflexión ética articuladas a aprendizajes de ciudadanía. Esa mediación es trazable (criterios, evidencia e instancias) y no una ocurrencia de planilla. La planilla para Secretaría cubre cumplimiento administrativo. La jornada masiva de recolección calma el pedido visible y no forma juicio sobre el territorio. Certificaciones y actas son dominio de archivo: lucen Ley 115 cumplida y dejan intacta la firma vacía.",
        "normativeJustification": "La Ley 115 y las normas de servicio social estudiantil lo definen como práctica formativa de solidaridad, no como recuento de horas para Secretaría. Los EBC de ciudadanía exigen reflexión sobre el impacto. Un acta de certificación no sustituye ese aprendizaje.",
        "theoreticalJustification": "El servicio educa cuando el estudiante diagnostica, actúa y piensa el efecto sobre la comunidad. La planilla mide asistencia. La recolección masiva mide visibilidad. La certificación mide trámite. Ninguna garantiza formación ética.",
        "distractorAnalysis": {
            "0": "Trampa de la planilla de cumplimiento: las horas firmadas para Secretaría parecen servicio social trazable y comparable. Confunden recuento administrativo con formación ciudadana y dejan el impacto sin reflexión.",
            "2": "Trampa de la jornada masiva: la recolección visible calma el pedido de la comunidad y parece solidaridad inmediata. Omite diagnóstico del territorio y reflexión ética sobre el impacto del servicio.",
            "3": "Trampa de dominio cruzado de la certificación: actas y constancias de horas lucen como evidencia de calidad y de Ley 115. Documentan la firma y no el aprendizaje de solidaridad ni el diagnóstico comunitario.",
        },
    },
    {
        "id": "oro-soc-32",
        "options": [
            "Calificar en los ensayos de sociales el contenido factual y los datos del tema, y posponer tesis, evidencia argumentativa y cohesión, argumentando que esas dimensiones corresponden a lenguaje y no al juicio del área.",
            "Acordar con el área de lenguaje una rúbrica compartida de argumentación —tesis, evidencia y cohesión— aplicada a temas sociales, de modo que los ensayos dejen de evaluarse con criterios descoordinados.",
            "Pedir que lenguaje corrija la forma al final del periodo y que sociales juzgue el contenido, sin criterios comunes previos de tesis, evidencia y cohesión, y presentar esa división de oficios como articulación.",
            "Emitir una circular de coordinación que ordene más ensayos para Saber en sociales, sin rúbrica compartida con lenguaje, y archivar la circular como evidencia de articulación interdisciplinar y de mejora institucional.",
        ],
        "explanation": "La condición de calidad pide lo más defendible cuando sociales pide ensayos argumentativos y no coordina con lenguaje tesis, evidencia y cohesión. Los EBC de ambas áreas refuerzan la argumentación como competencia transversal; la Ley 115 exige articulación curricular, no oficios consecutivos. Acordar una rúbrica compartida, conocida de antemano, deja criterios, evidencias e instancias trazables y mejora las producciones. Calificar el contenido factual y dejar la forma a lenguaje produce datos sin tesis. Corregir la forma al final finge articulación por turnos y mantiene opacos los criterios. La circular de «más ensayos para Saber» es gestión de resultados externos: ordena volumen y no calidad argumentativa.",
        "normativeJustification": "Los EBC de lenguaje y de ciencias sociales convergen en la argumentación con tesis y evidencia. La Ley 115 y el plan de estudios (Decreto 1075) exigen coherencia interdisciplinar. Una circular de coordinación no sustituye la rúbrica compartida previa.",
        "theoreticalJustification": "Un ensayo de sociales es argumento situado, no ficha de datos ni pieza que lenguaje «arregla» después. La rúbrica común enseña el desempeño. La división tardía de oficios y la circular Saber miden cobertura o volumen, no cohesión argumentativa.",
        "distractorAnalysis": {
            "0": "Trampa de la frontera de área: calificar el contenido factual y dejar tesis y cohesión a lenguaje parece respeto de competencias. Produce ensayos de datos sin argumentación, que es el hueco que el caso describe.",
            "2": "Trampa de la corrección tardía: que lenguaje arregle la forma al final y sociales el contenido parece articulación por turnos. Sin rúbrica compartida previa, los criterios siguen opacos para quien escribe el ensayo.",
            "3": "Trampa de dominio cruzado de la circular Saber: ordenar más ensayos desde coordinación parece mejora de resultados externos y queda archivada como gestión. No acuerda con lenguaje tesis, evidencia y cohesión.",
        },
    },
    {
        "id": "dir-apt-lec-01",
        "options": [
            "De la experiencia de El Progreso se desprende que los gestores de convivencia deben asumir, como política permanente de la institución, la resolución de los conflictos del descanso, con lo cual la rectoría quedaría relevada de mediación adulta.",
            "En El Progreso se implementó, con el Consejo Académico, un programa de mediación a cargo de gestores de convivencia que, tras el aumento de conflictos en el descanso, redujo los reportes disciplinarios y exigió ajustar los horarios de capacitación para no interferir con las clases.",
            "El aumento del 30 por ciento de conflictos en el descanso se atribuye a la insuficiencia de docentes en esa franja, de modo que el programa de gestores sería un paliativo y no la medida cuya idea central recoge el relato institucional.",
            "El Consejo Académico, en ejercicio de sus funciones de gobierno escolar, dio por cerrado el programa de gestores de convivencia al no hallar evidencia de impacto, y la rectoría acató ese cierre pese a la disminución posterior de reportes.",
        ],
        "explanation": "La idea central articula el problema, la intervención, el resultado y el ajuste: en El Progreso los conflictos del descanso subieron; el rector, con el Consejo Académico, puso en marcha mediación a cargo de gestores de convivencia; a los tres meses bajaron los reportes disciplinarios; ante el costo de tiempo extra señalado por algunos docentes, se mantuvo el programa y se ajustaron los horarios de capacitación para no interferir con las clases. Convertir a los gestores en política permanente que releva a la rectoría sobrelee el texto. Atribuir el 30 por ciento a falta de docentes inventa una causa no dicha. Afirmar que el Consejo Académico cerró el programa contradice el relato y proyecta competencias de gobierno escolar que el texto no sostiene.",
        "normativeJustification": "El ítem evalúa la idea central del relato institucional, no la aplicación autónoma de la Ley 1620 ni del Decreto 1860. Lo que el texto afirma es implementación concertada, descenso de reportes y ajuste de horarios; no el cierre del programa ni una causa de planta docente.",
        "theoreticalJustification": "La idea central sintetiza problema, medida, efecto y condición de sostenibilidad. Un detalle (el 30 por ciento, la queja de tiempo) no agota esa síntesis. Una causa no enunciada y un cierre normativo del Consejo Académico son inferencias ilegítimas.",
        "distractorAnalysis": {
            "0": "Trampa de la sobrelectura: convertir a los gestores en política permanente de resolución de conflictos del descanso parece conclusión de gestión. El texto describe un programa ajustado, no una delegación que releve a la rectoría de mediación.",
            "2": "Trampa de la causa no dicha: atribuir el aumento del 30 por ciento a falta de docentes en el descanso parece diagnóstico de planta. El relato no establece esa causalidad; describe el programa, los reportes y el ajuste de horarios.",
            "3": "Trampa de dominio cruzado del gobierno escolar: afirmar que el Consejo Académico cerró el programa por falta de evidencia parece lectura del Decreto 1860. Contradice el texto: el Consejo participó en la implementación y los reportes disminuyeron.",
        },
    },
    {
        "id": "dir-apt-lec-02",
        "options": [
            "La rectoría conservó el programa de gestores de convivencia en los mismos términos, sin modificar los horarios de capacitación, para no ceder ante la observación docente sobre el tiempo adicional fuera de la jornada.",
            "La rectoría suspendió el programa de mediación estudiantil a fin de restablecer la jornada lectiva de los docentes que advirtieron la exigencia de tiempo extra, y así evitar interferencia con las clases de El Progreso.",
            "La rectoría reconoció la dificultad de tiempo señalada por algunos docentes y ajustó los horarios de capacitación de los gestores de convivencia, sin abandonar el programa de mediación ni su efecto sobre los reportes del descanso.",
            "La rectoría trasladó al Consejo Académico la decisión sobre mantener o no el programa, por considerarlo la instancia del gobierno escolar competente para resolver la queja relativa al tiempo fuera de la jornada.",
        ],
        "explanation": "Lo que se infiere sobre la actitud del rector frente a las críticas docentes es una mediación: reconoció el costo de tiempo fuera de la jornada y ajustó los horarios de capacitación, sin desmontar a los gestores de convivencia ni desconocer la baja de reportes disciplinarios. Conservar el programa idéntico, sin tocar horarios, niega el ajuste que el texto afirma y presenta una firmeza que el relato no describe. Suspender la mediación para devolver la jornada lectiva invierte la decisión de mantenerla. Trasladar la competencia al Consejo Académico introduce una regla de gobierno escolar que el texto no sostiene: esa instancia participó en la implementación inicial, no absorbió la determinación posterior del rector.",
        "normativeJustification": "La inferencia debe anclarse en lo dicho: el rector mantuvo el programa y ajustó la capacitación para no interferir con las clases. El Decreto 1860 describe funciones del Consejo Académico; ese saber externo no autoriza a afirmar un traslado de la decisión que el relato no narra.",
        "theoreticalJustification": "Inferir actitud exige leer la respuesta a la crítica (ajuste) y el objeto conservado (el programa). La inacción, la suspensión y la delegación al Consejo Académico son lecturas que o contradicen el texto o le añaden una competencia no enunciada.",
        "distractorAnalysis": {
            "0": "Trampa de la inacción: conservar el programa idéntico, sin tocar horarios, parece firmeza directiva ante la queja. Niega el ajuste de capacitación que el texto atribuye de forma expresa al rector de El Progreso.",
            "1": "Trampa de la suspensión restauradora: cancelar la mediación para devolver la jornada lectiva parece cuidar al equipo docente y las clases. Invierte la decisión narrada: se mantuvo el programa y se reorganizó el tiempo de capacitación.",
            "3": "Trampa de dominio cruzado de competencia: trasladar la decisión al Consejo Académico parece apego al gobierno escolar. El texto no dice que el rector se desprendiera de la determinación; dice que ajustó horarios y mantuvo la estrategia.",
        },
    },
]


def da_keys(ci: int) -> list[str]:
    return [str(n) for n in range(4) if n != ci]


def validate(items: list) -> list[str]:
    errors: list[str] = []
    ids_ok = list(CI.keys())
    if [it["id"] for it in items] != ids_ok:
        errors.append(f"ID ORDER {[it['id'] for it in items]}")
    src = json.loads(INP.read_text(encoding="utf-8"))
    if [s["id"] for s in src] != ids_ok:
        errors.append("INPUT ID MISMATCH")
    for src_it, it in zip(src, items):
        tag = it["id"]
        extra = sorted(set(it.keys()) - KEYS_OK)
        missing = sorted(KEYS_OK - set(it.keys()))
        if extra:
            errors.append(f"EXTRA KEYS {tag} {extra}")
        if missing:
            errors.append(f"MISSING KEY {tag} {missing}")
        if it.get("id") != src_it["id"]:
            errors.append(f"ID MISMATCH {tag}")
        ci = CI[tag]
        if src_it["correctIndex"] != ci:
            errors.append(f"CI MAP {tag} src={src_it['correctIndex']} map={ci}")
        opts = it["options"]
        if not isinstance(opts, list) or len(opts) != 4:
            errors.append(f"OPTIONS LEN {tag}")
            continue
        lengths = [len(o) for o in opts]
        skew = max(lengths) - min(lengths)
        if skew >= 180:
            errors.append(f"LEN SKEW {tag} {lengths} skew={skew}")
        for oi, opt in enumerate(opts):
            n = len(opt)
            if n < 80:
                errors.append(f"SHORT OPTION {tag} idx {oi} {n}")
            if n > 340:
                errors.append(f"LONG OPTION {tag} idx {oi} {n}")
            if oi != ci:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                low = opt.lower()
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
        da = it["distractorAnalysis"]
        expected = da_keys(ci)
        if sorted(da.keys()) != expected:
            errors.append(f"DA KEYS {tag} {sorted(da.keys())} expected {expected} ci={ci}")
        else:
            for k, v in da.items():
                if not isinstance(v, str) or len(v) < 80:
                    errors.append(f"SHORT DA {tag} {k} {len(v) if isinstance(v, str) else None}")
                if not str(v).startswith("Trampa de"):
                    errors.append(f"DA PREFIX {tag} {k}")
        if len(it.get("explanation") or "") < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(it.get('explanation') or '')}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")
        # explicación 743 usa «por sí sola» — no está en opciones incorrectas; OK
    return errors


def main() -> int:
    errors = validate(ITEMS)
    print("=== longitudes opciones ===")
    for it in ITEMS:
        lens = [len(o) for o in it["options"]]
        print(
            it["id"],
            "ci",
            CI[it["id"]],
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "DA",
            sorted(it["distractorAnalysis"].keys()),
        )
    if errors:
        print("=== ERRORES ===")
        for e in errors:
            print(e)
        print("errors", len(errors))
        return 1
    OUT.write_text(
        json.dumps(ITEMS, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    loaded = json.loads(OUT.read_text(encoding="utf-8"))
    errors2 = validate(loaded)
    if errors2:
        print("=== ERRORES POST-DUMP ===")
        for e in errors2:
            print(e)
        return 1
    print("WROTE", OUT)
    print("items", len(loaded))
    print("validation OK")
    print("errors", 0)
    return 0


if __name__ == "__main__":
    sys.exit(main())
