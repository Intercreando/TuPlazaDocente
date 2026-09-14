# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ped-393..400 (posiciones 1141-1148)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1141_1148.json"
CI = {
    "dir-apt-ped-393": 0,
    "dir-apt-ped-394": 1,
    "dir-apt-ped-395": 2,
    "dir-apt-ped-396": 3,
    "dir-apt-ped-397": 0,
    "dir-apt-ped-398": 1,
    "dir-apt-ped-399": 2,
    "dir-apt-ped-400": 3,
}

ITEMS = [
    {
        "id": "dir-apt-ped-393",
        "options": [
            "Reconocer la pluralidad de voces y experiencias, incluidas las de las víctimas, evitando relatos únicos o simplificados, y no reducir el conflicto armado a una versión oficial ni a un quiz de fechas.",
            "Presentar una versión oficial del conflicto armado, sin contrastar fuentes, para no polarizar al grupo y alinear la unidad con el discurso institucional de la IE.",
            "Omitir las voces de las víctimas para no politizar la clase y preservar una aparente neutralidad pedagógica frente al conflicto armado que el texto único pretende cerrar.",
            "Evaluar la unidad con un quiz de fechas y batallas como evidencia comparable del SIEE, sin análisis de relatos ni de la pluralidad de voces, incluidas las de las víctimas.",
        ],
        "explanation": "La condición de calidad pregunta qué implica principalmente abordar la memoria histórica del conflicto armado con responsabilidad pedagógica. Implica reconocer la pluralidad de voces y experiencias, incluidas las de las víctimas, y evitar relatos únicos o simplificados. Una versión oficial sin contrastar fuentes alinea el discurso institucional y cierra el debate. Omitir a las víctimas para no politizar finge neutralidad. El quiz de fechas del SIEE documenta cobertura y no analiza relatos.",
        "normativeJustification": "La Cátedra de la Paz, los DBA de sociales y el enfoque de memoria piden pluralidad de voces y lugar de las víctimas. El SIEE no homologa un quiz de fechas ni una versión oficial como abordaje responsable del conflicto armado.",
        "theoreticalJustification": "Memoria histórica responsable es pluralidad y víctimas, no relato único. Versión oficial, omisión por neutralidad o quiz de fechas cambian el objeto: de memoria a alineación, a silencio o a nota.",
        "distractorAnalysis": {
            "1": "Trampa de la alineación institucional: una versión oficial sin contrastar fuentes parece no polarizar. Cierra el conflicto armado en un relato único y omite la pluralidad que la responsabilidad pedagógica exige.",
            "2": "Trampa de la neutralidad: omitir a las víctimas para no politizar parece prudencia de aula. Silencia experiencias centrales de la memoria histórica y deja el texto único sin contrapunto.",
            "3": "Trampa de dominio cruzado del SIEE: el quiz de fechas y batallas luce como evidencia comparable. Sustituye el análisis de relatos y de voces, incluidas las de las víctimas, por cobertura de datos.",
        },
    },
    {
        "id": "dir-apt-ped-394",
        "options": [
            "Imponer la cultura de referencia del PEI como referente válido para todo el grupo, a fin de no fragmentar la identidad institucional del aula ni la diversidad que el caso describe.",
            "Promover reconocimiento, diálogo y respeto entre distintas culturas del aula y de la sociedad, sin silenciar la diversidad ni recortar el currículo a la cultura propia de cada estudiante.",
            "Unificar el currículo en un relato cultural del DBA nacional, para no dispersar la unidad con la diversidad presente en el aula y sostener un eje común de sociales.",
            "Limitar el estudio a la cultura propia de cada estudiante y reportarlo como indicador PMI de pertinencia etnoeducativa, sin diálogo intercultural entre las culturas del aula.",
        ],
        "explanation": "La condición de calidad pide la opción más defendible, con evidencia e instancia, sobre qué busca principalmente la educación intercultural en ciencias sociales. Busca reconocimiento, diálogo y respeto entre culturas del aula y de la sociedad, no imponer una cultura de referencia ni silenciar la diversidad. El PEI como referente único unifica identidad y apaga el diálogo. El relato del DBA nacional parece eje común y dispersa menos, pero oculta al aula. El PMI de pertinencia etnoeducativa documenta lo propio y omite el entre-culturas.",
        "normativeJustification": "Los DBA de sociales, el PEI inclusivo y la etnoeducación piden diálogo entre culturas presentes, no un referente único. El PMI de pertinencia no autoriza a recortar el estudio a la cultura propia ni a silenciar la diversidad del aula.",
        "theoreticalJustification": "Interculturalidad es reconocimiento y diálogo, no fusión en una cultura de referencia. PEI único, DBA nacional homogeneizado o PMI de lo propio cambian el objeto: de diálogo a identidad, a eje o a trámite.",
        "distractorAnalysis": {
            "0": "Trampa de la identidad institucional: imponer la cultura de referencia del PEI parece no fragmentar el aula. Silencia la diversidad y niega el diálogo que la educación intercultural busca.",
            "2": "Trampa del eje nacional: unificar el currículo en el DBA parece no dispersar la unidad. Oculta las culturas del aula y convierte el diálogo en un relato homogéneo.",
            "3": "Trampa de dominio cruzado del PMI: limitar el estudio a la cultura propia como pertinencia etnoeducativa luce como calidad. Omite el diálogo entre culturas y recorta el currículo a lo propio de cada estudiante.",
        },
    },
    {
        "id": "dir-apt-ped-395",
        "options": [
            "Aceptar las cadenas de redes como material actualizado de la unidad, confiando en la circulación masiva como señal de relevancia ciudadana para el análisis de sociales.",
            "Retirar medios y redes de la clase para proteger al grupo según la Ley 1620 frente al ciberacoso, y trabajar con el texto escolar como fuente segura de la unidad.",
            "Analizar críticamente origen, intención y confiabilidad de la información en medios y redes, no aceptar cadenas, no prohibir medios ni calificar el uso del celular.",
            "Calificar un promedio de uso de celular como evidencia comparable del SIEE, sin análisis de origen, intención ni confiabilidad de las cadenas que circulan en redes.",
        ],
        "explanation": "La condición de calidad pregunta qué implica principalmente desarrollar alfabetización mediática. Implica enseñar a analizar origen, intención y confiabilidad de la información en medios y redes, no aceptar cadenas ni prohibir medios. Confiar en la circulación masiva trata la cadena como material actualizado y omite el filtro. Retirar medios por la Ley 1620 protege frente al ciberacoso y también retira el objeto de análisis. El promedio de uso de celular del SIEE documenta dispositivo, no lectura crítica.",
        "normativeJustification": "Los DBA de sociales y de lenguaje piden análisis crítico de fuentes mediáticas. La Ley 1620 y el SIEE no convierten la prohibición de redes ni el promedio de celular en alfabetización mediática.",
        "theoreticalJustification": "Alfabetizar en medios es preguntar origen, intención y fiabilidad. Aceptar cadenas, prohibir medios o notar el celular cambian el objeto: de análisis a confianza, a retiro o a trámite de nota.",
        "distractorAnalysis": {
            "0": "Trampa de la relevancia ciudadana: aceptar cadenas por su circulación masiva parece actualizar la unidad. Omite origen, intención y confiabilidad que la alfabetización mediática exige.",
            "1": "Trampa de la protección 1620: retirar medios y redes parece cuidar al grupo frente al ciberacoso. Deja el texto escolar como fuente única y retira el objeto que se debía analizar.",
            "3": "Trampa de dominio cruzado del SIEE: el promedio de uso de celular luce como evidencia comparable. Documenta el dispositivo y no el análisis de las cadenas que circulan en redes.",
        },
    },
    {
        "id": "dir-apt-ped-396",
        "options": [
            "Sustituir de forma permanente el trabajo de aula por salidas, y reportarlo como indicador PMI de escuela abierta al territorio, sin el complemento teórico que el caso pide.",
            "Evaluar sobre todo la conducta fuera del aula con el manual de convivencia de la Ley 1620, homologando compostura en el recorrido con el análisis del fenómeno social o geográfico.",
            "Dejar la ruta al descubrimiento espontáneo del barrio, sin guía de observación, para no escolarizar la salida y preservar autenticidad frente a un paseo sin planeación.",
            "Observar y analizar fenómenos sociales o geográficos en su contexto real, complementando el aula, no un paseo sin planeación ni una nota de conducta del recorrido.",
        ],
        "explanation": "La condición de calidad pregunta qué permiten principalmente las salidas pedagógicas o el trabajo de campo. Permiten observar y analizar fenómenos sociales o geográficos en contexto real, complementando el aula, no un paseo sin planeación ni una nota de conducta. Reportar la salida permanente al PMI de escuela abierta documenta territorio y apaga el aula. Evaluar conducta con la Ley 1620 homologa compostura con análisis. La ruta espontánea sin guía parece autenticidad y reproduce el paseo sin planeación.",
        "normativeJustification": "Los DBA de geografía y de sociales piden observación situada que complementa el aula. El PMI de escuela abierta y la Ley 1620 no convierten la salida en reemplazo permanente del aula ni en nota de conducta.",
        "theoreticalJustification": "El trabajo de campo es observación analítica planeada en contexto. PMI de territorio, nota 1620 o descubrimiento sin guía cambian el objeto: de análisis a indicador, a convivencia o a paseo.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del PMI: sustituir el aula por salidas como escuela abierta luce como calidad territorial. Omite el complemento teórico y convierte la salida en reemplazo permanente.",
            "1": "Trampa de la convivencia 1620: evaluar la conducta del recorrido parece orden institucional. Homologa compostura con análisis del fenómeno social o geográfico que el campo debe permitir.",
            "2": "Trampa de la autenticidad: dejar la ruta al descubrimiento sin guía parece no escolarizar. Reproduce el paseo sin planeación que el caso critica y niega la observación analítica.",
        },
    },
    {
        "id": "dir-apt-ped-397",
        "options": [
            "Analizar y visualizar información geográfica en capas, relacionando variables sobre un mismo territorio, no memorizar satélites ni prohibir el mapa en papel ni tratar el SIG como software ajeno a sociales.",
            "Memorizar el funcionamiento técnico de los satélites como alfabetización STEM del DBA de tecnología, desplazando las capas y las variables del territorio que el SIG hace visibles.",
            "Tratar el SIG como software de sistemas ajeno a sociales y evitar el análisis espacial, para no invadir el área de informática y dejar el mapa en papel como único recurso.",
            "Reemplazar los mapas en papel en todas las actividades y reportarlo como indicador PMI de innovación digital de la IE, como si el SIG anulara las representaciones analógicas.",
        ],
        "explanation": "La condición de calidad pregunta qué permite principalmente el uso de herramientas básicas de SIG. Permite analizar y visualizar información geográfica en capas, relacionando variables sobre un mismo territorio, no teoría de satélites ni prohibir el mapa en papel. Memorizar satélites como STEM del DBA de tecnología desplaza las capas. Tratar el SIG como software ajeno a sociales evita el análisis espacial. Reportar el reemplazo del papel al PMI documenta innovación digital, no lectura de capas.",
        "normativeJustification": "Los DBA de geografía respaldan capas y relación de variables sobre un territorio. El DBA de tecnología y el PMI de innovación digital no convierten satélites ni el retiro del mapa en papel en uso didáctico del SIG.",
        "theoreticalJustification": "El SIG escolar es capas y variables sobre un mismo territorio. Teoría de satélites, software de sistemas o PMI digital cambian el objeto: de análisis espacial a STEM, a informática o a trámite de innovación.",
        "distractorAnalysis": {
            "1": "Trampa de la alfabetización STEM: memorizar satélites parece rigor tecnológico. Desplaza las capas y las variables del territorio que el SIG debe hacer visibles en sociales.",
            "2": "Trampa del software ajeno: evitar el análisis espacial para no invadir informática parece respeto de áreas. Deja el SIG fuera de sociales y el mapa en papel como recurso sin capas.",
            "3": "Trampa de dominio cruzado del PMI: reemplazar el mapa en papel como innovación digital luce institucional. Anula representaciones analógicas y no enseña a relacionar variables en capas.",
        },
    },
    {
        "id": "dir-apt-ped-398",
        "options": [
            "Limitar los derechos humanos a una clase aislada de Cátedra de la Paz, para cumplir el indicador de cobertura anual sin leer historia, política y sociedad a la luz de la dignidad.",
            "Analizar contenidos históricos, políticos y sociales en relación con la dignidad humana y los derechos fundamentales, de manera transversal, no en una clase aislada ni en un quiz de artículos.",
            "Dejar el enfoque como autoevaluación de caritas socioemocionales, sin análisis de casos, como trámite de clima de aula que sustituye la lectura de historia y política a la luz de la dignidad.",
            "Sustituir el análisis por un examen sorpresa de artículos en el SIEE, como evidencia comparable de derechos humanos sin transversalidad ni casos de historia, política y sociedad.",
        ],
        "explanation": "La condición de calidad pregunta qué implica principalmente incorporar un enfoque de derechos humanos en sociales. Implica analizar contenidos históricos, políticos y sociales a la luz de la dignidad y los derechos fundamentales, de manera transversal, no en una clase aislada ni con más quizzes. Cumplir la Cátedra de la Paz en una sesión cubre el indicador y apaga la transversalidad. Las caritas socioemocionales tramitan clima sin casos. El examen sorpresa del SIEE documenta artículos, no enfoque.",
        "normativeJustification": "La Cátedra de la Paz y los DBA de sociales piden un enfoque transversal de dignidad y derechos, no una sesión aislada. El SIEE no homologa el quiz de artículos ni las caritas como incorporación del enfoque.",
        "theoreticalJustification": "Derechos humanos en sociales es lente transversal sobre historia y política. Clase aislada, caritas de clima o examen sorpresa cambian el objeto: de enfoque a cobertura, a trámite socioemocional o a nota.",
        "distractorAnalysis": {
            "0": "Trampa de la cobertura de Cátedra de la Paz: una clase aislada parece cumplir el indicador anual. Deja historia, política y sociedad sin la lente de la dignidad que el enfoque exige.",
            "2": "Trampa del clima socioemocional: las caritas sin análisis de casos parecen formación en derechos. Sustituyen la lectura de contenidos por un trámite de aula y omiten la transversalidad.",
            "3": "Trampa de dominio cruzado del SIEE: el examen sorpresa de artículos luce como evidencia comparable. Documenta recitación y no el análisis transversal de historia, política y sociedad.",
        },
    },
    {
        "id": "dir-apt-ped-399",
        "options": [
            "Valorar sobre todo la extensión del texto como evidencia de producción escrita del SIEE, homologando cantidad de páginas con la calidad argumentativa del ensayo sobre el tema social.",
            "Premiar que el ensayo coincida con la opinión personal del docente, como coherencia con el criterio experto de la unidad y cierre de la controversia del tema social.",
            "Valorar la claridad de la tesis, la solidez de los argumentos y el uso de evidencia para sustentarlos, no la extensión, la coincidencia con el docente ni la ortografía como eje de la nota.",
            "Ponderar de forma preponderante la ortografía según el DBA de lenguaje y reportarla como evidencia comparable de calidad textual, sin el contenido argumentativo del tema social.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente al evaluar un ensayo argumentativo sobre un tema social. Lo defendible es valorar claridad de la tesis, solidez de los argumentos y uso de evidencia. Medir la extensión como producción del SIEE homologa páginas con argumento. Premiar la coincidencia con el docente cierra la controversia con la opinión del adulto. Ponderar la ortografía del DBA de lenguaje desplaza el objeto a otra área y deja el contenido social sin juicio.",
        "normativeJustification": "El Decreto 1290 y el SIEE piden criterios alineados al desempeño, aquí argumentar con evidencia. El DBA de lenguaje no autoriza a que la ortografía reemplace tesis, argumentos y fuentes del ensayo de sociales.",
        "theoreticalJustification": "Un ensayo se valora por tesis, argumentos y evidencia. Extensión, coincidencia con el docente u ortografía como eje cambian el objeto: de argumentación a cantidad, a adhesión o a norma de lengua.",
        "distractorAnalysis": {
            "0": "Trampa de la producción escrita: valorar la extensión parece evidencia comparable del SIEE. Homologa páginas con calidad argumentativa y no examina tesis ni fuentes del tema social.",
            "1": "Trampa del criterio experto: premiar la coincidencia con el docente parece coherencia de unidad. Convierte la evaluación en adhesión a la opinión del adulto y cierra la controversia.",
            "3": "Trampa de dominio cruzado del DBA de lenguaje: ponderar la ortografía como calidad textual luce institucional. Desplaza el ensayo de sociales y deja sin valorar tesis, argumentos y evidencia.",
        },
    },
    {
        "id": "dir-apt-ped-400",
        "options": [
            "Memorizar indicadores macroeconómicos de muchos países como cobertura del DBA de geografía económica, sin decisiones cotidianas de ahorro y consumo responsable que el caso sitúa en básicas.",
            "Ensayar inversión bursátil desde la básica y reportarlo como indicador PMI de emprendimiento de la IE, como si el aula de sociales fuera un simulador de bolsa.",
            "Mantener la unidad en modelos macro desconectados de la vida cotidiana, para no infantilizar el rigor económico del área ni bajarlo a ahorro y consumo del estudiante.",
            "Desarrollar conocimientos y habilidades básicas para decisiones económicas informadas de ahorro y consumo responsable, no memorizar el PIB de muchos países ni jugar a la bolsa.",
        ],
        "explanation": "La condición de calidad pregunta qué busca principalmente la educación económica y financiera básica, transversal en sociales. Busca conocimientos y habilidades para decisiones cotidianas informadas de ahorro y consumo responsable, no memorizar el PIB ni jugar a la bolsa. Memorizar indicadores del DBA cubre geografía económica y omite la vida cotidiana. El PMI de emprendimiento convierte el aula en simulador bursátil. Mantener modelos macro para no infantilizar parece rigor y desconecta al estudiante de sus decisiones.",
        "normativeJustification": "La educación económica y financiera del MEN en básicas prioriza decisiones cotidianas informadas. El DBA de indicadores y el PMI de emprendimiento no autorizan a memorizar el PIB ni a simular la bolsa como propósito principal.",
        "theoreticalJustification": "En básicas, lo económico se enseña como decisión cotidiana informada. Cobertura de indicadores, PMI bursátil o macro desconectado cambian el objeto: de ahorro y consumo a lista, a bolsa o a modelo abstracto.",
        "distractorAnalysis": {
            "0": "Trampa de la cobertura macro: memorizar indicadores de muchos países parece alfabetización económica. Omite ahorro y consumo responsable que el caso sitúa como propósito en básicas.",
            "1": "Trampa de dominio cruzado del PMI: ensayar inversión bursátil como emprendimiento luce innovación institucional. Convierte el aula en simulador de bolsa y no forma decisiones cotidianas informadas.",
            "2": "Trampa del rigor macro: desconectar los modelos de la vida cotidiana parece no infantilizar el área. Niega el ahorro y el consumo responsable que la educación financiera básica busca.",
        },
    },
]

if __name__ == "__main__":
    raise SystemExit(dump_and_report(OUT, ITEMS, CI, n_items=8))
