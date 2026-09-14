# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ped-293..300 y dir-apt-lec-301..302 (posiciones 1041-1050)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1041_1050.json"
CI = {
    "dir-apt-ped-293": 0,
    "dir-apt-ped-294": 1,
    "dir-apt-ped-295": 2,
    "dir-apt-ped-296": 3,
    "dir-apt-ped-297": 0,
    "dir-apt-ped-298": 1,
    "dir-apt-ped-299": 2,
    "dir-apt-ped-300": 3,
    "dir-apt-lec-301": 0,
    "dir-apt-lec-302": 1,
}

ITEMS = [
    {
        "id": "dir-apt-ped-293",
        "options": [
            "Pregunta de orden superior: exige analizar e interpretar por qué el personaje tomó esa decisión, no mera recuperación literal del nombre o de un dato puntual del texto.",
            "Pregunta de orden literal: el motivo de la decisión «está escrito en el texto», de modo que basta localizar la frase y no hace falta interpretar la conducta del personaje.",
            "Pregunta reproductiva: pide citar una frase del relato, como si copiar el enunciado de la decisión equivaliera a comprender por qué el personaje actuó de ese modo.",
            "Pregunta de participación para el SIEE: sirve para tomar asistencia o calificar la intervención oral comparable, más que para comprender la decisión del personaje.",
        ],
        "explanation": "La condición de calidad pregunta de qué es principalmente una pregunta como «por qué crees que el personaje tomó esa decisión», frente a una literal. Esa demanda exige análisis e interpretación de la conducta, no mera recuperación del nombre del personaje o de un dato puntual. Tratarla como literal porque el motivo «está en el texto» baja el nivel cognitivo al localizar una frase. Tomarla como reproductiva confunde citar el relato con justificar la decisión. Usarla para asistencia o participación del SIEE cambia el objeto: de comprensión a trámite de evidencia comparable.",
        "normativeJustification": "Los DBA de lenguaje distinguen recuperación literal de análisis e interpretación. El SIEE no convierte la pregunta del porqué del personaje en asistencia ni en nota de participación oral.",
        "theoreticalJustification": "Las taxonomías de preguntas sitúan el porqué en análisis. Localizar un dato, copiar una frase o tomar lista son otros objetos cognitivos, no orden superior.",
        "distractorAnalysis": {
            "1": "Trampa de lo literal porque «está en el texto»: localizar la frase del motivo parece lectura atenta. Baja la pregunta de análisis a recuperación y no interpreta la decisión del personaje.",
            "2": "Trampa de lo reproductivo: citar una frase del relato parece evidencia de comprensión. Copiar el enunciado de la decisión no equivale a justificar por qué el personaje actuó así.",
            "3": "Trampa de dominio cruzado del SIEE: usar la pregunta de por qué para asistencia o participación comparable parece evidencia de clase. Cambia el objeto de comprensión por un trámite de lista o de nota oral.",
        },
    },
    {
        "id": "dir-apt-ped-294",
        "options": [
            "Aceptar el texto y la autoridad de la fuente sin cuestionar, como respeto a las lecturas del período y para no desautorizar al autor ante el grupo.",
            "Analizar, cuestionar y evaluar información y argumentos del texto antes de aceptarlos o rechazarlos, y no tomar la autoridad de la fuente como cierre automático.",
            "Memorizar más contenido del texto como «base» para criticar después, de modo que el análisis se posponga hasta que el grupo recuerde un mayor número de datos.",
            "Evitar desacuerdos con el docente como respeto al clima de la Ley 1620, y reportar la ausencia de contrapuntos como evidencia de convivencia en el Comité.",
        ],
        "explanation": "La condición de calidad pregunta qué implica principalmente promover el pensamiento crítico. El caso contrapone aceptar el texto sin cuestionar y memorizar más como presuntas bases. Analizar, cuestionar y evaluar argumentos antes de aceptar o rechazar es el núcleo pedido. Aceptar la autoridad de la fuente como respeto no es crítica. Posponer el análisis hasta memorizar más invierte el orden. Evitar desacuerdos con el docente por la Ley 1620 importa un clima de convivencia que no es el objeto del stem.",
        "normativeJustification": "Los EBC y DBA de lenguaje piden evaluar argumentos, no acatar la fuente. La Ley 1620 no convierte la ausencia de desacuerdo con el docente en pensamiento crítico.",
        "theoreticalJustification": "El pensamiento crítico examina razones antes de aceptar o rechazar. Memorizar más, acatar al autor o silenciar el contrapunto cambian el objeto de la competencia.",
        "distractorAnalysis": {
            "0": "Trampa del respeto a la fuente: aceptar el texto sin cuestionar parece cuidado documental. El caso lo rechaza: sin análisis no hay pensamiento crítico, hay adhesión a la autoridad.",
            "2": "Trampa de memorizar como base: acumular datos para criticar después parece rigor. Posponer el análisis invierte el orden y deja la crítica como trámite futuro.",
            "3": "Trampa de dominio cruzado de la Ley 1620: evitar desacuerdos con el docente parece clima de respeto. Importa convivencia del Comité y no la evaluación de argumentos que pide el stem.",
        },
    },
    {
        "id": "dir-apt-ped-295",
        "options": [
            "Aumentar la dificultad del ranking Saber con un relato largo, de modo que el contexto realista sirva sobre todo a diferenciar puntajes y no a aplicar lo enseñado.",
            "Evaluar la memoria del relato del contexto, pidiendo recordar nombres, cifras o anécdotas de la situación narrada más que aplicar el conocimiento disciplinar.",
            "Evaluar la capacidad de aplicar conocimientos y habilidades en una situación con sentido, como en un ítem tipo Saber o PISA, más allá de memorizar el relato.",
            "Reemplazar la enseñanza disciplinar por competencias del PMI, de modo que el contexto realista acredite innovación y haga innecesaria la malla de contenidos.",
        ],
        "explanation": "La condición de calidad pregunta qué busca principalmente un ítem que presenta un contexto realista antes de la pregunta. En clave Saber o PISA se evalúa aplicar conocimientos y habilidades en una situación con sentido. Alargar el relato para el ranking no es el propósito pedagógico del caso. Evaluar la memoria de nombres y anécdotas del contexto reduce el ítem a recuperación. Reemplazar la enseñanza disciplinar por el PMI de competencias cruza gestión de calidad con el objeto de la evaluación.",
        "normativeJustification": "Los lineamientos de evaluación de competencias (Saber) piden aplicar saber en contexto. El PMI no autoriza sustituir la malla disciplinar por el relato del ítem.",
        "theoreticalJustification": "Un ítem contextualizado mide transferencia, no memoria del relato ni ranking. El contexto da sentido a la tarea; no reemplaza la enseñanza del contenido.",
        "distractorAnalysis": {
            "0": "Trampa del ranking Saber: un relato largo parece subir la exigencia. Sirve a diferenciar puntajes y no a evaluar la aplicación de lo enseñado en una situación con sentido.",
            "1": "Trampa de la memoria del contexto: recordar nombres, cifras o anécdotas de la narración parece lectura atenta. Reduce el ítem a recuperación y no a aplicar conocimientos.",
            "3": "Trampa de dominio cruzado del PMI: reemplazar la enseñanza disciplinar por competencias acreditadas parece innovación de calidad. El caso pide aplicar lo enseñado, no hacer innecesaria la malla.",
        },
    },
    {
        "id": "dir-apt-ped-296",
        "options": [
            "Mantener la lectura silenciosa individual como autonomía, sin roles compartidos de predecir, cuestionar, aclarar o resumir, porque cada quien avanza a su ritmo.",
            "Recitar el texto en voz alta como fluidez, de modo que repetir el pasaje palabra por palabra se tome por comprensión lectora lograda en el grupo.",
            "Recibir preguntas cerradas del docente como ítems comparables del SIEE, sin que el estudiante asuma el rol de guiar la discusión de comprensión del texto.",
            "Asumir roles rotativos de predecir, cuestionar, aclarar y resumir, para guiar en colaboración la comprensión del texto y no quedarse en la copia silenciosa.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente a la enseñanza recíproca en esta clase de comprensión. Palincsar y Brown describen roles rotativos de predecir, cuestionar, aclarar y resumir en colaboración. La lectura silenciosa individual no comparte esos roles. Recitar el texto mide fluidez, no comprensión guiada. Las preguntas cerradas del docente como ítems del SIEE mantienen el control adulto y no rotan la mediación entre estudiantes.",
        "normativeJustification": "Los DBA de lectura piden estrategias de comprensión colaborativa. El SIEE no homologa preguntas cerradas del docente como enseñanza recíproca ni la recitación como comprensión.",
        "theoreticalJustification": "Reciprocal teaching rota predicción, pregunta, aclaración y resumen. Silencio individual, recitado o ítem cerrado cambian el objeto: de mediación compartida a autonomía, fluidez o prueba.",
        "distractorAnalysis": {
            "0": "Trampa de la autonomía silenciosa: leer cada quien a su ritmo parece respeto al proceso. Omite los roles rotativos de predecir, cuestionar, aclarar y resumir que definen la enseñanza recíproca.",
            "1": "Trampa de la fluidez: recitar el pasaje palabra por palabra parece dominio del texto. Mide reproducción oral y no la comprensión colaborativa con roles que pide el caso.",
            "2": "Trampa de dominio cruzado del SIEE: las preguntas cerradas del docente lucen como ítems comparables de comprensión. Mantienen el control adulto y no rotan la guía de la discusión entre estudiantes.",
        },
    },
    {
        "id": "dir-apt-ped-297",
        "options": [
            "Al apoyo temporal y ajustado del docente en la ZDP, que se retira de forma gradual cuando el estudiante gana autonomía y ya no necesita esa mediación.",
            "A una estructura física de educación física o del patio, como si el andamiaje ligado a la ZDP fuera un andamio material y no una mediación pedagógica.",
            "A un examen de cierre de año del SIEE que sostiene el aprendizaje al final, tomado como andamio porque concentra la evidencia comparable del período.",
            "A retirar el apoyo desde el primer día para que la evidencia sea homogénea y comparable, como pide coordinación, sin mediación ajustada a la ZDP.",
        ],
        "explanation": "La condición de calidad pregunta a qué se refiere principalmente el andamiaje ligado a la ZDP. Es un apoyo temporal y ajustado que se retira al ganar autonomía. Coordinación pide cero ayudas para comparar, y eso niega la mediación de Vygotsky. Confundirlo con un andamio físico de educación física es un homónimo. El examen de cierre del SIEE no es andamiaje. Retirar el apoyo desde el día uno homogeneiza evidencia y abandona la zona de desarrollo próximo.",
        "normativeJustification": "La mediación en la ZDP es apoyo ajustado y transitorio. El SIEE no puede homologar el examen de cierre ni la comparabilidad sin ayudas como andamiaje pedagógico.",
        "theoreticalJustification": "Wood, Bruner y Vygotsky definen scaffolding como apoyo que se retira. Un andamio del patio, un examen anual o cero ayuda desde el inicio son otros objetos.",
        "distractorAnalysis": {
            "1": "Trampa del andamio físico: la estructura de educación física o del patio parece el sentido literal de andamiaje. No es la mediación pedagógica ajustada a la ZDP que pide el stem.",
            "2": "Trampa del examen de cierre: concentrar evidencia al final del año parece sostener el aprendizaje. Es sumativa del SIEE, no apoyo temporal que se retira al ganar autonomía.",
            "3": "Trampa de dominio cruzado de la comparabilidad: retirar el apoyo desde el primer día parece equidad de evidencias, como pide coordinación. Homogeneiza la prueba y niega el andamiaje en la ZDP.",
        },
    },
    {
        "id": "dir-apt-ped-298",
        "options": [
            "Organizar el año alrededor del examen final del período, de modo que las preguntas del entorno queden al servicio de ensayar la prueba y no de articular áreas.",
            "Articular aprendizajes de distintas áreas alrededor de preguntas o problemáticas significativas del entorno, con planeación que integra el período de primaria.",
            "Dejar el período al currículo emergente, prescindiendo de la planeación docente, porque el proyecto nace del interés del grupo y no requiere una secuencia.",
            "Limitar el proyecto a una área como profundidad disciplinar del DBA, y reportarlo como indicador de rigor en el PMI, sin articular las demás áreas del entorno.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente un currículo por proyectos de aula en primaria. Articula aprendizajes de distintas áreas alrededor de preguntas significativas del entorno. Organizar el año en función del examen final reduce el proyecto a ensayo de prueba. Prescindir de la planeación como currículo emergente deja el período sin secuencia. Limitarlo a una área como rigor del DBA o del PMI niega la articulación que el caso describe.",
        "normativeJustification": "Los lineamientos de primaria y el PEI permiten integrar áreas en proyectos con planeación. El PMI y el DBA no autorizan recortar el proyecto a una asignatura ni al ensayo del examen.",
        "theoreticalJustification": "El currículo por proyectos articula áreas en torno a un problema del entorno. El examen como eje, la emergencia sin secuencia o una sola disciplina cambian ese objeto.",
        "distractorAnalysis": {
            "0": "Trampa del examen como eje: organizar el año alrededor de la prueba final parece preparación responsable. Las preguntas del entorno quedan al servicio del ensayo y no de articular áreas.",
            "2": "Trampa del currículo emergente: prescindir de la planeación porque el proyecto nace del interés parece respeto al grupo. Deja el período de primaria sin secuencia y contradice el caso.",
            "3": "Trampa de dominio cruzado del DBA y el PMI: limitar el proyecto a una área como profundidad disciplinar parece rigor de calidad. Niega la articulación de áreas alrededor del entorno que pide el stem.",
        },
    },
    {
        "id": "dir-apt-ped-299",
        "options": [
            "Mantener los mismos grupos fijos por lista durante el año, como vínculo cooperativo estable, sin variar la composición según la actividad o las necesidades.",
            "Formar grupos por orden alfabético de la lista, como equidad aleatoria, de modo que el apellido determine el equipo y no el propósito pedagógico de la tarea.",
            "Variar la composición de los grupos según el propósito de cada actividad y las necesidades del estudiantado, y no dejarlos fijos por lista o por capricho.",
            "Evitar el trabajo grupal para que toda evidencia del SIEE sea individual y comparable, argumentando que el equipo impide atribuir el desempeño a cada estudiante.",
        ],
        "explanation": "La condición de calidad pregunta en qué consiste principalmente el agrupamiento flexible como estrategia pedagógica. Variar la composición según el propósito de la actividad y las necesidades. Los grupos fijos por lista durante el año no se ajustan a la tarea. El orden alfabético simula equidad y no atiende el propósito. Evitar el trabajo grupal para evidencia individual del SIEE cruza calificación comparable con la organización pedagógica del caso.",
        "normativeJustification": "El DUA y la organización del aula permiten agrupar según la tarea y las necesidades. El SIEE no exige anular el trabajo grupal para que toda evidencia sea individual.",
        "theoreticalJustification": "El agrupamiento flexible cambia la composición según el propósito. Fijar por lista, alfabetizar o prohibir el equipo por comparabilidad son otros criterios.",
        "distractorAnalysis": {
            "0": "Trampa del vínculo fijo: mantener los mismos grupos por lista todo el año parece cooperación estable. No varía la composición según la actividad o las necesidades que definen lo flexible.",
            "1": "Trampa de la equidad alfabética: el orden de la lista parece imparcial. El apellido determina el equipo y no el propósito pedagógico de la tarea.",
            "3": "Trampa de dominio cruzado del SIEE: evitar el trabajo grupal para evidencia individual comparable parece rigor evaluativo. Cambia el objeto: de agrupar con propósito a anular el equipo por atribución de nota.",
        },
    },
    {
        "id": "dir-apt-ped-300",
        "options": [
            "Sustituir la evaluación escrita por la observación como evaluación auténtica, de modo que el registro de aula reemplace las pruebas del período.",
            "Observar de forma exclusiva la disciplina del manual de convivencia, y tomar la conducta visible como el objeto principal de la observación cualitativa.",
            "Dejar de registrar lo observado para no burocratizar el clima de aula, confiando en la memoria de la clase como evidencia suficiente del proceso de aprendizaje.",
            "Recoger información sobre procesos, actitudes y desempeños que los instrumentos escritos no evidencian, con registro que complementa y no reemplaza las pruebas.",
        ],
        "explanation": "La condición de calidad pregunta qué permite principalmente la observación como instrumento cualitativo. Recoge procesos, actitudes y desempeños que lo escrito no muestra, con registro. Sustituir las pruebas escritas como evaluación auténtica desborda el instrumento. Reducirla a la disciplina del manual cambia el objeto a convivencia. Dejar de registrar para no burocratizar deja el proceso sin evidencia que el caso exige.",
        "normativeJustification": "El Decreto 1290 admite técnicas cualitativas complementarias. El manual de convivencia no convierte la observación de aprendizajes en control disciplinario ni autoriza no registrar.",
        "theoreticalJustification": "La observación cualitativa documenta procesos no visibles en lo escrito. Reemplazar pruebas, mirar de forma exclusiva la disciplina o no registrar cambian su función de evidencia.",
        "distractorAnalysis": {
            "0": "Trampa de la evaluación auténtica como recambio: sustituir las pruebas escritas por la observación parece coherencia con el aula. El instrumento complementa; no reemplaza la evaluación del período.",
            "1": "Trampa de dominio cruzado del manual 1620: observar la disciplina como objeto principal parece seguimiento de convivencia. Cambia el foco de procesos y actitudes de aprendizaje por conducta del manual.",
            "2": "Trampa de no burocratizar: no registrar para cuidar el clima parece alivio de carga. El caso pide observación con registro; la memoria de la clase no sostiene el proceso.",
        },
    },
    {
        "id": "dir-apt-lec-301",
        "options": [
            "La independencia de las provincias que hoy conforman Colombia fue un proceso de más de una década, con avances y retrocesos, y no un hecho ocurrido en un único día.",
            "La independencia quedó lograda el 20 de julio de 1810 con el Grito de Independencia, de modo que esa fecha del calendario escolar agota el proceso descrito.",
            "La Patria Boba fortaleció la capacidad de resistencia frente a la reconquista española liderada por Pablo Morillo, al unir a las facciones criollas tras 1810.",
            "Simón Bolívar lideró la reconquista española y Pablo Morillo la campaña libertadora de 1819, según el mapa de actores que a veces se enseña en la efeméride escolar.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que la independencia no fue un hecho de un día, sino un proceso de más de una década, con avances y retrocesos. El 20 de julio de 1810 es un hito, no el logro acabado. Invertir la Patria Boba como fortalecimiento contradice que debilitó la resistencia. Intercambiar a Bolívar y Morillo importa un mapa de actores del currículo que el texto no sostiene.",
        "normativeJustification": "El ítem lee la idea principal del fragmento: proceso extendido hasta Boyacá 1819. No autoriza agotar la independencia en el 20 de julio ni invertir roles de Bolívar y Morillo.",
        "theoreticalJustification": "La idea principal sintetiza el proceso con avances y retrocesos. Un hito escolar, la inversión de la Patria Boba y la confusión de actores son inferencias ilegítimas.",
        "distractorAnalysis": {
            "1": "Trampa del detalle como idea principal: tomar el 20 de julio de 1810 como el logro acabado parece la fecha canónica del Grito. El texto lo sitúa como inicio de un proceso de más de una década, no como cierre.",
            "2": "Trampa de invertir la cláusula de la Patria Boba: afirmar que fortaleció la resistencia parece lectura patriótica. El pasaje dice que las luchas internas debilitaron la capacidad frente a Morillo.",
            "3": "Trampa de dominio cruzado del currículo y la efeméride: intercambiar a Bolívar (libertador) y Morillo (reconquista) es un error de actores que a veces circula en el mapa escolar. El texto no lo sostiene.",
        },
    },
    {
        "id": "dir-apt-lec-302",
        "options": [
            "Una alianza sólida entre las distintas facciones criollas, que reforzó la capacidad de resistencia frente a la reconquista española liderada por Pablo Morillo.",
            "Luchas internas entre distintas facciones criollas que debilitaron la capacidad de resistencia frente a la reconquista española liderada por Pablo Morillo.",
            "La consolidación definitiva del proceso de independencia, la que el texto sitúa en la Batalla de Boyacá de 1819, ya alcanzada durante la Patria Boba.",
            "La ausencia de conflictos internos, para una lectura cívica de la efeméride del 20 de julio en el acto escolar, que el SIEE reporta como convivencia histórica.",
        ],
        "explanation": "La condición de calidad pregunta qué caracterizó, según el texto, a la Patria Boba. El pasaje la describe como luchas internas entre facciones criollas que debilitaron la resistencia frente a la reconquista. Una alianza sólida invierte esa cláusula. Situar ahí la consolidación definitiva confunde el período con Boyacá 1819. La ausencia de conflictos para una efeméride cívica o el SIEE importa un relato escolar que el texto no afirma.",
        "normativeJustification": "El ítem pide la caracterización que el texto enuncia: luchas internas que debilitaron la resistencia. No autoriza la alianza, la consolidación de 1819 ni el relato cívico del SIEE.",
        "theoreticalJustification": "La Patria Boba se lee en la cláusula de facciones y debilitamiento. Invertirla, adelantar Boyacá o importar la efeméride cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de invertir las facciones: una alianza sólida que reforzó la resistencia parece cohesión criolla. El texto afirma luchas internas que debilitaron la capacidad frente a la reconquista de Morillo.",
            "2": "Trampa de adelantar Boyacá: situar la consolidación definitiva en la Patria Boba parece cierre del proceso. Esa consolidación el texto la reserva a la Batalla de Boyacá en 1819.",
            "3": "Trampa de dominio cruzado del SIEE y la efeméride: la ausencia de conflictos para un acto cívico del 20 de julio parece lectura escolar de convivencia. El pasaje caracteriza la Patria Boba por luchas internas, no por armonía.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI, {}))
