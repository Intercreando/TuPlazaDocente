# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ped-383..392 (posiciones 1131-1140)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1131_1140.json"
CI = {
    "dir-apt-ped-383": 2,
    "dir-apt-ped-384": 3,
    "dir-apt-ped-385": 0,
    "dir-apt-ped-386": 1,
    "dir-apt-ped-387": 2,
    "dir-apt-ped-388": 3,
    "dir-apt-ped-389": 0,
    "dir-apt-ped-390": 1,
    "dir-apt-ped-391": 2,
    "dir-apt-ped-392": 3,
}

ITEMS = [
    {
        "id": "dir-apt-ped-383",
        "options": [
            "Aplicar al episodio los estándares éticos de hoy como rúbrica de competencias ciudadanas del SIEE, para «formar en valores» sin situar las decisiones en el contexto de su época.",
            "Pedir simpatía afectiva con todos los personajes del episodio, como clima socioemocional que humaniza la historia y evita el malestar de distinguir comprensión contextual de identificación.",
            "Comprender las decisiones y acciones del pasado en el contexto de su época, con evidencia del episodio, sin anacronismo, sin simpatía automática y sin suspender el análisis crítico.",
            "Suspender el análisis crítico de las acciones para «respetar la fuente» y no politizar el período, como si la empatía histórica fuera ausencia de juicio sobre el episodio.",
        ],
        "explanation": "La condición de calidad pide la opción más defendible, con evidencia e instancia, sobre qué implica desarrollar empatía histórica. Esa empatía consiste en comprender decisiones y acciones del pasado en el contexto de su época, sin anacronismo, sin simpatía automática y sin suspender la crítica. Aplicar los estándares éticos de hoy como rúbrica de ciudadanas del SIEE forma en valores, pero juzga el episodio fuera de su tiempo. Pedir simpatía afectiva con todos los personajes humaniza el clima y confunde empatía con identificación. Suspender el juicio para respetar la fuente deja la comprensión histórica sin análisis.",
        "normativeJustification": "Los DBA de ciencias sociales piden situar decisiones en su época y contrastar fuentes, no anacronismo ni simpatía automática. El SIEE de ciudadanas no autoriza a juzgar el episodio con la ética de hoy como rúbrica comparable.",
        "theoreticalJustification": "La empatía histórica es comprensión contextual con crítica, no identificación afectiva ni suspensión del juicio. La rúbrica ética actual, la simpatía automática o el respeto acrítico a la fuente cambian el objeto.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del SIEE de ciudadanas: formar en valores con la ética de hoy parece evidencia comparable. Juzga el episodio con estándares actuales y no sitúa las decisiones en su época.",
            "1": "Trampa de la simpatía automática: pedir identificación afectiva con todos los personajes parece clima humanizador. Confunde empatía histórica con adhesión emocional y anula la distancia crítica del episodio.",
            "3": "Trampa del respeto a la fuente: suspender la crítica para no politizar parece prudencia. Convierte la empatía en ausencia de juicio y deja el episodio sin análisis de las acciones.",
        },
    },
    {
        "id": "dir-apt-ped-384",
        "options": [
            "Recitar las coordenadas de países como evidencia comparable de localización en el SIEE, para documentar cobertura del DBA de geografía sin leer escala ni simbología del mapa.",
            "Privilegiar el relato oral del barrio como territorio vivido y dejar el mapa como adorno del tablero, argumentando que la cartografía escolar aleja al estudiante de su entorno.",
            "Dibujar a mano alzada sin referencia de escala ni simbología, como producción artística del área, para que la creatividad compense la lectura cartográfica que el caso pide.",
            "Leer, interpretar y elaborar mapas comprendiendo escala, simbología y coordenadas, en lugar de recitar ubicaciones, prescindir del mapa o dibujar sin convenciones.",
        ],
        "explanation": "La condición de calidad pregunta qué implica principalmente la alfabetización cartográfica. El estudiante lee, interpreta y elabora mapas comprendiendo escala, simbología y coordenadas, no copia mapas ni memoriza coordenadas. Recitar ubicaciones como evidencia del SIEE documenta cobertura, no lectura del mapa. Privilegiar el relato del barrio y dejar el mapa como adorno desplaza la cartografía. Dibujar a mano alzada sin convenciones parece creatividad y omite escala y simbología.",
        "normativeJustification": "Los DBA de geografía piden leer y producir representaciones con escala, simbología y coordenadas. El SIEE no homologa recitar coordenadas ni el dibujo libre sin convenciones como alfabetización cartográfica.",
        "theoreticalJustification": "Alfabetizar en mapas es leer y elaborar con convenciones. Recitar, oralizar el barrio sin mapa o dibujar sin escala cambian el objeto: de cartografía a memoria, a relato o a trazo libre.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del SIEE: recitar coordenadas parece evidencia comparable de localización. Documenta cobertura del DBA y no enseña a leer escala ni simbología.",
            "1": "Trampa del territorio vivido: el relato oral del barrio parece pertinencia. Deja el mapa como adorno y no desarrolla leer, interpretar ni elaborar representaciones.",
            "2": "Trampa de la creatividad artística: dibujar a mano alzada sin escala parece producción. Omite simbología y coordenadas que el caso pide como alfabetización cartográfica.",
        },
    },
    {
        "id": "dir-apt-ped-385",
        "options": [
            "Comprender las relaciones entre fenómenos y su distribución espacial, y las escalas de análisis, en lugar de recitar ríos, aislar lo físico de lo humano o copiar mapas sin lectura propia.",
            "Recitar nombres de ríos y accidentes del DBA como cobertura para Saber, sin relacionarlos con población ni con las escalas de análisis del territorio que el caso señala.",
            "Separar geografía física y humana como rigor disciplinar, para no mezclar capas y así cuidar la pureza de cada eje del programa frente a las listas de ríos.",
            "Copiar mapas ya elaborados y reportarlos como indicador PMI de producción cartográfica de la IE, sin análisis propio de relaciones ni de escalas sobre el territorio.",
        ],
        "explanation": "La condición de calidad pregunta qué busca principalmente el pensamiento espacial en geografía. El estudiante comprende relaciones entre fenómenos, su distribución y las escalas de análisis, no listas de ríos aisladas. Recitar accidentes para Saber cubre nombres y omite población y escalas. Separar lo físico de lo humano parece rigor y bloquea las relaciones que el caso pide. Copiar mapas para el PMI documenta producción y no análisis espacial propio.",
        "normativeJustification": "Los DBA de geografía piden distribución, relaciones y escalas, no nomenclatura suelta. El PMI de producción cartográfica no autoriza a copiar mapas ni a recitar ríos como pensamiento espacial.",
        "theoreticalJustification": "El pensamiento espacial articula fenómenos en el espacio y elige escala. Memorizar nombres, aislar lo físico de lo humano o copiar mapas cambian el objeto: de relación a lista, a eje puro o a trámite de calidad.",
        "distractorAnalysis": {
            "1": "Trampa de la cobertura para Saber: recitar ríos y accidentes parece alfabetización geográfica. Omite población, distribución y escalas de análisis que el pensamiento espacial exige.",
            "2": "Trampa del rigor disciplinar: separar lo físico de lo humano parece no mezclar capas. Bloquea las relaciones espaciales que el caso pide frente a las listas de ríos.",
            "3": "Trampa de dominio cruzado del PMI: copiar mapas como producción cartográfica luce como indicador de calidad. No analiza relaciones ni escalas y deja el pensamiento espacial en trámite.",
        },
    },
    {
        "id": "dir-apt-ped-386",
        "options": [
            "Cubrir conocimientos teóricos sobre instituciones como alfabetización constitucional del DBA, sin práctica de participación ni dilemas del entorno que el reduccionismo de copiar la Constitución deja de lado.",
            "Desarrollar habilidades cognitivas, emocionales y comunicativas para participar de forma constructiva en una sociedad democrática, no recitar artículos ni imponer una militancia de aula.",
            "Adoptar una postura política específica como formación ética comprometida del grupo, de modo que el área oriente la militancia del curso en lugar de habilidades de participación.",
            "Evaluar la recitación de artículos de la Constitución con un quiz comparable del SIEE, como evidencia de ciudadanía sin habilidades de participación ni dilemas del entorno.",
        ],
        "explanation": "La condición de calidad pregunta qué buscan principalmente desarrollar las competencias ciudadanas del MEN frente al reduccionismo de copiar la Constitución o imponer militancia. Integran habilidades cognitivas, emocionales y comunicativas para participar de forma constructiva en una sociedad democrática. Cubrir instituciones como alfabetización del DBA deja la práctica de participación. Imponer una postura política convierte el área en militancia. El quiz de artículos del SIEE documenta recitación, no competencias.",
        "normativeJustification": "El MEN define competencias ciudadanas como cognitivas, emocionales y comunicativas para la participación democrática. El DBA constitucional y el SIEE no homologan recitar artículos ni imponer militancia como esas competencias.",
        "theoreticalJustification": "Ciudadanía escolar es saber, sentir y comunicar para participar. Teoría institucional sin práctica, militancia de aula o quiz de artículos cambian el objeto: de competencia a cobertura, a adhesión o a nota.",
        "distractorAnalysis": {
            "0": "Trampa de la alfabetización constitucional: cubrir instituciones del DBA parece rigor ciudadano. Omite práctica de participación y dilemas del entorno que el MEN pide integrar.",
            "2": "Trampa de la formación comprometida: imponer una postura política parece ética pública. Convierte el área en militancia y no desarrolla habilidades para participar de forma constructiva.",
            "3": "Trampa de dominio cruzado del SIEE: el quiz de artículos de la Constitución luce como evidencia comparable de ciudadanía. Documenta recitación, no habilidades cognitivas, emocionales y comunicativas.",
        },
    },
    {
        "id": "dir-apt-ped-387",
        "options": [
            "Retirar el conflicto de las noticias de la unidad para proteger el clima de la Ley 1620 y no polarizar al grupo, dejando el tema controvertido fuera del análisis de sociales.",
            "Presentar la opinión del docente como orientación experta del adulto responsable, para que el grupo no se pierda entre voces y cierre el conflicto de las noticias con una tesis institucional.",
            "Presentar distintas perspectivas fundamentadas sobre el conflicto de las noticias, fomentando análisis crítico sin que el docente ni quien habla más fuerte impongan la tesis.",
            "Ceder el cierre del tema a quien habla con más fuerza en el gobierno escolar, y registrar esa voz como indicador PMI de participación estudiantil de la IE.",
        ],
        "explanation": "La condición de calidad pide la recomendación didáctica más defendible al enseñar un tema controvertido. Corresponde presentar perspectivas fundamentadas y fomentar análisis crítico, sin que el docente ni el más fuerte impongan la tesis. Retirar el conflicto de las noticias para proteger el clima 1620 evita polarizar y también evita el análisis. Imponer la opinión del docente parece orientación experta y cierra el debate. Ceder el cierre al gobierno escolar y reportarlo al PMI documenta voz estudiantil, no la enseñanza del tema controvertido.",
        "normativeJustification": "Los DBA de sociales y la formación ciudadana piden análisis de controversias con perspectivas fundamentadas. La Ley 1620 y el PMI de participación no autorizan a silenciar el tema ni a que el más fuerte cierre la tesis.",
        "theoreticalJustification": "Didáctica de lo controvertido es pluralidad argumentada, no silencio, no tesis del adulto ni voz del más fuerte. Clima 1620, orientación experta o PMI de participación cambian el objeto de la recomendación.",
        "distractorAnalysis": {
            "0": "Trampa del clima 1620: retirar el conflicto de las noticias parece proteger la convivencia. Deja el tema controvertido fuera del análisis y no presenta perspectivas fundamentadas.",
            "1": "Trampa de la orientación experta: la opinión del docente como tesis institucional parece no perder al grupo. Impone una postura y contradice el análisis crítico que el caso pide.",
            "3": "Trampa de dominio cruzado del PMI y el gobierno escolar: ceder el cierre a quien habla más fuerte luce como participación estudiantil. Documenta volumen de voz, no perspectivas fundamentadas.",
        },
    },
    {
        "id": "dir-apt-ped-388",
        "options": [
            "Recitar las definiciones de la unidad como base conceptual previa, sin un ejemplo concreto ni una decisión fundada en evidencia de la situación real o realista del caso.",
            "Aplicar pruebas estandarizadas de selección múltiple y reportarlas como evidencia comparable del SIEE, sin analizar una situación real o realista en profundidad.",
            "Acotar la clase al temario del DBA y no salirse hacia situaciones del entorno, para cubrir estándares sin el análisis en profundidad que el estudio de caso exige.",
            "Analizar en profundidad una situación real o realista para desarrollar análisis y toma de decisiones con evidencia, no un quiz secreto ni un promedio vacío de la unidad.",
        ],
        "explanation": "La condición de calidad pregunta en qué consiste principalmente el método de estudio de caso en ciencias sociales. Consiste en analizar en profundidad una situación real o realista para decidir con evidencia, no en recitar definiciones ni en un quiz secreto. Recitar conceptos como base previa deja el caso sin decisión. Las pruebas del SIEE documentan cobertura comparable y omiten el análisis situado. Acotar el DBA para no salirse del temario cubre estándares y evita el entorno.",
        "normativeJustification": "Los DBA de sociales piden análisis de situaciones y toma de decisiones con evidencia. El SIEE y la cobertura del temario no convierten un quiz ni la recitación de definiciones en estudio de caso.",
        "theoreticalJustification": "El caso es análisis situado y decisión fundada. Definiciones previas, prueba estandarizada o temario cerrado cambian el objeto: de caso a glosario, a ítem secreto o a cobertura.",
        "distractorAnalysis": {
            "0": "Trampa de la base conceptual: recitar definiciones antes del ejemplo parece rigor. Deja la situación sin análisis en profundidad ni decisión con evidencia.",
            "1": "Trampa de dominio cruzado del SIEE: las pruebas de selección múltiple lucen como evidencia comparable. Sustituyen el caso por un quiz y no analizan una situación real o realista.",
            "2": "Trampa del temario cerrado: no salirse del DBA parece cobertura responsable. Evita situaciones del entorno y niega el estudio de caso que el enunciado pide.",
        },
    },
    {
        "id": "dir-apt-ped-389",
        "options": [
            "Aprendizaje basado en problemas aplicado a las ciencias sociales: investigar un problema real del barrio y proponer acciones, no un quiz memorístico ni un tema desconectado de la comunidad.",
            "Convertir el proyecto del barrio en evaluación memorística de contenidos teóricos del DBA, para asegurar cobertura antes de cualquier acción en la comunidad.",
            "Recentrar la unidad en un tema nacional desconectado de la comunidad, como rigor académico que no provincializa el DBA de sociales ni el problema del barrio.",
            "Reportar las acciones en el barrio como indicador PMI o PRAE de proyección a la comunidad, sin el ciclo de indagación y propuesta que define el aprendizaje basado en problemas.",
        ],
        "explanation": "La condición de calidad pregunta de qué es ejemplo un proyecto que investiga y propone soluciones a una problemática social real de la comunidad. Es aprendizaje basado en problemas aplicado a las ciencias sociales, anclado al barrio, no un quiz memorístico. Convertirlo en evaluación teórica del DBA asegura cobertura y apaga la indagación. Recentrar en un tema nacional desconectado parece rigor y niega la comunidad. Reportarlo al PMI o al PRAE documenta proyección, no el ciclo de ABP.",
        "normativeJustification": "Los DBA de sociales y la formación ciudadana respaldan investigar problemas reales y proponer acciones. El PMI, el PRAE y el SIEE memorístico no sustituyen el ABP por cobertura o por un indicador de proyección.",
        "theoreticalJustification": "El ABP articula problema, indagación y propuesta en contexto. Quiz del DBA, tema nacional desconectado o reporte PMI o PRAE cambian el objeto: de problema a cobertura, a temario o a trámite de calidad.",
        "distractorAnalysis": {
            "1": "Trampa de la cobertura del DBA: volver el proyecto memorístico parece asegurar contenidos. Apaga la indagación del problema real del barrio que define el ABP.",
            "2": "Trampa del rigor nacional: desconectar el tema de la comunidad parece no provincializar el DBA. Niega el problema del barrio que el caso presenta como objeto del proyecto.",
            "3": "Trampa de dominio cruzado del PMI y el PRAE: reportar acciones como proyección a la comunidad luce como calidad institucional. Documenta gestión, no el ciclo de indagación y propuesta del ABP.",
        },
    },
    {
        "id": "dir-apt-ped-390",
        "options": [
            "Abrir la palabra sin orden ni tiempo definido, como participación espontánea más democrática, frente a un debate que en el caso se reduce a hablar más fuerte sin evidencia.",
            "Establecer roles, tiempos y reglas claras, exigiendo argumentar las posturas con evidencia, en lugar de premiar el volumen de voz o prescindir de preparación de fuentes.",
            "Evaluar quién sostiene más tiempo la palabra como liderazgo oral del período, homologando persistencia y volumen con argumentación sobre el tema de sociales.",
            "Registrar el debate como evidencia comparable de participación en el SIEE o en el gobierno escolar, premiando la intervención visible más que la argumentación con fuentes.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente al debate estructurado en ciencias sociales. Se fijan roles, tiempos y reglas, y se exige argumentar con evidencia, no hablar más fuerte. Abrir la palabra sin orden parece democracia espontánea y reproduce el volumen que el caso critica. Premiar quién habla más tiempo confunde liderazgo oral con argumento. Registrar el debate en el SIEE o en el gobierno escolar documenta participación visible, no estructura ni fuentes.",
        "normativeJustification": "Los DBA de sociales piden argumentación con evidencia y participación regulada. El SIEE y el gobierno escolar no homologan el volumen de voz ni la intervención visible como debate estructurado.",
        "theoreticalJustification": "El debate estructurado es regla, rol y prueba. Espontaneidad sin turno, premio al volumen o evidencia de participación institucional cambian el objeto: de argumento a clima, a liderazgo o a trámite.",
        "distractorAnalysis": {
            "0": "Trampa de la democracia espontánea: hablar sin orden ni tiempo parece participación genuina. Reproduce el hablar más fuerte que el caso describe y omite evidencia y reglas.",
            "2": "Trampa del liderazgo oral: premiar quién sostiene la palabra parece valorar participación. Homologa volumen con argumentación y no exige fuentes ni roles.",
            "3": "Trampa de dominio cruzado del SIEE y el gobierno escolar: registrar el debate como participación comparable luce institucional. Premia intervención visible, no argumentación con evidencia.",
        },
    },
    {
        "id": "dir-apt-ped-391",
        "options": [
            "Memorizar el guion del juicio o de la sesión legislativa como calidad de la representación, sin comprender las instituciones ni los procesos que el rol debería hacer visibles.",
            "Evitar el análisis crítico del proceso representado para no romper la ficción del rol y así proteger el clima lúdico de la simulación de juicio o de sesión legislativa.",
            "Comprender de forma vivencial instituciones o procesos, asumiendo roles y perspectivas, no memorizar un guion ni consignar la simulación como reemplazo de toda evaluación del período.",
            "Consignar la simulación del juicio o de la sesión legislativa como evidencia comparable del período en el SIEE, de modo que el desempeño del rol homologue el aprendizaje de la unidad.",
        ],
        "explanation": "La condición de calidad pregunta qué busca principalmente la simulación de un juicio o sesión legislativa. Busca comprensión vivencial de instituciones o procesos al asumir roles y perspectivas, no memorizar un guion ni reemplazar la evaluación del período. Memorizar el guion parece calidad representativa y vacía el contenido. Evitar el análisis para no romper la ficción protege el juego y omite la crítica. Consignarla en el SIEE como evidencia del período convierte el rol en nota única de la unidad.",
        "normativeJustification": "Los DBA de sociales y de competencias ciudadanas respaldan comprender instituciones mediante roles. El SIEE no autoriza a sustituir el período por el desempeño del guion ni a anular el análisis crítico del proceso.",
        "theoreticalJustification": "La simulación es comprensión situada por rol, no teatro de memoria ni trámite de nota. Guion memorizado, ficción intocable o evidencia SIEE del período cambian el propósito del juicio o de la sesión.",
        "distractorAnalysis": {
            "0": "Trampa de la calidad representativa: memorizar el guion parece profesionalizar el juicio o la sesión. Vacía la comprensión de instituciones y procesos que el rol debería hacer visibles.",
            "1": "Trampa de la ficción intocable: evitar el análisis crítico parece no romper el clima lúdico. Deja la simulación sin lectura del proceso representado.",
            "3": "Trampa de dominio cruzado del SIEE: consignar la simulación como evidencia del período luce comparable. Homologa el desempeño del rol con todo el aprendizaje y reemplaza otras valoraciones de la unidad.",
        },
    },
    {
        "id": "dir-apt-ped-392",
        "options": [
            "Memorizar la biografía del caricaturista y reportarla como evidencia del DBA de artes o del PMI de producción artística, sin interpretar mensajes, símbolos ni posturas de la viñeta.",
            "Leer la caricatura política como lenguaje visual puro, sin contexto histórico o político, para no contaminar la imagen con la coyuntura del episodio que el caso sitúa.",
            "Limitarse a describir rayas, colores y composición como observación objetiva previa, sin interpretar el mensaje sintético que la caricatura política permite leer.",
            "Desarrollar análisis crítico al interpretar mensajes, símbolos y posturas expresados de forma sintética en la caricatura política, no describir rayas ni memorizar al autor.",
        ],
        "explanation": "La condición de calidad pregunta qué permite principalmente el uso didáctico de caricaturas políticas. Permite análisis crítico al interpretar mensajes, símbolos y posturas de forma sintética, no describir rayas ni memorizar al autor. Reportar la biografía al DBA de artes o al PMI desplaza la viñeta a otro dominio. Leerla como lenguaje visual puro omite el contexto político. Describir rayas parece observación objetiva y deja el mensaje sin interpretación.",
        "normativeJustification": "Los DBA de ciencias sociales piden interpretar fuentes visuales en su coyuntura. El DBA de artes y el PMI de producción artística no convierten la ficha del autor ni la descripción de rayas en análisis de la caricatura política.",
        "theoreticalJustification": "La caricatura es fuente sintética de posturas. Biografía de artes, imagen pura o inventario de rayas cambian el objeto: de mensaje político a autor, a forma o a descripción.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del DBA de artes y del PMI: la biografía del caricaturista luce como producción artística de calidad. Desplaza la interpretación de mensajes y símbolos de la viñeta.",
            "1": "Trampa del lenguaje visual puro: omitir el contexto histórico o político parece no contaminar la imagen. Deja la caricatura sin la coyuntura que el caso pide interpretar.",
            "2": "Trampa de la observación objetiva: describir rayas y composición parece rigor perceptual. Omite el mensaje sintético y las posturas que el recurso didáctico debe hacer visibles.",
        },
    },
]

if __name__ == "__main__":
    raise SystemExit(dump_and_report(OUT, ITEMS, CI, n_items=10))
