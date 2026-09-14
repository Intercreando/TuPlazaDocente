# -*- coding: utf-8 -*-
"""Reescribe dir-apt-lec-213..220 y dir-apt-num-221..222 (posiciones 961-970)."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_961_970.json"

FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)
OBVIOUS = (
    "ignorar",
    "sin planear",
    "aunque rompa",
    "aunque se presente como",
    "aunque se presente",
    "aunque ahorre",
    "aunque parezca",
    "actividad recreativa",
    "eliminar toda evidencia",
    "para que se note liderazgo",
    "castigo del rincón",
    "acta genérica",
    "delegar el conflicto a familias",
    "familias o chats",
)
TEMPLATE = (
    "aplaazar la decisión con un acta genérica",
    "imponer una salida visible",
    "delegar el conflicto a familias o chats",
    "adelantar contenidos de grados superiores",
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
    "dir-apt-lec-213": 0,
    "dir-apt-lec-214": 1,
    "dir-apt-lec-215": 2,
    "dir-apt-lec-216": 3,
    "dir-apt-lec-217": 0,
    "dir-apt-lec-218": 1,
    "dir-apt-lec-219": 2,
    "dir-apt-lec-220": 3,
    "dir-apt-num-221": 0,
    "dir-apt-num-222": 1,
}
NUM_IDS = {"dir-apt-num-221", "dir-apt-num-222"}
NEEDLE = {
    "dir-apt-num-221": "8",
    "dir-apt-num-222": "2h 20min",
}

ITEMS = [
    {
        "id": "dir-apt-lec-213",
        "options": [
            "Integrar la dimensión ambiental en la práctica cotidiana del aula, con la salida al patio, el consumo de recursos y un problema ambiental local, contribuye a que los estudiantes la perciban como parte de la vida diaria y no como un tema de fechas del calendario.",
            "La educación ambiental se agota en el proyecto ambiental institucional, de modo que la salida al patio, el análisis del consumo de recursos y el problema local no complementan el PRAE ni cambian la percepción cotidiana de los estudiantes.",
            "El consumo de recursos dentro del aula y la observación del entorno en el patio no se relacionan con la educación ambiental, porque esa dimensión queda fuera de la asignatura y de la vida diaria del curso.",
            "Limitar la educación ambiental a las fechas específicas del calendario del PRAE o al indicador ambiental del PMI, de modo que el tablero de calidad acredite jornadas puntuales y no la práctica cotidiana del aula.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que integrar la dimensión ambiental en la práctica cotidiana del aula contribuye a que los estudiantes la perciban como parte de la vida diaria, y que esa integración no sustituye la planeación institucional. Agotar la educación ambiental en el proyecto ambiental institucional contradice ese complemento cotidiano. Negar el consumo de recursos en el aula invierte un ejemplo explícito del patio y del problema local. Limitarla a fechas del calendario o al indicador del PMI importa un reporte de calidad que el texto contrapone a la vida diaria.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre educación ambiental cotidiana. Lo afirmado es el complemento al PRAE en el aula, el patio y el problema local, no el agotamiento en el proyecto institucional ni el indicador de fechas del PMI.",
        "theoreticalJustification": "La idea principal sintetiza la integración cotidiana y su efecto en la vida diaria. Un ejemplo negado, el PRAE como techo y el calendario de calidad son inferencias ilegítimas frente al pasaje.",
        "distractorAnalysis": {
            "1": "Trampa de agotar la educación ambiental en el PRAE: el texto afirma que la integración cotidiana no sustituye la planeación institucional, pero sí la complementa. Reducir todo al proyecto ambiental niega el patio, el consumo de recursos y el problema local.",
            "2": "Trampa de negar el ejemplo del consumo: el pasaje cita el análisis del consumo de recursos dentro del aula y la salida al patio como formas cotidianas. Afirmar que no se relacionan con la educación ambiental invierte esos ejemplos.",
            "3": "Trampa de dominio cruzado del calendario y el PMI: limitar la educación ambiental a fechas del PRAE o al indicador de calidad es un reporte plausible de gestión. El texto contrapone esas fechas específicas a la práctica cotidiana del aula.",
        },
    },
    {
        "id": "dir-apt-lec-214",
        "options": [
            "La integración cotidiana se reduce a la lectura de un libro sobre el tema una vez al año, sin salida al patio, sin análisis del consumo de recursos y sin vincular un problema ambiental local a los contenidos de la asignatura.",
            "Observar el entorno natural en una salida al patio, analizar el consumo de recursos dentro del aula y vincular un problema ambiental local con los contenidos de la asignatura, como formas cotidianas que no sustituyen el PRAE.",
            "Reemplazar el currículo de ciencias naturales por la dimensión ambiental cotidiana, de modo que el patio, el consumo de recursos y el problema local ocupen el lugar de la malla de ciencias en el plan de estudios.",
            "Suspender las clases para un día exclusivo del PRAE o del Día E ambiental, de modo que el calendario de calidad acredite la dimensión ambiental sin la práctica cotidiana del patio y del aula.",
        ],
        "explanation": "La condición de calidad pregunta qué ejemplos se mencionan de integración ambiental en la práctica docente cotidiana. El texto enumera la salida al patio para observar el entorno natural, el análisis del consumo de recursos dentro del aula y la vinculación de un problema ambiental local con los contenidos. La lectura de un libro una vez al año no aparece. Reemplazar el currículo de ciencias naturales sobregeneraliza esos ejemplos. Suspender clases para un día del PRAE o del calendario de calidad desplaza la cotidianidad que el stem pide.",
        "normativeJustification": "El ítem pide los ejemplos que el texto enumera: patio, consumo de recursos y problema local articulado a la asignatura. No autoriza un libro anual, el recambio de ciencias ni una jornada exclusiva del PRAE.",
        "theoreticalJustification": "Los ejemplos se leen en la enumeración del pasaje. Un detalle no dicho, una sobregeneralización curricular y un indicador de calendario cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa del libro anual como ejemplo: reducir la integración cotidiana a una lectura una vez al año parece una actividad ambiental ordenada. El texto no la menciona; cita patio, consumo de recursos y problema local con los contenidos.",
            "2": "Trampa de reemplazar ciencias naturales: ocupar la malla de ciencias con el patio y el problema local parece profundizar la dimensión ambiental. El pasaje habla de integración cotidiana, no de sustituir el currículo de la asignatura.",
            "3": "Trampa de dominio cruzado del Día E y el PRAE: suspender clases para un día exclusivo es un acto plausible de calendario de calidad. El texto habla de práctica cotidiana en el patio y el aula, no de una jornada puntual.",
        },
    },
    {
        "id": "dir-apt-lec-215",
        "options": [
            "La motivación hacia la asignatura se agota en el interés personal de cada estudiante por el tema, de modo que el clima de aula, la participación y el temor a la burla no alteran ese interés inicial del grupo.",
            "El clima de aula no influye en la motivación: sentirse seguro para participar, equivocarse y preguntar sin temor a la burla no se asocia con mayores niveles de motivación en el grupo.",
            "Un clima de aula seguro, donde se puede participar, equivocarse y preguntar sin temor a la burla, favorece la motivación, incluso en asignaturas que inicialmente generaban poco interés en el grupo.",
            "La motivación es un rasgo del estudiante que el docente no puede influir y se reporta en la evaluación de desempeño del Decreto 1278, de modo que el clima de aula queda fuera del acta de calidad.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje afirma que la motivación no se agota en el interés personal, sino que un clima seguro para participar, equivocarse y preguntar sin temor a la burla favorece la motivación. Negar la influencia del clima invierte esa tesis. Reportar la motivación como rasgo inamovible del Decreto 1278 importa un saber de desempeño que el texto no sostiene. La idea central es el clima de aula como factor de motivación, incluso en asignaturas de poco interés inicial.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre clima y motivación. Lo afirmado es el ambiente seguro de participación y error; no el agotamiento en el interés personal ni un rasgo de carrera del 1278.",
        "theoreticalJustification": "La idea principal articula clima, seguridad para equivocarse y motivación. Invertir la influencia del clima o importar el estatuto docente desplaza el objeto del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de agotar la motivación en el interés personal: tratar el gusto por el tema como techo parece un diagnóstico de aula. El texto lo niega y sitúa el clima seguro, la participación y el error sin burla como factores que favorecen la motivación.",
            "1": "Trampa de negar el clima: afirmar que participar, equivocarse y preguntar sin burla no influyen parece separar afecto y aprendizaje. El pasaje asocia ese ambiente con mayores niveles de motivación en el grupo.",
            "3": "Trampa de dominio cruzado del Decreto 1278: reportar la motivación como rasgo inamovible en desempeño es un saber de carrera docente. El texto no lo afirma; describe un clima de aula que el docente construye y que favorece la motivación.",
        },
    },
    {
        "id": "dir-apt-lec-216",
        "options": [
            "El efecto del clima seguro sobre la motivación se observa en las asignaturas que ya generaban mucho interés previo en el grupo, y no en aquellas que inicialmente despertaban poco interés.",
            "El efecto del clima de aula sobre la motivación se restringe a las asignaturas relacionadas con el arte, porque la participación y el error sin burla serían propios de ese campo y no del resto del plan.",
            "El efecto se observa en educación física, como indicador de convivencia del manual y de la Ley 1620, de modo que el clima seguro se reporta en el Comité y no en las asignaturas del plan de estudios.",
            "El efecto de un clima seguro, donde se participa y se yerra sin temor a la burla, puede observarse incluso en asignaturas que inicialmente generaban poco interés en el grupo.",
        ],
        "explanation": "La condición de calidad pregunta en qué tipo de asignaturas puede observarse el efecto de un buen clima de aula sobre la motivación. El texto lo sitúa incluso en asignaturas que inicialmente generaban poco interés en el grupo. Restringirlo a las que ya generaban mucho interés invierte ese alcance. Limitarlo al arte inventa un campo que el pasaje no nombra. Reportarlo en educación física como indicador de convivencia de la Ley 1620 es un saber de manual ajeno al texto.",
        "normativeJustification": "El ítem pide el alcance que el texto enuncia: incluso asignaturas de poco interés inicial. No autoriza el recorte a las de alto interés, al arte ni al indicador de convivencia de la 1620.",
        "theoreticalJustification": "El efecto se lee en la última oración del pasaje. Invertir el alcance, restringirlo a un área o importar el manual de convivencia cambia el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de invertir el alcance: situar el efecto en las asignaturas que ya generaban mucho interés parece coherencia con el gusto previo. El texto dice lo contrario: el clima seguro se asocia con motivación incluso donde el interés inicial era bajo.",
            "1": "Trampa de restringir al arte: reservar participación y error sin burla a las asignaturas artísticas parece un criterio de área. El pasaje no nombra el arte; habla de asignaturas de poco interés inicial en el grupo.",
            "2": "Trampa de dominio cruzado de la Ley 1620: reportar el clima en educación física como indicador de convivencia del manual es un saber de Comité plausible. El texto no sitúa el efecto en esa asignatura ni en el reporte de convivencia.",
        },
    },
    {
        "id": "dir-apt-lec-217",
        "options": [
            "La evaluación formativa puede aplicarse mediante estrategias sencillas, siempre que la información recogida se use para ajustar la enseñanza de la siguiente clase, y no por la sofisticación del instrumento.",
            "La evaluación formativa en el día a día requiere instrumentos elaborados y sofisticados, de modo que una pregunta abierta, la observación del trabajo o explicar lo aprendido no bastan para ajustar la siguiente clase.",
            "Observar el trabajo de los estudiantes mientras resuelven un ejercicio no aporta información útil al docente, porque esa mirada cotidiana no sirve para ajustar la siguiente clase ni para la formativa.",
            "La evaluación formativa no se relaciona con la planeación de la siguiente clase: su fin es el boletín comparable del SIEE, de modo que la información recogida se destina a la nota y no al ajuste de la enseñanza.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que la evaluación formativa puede aplicarse con estrategias sencillas, siempre que la información recogida se use para ajustar la enseñanza de la siguiente clase. Exigir instrumentos elaborados contradice esa tesis. Negar utilidad a observar el trabajo invierte un ejemplo. Destinar la formativa al boletín del SIEE importa un fin de calificación que el texto no afirma.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre formativa cotidiana. Lo esencial es usar la información para ajustar la siguiente clase, no la sofisticación del instrumento ni el boletín del Decreto 1290.",
        "theoreticalJustification": "La formativa se define por el uso pedagógico de la evidencia, no por el aparato del instrumento. Invertir un ejemplo o importar el SIEE como fin de nota cambia el objeto del pasaje.",
        "distractorAnalysis": {
            "1": "Trampa de exigir instrumentos sofisticados: tratar la formativa cotidiana como un diseño elaborado parece rigor evaluativo. El texto niega esa exigencia y cita pregunta abierta, observación del trabajo y explicar lo aprendido.",
            "2": "Trampa de negar la observación: afirmar que mirar el trabajo mientras resuelven un ejercicio no aporta información parece desconfiar de la evidencia informal. El pasaje la cita como estrategia sencilla para ajustar la siguiente clase.",
            "3": "Trampa de dominio cruzado del SIEE: destinar la formativa al boletín comparable es un uso real de calificación. El texto no lo afirma; pide que la información recogida ajuste la enseñanza de la siguiente clase.",
        },
    },
    {
        "id": "dir-apt-lec-218",
        "options": [
            "Las estrategias sencillas de formativa cotidiana se identifican con exámenes escritos estandarizados al cierre, sin pregunta abierta al finalizar la clase, sin observación del trabajo y sin pedir que expliquen lo aprendido.",
            "Una pregunta abierta al finalizar la clase, observar el trabajo de los estudiantes mientras resuelven un ejercicio, y pedirles que expliquen con sus palabras lo aprendido, como estrategias sencillas de formativa cotidiana.",
            "La revisión de cuadernos al final del período, como evidencia sumativa de cierre, sustituye la pregunta abierta, la observación cotidiana y la explicación de lo aprendido para ajustar la siguiente clase.",
            "Las pruebas externas aplicadas por el Ministerio de Educación o el ICFES operan como formativa cotidiana, de modo que el indicador nacional reemplaza la pregunta abierta, la observación y explicar lo aprendido en el aula.",
        ],
        "explanation": "La condición de calidad pregunta qué ejemplos se mencionan de estrategias sencillas de evaluación formativa. El texto cita una pregunta abierta al finalizar la clase, observar el trabajo mientras resuelven un ejercicio y pedir que expliquen con sus palabras lo aprendido. Los exámenes escritos estandarizados no aparecen. La revisión de cuadernos al final del período es un cierre sumativo, no cotidiano. Las pruebas del Ministerio o del ICFES son un indicador externo, no la formativa de aula que el stem pide.",
        "normativeJustification": "El ítem pide los ejemplos que el texto enumera: pregunta abierta, observación del trabajo y explicación de lo aprendido. No autoriza el examen estandarizado, el cuaderno de cierre ni las pruebas externas del MEN.",
        "theoreticalJustification": "Los ejemplos se leen en la enumeración cotidiana del pasaje. Un instrumento de cierre, un momento sumativo y un indicador nacional cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa del examen estandarizado: identificar la formativa cotidiana con pruebas escritas de cierre parece evidencia comparable. El texto no las menciona; cita pregunta abierta, observación del trabajo y explicar lo aprendido.",
            "2": "Trampa del cuaderno de período: la revisión al cierre parece un seguimiento ordenado de evidencias. Es un momento sumativo; el pasaje sitúa las estrategias sencillas en el día a día para ajustar la siguiente clase.",
            "3": "Trampa de dominio cruzado del ICFES y el MEN: tratar las pruebas externas como formativa cotidiana es un saber de calidad nacional. El texto no las cita; habla de pregunta abierta, observación y explicación en el aula.",
        },
    },
    {
        "id": "dir-apt-lec-219",
        "options": [
            "La biblioteca o rincón de lectura del aula reemplaza la biblioteca escolar central, de modo que la colección pequeña del salón hace innecesaria la biblioteca institucional y agota el hábito autónomo en ese rincón.",
            "Organizar el rincón de lectura con una lista cerrada de títulos asignados por el docente, de modo que la cercanía a los libros no se combine con la elección libre en momentos específicos del día.",
            "La cercanía física a los libros y la libre elección de lectura, con participación activa del docente que recomienda títulos y conversa, favorecen el hábito de lectura autónoma, además de la biblioteca escolar central.",
            "La biblioteca de aula se reporta como indicador de volúmenes del PMI o del inventario de calidad, y no se relaciona con el hábito de lectura autónoma ni con la elección libre o la conversación sobre títulos.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje afirma que la cercanía a los libros y la libre elección, con participación activa del docente, favorecen el hábito de lectura autónoma, además de la biblioteca escolar central. Tratar el rincón como reemplazo de la biblioteca central contradice ese complemento. Impedir la elección libre niega un factor que el texto valora. Reportar volúmenes en el PMI importa un indicador de inventario que el pasaje no usa como idea central.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre biblioteca de aula. Lo afirmado es cercanía, elección libre y docente activo, además de la biblioteca central; no el recambio institucional ni el inventario del PMI.",
        "theoreticalJustification": "La idea principal articula acceso, elección y mediación docente. Sustituir la biblioteca central, cerrar la lista de títulos o importar el tablero de volúmenes desplaza el objeto del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de reemplazar la biblioteca central: tratar el rincón de aula como sucesor de la biblioteca escolar parece eficiencia de colección. El texto lo presenta además de la biblioteca central, no en su lugar.",
            "1": "Trampa de la lista cerrada: asignar títulos desde el rincón parece mediación docente ordenada. El pasaje valora la elección libre en momentos específicos del día, sumada a la cercanía física con los libros.",
            "3": "Trampa de dominio cruzado del PMI y el inventario: reportar la biblioteca de aula como indicador de volúmenes es un saber de calidad plausible. El texto no la define por el tablero; la asocia al hábito autónomo, la elección y la conversación.",
        },
    },
    {
        "id": "dir-apt-lec-220",
        "options": [
            "Conservar una distancia respecto de las elecciones del rincón de aula, sin recomendar títulos ni conversar sobre lo leído, para no interferir con el hábito autónomo de los estudiantes.",
            "Asignar los mismos títulos de la biblioteca de aula a todo el curso, en clave de equidad de evidencias, de modo que la elección libre en momentos específicos del día quede sustituida por una lista común.",
            "Retirar la conversación sobre los libros y dejar evidencia escrita comparable de lectura para el SIEE, de modo que el rincón se reporta como nota de proceso y no como diálogo sobre títulos.",
            "El docente participa activamente recomendando títulos de la biblioteca de aula y conversando con los estudiantes sobre lo que están leyendo, para potenciar el hábito autónomo junto a la elección libre.",
        ],
        "explanation": "La condición de calidad pregunta qué rol cumple el docente para potenciar el efecto de la biblioteca de aula. El texto señala participación activa: recomendar títulos y conversar con los estudiantes sobre lo que están leyendo. Mantenerse al margen niega esa participación. Imponer los mismos libros a todo el curso contradice la elección libre. Dejar evidencia comparable para el SIEE importa un cierre de calificación que el pasaje no pide.",
        "normativeJustification": "El ítem pide el rol que el texto asigna al docente en el rincón de lectura: recomendar títulos y conversar. No autoriza el retiro de la mediación, la lista única ni la evidencia comparable del Decreto 1290.",
        "theoreticalJustification": "El hábito autónomo, en este pasaje, se potencia con mediación y diálogo, no con ausencia del docente, homogeneidad de títulos ni nota de proceso.",
        "distractorAnalysis": {
            "0": "Trampa de la no interferencia: alejarse de las elecciones del rincón parece respetar la autonomía lectora. El texto pide lo contrario: participación activa recomendando títulos y conversando sobre lo que están leyendo.",
            "1": "Trampa de la lista común: asignar los mismos libros a todo el curso parece equidad de evidencias. Contradice la elección libre en momentos específicos del día que el pasaje asocia al hábito autónomo.",
            "2": "Trampa de dominio cruzado del SIEE: retirar la conversación y dejar evidencia escrita comparable es un cierre plausible de proceso. El texto no pide nota de lectura; pide recomendar títulos y conversar sobre lo leído.",
        },
    },
    {
        "id": "dir-apt-num-221",
        "options": [
            "Consignar 8 estudiantes con desempeño superior en el acta institucional: 32 × 0,25, sin redondear ni cambiar la base del curso ni mezclar el cupo SIMAT o el indicador de otro proceso pedido por Secretaría.",
            "Reportar 6 en el PMI, tomando 24 × 0,25 (omite cerca de ocho del curso) o 32 × cerca de 0,19, como propone el docente, porque deja un cupo cauto comparable con el histórico de superior.",
            "Consignar 7 en el acta de calidad, tomando 28 × 0,25 o recortando cuatro del curso de 32, como insiste el segundo docente, para no tensionar el informe de desempeño superior ante Secretaría.",
            "Registrar 9 en el tablero SIMAT, aplicando el 25% a 36 cupos (36 × 0,25) como matrícula inflada, para que el indicador de desempeño superior luzca alineado con la meta de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 25% de 32 estudiantes es 32 × 0,25 = 8 con desempeño superior. Esa es la cifra del acta institucional. Reportar 6 omite parte del curso o baja la alícuota; 7 usa 28 × 0,25; 9 aplica el 25% a 36 cupos del SIMAT. Ninguna conserva 32 y el 25% pedido por Secretaría.",
        "normativeJustification": "El informe de PMI y SIMAT debe conservar la matrícula del curso (32) y el 25% de desempeño superior. No recorta a 24, no usa 28 ni infla a 36 cupos como si fueran 32 × 0,25.",
        "theoreticalJustification": "Superior = n × 0,25. Con n=32, el producto es 8. 24 × 0,25 = 6; 28 × 0,25 = 7; 36 × 0,25 = 9 cambian la base o la alícuota.",
        "distractorAnalysis": {
            "1": "Trampa de omitir matrícula del curso: 6 = 24 × 0,25 o 32 × cerca de 0,19, como propone el docente. Recorta cerca de ocho estudiantes o baja el 25%. No es 32 × 0,25 = 8.",
            "2": "Trampa de otra base de 28: 7 = 28 × 0,25, como insiste el segundo docente. Conserva el 25% pero cambia los 32 del caso. No es la cifra del acta de desempeño superior.",
            "3": "Trampa de dominio cruzado del cupo SIMAT: 9 = 36 × 0,25. Infla la matrícula a 36 para el tablero de calidad. Sustituye 32 × 0,25 por un indicador de cupo, no por el curso del caso.",
        },
    },
    {
        "id": "dir-apt-num-222",
        "options": [
            "Reportar 2h 00min en el PMI (120 min = 24 × 5), omitiendo 4 cuadernos de los 28, como propone el docente, porque deja una carga limpia comparable con jornadas anteriores de calificación.",
            "Consignar 2h 20min en el acta institucional: 28 cuadernos × 5 minutos = 140 minutos, sin redondear ni cambiar la base ni mezclar el cupo SIMAT o el tiempo de otro proceso pedido por Secretaría.",
            "Consignar 2h 40min en el acta de calidad (160 min = 32 × 5), tomando el curso de 32 o un buffer de 4 cuadernos, como insiste el segundo docente, para no tensionar el informe de calificación.",
            "Registrar 3h 00min en el tablero SIMAT (180 min = 36 × 5), con matrícula inflada a 36 cupos, para que la holgura de calificación luzca alineada con la meta de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Calificar 28 cuadernos a 5 minutos cada uno da 28 × 5 = 140 minutos, es decir 2h 20min. Esa es la cifra del acta institucional. Reportar 2h 00min usa 24 × 5; 2h 40min usa 32 × 5; 3h 00min aplica 36 × 5 del SIMAT. Ninguna conserva 28 cuadernos y 5 minutos.",
        "normativeJustification": "El tiempo de calificación se reporta con los 28 cuadernos y los 5 minutos del caso. El PMI no puede omitir 4 cuadernos, inflar a 32 ni usar 36 cupos SIMAT como si fueran 28 × 5.",
        "theoreticalJustification": "Minutos = n × 5. Con n=28, el producto es 140 = 2h 20min. 24 × 5 = 120; 32 × 5 = 160; 36 × 5 = 180 cambian la base de cuadernos.",
        "distractorAnalysis": {
            "0": "Trampa de omitir cuatro cuadernos: 2h 00min = 120 min = 24 × 5, como propone el docente. Recorta el lote de 28. No es 28 × 5 = 140 minutos ni 2h 20min.",
            "2": "Trampa de inflar a 32 cuadernos: 2h 40min = 160 min = 32 × 5, como insiste el segundo docente. Conserva los 5 minutos pero cambia los 28 del caso. No es la cifra del acta.",
            "3": "Trampa de dominio cruzado del cupo SIMAT: 3h 00min = 180 min = 36 × 5. Infla la matrícula a 36 para el tablero de calidad. Sustituye 28 × 5 por un indicador de cupo, no por los cuadernos del caso.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {
        k: it[k]
        for k in (
            "id",
            "options",
            "explanation",
            "normativeJustification",
            "theoreticalJustification",
            "distractorAnalysis",
        )
    }


def n_sentences(text: str) -> int:
    return text.count(".") + text.count("?") + text.count("!")


def validate(items: list) -> list[str]:
    errors: list[str] = []
    if len(items) != 10:
        errors.append(f"COUNT {len(items)}")
    ids = [it.get("id") for it in items]
    expected_ids = list(CI)
    if ids != expected_ids:
        errors.append(f"ORDER {ids}")
    for it in items:
        tag = it.get("id")
        extra = set(it) - KEYS_OK
        missing = KEYS_OK - set(it)
        if extra:
            errors.append(f"EXTRA KEYS {tag} {extra}")
        if missing:
            errors.append(f"MISSING KEYS {tag} {missing}")
        ci = CI[tag]
        opts = it["options"]
        if not isinstance(opts, list) or len(opts) != 4:
            errors.append(f"OPTIONS {tag}")
            continue
        lengths = [len(o) for o in opts]
        skew = max(lengths) - min(lengths)
        if skew >= 180:
            errors.append(f"LEN SKEW {tag} {lengths} skew={skew}")
        needle = NEEDLE.get(tag)
        if needle and needle not in opts[ci]:
            errors.append(f"MISSING FIGURE {tag} {needle}")
        blob = " ".join(opts) + " " + (it.get("explanation") or "")
        blob += " " + (it.get("normativeJustification") or "")
        blob += " " + (it.get("theoreticalJustification") or "")
        blob += " " + " ".join((it.get("distractorAnalysis") or {}).values())
        if "p. ej." in blob.lower() or "p.ej." in blob.lower():
            errors.append(f"P.EJ {tag}")
        for oi, opt in enumerate(opts):
            n = len(opt)
            if n < 80:
                errors.append(f"SHORT OPTION {tag} idx {oi} {n}")
            if n > 340:
                errors.append(f"LONG OPTION {tag} idx {oi} {n}")
            low = opt.lower()
            if any(x in low for x in TEMPLATE):
                errors.append(f"TEMPLATE DISTRACTOR {tag} idx {oi}")
            if oi != ci:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
                if "no solo" in low or "no sólo" in low:
                    errors.append(f"NO SOLO {tag} idx {oi}")
        da = it["distractorAnalysis"]
        expected = expected_da_keys(ci)
        if sorted(da.keys()) != expected:
            errors.append(f"DA KEYS {tag} {sorted(da.keys())} expected {expected} ci={ci}")
        else:
            for k, v in da.items():
                if not isinstance(v, str) or len(v) < 80:
                    errors.append(f"SHORT DA {tag} {k} {len(v) if isinstance(v, str) else None}")
                if not str(v).startswith("Trampa"):
                    errors.append(f"DA NO TRAMPA {tag} {k}")
        expl = it.get("explanation") or ""
        if len(expl) < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(expl)}")
        n_sent = n_sentences(expl)
        if n_sent < 4 or n_sent > 7:
            errors.append(f"SENTENCES {tag} {n_sent}")
        if tag in NUM_IDS:
            elow = expl.lower()
            if "cifra coherente" not in elow:
                errors.append(f"NUM EXPL FRASE cifra coherente {tag}")
            if "sin redondear ni cambiar la base" not in elow:
                errors.append(f"NUM EXPL FRASE sin redondear {tag}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")
        n_cross = sum(1 for v in da.values() if "dominio cruzado" in v.lower())
        if n_cross != 1:
            errors.append(f"CROSS DOMAIN {tag} {n_cross}")
    return errors


def main() -> int:
    public = [public_item(it) for it in ITEMS]
    errors = validate(public)
    print("=== longitudes opciones ===")
    for it in public:
        lens = [len(o) for o in it["options"]]
        ci = CI[it["id"]]
        cruz = sum(
            1 for v in it["distractorAnalysis"].values() if "dominio cruzado" in v.lower()
        )
        print(
            it["id"],
            "ci",
            ci,
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "sent",
            n_sentences(it["explanation"]),
            "NJ",
            len(it["normativeJustification"]),
            "TJ",
            len(it["theoreticalJustification"]),
            "DA",
            {k: len(v) for k, v in it["distractorAnalysis"].items()},
            "cruz",
            cruz,
        )
    if errors:
        print("=== ERRORES ===")
        for e in errors:
            print(e)
        print("errors", len(errors))
        return 1
    OUT.write_text(
        json.dumps(public, ensure_ascii=False, indent=2) + "\n",
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
    print("errors", 0)
    print("validation OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
