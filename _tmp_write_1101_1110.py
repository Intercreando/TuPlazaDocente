# -*- coding: utf-8 -*-
"""Reescribe dir-apt-blan-353..360 y dir-apt-dis-361..362 (posiciones 1101-1110)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1101_1110.json"
CI = {
    "dir-apt-blan-353": 0,
    "dir-apt-blan-354": 1,
    "dir-apt-blan-355": 2,
    "dir-apt-blan-356": 3,
    "dir-apt-blan-357": 0,
    "dir-apt-blan-358": 1,
    "dir-apt-blan-359": 2,
    "dir-apt-blan-360": 3,
    "dir-apt-dis-361": 0,
    "dir-apt-dis-362": 1,
}

ITEMS = [
    {
        "id": "dir-apt-blan-353",
        "options": [
            "Facilitar que las distintas perspectivas se expresen con respeto y usar esa diversidad de opiniones sobre la política pública como insumo para analizar el tema desde múltiples ángulos.",
            "Priorizar la postura más cercana al PEI institucional como marco oficial del análisis, para que la tensión entre estratos no desordene el debate de política pública.",
            "Sustituir el tema de política pública por un taller de mapas del DBA, para no generar tensión entre estudiantes de estratos socioeconómicos distintos.",
            "Pedir que nadie mencione su estrato y calificar la oralidad con una rúbrica única del SIEE, para que la evidencia de ciudadanía sea comparable y «neutra».",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando estudiantes de estratos distintos tensionan un tema de política pública. Facilitar la expresión respetuosa y usar esa diversidad como insumo enriquece el análisis. Priorizar la postura del PEI usa la institución para silenciar un bando. Sustituir por mapas del DBA evade el objeto. La rúbrica única del SIEE que prohíbe mencionar el estrato busca comparabilidad y aplasta el dato social que el debate necesita tratar con cuidado, no ocultar como trámite.",
        "normativeJustification": "Los Estándares de competencias ciudadanas y el DUA piden deliberar política pública con pluralismo. El PEI, el taller de mapas y el SIEE no autorizan a oficializar una postura, a evadir el tema ni a homologar la oralidad ocultando el estrato.",
        "theoreticalJustification": "La diversidad socioeconómica es recurso de análisis, no ruido. El PEI como marco, los mapas o la rúbrica neutra miden lealtad, cobertura o evidencia, no deliberación ética.",
        "distractorAnalysis": {
            "1": "Trampa del PEI como marco oficial: priorizar la postura institucional parece ordenar el debate. Silencia perspectivas de estrato y no es la conducta más defendible ética e institucionalmente.",
            "2": "Trampa de evadir con mapas: sustituir la política pública parece cuidado del clima. Cambia el objeto de la clase y no media la tensión entre estratos.",
            "3": "Trampa de dominio cruzado del SIEE: la rúbrica única y el silencio sobre el estrato lucen como evidencia comparable. Ocultan el dato social y no facilitan el análisis plural.",
        },
    },
    {
        "id": "dir-apt-blan-354",
        "options": [
            "Registrar el comentario de «poco útil» en el observador como falta de compromiso (Ley 1620) y exigir una disculpa, sin indagar por qué el estudiante percibe así las ciencias sociales.",
            "Conversar con el estudiante para entender su percepción y explorar formas de conectar los contenidos de ciencias sociales con situaciones o intereses relevantes para él.",
            "Aumentar los quizzes del SIEE sobre el área, para demostrar la utilidad de sociales mediante notas visibles y evidencia comparable de rigor en el período.",
            "Incluir el comentario como ítem de percepción del área en el tablero PMI, diseñar una encuesta de clima y archivar el hallazgo, sin mediar todavía con el estudiante.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante califica las ciencias sociales como poco útiles. Conversar para entender y conectar con sus intereses es constructivo y sostiene el vínculo pedagógico. Registrar en el observador 1620 sanciona una percepción y no la explora. Aumentar quizzes del SIEE impone rigor visible y puede confirmar que el área «sirve para la nota». Reportar al PMI documenta clima y deja el desinterés sin mediación.",
        "normativeJustification": "Los DBA de ciencias sociales y el Decreto 1075 piden pertinencia y diálogo. La Ley 1620, el SIEE de quizzes y el PMI de percepción no sustituyen la conversación con el estudiante que declara el área poco útil.",
        "theoreticalJustification": "El desinterés se trabaja con sentido y vínculo. El observador, el quiz o el indicador de clima miden sanción, evidencia o tablero, no pertinencia.",
        "distractorAnalysis": {
            "0": "Trampa del 1620: registrar «poco útil» como falta de compromiso parece sostener la autoridad. Sanciona una percepción y no indaga el sentido que el estudiante no encuentra en sociales.",
            "2": "Trampa de los quizzes: aumentar pruebas del SIEE parece demostrar utilidad. Confirma que el área vale por la nota y no conecta con sus intereses.",
            "3": "Trampa de dominio cruzado del PMI: la encuesta de percepción del área luce como gestión de calidad. Archiva el comentario y no media con el estudiante que lo formuló.",
        },
    },
    {
        "id": "dir-apt-blan-355",
        "options": [
            "Reasignar de inmediato el país o la postura del Modelo ONU para que coincida con la opinión personal del estudiante, y así no tensionar su comodidad ni el clima del simulacro.",
            "Mantener el rol asignado sin acompañamiento adicional y evaluar el discurso final con rúbrica comparable del SIEE, argumentando que la incomodidad forma parte del ejercicio.",
            "Explicar el valor pedagógico de representar una postura distinta a la propia para desarrollar empatía y comprensión de otras perspectivas, y ofrecer acompañamiento durante el Modelo ONU.",
            "Elevar la incomodidad al comité de convivencia (Ley 1620) como objeción de conciencia, y retirar al estudiante del simulacro hasta que haya un acta de autorización.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando, en un Modelo ONU, un estudiante debe representar una postura con la que está en desacuerdo. Explicar el valor de esa distancia y acompañar resignifica la incomodidad como aprendizaje. Reasignar el país para coincidir con su opinión evita el conflicto cognitivo que el simulacro busca. Evaluar solo el discurso final con el SIEE mantiene el rol y abandona el acompañamiento. Abrir un 1620 por objeción de conciencia judicializa un ejercicio de perspectiva.",
        "normativeJustification": "Los DBA de ciencias sociales y los Estándares de competencias ciudadanas amparan el juego de roles como empatía política. El SIEE y la Ley 1620 no autorizan a reasignar por comodidad, a evaluar sin mediación ni a procesar la incomodidad como convivencia.",
        "theoreticalJustification": "Representar al otro es el objeto del Modelo ONU. El cambio de país, la rúbrica muda o el acta 1620 miden confort, evidencia o disciplina, no perspectiva.",
        "distractorAnalysis": {
            "0": "Trampa de alinear el rol con la opinión: reasignar el país parece cuidado. Evita el conflicto cognitivo que el simulacro pide y no es la conducta más defendible ética e institucionalmente.",
            "1": "Trampa de la rúbrica final: evaluar el discurso comparable al cierre parece rigor del SIEE. Mantiene el rol y deja sin acompañamiento a quien manifestó incomodidad.",
            "3": "Trampa de dominio cruzado de la Ley 1620: tratar la incomodidad como objeción de conciencia luce como canal institucional. Retira al estudiante del Modelo ONU y judicializa un ejercicio de perspectiva.",
        },
    },
    {
        "id": "dir-apt-blan-356",
        "options": [
            "Seguir la clase según el plan de área y la cobertura del DBA, ofreciendo al estudiante que se calme en silencio, para no perder el hilo de la sesión ni alterar al grupo.",
            "Suspender ciencias sociales del día y pasar a un recreo dirigido de bienestar, argumentando que la noticia de violencia hace inviable cualquier contenido académico.",
            "Activar de inmediato la ruta de atención en salud mental y retirar al estudiante del aula hacia orientación, sin un espacio breve para que exprese cómo se siente frente a la noticia.",
            "Permitir un breve espacio para que el estudiante exprese cómo se siente, y evaluar si conviene ajustar la actividad planeada o remitirlo a apoyo institucional si es necesario.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante llega alterado por noticias de violencia en el país. Un espacio breve de expresión, con flexibilidad de la actividad y remisión si hace falta, atiende la emoción y sostiene el aula. Seguir el DBA en silencio privilegia la cobertura. Suspender el día por un recreo de bienestar evacua el contenido y puede espectacularizar. Activar de inmediato la ruta y retirar sin escuchar es un protocolo de protección que salta la contención mínima en clase.",
        "normativeJustification": "La Ley 1620 y las rutas de atención piden escuchar y, si hay riesgo, remitir. El plan de área, el recreo de bienestar y la activación muda de la ruta no sustituyen ese espacio breve ni el ajuste prudente de la actividad.",
        "theoreticalJustification": "La alteración por violencia reciente se regula con contención y criterio de remisión. La cobertura, el recreo o el retiro inmediato miden DBA, clima o protocolo, no cuidado situado.",
        "distractorAnalysis": {
            "0": "Trampa de la cobertura del DBA: seguir el plan y pedir silencio parece profesionalismo. Deja alterado al estudiante sin voz y no es la conducta más defendible ética e institucionalmente.",
            "1": "Trampa del recreo de bienestar: suspender sociales parece cuidado. Evacua el contenido y no evalúa si basta un ajuste breve o una remisión.",
            "2": "Trampa de dominio cruzado de la ruta de atención: retirar de inmediato hacia orientación luce como protección formal. Salta el espacio breve de expresión que el caso pide antes de remisión.",
        },
    },
    {
        "id": "dir-apt-blan-357",
        "options": [
            "Guiar el análisis hacia el contraste de distintas fuentes e interpretaciones históricas, mostrando que el hecho controvertido admite más de una lectura fundamentada.",
            "Fijar la versión del manual escolar como evidencia comparable del SIEE, para que el desacuerdo se cierre con un referente único y el grupo no disperse el aprendizaje.",
            "Cerrar el hecho controvertido y pasar a una línea de tiempo de fechas del DBA, para evitar interpretaciones distintas y conservar el clima de la clase.",
            "Hacer votar al grupo cuál interpretación entra al acta de clase, de modo que el gobierno escolar del aula zanje el desacuerdo con mayoría visible.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando hay desacuerdo sobre la interpretación de un hecho histórico controvertido. Contrastar fuentes e interpretaciones desarrolla pensamiento histórico crítico. Fijar el manual como evidencia del SIEE impone una versión comparable y mata el debate. Pasar a una línea de tiempo evade el objeto controvertido. Votar cuál interpretación entra al acta confunde democracia de aula con verdad histórica.",
        "normativeJustification": "Los DBA de ciencias sociales piden contrastar fuentes, no homologar una versión. El SIEE, las efemérides y el gobierno escolar no autorizan a canonizar el manual, a evadir el hecho ni a votar la interpretación.",
        "theoreticalJustification": "La historia se argumenta con fuentes, no con autoridad del texto, con fechas ni con mayoría. El SIEE, la línea de tiempo o el voto miden evidencia, cobertura o legitimidad, no crítica.",
        "distractorAnalysis": {
            "1": "Trampa del manual comparable: fijar la versión del texto como SIEE parece rigor. Cierra el desacuerdo con un referente único y no contrastan fuentes.",
            "2": "Trampa de las fechas del DBA: cerrar el hecho controvertido parece cuidado del clima. Evade el objeto de la discusión y no forma pensamiento histórico.",
            "3": "Trampa de dominio cruzado del gobierno escolar: votar la interpretación para el acta luce como participación. Confunde mayoría con lectura fundamentada del hecho.",
        },
    },
    {
        "id": "dir-apt-blan-358",
        "options": [
            "Reducir el período a historia de Colombia para responder al interés local y al indicador PMI de identidad, y dejar la historia de otros países para un club o para otro grado.",
            "Explicar, con ejemplos concretos, cómo los procesos históricos de otros países ayudan a comprender mejor los propios y el mundo interconectado en el que vivimos.",
            "Asignar un ensayo extra de historia mundial como evidencia del SIEE de «apertura», para que el estudiante documente por escrito por qué debe estudiar otros países.",
            "Remitir la duda al Consejo Académico para que ajuste el plan de área, argumentando que la pertinencia de la historia mundial es una decisión de gobierno escolar, no del aula.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante pregunta por qué estudiar la historia de otros países y no solamente la de Colombia. Explicar con ejemplos el valor comparativo responde a la inquietud con solidez pedagógica. Reducir el período a lo nacional calma el interés local y recorta el DBA mundial. El ensayo extra del SIEE convierte la duda en carga evaluativa. Remitir al Consejo Académico transfiere al gobierno escolar una orientación que el docente puede dar en el momento.",
        "normativeJustification": "Los DBA de ciencias sociales incluyen historia mundial y comparada. El PMI de identidad, el SIEE de ensayos extra y el Consejo Académico no autorizan a recortar, a sobrecargar ni a diferir la respuesta.",
        "theoreticalJustification": "La historia comparada da sentido a lo propio. El recorte nacional, el ensayo punitivo o el trámite de plan de área miden identidad, evidencia o gobierno, no comprensión.",
        "distractorAnalysis": {
            "0": "Trampa del PMI de identidad: reducir a historia de Colombia parece pertinencia local. Recorta el DBA mundial y no responde la inquietud con argumentos comparativos.",
            "2": "Trampa del ensayo extra: documentar la «apertura» en el SIEE parece rigor. Convierte una pregunta legítima en carga evaluativa y no explica con ejemplos.",
            "3": "Trampa de dominio cruzado del gobierno escolar: remitir al Consejo Académico luce como plan de área. Difiere la orientación que el docente puede dar en el aula.",
        },
    },
    {
        "id": "dir-apt-blan-359",
        "options": [
            "Ponderar en la rúbrica, además de la argumentación, la alineación de la tesis con el PEI institucional, de modo que el ensayo «encaje» con el proyecto de la IE.",
            "Devolver el ensayo para que incorpore la tesis del texto guía antes de calificar, argumentando que el uso de la fuente autorizada es criterio de calidad del SIEE.",
            "Evaluar el ensayo según la calidad de la argumentación y el uso de evidencia, con independencia de si el docente comparte o no la opinión expresada sobre el tema social.",
            "Elevar el ensayo al comité de convivencia (Ley 1620) por contenido inapropiado, y dejar la calificación en suspenso hasta el acta, dado el desacuerdo con la opinión.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un ensayo argumentativo, bien sustentado, expresa una opinión con la que el docente está en desacuerdo. Evaluar argumentación y evidencia, no la coincidencia de tesis, es objetividad del SIEE y ética profesional. Ponderar la alineación con el PEI usa el proyecto como filtro ideológico. Devolver para incorporar la tesis del texto guía disfraza de «uso de fuente» la corrección de la opinión. Elevar al 1620 judicializa un desacuerdo de ideas.",
        "normativeJustification": "El Decreto 1290 y el SIEE exigen criterios públicos de argumentación, no de afinidad. El PEI, el texto guía y la Ley 1620 no autorizan a filtrar la tesis, a reescribirla ni a procesarla como convivencia.",
        "theoreticalJustification": "La evaluación ética separa la calidad del argumento de la opinión del evaluador. El PEI, la fuente autorizada o el 1620 miden lealtad, cobertura o disciplina, no objetividad.",
        "distractorAnalysis": {
            "0": "Trampa del PEI como filtro: ponderar la alineación institucional parece coherencia de proyecto. Castiga la tesis disidente y no es la conducta más defendible ética e institucionalmente.",
            "1": "Trampa del texto guía: devolver el ensayo para incorporar la tesis autorizada parece uso de fuente. Obliga a cambiar la opinión antes de calificar.",
            "3": "Trampa de dominio cruzado de la Ley 1620: elevar el ensayo por contenido inapropiado luce como canal institucional. Judicializa un desacuerdo de ideas y deja la nota en suspenso.",
        },
    },
    {
        "id": "dir-apt-blan-360",
        "options": [
            "Compartir la opinión política personal como marco experto para orientar el análisis del grupo, de modo que los estudiantes dispongan de un referente «informado» sobre el tema controvertido.",
            "Recordar el manual de convivencia y pedir que las preguntas sobre la vida personal del docente se hagan en orientación, no en clase, para no desviar el tema controvertido.",
            "Declarar que el docente no tiene postura sobre el tema y pasar de inmediato a un quiz del SIEE de datos, para evitar cualquier conflicto y conservar evidencia comparable.",
            "Explicar con respeto que el rol docente es presentar distintas perspectivas de manera equilibrada, más que imponer la opinión personal del maestro sobre el grupo.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante pregunta la opinión política personal del docente sobre un tema controvertido. Explicitar el rol de presentar perspectivas equilibradas forma ciudadanía sin imponer. Compartir la opinión como marco experto usa la autoridad para sesgar el análisis. Enviar la pregunta a orientación trata como intromisión personal lo que es una demanda de rol. Declarar que no hay postura y pasar a un quiz evade y cambia el objeto por evidencia del SIEE.",
        "normativeJustification": "Los Estándares de competencias ciudadanas y el Decreto 1075 piden pluralismo y no propaganda. El manual, orientación y el SIEE no autorizan a expertizar la opinión propia, a reprimir la pregunta ni a sustituirla por un quiz.",
        "theoreticalJustification": "El docente es mediador de perspectivas, no militante ni vacío. El marco experto, el reenvío a orientación o el quiz miden autoridad, disciplina o evidencia, no equilibrio.",
        "distractorAnalysis": {
            "0": "Trampa del marco experto: compartir la opinión personal como referente informado parece honestidad intelectual. Impone la tesis del docente y no es la conducta más defendible ética e institucionalmente.",
            "1": "Trampa del manual: enviar la pregunta a orientación parece límite profesional. Trata como intromisión una demanda de rol frente a un tema controvertido de clase.",
            "2": "Trampa de dominio cruzado del SIEE: declarar que no hay postura y pasar a un quiz luce como neutralidad comparable. Evade el rol de presentar perspectivas y cambia el objeto por datos.",
        },
    },
    {
        "id": "dir-apt-dis-361",
        "options": [
            "Orientar el 20 de julio de 1810 como datación del Grito de Independencia en Santafé, y reenseñar no fusionarlo con la Batalla de Boyacá del 7 de agosto de 1819.",
            "Tomar el 7 de agosto de 1819 como «Grito», fusionando el hito militar de Boyacá con el inicio del proceso, para unificar las dos efemérides en una sola fecha memorable.",
            "Consignar el 20 de julio de 1819, mezclando el día del Grito con el año de Boyacá, como hace el estudiante que fusiona ambas fechas en el aula.",
            "Adoptar el 5 de agosto de 1810 en el calendario de calidad del PMI, por cercanía al cierre del año escolar y a la semana de efemérides que Secretaría pide reportar.",
        ],
        "explanation": "La condición de calidad pide qué datación del Grito hay que orientar como aprendizaje esencial y qué error reenseñar. El Grito se conmemora el 20 de julio de 1810; el 7 de agosto de 1819 es Boyacá, otro hito. Fusionar 1819 como Grito borra el inicio del proceso. El 20 de julio de 1819 mezcla día y año, que es el error del estudiante. El 5 de agosto de 1810 alinea el PMI de efemérides y no es la fecha del Grito.",
        "normativeJustification": "Los DBA de ciencias sociales distinguen 20 de julio de 1810 (inicio) y 7 de agosto de 1819 (desenlace militar). El PMI de efemérides no autoriza a mover el Grito al 5 de agosto ni a fusionarlo con Boyacá.",
        "theoreticalJustification": "Periodizar independencias exige no colapsar inicio y hito militar. Fusionar 1819, mezclar 20 de julio de 1819 o alinear el calendario de calidad cambian el objeto de la datación.",
        "distractorAnalysis": {
            "1": "Trampa de unificar efemérides: tomar Boyacá (7 de agosto de 1819) como Grito parece una fecha memorable. Borra el 20 de julio de 1810 y fusiona inicio con desenlace militar.",
            "2": "Trampa de la fusión del estudiante: 20 de julio de 1819 combina el día del Grito con el año de Boyacá. Es el error que el caso pide reenseñar, no el aprendizaje esencial.",
            "3": "Trampa de dominio cruzado del PMI: el 5 de agosto de 1810 luce como calendario de calidad cercano al año escolar. No es la datación del Grito ni reenseña la confusión con Boyacá.",
        },
    },
    {
        "id": "dir-apt-dis-362",
        "options": [
            "Enseñar que Boyacá inicia el proceso independentista y omitir el Grito de 1810, para ahorrar una efeméride en la línea de tiempo y llegar más rápido al 7 de agosto de 1819.",
            "Enseñar que Boyacá consolidó la independencia al derrotar realistas y abrir el avance a Bogotá, y reenseñar no confundir ese desenlace militar con el inicio de 1810 ni con un acto constitucional.",
            "Presentar Boyacá como la promulgación de la primera Constitución, de modo que el hito militar se lea como trámite jurídico comparable al de 1991 en el SIEE de civismo.",
            "Afirmar que Boyacá cerró todo conflicto interno criollo, y reportarlo así en el indicador PMI de «cierre de conflicto», para que el 7 de agosto luzca como paz definitiva.",
        ],
        "explanation": "La condición de calidad pide la interpretación más defendible de Boyacá y el error a reenseñar. La victoria del 7 de agosto de 1819 consolidó el proceso, derrotó realistas y abrió el avance a Bogotá; no es el inicio (1810) ni un acto constitucional. Omitir 1810 para ahorrar efemérides borra el Grito. Leer Boyacá como primera Constitución anacroniza el hito. Reportarlo como cierre de todo conflicto interno en el PMI de paz infla el alcance militar.",
        "normativeJustification": "Los DBA distinguen 1810 (inicio) y 1819 (desenlace militar). El SIEE de civismo y el PMI de cierre de conflicto no convierten Boyacá en Constitución ni en paz definitiva criolla.",
        "theoreticalJustification": "Boyacá es hito militar de consolidación. Inicio, acto constitucional o cierre total de conflictos internos cambian el objeto: de desenlace a origen, a derecho o a indicador de paz.",
        "distractorAnalysis": {
            "0": "Trampa de ahorrar el Grito: iniciar el proceso en Boyacá parece simplificar la línea de tiempo. Borra 1810 y confunde inicio con desenlace militar del 7 de agosto de 1819.",
            "2": "Trampa de la primera Constitución: leer Boyacá como trámite jurídico parece civismo. Anacroniza el hito militar y no reenseña la diferencia con 1810.",
            "3": "Trampa de dominio cruzado del PMI: reportar Boyacá como cierre de todo conflicto criollo luce como indicador de paz. Infla el alcance de 1819 y no es la interpretación más defendible.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI))
