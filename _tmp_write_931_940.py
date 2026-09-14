# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ped-183..192 (posiciones 931-940) y escribe _tmp_out_931_940.json."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_931_940.json"

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
KEYS_OK = {
    "id",
    "options",
    "explanation",
    "normativeJustification",
    "theoreticalJustification",
    "distractorAnalysis",
}
CI = {
    "dir-apt-ped-183": 2,
    "dir-apt-ped-184": 3,
    "dir-apt-ped-185": 0,
    "dir-apt-ped-186": 1,
    "dir-apt-ped-187": 2,
    "dir-apt-ped-188": 3,
    "dir-apt-ped-189": 0,
    "dir-apt-ped-190": 1,
    "dir-apt-ped-191": 2,
    "dir-apt-ped-192": 3,
}

ITEMS = [
    {
        "id": "dir-apt-ped-183",
        "options": [
            "Registrar en el observador un perfil fijo de «inteligencia dominante» y orientar el año lectivo a ese canal, como personalización de por vida, de modo que el etiquetado quede documentado como diferenciación permanente.",
            "Priorizar en el boletín evidencias lógico-matemáticas comparables, porque el tablero de calidad las homologa, y dejar las demás fortalezas como actividades de apoyo que no alimentan el ranking de la sede.",
            "Diversificar las formas de presentar y evaluar, reconociendo distintas fortalezas cognitivas, sin etiquetar ni segregar de forma permanente, frente a separar el curso por inteligencia dominante de por vida.",
            "Organizar grupos permanentes por inteligencia «dominante» para diferenciar, como piden en la reunión, argumentando que esa agrupación estable atiende la diversidad con canales homogéneos durante el año.",
        ],
        "explanation": "La condición de calidad pregunta qué sugiere una aplicación pertinente de las inteligencias múltiples en el aula. Diversificar formas de presentar y evaluar, reconociendo distintas fortalezas cognitivas, sin etiquetar ni segregar de forma permanente, responde a esa pertinencia. Registrar un perfil fijo de inteligencia dominante en el observador convierte la teoría en etiqueta de por vida. Priorizar evidencias lógico-matemáticas comparables sirve al boletín y al tablero de calidad, no a Gardner. Organizar grupos permanentes por inteligencia dominante, como piden en la reunión, segrega en nombre de la diferenciación. La decisión defendible diversifica estrategias y evita el etiquetado permanente.",
        "normativeJustification": "El Decreto 1290 y el diseño universal del aprendizaje exigen evidencias y estrategias diversas, no un canal fijo de por vida. Gardner no autoriza grupos permanentes ni a reducir el boletín a lo lógico-matemático homologable.",
        "theoreticalJustification": "Las inteligencias múltiples informan la diversificación de estrategias, no la clasificación estable del estudiante. Etiquetar, homologar el SIEE o agrupar por dominante miden personalización, comparabilidad o diferenciación aparente, no pertinencia.",
        "distractorAnalysis": {
            "0": "Trampa del etiquetado profesionalizado: fijar en el observador una inteligencia dominante y orientar el año a ese canal parece personalización seria. Convierte a Gardner en perfil permanente y niega la diversificación sin segregación.",
            "1": "Trampa de dominio cruzado del SIEE: priorizar evidencias lógico-matemáticas comparables parece rigor de boletín y tablero de calidad. Es homologación evaluativa, no aplicación pertinente de inteligencias múltiples.",
            "3": "Trampa de la segregación disfrazada de diferenciación: agrupar de forma permanente por inteligencia dominante parece atender la diversidad que pide la reunión. Segrega el curso; no diversifica formas de presentar y evaluar.",
        },
    },
    {
        "id": "dir-apt-ped-184",
        "options": [
            "Convertir el instrumento de inicio de unidad en calificación definitiva del período, como hacen hoy en la sede, para que el boletín cierre con una nota comparable desde el primer día de la unidad.",
            "Usar el menor desempeño previo del instrumento de inicio como insumo de recuperación o amonestación en carpeta, de modo que quien llega con baja evidencia quede marcado para el resto del período.",
            "Sustituir la evaluación formativa del período por el diagnóstico inicial, para no duplicar instrumentos ante la visita de calidad y dejar una evidencia única de proceso en la carpeta institucional.",
            "Identificar saberes previos y necesidades para orientar la planeación pedagógica, no para sancionar ni para reemplazar la formativa del período, frente al uso del instrumento de inicio como nota definitiva.",
        ],
        "explanation": "La condición de calidad pregunta cuál es el propósito principal de la evaluación diagnóstica al inicio de un período o unidad. Identificar saberes previos y necesidades para orientar la planeación, no para sancionar ni reemplazar la formativa, responde a ese propósito. Convertir el instrumento de inicio en nota definitiva, como hacen hoy, confunde diagnóstico con cierre sumativo. Usar el menor desempeño previo como amonestación en carpeta vuelve punitivo el punto de partida. Sustituir la formativa por el diagnóstico reduce instrumentos ante la visita, pero vacía el seguimiento del período. El diagnóstico orienta la enseñanza; no certifica ni reemplaza.",
        "normativeJustification": "El Decreto 1290 sitúa la evaluación diagnóstica como insumo para ajustar la enseñanza. Ni la nota de cierre, ni la amonestación en carpeta, ni la evidencia única de la visita absorben ese propósito de inicio.",
        "theoreticalJustification": "Diagnosticar es leer el punto de partida para planear. Calificar, sancionar o sustituir la formativa miden SIEE, disciplina o carpeta de calidad, no el propósito principal del diagnóstico.",
        "distractorAnalysis": {
            "0": "Trampa de la nota definitiva de inicio: cargar el instrumento al boletín parece rigor comparable desde el primer día, como hacen hoy. Convierte el diagnóstico en sumativa y niega orientar la planeación.",
            "1": "Trampa del uso punitivo de la carpeta: usar el menor desempeño previo como recuperación o amonestación parece seguimiento serio. Sanciona el punto de partida; el diagnóstico no es medida disciplinaria.",
            "2": "Trampa de dominio cruzado del SIEE ante la visita: sustituir la formativa por el diagnóstico parece no duplicar instrumentos y dejar evidencia única. El stem pide el propósito de inicio, no el cierre documental de calidad.",
        },
    },
    {
        "id": "dir-apt-ped-185",
        "options": [
            "Emitir un juicio valorativo final sobre el aprendizaje logrado al cierre de un proceso o período, a diferencia de la retroalimentación continua y de los quizzes de proceso que el equipo confunde con evaluación sumativa.",
            "Brindar retroalimentación continua durante el proceso, como si esa práctica de acompañamiento definiera la sumativa, replicando los quizzes de proceso que hoy se presentan como cierre del período.",
            "Aplicar el instrumento al inicio de cada unidad, como si fuera diagnóstico, para adelantar el cierre del período y disponer de una nota de sumativa antes de desarrollar los aprendizajes previstos.",
            "Excluir calificación o certificación, tratando la sumativa como trámite de clima institucional sin juicio valorativo, de modo que el cierre del período quede en un concepto de convivencia y no en un dictamen de aprendizaje.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente a la evaluación sumativa a diferencia de la formativa. Emitir un juicio valorativo final sobre el aprendizaje logrado al cierre de un proceso o período responde a esa diferencia. Brindar retroalimentación continua es propio de la formativa y de los quizzes de proceso del caso, no de la sumativa. Aplicarla al inicio de cada unidad la confunde con la diagnóstica y adelanta un cierre sin enseñanza. Excluir calificación o certificación la vuelve trámite de clima, la otra confusión del equipo. La sumativa cierra con juicio; la formativa acompaña.",
        "normativeJustification": "El Decreto 1290 distingue evaluación formativa, diagnóstica y sumativa. El juicio de cierre del período no se agota en quizzes de proceso, ni en un instrumento de inicio, ni en un concepto de clima sin valoración.",
        "theoreticalJustification": "Sumar es emitir un juicio al cierre. Retroalimentar, diagnosticar al inicio o eludir la calificación miden proceso, punto de partida o convivencia, no la caracterización principal de la sumativa.",
        "distractorAnalysis": {
            "1": "Trampa de dominio cruzado de la formativa: la retroalimentación continua y los quizzes de proceso son práctica válida de acompañamiento. El stem pide lo que caracteriza a la sumativa a diferencia de esa formativa, no el seguimiento.",
            "2": "Trampa de adelantar el cierre como diagnóstico: aplicar el instrumento al inicio parece ganar tiempo de período. Confunde sumativa con diagnóstica y certifica antes de enseñar.",
            "3": "Trampa del trámite de clima: excluir calificación parece equidad y convivencia. Vacía el juicio valorativo que define a la sumativa frente a la formativa.",
        },
    },
    {
        "id": "dir-apt-ped-186",
        "options": [
            "Reducir la evaluación a un único momento del período, como propone un actor, para disponer de evidencia comparable de cierre y simplificar el registro institucional de resultados en el SIEE.",
            "Evidenciar el progreso del estudiante a lo largo del tiempo mediante una selección organizada de sus producciones en portafolio, frente a un único momento de cierre, a sustituir la observación o a reservarlo a la visita o a la universidad.",
            "Sustituir la observación directa del docente por el portafolio, como insiste el segundo actor, argumentando que la carpeta de producciones ya cubre el seguimiento de aula y hace innecesaria la mirada del maestro.",
            "Reservar el portafolio a la carpeta de calidad de la visita o a las prácticas universitarias, como sugiere el tercero, dejando el aula de la institución oficial sin esa evidencia de proceso a lo largo del tiempo.",
        ],
        "explanation": "La condición de calidad pregunta qué decisión es la más defendible pedagógica e institucionalmente sobre el portafolio. Evidenciar el progreso del estudiante a lo largo del tiempo mediante una selección organizada de producciones responde a esa defensa. Reducir la evaluación a un único momento, como propone un actor, pierde el proceso. Sustituir la observación directa, como insiste el segundo, borra el seguimiento docente. Reservarlo a la visita o a la educación superior, como sugiere el tercero, lo saca del aula oficial. El portafolio documenta evolución; no reemplaza al docente ni se reserva a otro nivel.",
        "normativeJustification": "El Decreto 1290 admite diversas formas de evidenciar aprendizajes, entre ellas el portafolio como proceso. No autoriza a reducir la evaluación a un acto de cierre, ni a sustituir la observación, ni a relegar el instrumento a la visita o a la educación superior.",
        "theoreticalJustification": "El portafolio selecciona producciones para ver evolución. Un momento único, la carpeta que reemplaza al docente o el archivo de calidad miden comparabilidad, sustitución o visita, no progreso en el tiempo.",
        "distractorAnalysis": {
            "0": "Trampa del cierre único comparable: un momento del período parece evidencia limpia para el SIEE y atiende al primer actor. Pierde el progreso temporal que el portafolio está llamado a mostrar.",
            "2": "Trampa de sustituir la observación: la carpeta de producciones parece cubrir el seguimiento y reemplazar la mirada del docente. El portafolio complementa; no reemplaza la observación directa.",
            "3": "Trampa de dominio cruzado de la visita y la educación superior: reservar el portafolio a la carpeta de calidad o a prácticas universitarias parece rigor de otro nivel. El stem pide la decisión de aula más defendible, no el archivo de la visita.",
        },
    },
    {
        "id": "dir-apt-ped-187",
        "options": [
            "Tratar el currículo oculto como documento curricular confidencial que conocen los directivos, como propone el primer actor, y archivarlo en rectoría fuera del PEI que se socializa con la comunidad.",
            "Identificar el currículo oculto con la parte del currículo dedicada a la evaluación, como insiste el segundo actor, de modo que el SIEE y el boletín absorban el concepto y lo vuelvan capítulo del sistema institucional.",
            "Reconocer los aprendizajes, valores y normas que los estudiantes adquieren de manera implícita a través de las dinámicas y relaciones escolares, más allá del currículo formal, frente a lecturas confidenciales, evaluativas o privadas del caso.",
            "Tratarlo como currículo alternativo de la educación privada, como sugiere el tercer actor, argumentando que en la institución oficial el PEI ya cubre de forma explícita todo lo que se enseña y se evalúa.",
        ],
        "explanation": "La condición de calidad pregunta qué decisión es la más defendible pedagógica e institucionalmente sobre el currículo oculto. Se trata de los aprendizajes, valores y normas que los estudiantes adquieren de manera implícita a través de las dinámicas y relaciones escolares, más allá del currículo formal. Tratarlo como documento confidencial de directivos, como propone el primer actor, lo vuelve secreto de archivo. Identificarlo con la parte evaluativa, como insiste el segundo, lo reduce al SIEE. Tratarlo como currículo de la educación privada, como sugiere el tercero, lo saca de la escuela oficial. Lo oculto es implícito y relacional, no un documento ni un sector.",
        "normativeJustification": "La Ley 115 y el PEI distinguen currículo formal de las prácticas que lo realizan. El Decreto 1290 regula la evaluación; no define el currículo oculto. La privacidad de un documento de rectoría o el carácter privado de otra oferta no agotan el concepto.",
        "theoreticalJustification": "El currículo oculto es lo que se aprende en las relaciones, no lo escrito ni lo evaluado. Confidencialidad directiva, capítulo del SIEE o alternativa privada miden archivo, boletín o sector, no lo implícito.",
        "distractorAnalysis": {
            "0": "Trampa del documento confidencial: archivarlo en rectoría parece reserva institucional de directivos, como propone el primer actor. Convierte lo implícito en secreto de carpeta y niega las dinámicas escolares.",
            "1": "Trampa de dominio cruzado del SIEE: identificarlo con la parte del currículo dedicada a la evaluación parece rigor de boletín. El stem pide la lectura pedagógica del oculto, no el capítulo evaluativo.",
            "3": "Trampa del currículo de la educación privada: tratarlo como alternativa de otro sector parece delimitar oferta. El oculto opera en toda escuela, incluida la oficial, en las relaciones más allá del PEI formal.",
        },
    },
    {
        "id": "dir-apt-ped-188",
        "options": [
            "Resolver conflictos disciplinarios como función principal del mediador pedagógico, alineando el rol con el manual de convivencia y la Ley 1620, de modo que la mediación se agote en el clima de aula.",
            "Asumir el rol de la familia en el aprendizaje, de modo que el docente cubra en la sede lo que corresponde al hogar y la mediación reemplace el acompañamiento familiar que el caso distingue del trabajo de aula.",
            "Evaluar con pruebas estandarizadas comparables como si esa práctica fuera la mediación pedagógica, para que el boletín y las evidencias tipo Saber homologuen el acompañamiento del docente que hoy dicta y examina.",
            "Facilitar y acompañar la construcción de conocimiento, más que transmitir en un solo sentido, frente al docente que dicta y examina y frente a reducir la mediación a disciplina, a reemplazar a la familia o a pruebas.",
        ],
        "explanation": "La condición de calidad pregunta a qué se refiere principalmente el docente como mediador pedagógico. Facilitar y acompañar la construcción de conocimiento, más que transmitir en un solo sentido, responde a esa referencia. Resolver conflictos como función principal alinea el rol con la Ley 1620 y el manual, no con la mediación de saberes. Asumir el rol de la familia confunde escuela y hogar. Evaluar con pruebas estandarizadas comparablemente es lenguaje del SIEE y de Saber, no andamiaje. El mediador pregunta y sostiene; no dicta, no reemplaza al acudiente ni se agota en el examen.",
        "normativeJustification": "Vygotsky sitúa al docente como mediador en la zona de desarrollo próximo. La Ley 1620 regula convivencia; el Decreto 1290, la evaluación. Ni el manual ni las pruebas Saber definen la mediación pedagógica del caso.",
        "theoreticalJustification": "Mediar es facilitar la construcción del saber, no transmitir en un sentido. Disciplina, suplencia familiar o prueba estandarizada miden convivencia, alianza casa-escuela o SIEE, no esa mediación.",
        "distractorAnalysis": {
            "0": "Trampa del mediador de convivencia: resolver conflictos según el manual y la Ley 1620 parece el oficio natural del mediador. Es función de clima; el stem pide la mediación pedagógica de conocimiento.",
            "1": "Trampa de reemplazar a la familia: cubrir en la sede el rol del hogar parece compromiso integral. La mediación pedagógica no asume la función familiar que el caso distingue del aula.",
            "2": "Trampa de dominio cruzado del SIEE y Saber: evaluar con pruebas estandarizadas comparables parece mediación rigurosa y homologable. El stem pide facilitar la construcción de conocimiento, no certificar con examen.",
        },
    },
    {
        "id": "dir-apt-ped-189",
        "options": [
            "Hacer que los estudiantes revisen contenidos introductorios fuera del aula y dediquen la clase a aplicar y profundizar, con mediación docente, frente a retirar la explicación o a reservar el modelo a la oferta virtual.",
            "Retirar la explicación y la mediación docente para maximizar la autonomía, profesionalizando la propuesta del caso de «nada de exposición», de modo que la clase quede en trabajo independiente sin andamiaje.",
            "Invertir el orden de las evaluaciones respecto a las actividades, sin cambiar el uso del tiempo de clase, de modo que el examen se adelante y el aula invertida quede en un reordenamiento de evidencias del período.",
            "Reservar el modelo de aula invertida a la oferta virtual o al indicador de TIC de la visita de calidad, como si la presencialidad de la institución no admitiera revisar contenidos fuera y aplicarlos en clase.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente al aula invertida en esta propuesta de reorganizar el tiempo. Los estudiantes revisan contenidos introductorios fuera del aula y dedican la clase a aplicar y profundizar, con mediación. Retirar la explicación para maximizar autonomía, como «nada de exposición», abandona el andamiaje. Invertir el orden de las evaluaciones sin cambiar el tiempo de clase es una mallectura de «invertida». Reservar el modelo a lo virtual o al indicador de TIC de la visita lo saca de la presencialidad. Lo que se invierte es el uso del tiempo, no la ausencia del docente ni el calendario de pruebas.",
        "normativeJustification": "El aula invertida reorganiza el tiempo didáctico: input inicial fuera y aplicación mediada en clase. El PMI digital y la visita de calidad pueden registrar TIC; no definen el modelo ni lo restringen a la oferta virtual.",
        "theoreticalJustification": "Invertir el aula es cambiar cuándo se presenta el contenido y cuándo se aplica. Quitar la mediación, reordenar exámenes o reportar TIC miden autonomía extrema, SIEE o indicador, no esa caracterización.",
        "distractorAnalysis": {
            "1": "Trampa de la autonomía sin mediación: retirar la exposición parece maximizar independencia y profesionaliza el «nada de explicación» del caso. El aula invertida exige mediación en la clase de aplicación, no abandono docente.",
            "2": "Trampa de invertir las evaluaciones: adelantar el examen respecto a las actividades parece una lectura literal de «invertida». No cambia el uso del tiempo de clase, que es lo que caracteriza al modelo.",
            "3": "Trampa de dominio cruzado del PMI digital: reservar el aula invertida a lo virtual o al indicador de TIC de la visita parece coherencia de calidad. El stem pide la caracterización didáctica del tiempo, no el reporte de conectividad.",
        },
    },
    {
        "id": "dir-apt-ped-190",
        "options": [
            "Sustituir las evaluaciones formales del SIEE por videojuegos como evidencia auténtica, profesionalizando al primer actor, de modo que retos y puntajes digitales cierren el período en lugar de las pruebas institucionales.",
            "Incorporar retos, niveles y recompensas en actividades de aprendizaje para fomentar la motivación, sin reemplazar el propósito pedagógico, frente a sustituir el SIEE, limitar la práctica a inicial o destinar la hora al clima.",
            "Limitar la gamificación a la educación inicial, como insiste el segundo actor, argumentando que los grados posteriores requieren evidencias formales y no dinámicas de juego en el aula de básica o media.",
            "Destinar la hora a dinámicas lúdicas sin propósitos ni evidencias de aprendizaje, para el tablero de convivencia, de modo que el juego ocupe el tiempo de clase sin articular retos al propósito pedagógico del período.",
        ],
        "explanation": "La condición de calidad pregunta qué decisión es la más defendible pedagógica e institucionalmente sobre la gamificación. Incorporar retos, niveles y recompensas en actividades de aprendizaje para fomentar la motivación, sin reemplazar el propósito pedagógico, responde a esa defensa. Sustituir las evaluaciones formales del SIEE por videojuegos, como el primer actor, vacía el sistema institucional. Limitarla a la educación inicial, como el segundo, recorta el recurso. Destinar la hora a dinámicas lúdicas sin evidencias, para el tablero de convivencia, cambia el objeto al clima. El juego motiva el aprendizaje; no reemplaza al SIEE ni se reserva a un nivel.",
        "normativeJustification": "El Decreto 1290 exige evidencias de aprendizaje con propósito. La gamificación puede motivar; no sustituye las evaluaciones institucionales ni se limita por nivel, ni se reporta como indicador de convivencia.",
        "theoreticalJustification": "Gamificar es usar mecánica de juego al servicio de un propósito de aprendizaje. Videojuego como evidencia de cierre, restricción a inicial o hora de clima miden autenticidad, etapa o convivencia, no esa incorporación.",
        "distractorAnalysis": {
            "0": "Trampa de los videojuegos como evidencia de cierre: sustituir el SIEE parece evaluación auténtica y atiende al primer actor. Reemplaza el propósito institucional de certificar aprendizajes por puntajes de juego.",
            "2": "Trampa de reservarla a la educación inicial: limitar la gamificación a ese nivel, como insiste el segundo actor, parece cuidado de la seriedad de básica y media. El recurso no se agota en un ciclo.",
            "3": "Trampa de dominio cruzado de clima: destinar la hora a dinámicas lúdicas para el tablero de convivencia parece cuidar el ambiente. El stem pide la decisión pedagógica de gamificar con propósito, no el indicador de clima.",
        },
    },
    {
        "id": "dir-apt-ped-191",
        "options": [
            "Memorizar definiciones teóricas sobre las emociones, como el programa actual del caso, de modo que el cuaderno de definiciones sirva de evidencia del componente socioemocional en la carpeta de área.",
            "Evaluar las competencias socioemocionales con pruebas escritas estandarizadas comparables, para que el boletín y el tablero de calidad homologuen ese desempeño como una nota de área frente a Saber.",
            "Reconocer y gestionar emociones, y relacionarse de manera asertiva, frente a memorizar definiciones, medirlas con prueba escrita o promover el autocontrol como no expresar emociones en el aula.",
            "Promover el autocontrol como no expresar emociones en el aula, para el clima institucional, profesionalizando la prohibición del caso y dejando la gestión emocional como silencio disciplinado.",
        ],
        "explanation": "La condición de calidad pregunta qué busca principalmente el desarrollo de competencias socioemocionales en el aula. Reconocer y gestionar emociones, y relacionarse de manera asertiva, responde a ese propósito. Memorizar definiciones, como el programa actual, convierte el componente en recitación. Evaluarlas con pruebas escritas estandarizadas sirve al boletín y a Saber, no a la gestión relacional. Promover el autocontrol como no expresar emociones, para el clima, profesionaliza la prohibición del caso. Lo socioemocional se ejerce; no se recita, no se homologa en prueba ni se silencia.",
        "normativeJustification": "Los lineamientos de competencias ciudadanas y socioemocionales del MEN apuntan a reconocer, gestionar y relacionarse. El Decreto 1290 no exige prueba escrita comparable como definición de ese desarrollo, ni el manual autoriza el silencio emocional como clima.",
        "theoreticalJustification": "La competencia socioemocional es actuación: reconocer, regular y relacionarse. Definiciones, prueba estandarizada o prohibición de expresar miden memoria, SIEE o disciplina, no ese propósito principal.",
        "distractorAnalysis": {
            "0": "Trampa de la recitación teórica: memorizar definiciones sobre emociones parece programa serio y deja evidencia en el cuaderno. Confunde saber declarar con reconocer, gestionar y relacionarse de forma asertiva.",
            "1": "Trampa de dominio cruzado del SIEE y Saber: una prueba escrita estandarizada comparable parece rigor de boletín. El stem pide qué busca el desarrollo socioemocional, no cómo homologarlo en una nota.",
            "3": "Trampa del silencio como autocontrol: no expresar emociones parece cuidar el clima y profesionaliza la prohibición del caso. Niega la gestión y la asertividad que el desarrollo socioemocional busca.",
        },
    },
    {
        "id": "dir-apt-ped-192",
        "options": [
            "Organizar el trabajo de forma individual, sin interacción, como si autonomía fuera aislamiento, replicando la confusión del caso de trabajar sin pares ni mediación y sin devolución sobre el proceso.",
            "Conservar la dependencia de la instrucción directa del docente, de modo que el estudiante ejecute paso a paso lo que se dicta y la autonomía quede aplazada hasta que el maestro cierre cada tarea del período.",
            "Omitir la retroalimentación y dejar pruebas individuales comparables, porque quien es autónomo se autorregula, de modo que el boletín cierre sin devolución de proceso y el SIEE muestre evidencias homogéneas.",
            "Asumir un rol activo en la planificación, ejecución y evaluación del propio aprendizaje, con mediación y criterios, frente a aislarse, depender de la instrucción directa u omitir la retroalimentación del proceso.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente al aprendizaje autónomo según el marco y la evidencia del caso. Asumir un rol activo en la planificación, ejecución y evaluación del propio aprendizaje, con mediación y criterios, responde a esa caracterización. Organizar el trabajo individual sin interacción confunde autonomía con aislamiento. Conservar la dependencia de la instrucción directa deja al estudiante en el otro polo. Omitir retroalimentación y dejar pruebas comparables parece autorregulación para el SIEE, pero vacía la mediación. Autonomía es autorregulación mediada, no soledad ni abandono de la devolución.",
        "normativeJustification": "El Decreto 1290 y la evaluación formativa exigen criterios conocidos y retroalimentación. El aprendizaje autónomo no se define por el trabajo individual ni por la ausencia de devolución; se define por el rol activo con mediación.",
        "theoreticalJustification": "Autonomía es planear, hacer y valorar el propio proceso con apoyo. Aislarse, esperar la instrucción directa u omitir la retroalimentación miden soledad, dependencia o comparabilidad de prueba, no esa caracterización.",
        "distractorAnalysis": {
            "0": "Trampa del aislamiento: organizar el trabajo individual sin interacción parece autonomía y replica la confusión del caso. Autonomía no es soledad; admite pares y mediación con criterios.",
            "1": "Trampa de la instrucción directa prolongada: ejecutar paso a paso lo que se dicta parece rigor y cuidado. Conserva dependencia; niega el rol activo de planear, ejecutar y evaluar el propio aprendizaje.",
            "2": "Trampa de dominio cruzado del SIEE: omitir retroalimentación y dejar pruebas individuales comparables parece autorregulación madura. El stem pide la caracterización del autónomo con mediación, no el boletín sin devolución.",
        },
    },
]


def expected_da_keys(ci: int) -> list:
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


def validate(items: list) -> list:
    errors = []
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
        if skew > 180:
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
                if "no solo" in low or "no sólo" in low:
                    errors.append(f"NO SOLO {tag} idx {oi}")
        da = it["distractorAnalysis"]
        expected = expected_da_keys(ci)
        if sorted(da.keys()) != expected:
            errors.append(f"DA KEYS {tag} {sorted(da.keys())} expected {expected} ci={ci}")
        else:
            cruz = 0
            for k, v in da.items():
                if not isinstance(v, str) or len(v) < 80:
                    errors.append(f"SHORT DA {tag} {k} {len(v) if isinstance(v, str) else None}")
                if not str(v).startswith("Trampa"):
                    errors.append(f"DA NO TRAMPA {tag} {k}")
                if "dominio cruzado" in (v or "").lower():
                    cruz += 1
            if cruz != 1:
                errors.append(f"CRUZADOS {tag} {cruz}")
        expl = it.get("explanation") or ""
        if len(expl) < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(expl)}")
        n_sent = expl.count(".") + expl.count("?") + expl.count("!")
        if n_sent < 4 or n_sent > 8:
            errors.append(f"SENTENCES {tag} {n_sent}")
        if n_sent > 7:
            errors.append(f"SENTENCES USERCAP {tag} {n_sent}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")
    return errors


def main() -> int:
    public = [public_item(it) for it in ITEMS]
    errors = validate(public)
    print("=== longitudes opciones ===")
    for it in public:
        lens = [len(o) for o in it["options"]]
        ci = CI[it["id"]]
        expl = it["explanation"]
        n_sent = expl.count(".") + expl.count("?") + expl.count("!")
        da = it["distractorAnalysis"]
        cruz = [k for k, v in da.items() if "dominio cruzado" in v.lower()]
        print(
            it["id"],
            "ci",
            ci,
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(expl),
            "sent",
            n_sent,
            "NJ",
            len(it["normativeJustification"]),
            "TJ",
            len(it["theoreticalJustification"]),
            "DA",
            {k: len(v) for k, v in da.items()},
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
