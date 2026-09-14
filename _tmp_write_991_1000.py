# -*- coding: utf-8 -*-
"""Reescribe dir-apt-blan-243..252 (posiciones 991-1000)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_991_1000.json"
CI = {
    "dir-apt-blan-243": 2,
    "dir-apt-blan-244": 3,
    "dir-apt-blan-245": 0,
    "dir-apt-blan-246": 1,
    "dir-apt-blan-247": 2,
    "dir-apt-blan-248": 3,
    "dir-apt-blan-249": 0,
    "dir-apt-blan-250": 1,
    "dir-apt-blan-251": 2,
    "dir-apt-blan-252": 3,
}

ITEMS = [
    {
        "id": "dir-apt-blan-243",
        "options": [
            "Entregar al padre el SIEE y la rúbrica del trabajo escrito por correo, manteniendo la nota, para acreditar transparencia documental sin sentarse a revisar el texto con él en la IE.",
            "Ajustar al alza la calificación del trabajo escrito en la misma reunión, para preservar la alianza con la familia que cuestionó con respeto y evitar que el reclamo escale a coordinación.",
            "Explicar con claridad los criterios usados en el trabajo escrito y, si hace falta, revisar el producto junto con el padre de forma objetiva, sin alterar la nota por presión ni cerrar el diálogo.",
            "Trasladar el reclamo respetuoso al Consejo Directivo como queja formal de evaluación, para que el gobierno escolar zanje la nota del trabajo escrito y el docente quede cubierto institucionalmente.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un padre cuestiona con respeto la nota de un trabajo escrito. Explicar criterios y revisar el producto con objetividad sostiene el SIEE y la confianza. Enviar la rúbrica por correo sin revisar juntos es transparencia de papel. Subir la nota para no tensionar la alianza cede el criterio. Pasar el caso al Consejo Directivo confunde gobierno escolar con la revisión técnica del docente.",
        "normativeJustification": "El Decreto 1290 y el SIEE obligan a criterios públicos y a atender el reclamo con revisión del desempeño. El Consejo Directivo no sustituye esa revisión; ceder la nota por clima tampoco.",
        "theoreticalJustification": "Un reclamo respetuoso se resuelve con criterios y evidencia del trabajo. El PDF del SIEE, el alza por alianza o el traslado al gobierno escolar miden imagen, clima o instancia, no la ética evaluativa.",
        "distractorAnalysis": {
            "0": "Trampa de la transparencia documental: enviar el SIEE y la rúbrica parece cumplimiento evaluativo. Evita revisar el trabajo escrito con el padre y convierte el reclamo respetuoso en un trámite de archivo.",
            "1": "Trampa de la alianza familiar: subir la nota en la misma reunión parece cuidado del clima. Sacrifica la objetividad de los criterios y enseña que el reclamo respetuoso se resuelve con un alza.",
            "3": "Trampa de dominio cruzado del gobierno escolar: llevar el reclamo al Consejo Directivo luce como canal institucional impecable. El stem pide la conducta del docente ante la nota, no que otra instancia vote el trabajo escrito.",
        },
    },
    {
        "id": "dir-apt-blan-244",
        "options": [
            "Suspender el examen del grupo y reprogramarlo otro día con un instrumento nuevo, para no dejar en desventaja a quienes no copiaron y restaurar equidad visible en la sesión.",
            "Anular de inmediato el examen del estudiante que copiaba, consignar la nota mínima en el SIEE y continuar con el resto, para proteger la integridad de la prueba en el acto.",
            "Señalar en voz alta el material irregular y usarlo como ejemplo formativo ante el grupo, de modo que la copia quede registrada como falta de honestidad académica en el momento.",
            "Retirar con discreción el material irregular, permitir que el grupo termine y formalizar después el caso según el manual de convivencia, con reserva y debido proceso.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente al sorprender a un estudiante copiando en el examen. Retirar el material con discreción y formalizar después respeta al grupo, al implicado y el debido proceso. Reprogramar todo el examen sacrifica la evidencia de quienes sí trabajaron. Anular y poner la nota mínima en el acto salta el manual. El llamado en voz alta expone y mezcla 1620 con escarnio.",
        "normativeJustification": "El manual y la Ley 1620 exigen reserva, proporcionalidad y debido proceso. El SIEE no autoriza la nota mínima express ni la reprogramación colectiva como primer gesto; el ejemplo público vulnera confidencialidad.",
        "theoreticalJustification": "La copia se interrumpe sin espectáculo y se tramita después. Reprogramar al grupo, anular con nota mínima o ejemplarizar en voz alta miden equidad visible, SIEE o escarmiento, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la equidad visible: suspender y reprogramar el examen del grupo parece no perjudicar a quienes no copiaron. Anula la evidencia de la sesión y desborda la medida respecto de un caso individual.",
            "1": "Trampa de la nota mínima en el acto: anular y calificar de inmediato parece integridad del SIEE. Impone la sanción sin el procedimiento del manual y confunde interrupción de la copia con fallo evaluativo express.",
            "2": "Trampa de dominio cruzado de la Ley 1620: señalar el material en voz alta como ejemplo formativo luce como honestidad académica. Expone al estudiante y vulnera la reserva que el caso exige en ese momento.",
        },
    },
    {
        "id": "dir-apt-blan-245",
        "options": [
            "Intervenir de inmediato para detener el acoso presenciado, proteger a quien lo recibe y, enseguida, reportar y activar la ruta institucional de atención, con reserva y registro.",
            "Separar a los dos estudiantes y mediarlo como desacuerdo entre pares, sin abrir aún la ruta, para no etiquetar como acoso un conflicto que podría resolverse con diálogo de aula.",
            "Consignar lo presenciado como nota de convivencia en el observador y el SIEE, para que el acoso quede como evidencia comparable de período mientras se termina la clase.",
            "Terminar primero el bloque de clase para no perder el hilo y reportar el acoso al cierre, cuando haya más calma y el grupo no quede sin la explicación prevista.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando el docente presencia acoso entre dos estudiantes. Detenerlo de inmediato, proteger y activar la ruta es el deber de cuidado. Mediarlo como conflicto entre pares minimiza el acoso. Pasarlo al SIEE como nota de convivencia cambia el objeto. Esperar al cierre de la clase privilegia el hilo didáctico sobre la protección.",
        "normativeJustification": "La Ley 1620 y el Decreto 1965 obligan a interrumpir, reportar y activar la ruta ante acoso presenciado. La mediación de pares, la nota del SIEE y el aplazamiento al cierre no cumplen esa ruta.",
        "theoreticalJustification": "El acoso presenciado no es un desacuerdo negociable. La interrupción y la ruta protegen. La mediación, la nota de período o esperar el cierre miden 1620 mal leído, SIEE o tiempo de clase, no la ética pedida.",
        "distractorAnalysis": {
            "1": "Trampa del conflicto entre pares: separar y mediar parece pedagogía de convivencia. Rebaja el acoso presenciado a un desacuerdo y retrasa la ruta de atención que el caso exige de inmediato.",
            "2": "Trampa de dominio cruzado del SIEE: anotar convivencia como evidencia de período luce como registro institucional. El acoso se atiende por la ruta 1620, no como nota comparable mientras sigue la clase.",
            "3": "Trampa de proteger el hilo de clase: reportar al cierre parece prudencia de clima. Deja el acoso activo durante el bloque y pospone la protección de quien lo está recibiendo.",
        },
    },
    {
        "id": "dir-apt-blan-246",
        "options": [
            "Mantener las mismas actividades y los mismos tiempos que el resto del grupo, en nombre de la equidad del SIEE, para que el atraso no se lea como un privilegio de ajuste frente a sus compañeros.",
            "Comunicar el atraso creciente al equipo de apoyo pedagógico y explorar ajustes razonables en las actividades del estudiante, con seguimiento, sin bajar las metas del curso ni decidir repetición de antemano.",
            "Rebajar las exigencias académicas de todo el grupo para acercar el ritmo al estudiante que se atrasa, de modo que nadie quede visiblemente desfasado en las evidencias del período.",
            "Llevar el caso al comité de evaluación con recomendación de no promoción al cierre, argumentando que el desfase ya es estructural y conviene decidir pronto la trayectoria del estudiante.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante con dificultades de aprendizaje se atrasa respecto del grupo. Activar apoyo y explorar ajustes razonables es el marco 1421 y DUA. Igualar actividades y tiempos en nombre del SIEE niega el ajuste. Bajar las metas de todos confunde inclusión con nivelación a la baja. Recomendar no promoción sin proceso de apoyo adelanta una decisión de trayectoria.",
        "normativeJustification": "El Decreto 1421 y los ajustes razonables exigen coordinación con apoyo pedagógico antes de decisiones de promoción. El SIEE no impide ajustar; rebajar al grupo o adelantar la no promoción vulnera ese proceso.",
        "theoreticalJustification": "El atraso por dificultad de aprendizaje pide mediación y ajuste, no homogeneidad. La equidad sin ajuste, la bajada colectiva o la no promoción temprana miden SIEE, clima o trayectoria, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la equidad homogénea: mismas actividades y tiempos parecen rigor del SIEE. Niegan el ajuste razonable y dejan que el atraso crezca como si el privilegio fuera el apoyo.",
            "2": "Trampa de nivelar a la baja: rebajar al grupo entero parece inclusión. Cambia las metas de quienes no requieren ese recorte y no atiende la dificultad específica del estudiante.",
            "3": "Trampa de dominio cruzado de la promoción: recomendar no promoción en el comité parece decisión institucional oportuna. Adelanta la trayectoria sin el proceso de apoyo y ajuste que el caso pide primero.",
        },
    },
    {
        "id": "dir-apt-blan-247",
        "options": [
            "Asignar por decreto docente quién hace cada parte del trabajo en grupo, para cortar el desacuerdo de raíz y no perder más tiempo de la clase en la discusión de los dos estudiantes.",
            "Disolver la pareja, pasar a productos individuales y calificar por separado en el SIEE, de modo que el conflicto por las tareas no contamine la evidencia comparable del período.",
            "Mediar el desacuerdo ayudándolos a verbalizar lo que cada uno necesita y a pactar una distribución de tareas que ambos consideren justa, con criterio visible de corresponsabilidad.",
            "Abrir un llamado de convivencia por dificultad para el trabajo en equipo, con registro en coordinación, para que el manual cubra el conflicto como falta al pacto de aula.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando dos estudiantes discuten cómo dividir las tareas de un trabajo en grupo. Mediar la comunicación y un pacto justo tiene valor formativo. Asignar por decreto ahorra tiempo y les quita la corresponsabilidad. Disolver y calificar por separado usa el SIEE para evadir el conflicto. Abrir convivencia convierte un desacuerdo de tarea en falta al manual.",
        "normativeJustification": "El trabajo colaborativo y la Ley 1620 piden mediación pedagógica de desacuerdos menores. El SIEE no exige producto individual para zanjear un reparto; el manual no es la primera instancia de un conflicto de tareas.",
        "theoreticalJustification": "El desacuerdo sobre el reparto es contenido de aprendizaje social. La mediación lo aprovecha. El decreto, la nota individual o el llamado de convivencia miden tiempo, SIEE o 1620, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa del decreto eficiente: asignar las partes parece liderazgo de aula y salva minutos. Impide que los dos estudiantes aprendan a negociar el reparto que originó el conflicto.",
            "1": "Trampa de la evidencia individual: disolver la pareja y calificar por separado parece proteger el SIEE. Evade el conflicto de tareas y pierde el objeto colaborativo del trabajo en grupo.",
            "3": "Trampa de dominio cruzado de la Ley 1620: abrir convivencia por el trabajo en equipo luce como canal institucional. El caso es un desacuerdo de reparto, no una falta que deba entrar de entrada al manual.",
        },
    },
    {
        "id": "dir-apt-blan-248",
        "options": [
            "Exigir al menos una intervención oral calificable por sesión, como evidencia comparable de participación en el SIEE, para que la timidez no deje sin nota un desempeño que en lo escrito ya es sólido.",
            "Dejar la participación voluntaria como está y valorar de forma permanente el canal escrito, argumentando respeto por el estilo del estudiante tímido y por sus buenos trabajos.",
            "Registrar la ausencia de voz en clase como posible necesidad educativa y derivar a apoyo, para que un PIAR cubra la timidez y el grupo no espere oralidad de quien no la ofrece.",
            "Ofrecer primero participaciones de menor exposición, en parejas o grupos pequeños, y recién después una intervención ante todo el curso, de modo que la timidez se acompañe sin humillación.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante tímido no participa de forma voluntaria pese a buenos escritos. Graduar la exposición desde parejas hacia el grupo respeta el ritmo y desarrolla la oralidad. Exigir una oral calificable por sesión usa el SIEE como presión. Congelar el canal escrito abandona la competencia comunicativa. Derivar a PIAR medicaliza la timidez.",
        "normativeJustification": "El DUA pide múltiples formas de participación sin etiquetar. El SIEE no obliga una oral diaria; el Decreto 1421 no convierte la timidez en NEE de entrada.",
        "theoreticalJustification": "La timidez se acompaña con exposición gradual. La nota oral, el respeto estático al escrito o el PIAR miden SIEE, estilo o inclusión mal aplicada, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la oral calificable: una intervención por sesión parece equidad de evidencia. Presiona al estudiante tímido y convierte la participación en nota, no en andamiaje.",
            "1": "Trampa del respeto estático al escrito: dejarlo en lo voluntario parece cuidado. Abandona el desarrollo de la oralidad que el caso pide sin exposición masiva inmediata.",
            "2": "Trampa de dominio cruzado del Decreto 1421: derivar a PIAR por no hablar en clase luce como inclusión. Etiqueta la timidez como necesidad educativa y salta el andamiaje de menor exposición.",
        },
    },
    {
        "id": "dir-apt-blan-249",
        "options": [
            "Explicar con respeto al colega que la nota de la evaluación compartida debe sostenerse en criterios objetivos y no acceder a subirla sin justificación pedagógica, dejando constancia del criterio común.",
            "Acordar un punto intermedio entre la nota original y la que pide el colega, para cuidar el clima del equipo y cerrar el favor sin dejar el SIEE en un extremo.",
            "Subir la nota y dejar en el instrumento una observación de «ajuste de consistencia entre evaluadores», de modo que el SIEE quede alineado y el pedido del colega no quede en un desacuerdo visible.",
            "Consultar al consejo de padres si esa evaluación compartida admite el alza, para transparentar el pedido del colega y no decidir en privado un cambio de nota.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un colega pide subir una nota compartida sin justificación pedagógica. Mantener los criterios y explicar la negativa con respeto protege el SIEE. El punto intermedio negocia la nota como clima de equipo. El «ajuste de consistencia» documenta el favor. Consultar al consejo de padres expone un conflicto profesional a una instancia que no evalúa.",
        "normativeJustification": "El Decreto 1290 ancla la calificación en criterios. El clima de pares, la observación de consistencia y el consejo de padres no habilitan un alza sin fundamento pedagógico.",
        "theoreticalJustification": "La integridad evaluativa no se pacta por cortesía. El promedio entre notas, el ajuste documental o el voto de familias miden clima, SIEE o gobierno, no la ética pedida.",
        "distractorAnalysis": {
            "1": "Trampa del punto intermedio: ceder un alza parcial parece colegialidad. Sigue alterando la nota sin justificación pedagógica y enseña que el pedido del colega se negocia.",
            "2": "Trampa de dominio cruzado del SIEE: el «ajuste de consistencia» parece rigor de evaluadores. Documenta el favor y usa el instrumento para maquillar una nota que no tiene fundamento.",
            "3": "Trampa del consejo de padres: consultar el alza parece transparencia. Traslada un conflicto entre docentes a una instancia familiar que no debe zanjear la evaluación compartida.",
        },
    },
    {
        "id": "dir-apt-blan-250",
        "options": [
            "Nombrar en voz alta a un compañero «padrino» del estudiante nuevo, frente a todo el grupo, para visibilizar el acogimiento de mitad de año y que nadie pueda decir que quedó aislado.",
            "Diseñar actividades de aula que faciliten su integración social y académica con el grupo, sin exponerlo de forma incómoda ni convertirlo en caso público de acogida.",
            "Abrir un seguimiento de convivencia al grupo por exclusión del estudiante que llegó a mitad de año, con llamado a coordinación, para que el manual cubra el aislamiento percibido.",
            "Documentar el aislamiento en el observador y esperar a que el estudiante nuevo tome la iniciativa de integrarse, para no forzar vínculos ni interferir en la dinámica ya armada del curso.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante llega a mitad de año y se percibe aislado. Diseñar integración sin exposición incómoda es acogida pedagógica. El padrino público lo pone en el centro. Abrir convivencia contra el grupo criminaliza un desajuste de ingreso. Esperar y documentar abandona el deber de incluir.",
        "normativeJustification": "La matrícula a mitad de año y el enfoque de derechos piden planeación de acogida. El manual 1620 no es la primera respuesta al aislamiento; el observador pasivo tampoco.",
        "theoreticalJustification": "La inclusión del recién llegado se diseña en la tarea, no en el espectáculo. El padrino público, la convivencia o la espera documentada miden imagen, 1620 o pasividad, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa del padrino público: nombrarlo frente al grupo parece acogida visible. Expone al estudiante nuevo y puede reforzar el aislamiento que se quería resolver.",
            "2": "Trampa de dominio cruzado de la Ley 1620: abrir convivencia al grupo por exclusión luce como protección. Convierte un ingreso a mitad de año en falta colectiva y salta el diseño pedagógico de integración.",
            "3": "Trampa de la espera documentada: anotar y no interferir parece respeto a la dinámica del curso. Deja el aislamiento sin intervención y no es la conducta defendible ante un estudiante nuevo.",
        },
    },
    {
        "id": "dir-apt-blan-251",
        "options": [
            "Corregir el contenido en la clase siguiente sin mencionar el error de hoy, para no debilitar la autoridad frente al mismo grupo y dejar la versión correcta en la próxima explicación.",
            "Enviar a las familias una nota escrita con la versión correcta del tema, para que el error cometido frente al grupo quede subsanado con transparencia hacia el hogar.",
            "Reconocer el error de contenido abiertamente ante el mismo grupo y hacer de inmediato la corrección, modelando que equivocarse y enmendar también es parte de aprender.",
            "Dejar constancia del error en la autoevaluación de desempeño 1278, para que el desliz de contenido quede como evidencia de mejora profesional y no como un tema de aula.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando el docente se da cuenta, frente al mismo grupo, de un error de contenido. Reconocerlo y corregir modela honestidad intelectual. Callarlo hasta la clase siguiente protege la imagen y deja el error circulando. Avisar a las familias desplaza al aula un asunto del grupo. Pasarlo al 1278 convierte un gesto pedagógico en expediente de desempeño.",
        "normativeJustification": "La ética profesional y el derecho a una enseñanza veraz piden corrección oportuna ante quien recibió el error. El 1278 no es el canal de un desliz de contenido; la circular a familias tampoco sustituye la enmienda en clase.",
        "theoreticalJustification": "El error docente, reconocido, enseña criterio científico. El silencio, el aviso a familias o el expediente 1278 miden autoridad, imagen o evaluación de planta, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de proteger la autoridad: corregir mañana sin nombrar el error parece prudencia. Deja al grupo con la versión falsa el resto del día y oculta un desliz que ya ocurrió frente a ellos.",
            "1": "Trampa de la transparencia hacia el hogar: la nota a familias parece honestidad institucional. Saca del aula la corrección y puede amplificar un error que debía enmendarse con el mismo grupo.",
            "3": "Trampa de dominio cruzado del Decreto 1278: registrar el error en la autoevaluación de desempeño luce como mejora profesional. El stem pide qué hacer frente al grupo, no cómo documentar el desliz en la planta.",
        },
    },
    {
        "id": "dir-apt-blan-252",
        "options": [
            "Recoger todos los celulares del curso por el resto del período y guardarlos en coordinación, como medida de choque ante el uso reiterado pese a las indicaciones del inicio.",
            "Incorporar el uso del celular como descriptor de actitud en el SIEE, de modo que cada reiteración baje la nota de período y quede evidencia comparable del incumplimiento.",
            "Autorizar el celular como recurso de competencia digital del PMI, con la condición de reportar actividades en línea, para alinear el uso reiterado con el indicador de TIC de la visita.",
            "Recordar con firmeza los acuerdos del manual de convivencia sobre el celular y aplicar de manera consistente las consecuencias ya previstas, sin improvisar una medida nueva en el acto.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando varios estudiantes reiteran el uso del celular pese a las indicaciones del período. Aplicar con consistencia lo ya pactado en el manual es formativo y previsible. Recoger todos los aparatos por el período es una medida de choque desproporcionada. Bajar la nota de actitud usa el SIEE como sanción. Autorizarlos como TIC del PMI cambia la norma para cuadrar un indicador.",
        "normativeJustification": "El manual de convivencia y el debido proceso piden consecuencias previsibles. El SIEE no es el lugar de la reiteración del celular; el PMI digital no habilita a reescribir el acuerdo del aula.",
        "theoreticalJustification": "La consistencia de la norma enseña más que la improvisación. El decomiso prolongado, la nota de actitud o el recubrimiento TIC miden choque, SIEE o visita de calidad, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la medida de choque: recoger los celulares del período parece restablecer la clase. Es desproporcionada respecto de las consecuencias ya previstas y puede escalar el conflicto con el grupo.",
            "1": "Trampa de la nota de actitud: bajar el SIEE por cada uso parece evidencia comparable. Convierte una falta al manual en calificación y mezcla evaluación del aprendizaje con control del celular.",
            "2": "Trampa de dominio cruzado del PMI digital: autorizar el celular como competencia TIC luce alineado con la visita de calidad. Reescribe el acuerdo del período para cuadrar un indicador y no aplica la norma ya dada.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI, {}))
