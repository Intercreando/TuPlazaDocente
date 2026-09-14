# -*- coding: utf-8 -*-
"""Reescribe dir-apt-lec-03..12 (posiciones 751-760) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_751_760.json"

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
    "dir-apt-lec-03": 1,
    "dir-apt-lec-04": 1,
    "dir-apt-lec-05": 1,
    "dir-apt-lec-06": 1,
    "dir-apt-lec-07": 2,
    "dir-apt-lec-08": 0,
    "dir-apt-lec-09": 1,
    "dir-apt-lec-10": 1,
    "dir-apt-lec-11": 1,
    "dir-apt-lec-12": 1,
}
IDS_OK = list(CI.keys())

ITEMS = [
    {
        "id": "dir-apt-lec-03",
        "options": [
            "Otorgó a las instituciones el mandato de revisar y actualizar el SIEE de manera periódica, con participación de toda la comunidad educativa, para superar las dificultades de homologación de calificaciones entre colegios.",
            "Otorgó a las instituciones educativas colombianas autonomía para definir su Sistema Institucional de Evaluación de Estudiantes (SIEE), dentro de unos criterios mínimos fijados por el Ministerio de Educación Nacional.",
            "Dispuso que el Consejo Directivo adopte el SIEE y que este incluya criterios de promoción, estrategias de apoyo y superación, y la periodicidad de los informes de evaluación que se entregan a las familias.",
            "Centralizó en el Ministerio de Educación Nacional la evaluación de los estudiantes y unificó las escalas de valoración, con el fin de facilitar la homologación de calificaciones cuando un estudiante se traslada de institución.",
        ],
        "explanation": "La pregunta pide qué otorgó el Decreto 1290 de 2009 según el texto, no un recuento de todo el régimen de evaluación. El pasaje afirma, de manera explícita, que el decreto concedió a las instituciones educativas autonomía para definir el SIEE dentro de criterios mínimos fijados por el MEN. Esa es la respuesta anclada al enunciado. La diversidad de escalas y las dificultades de homologación son consecuencias posteriores; la revisión periódica del SIEE con la comunidad es una prioridad de muchos rectores, no lo que el decreto otorgó. Incorporar funciones verdaderas del 1290 —adopción por el Consejo Directivo, promoción, informes a familias— es conocimiento normativo que el pasaje no enuncia como respuesta al stem.",
        "normativeJustification": "El Decreto 1290 de 2009 sí reconoce autonomía institucional para el SIEE, con criterios mínimos del MEN. El ítem, no obstante, se resuelve con lo que el pasaje sostiene, no con el articulado completo (Consejo Directivo, promoción o informes a familias).",
        "theoreticalJustification": "En lectura crítica, lo otorgado se distingue de las consecuencias y de las recomendaciones de gestión. Importar el resto de la norma, aunque sea verdadero, es un error de dominio cruzado: se responde de memoria y no al texto.",
        "distractorAnalysis": {
            "0": "Trampa del detalle final como si fuera lo otorgado: revisar y actualizar el SIEE con la comunidad educativa es una prioridad de muchos rectores. El stem pregunta qué concedió el Decreto 1290, no qué recomiendan las rectorías.",
            "2": "Trampa de dominio cruzado del Decreto 1290: adopción por el Consejo Directivo, promoción e informes a familias son funciones reales del SIEE. El texto no las enuncia como lo que el decreto otorgó.",
            "3": "Trampa de la inversión centralizadora: unificar escalas en el MEN parece resolver la homologación que el propio pasaje describe. El 1290, según el texto, otorgó autonomía, no centralización de la evaluación.",
        },
    },
    {
        "id": "dir-apt-lec-04",
        "options": [
            "Una mejora generalizada de los resultados académicos en el país, presentada como efecto directo de la autonomía para definir el SIEE y de la diversidad de escalas de valoración entre colegios.",
            "Dificultades, en algunos casos, para homologar las calificaciones cuando un estudiante se traslada de una institución educativa a otra, a causa de esa diversidad de escalas de valoración.",
            "Que muchos rectores consideren prioritario revisar y actualizar el SIEE con participación de toda la comunidad educativa, tomada esa prioridad institucional como la consecuencia directa de la diversidad de escalas.",
            "La aplicación de una escala nacional de las Pruebas Saber del ICFES que, para efectos de traslado, sustituye las escalas del SIEE y corrige la heterogeneidad de valoración entre colegios.",
        ],
        "explanation": "El stem pregunta por una consecuencia de la diversidad de escalas de valoración. El texto la enuncia con claridad: esa diversidad ha dificultado, en algunos casos, la homologación de calificaciones cuando un estudiante se traslada de institución. No afirma una mejora generalizada de resultados ni la desaparición del SIEE. La revisión periódica del SIEE con participación de la comunidad aparece como prioridad de muchos rectores, derivada de ese problema, no como la consecuencia que el stem solicita. Invocar la escala de las Pruebas Saber o una unificación ministerial es conocimiento externo: el ICFES sí usa una escala nacional, pero el pasaje no la presenta como efecto de la diversidad del SIEE.",
        "normativeJustification": "El Decreto 1290 permite escalas institucionales diversas y obliga a prever procedimientos cuando hay traslado. El ítem no pide ese articulado: pide la consecuencia que el texto nombra, que es la dificultad de homologar calificaciones entre colegios.",
        "theoreticalJustification": "Una consecuencia explícita no se sustituye por un efecto deseable (mejores resultados), por una respuesta de gestión (revisar el SIEE) ni por un referente externo (escala Saber). Leer es localizar lo que el pasaje sostiene, no lo que la política educativa podría corregir.",
        "distractorAnalysis": {
            "0": "Trampa de la sobregeneralización de resultados: atribuir una mejora académica general a la diversidad de escalas suena a defensa de la autonomía. El pasaje no afirma ese efecto; afirma dificultades de homologación en algunos traslados.",
            "2": "Trampa del detalle posterior: la revisión del SIEE con la comunidad es una prioridad de rectores ante el problema. No es la consecuencia que el stem pide; esa consecuencia es la dificultad de homologar calificaciones.",
            "3": "Trampa de dominio cruzado de las Pruebas Saber: la escala nacional del ICFES existe y es independiente del SIEE. El texto no la presenta como consecuencia de la diversidad de escalas institucionales.",
        },
    },
    {
        "id": "dir-apt-lec-05",
        "options": [
            "Reducir el número de docentes requeridos por institución, al concentrar la planta en una jornada más extensa y ganar eficiencia en la asignación de la carga académica.",
            "Aumentar el tiempo de permanencia de los estudiantes en la institución educativa, con el fin de fortalecer el aprendizaje, según uno de los propósitos que el pasaje enuncia de forma explícita.",
            "Garantizar un complemento alimentario adicional del Programa de Alimentación Escolar (PAE), presentado como el propósito principal de la Jornada Única y no como condición de su viabilidad.",
            "Fortalecer, como eje del programa, los componentes de artes, educación física, ciencia y ciudadanía previstos en los lineamientos de Jornada Única del Ministerio de Educación Nacional.",
        ],
        "explanation": "La condición de calidad pide uno de los propósitos principales de la Jornada Única según el texto. El pasaje indica que su implementación busca aumentar el tiempo de permanencia de los estudiantes en la institución, con el fin de fortalecer el aprendizaje y reducir la exposición a riesgos del entorno. El stem admite «uno» de esos propósitos; la opción correcta recoge el de fortalecer el aprendizaje mediante más permanencia, sin negar el otro. Reducir la planta docente contradice las condiciones de viabilidad. Presentar el complemento del PAE como propósito confunde un requisito crítico de implementación con la finalidad del programa. Los componentes de artes, educación física y ciencia de los lineamientos del MEN son política real de Jornada Única, pero el texto no los enuncia.",
        "normativeJustification": "La Jornada Única, en la política del MEN, busca más tiempo escolar para el aprendizaje; el PAE es condición de bienestar, no el propósito pedagógico del pasaje. El ítem se resuelve con la finalidad que el texto declara, no con el catálogo completo de componentes de la jornada.",
        "theoreticalJustification": "Propósito y condición de viabilidad no son intercambiables. Un detalle operativo (el complemento del PAE) o un lineamiento externo (artes y ciencia) pueden ser verdaderos en otro registro y, aun así, no responder a lo que el enunciado pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de la inversión de planta: reducir docentes por eficiencia de una jornada más larga parece gestión racional. El texto asocia la viabilidad al número de docentes, no a recortarlo, y el propósito es más permanencia para aprender.",
            "2": "Trampa del detalle del PAE como propósito: el complemento alimentario adicional es condición crítica de viabilidad. Convertirlo en finalidad de la Jornada Única desplaza lo que el pasaje llama propósito (permanencia y aprendizaje).",
            "3": "Trampa de dominio cruzado de los lineamientos de Jornada Única: artes, educación física y ciencia son componentes reales de la política del MEN. El texto no los formula como el propósito pedido.",
        },
    },
    {
        "id": "dir-apt-lec-06",
        "options": [
            "La disponibilidad de infraestructura adecuada, señalada en el pasaje entre las condiciones de viabilidad y elevada aquí al rango de factor que el texto marca de manera crítica.",
            "La cobertura adecuada del Programa de Alimentación Escolar (PAE), porque una jornada más extensa exige garantizar, como mínimo, un complemento alimentario adicional para los estudiantes.",
            "La operación del Comité Escolar de Convivencia creado por la Ley 1620, en la idea de que una jornada más larga incrementa las situaciones de conflicto y el texto lo habría marcado como crítico.",
            "La reducción de la jornada laboral de los docentes, entendida como condición para hacer viable la Jornada Única, cuando el pasaje alude al número de docentes y no a recortar su tiempo de trabajo.",
        ],
        "explanation": "El stem pide la condición que el texto señala como crítica para la viabilidad de la Jornada Única. El pasaje lista infraestructura, número de docentes y, de manera crítica, la cobertura del PAE, porque una jornada más extensa exige al menos un complemento alimentario adicional. Esa marca retórica distingue el PAE de las demás condiciones. Tomar la infraestructura como el factor crítico es leer un detalle de la enumeración y desplazarlo al lugar que el texto reserva al PAE. El Comité Escolar de Convivencia (Ley 1620) es una instancia real, ajena a este pasaje. Recortar la jornada de los docentes invierte lo dicho: el texto habla del número de docentes, no de reducir su tiempo de trabajo.",
        "normativeJustification": "La política de Jornada Única articula planta, planta física y PAE; el programa de alimentación es condición de permanencia en jornadas largas. El ítem no pregunta el listado de la política, sino el factor que el propio texto califica como crítico.",
        "theoreticalJustification": "En una enumeración, el énfasis («de manera crítica») jerarquiza. Quien iguala todos los requisitos o importa convivencia (1620) y recorte de jornada docente no distingue lo subrayado por el autor del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa del detalle de la enumeración: la infraestructura sí aparece entre las condiciones de viabilidad. El texto, no obstante, marca de manera crítica la cobertura del PAE; elevar la infraestructura a ese rango es leer mal el énfasis.",
            "2": "Trampa de dominio cruzado de la Ley 1620: un Comité Escolar de Convivencia activo es obligatorio y una jornada larga puede tensionar el clima. El pasaje no lo señala como condición crítica de la Jornada Única.",
            "3": "Trampa de la inversión de la jornada docente: recortar el tiempo de trabajo de los maestros parece hacer viable la extensión estudiantil. El texto habla del número de docentes disponible, no de reducir su jornada.",
        },
    },
    {
        "id": "dir-apt-lec-07",
        "options": [
            "Que, durante la pandemia, las sedes rurales evidenciaron una brecha digital: unos estudiantes con conectividad y dispositivos propios y otros que dependían de guías impresas entregadas de manera periódica.",
            "Que la conectividad rural alcanzó la estabilidad de la urbana gracias a programas nacionales de acceso digital, Computadores para Educar y las directrices de educación remota del Ministerio de Educación Nacional.",
            "Que, ante la desigualdad de acceso digital, varios rectores mantuvieron estrategias híbridas que combinan plataformas digitales —cuando hay conectividad— con materiales físicos como respaldo.",
            "Que, superada la emergencia, las instituciones rurales abandonaron las guías impresas y asumieron que toda la comunidad educativa contaba ya con acceso permanente a internet.",
        ],
        "explanation": "La idea principal articula un diagnóstico y una decisión: la pandemia evidenció una brecha digital rural —unos con conectividad y dispositivos, otros con guías impresas— y, superada la emergencia, varios rectores mantuvieron estrategias híbridas, combinando plataformas digitales cuando había conectividad con materiales físicos como respaldo, en lugar de asumir acceso permanente a internet. Describir la brecha de la pandemia es el contexto, no el planteamiento completo. Afirmar que la conectividad rural igualó a la urbana o que los impresos se abandonaron contradice el pasaje. Los programas nacionales de acceso digital pueden ser ciertos en otro registro; aquí no sostienen la idea central.",
        "normativeJustification": "No hay en el pasaje un mandato nacional de hibridación ni un cierre de la brecha rural. La lectura se sostiene en la decisión de varios rectores de conservar medios digitales y físicos, no en Computadores para Educar ni en directrices genéricas de educación remota.",
        "theoreticalJustification": "La idea principal integra diagnóstico y respuesta institucional. Un detalle verdadero del contexto (la brecha en pandemia) no agota el sentido. La inversión (abandonar impresos) y el dato de política digital externa desplazan el núcleo argumental.",
        "distractorAnalysis": {
            "0": "Trampa del contexto tomado como idea principal: la brecha de la pandemia (dispositivos frente a guías impresas) es el diagnóstico inicial. La idea central incluye la decisión posterior de mantener estrategias híbridas con respaldo físico.",
            "1": "Trampa de dominio cruzado de la política digital: Computadores para Educar y la educación remota del MEN existen como programas. El texto no afirma que la conectividad rural igualara en estabilidad a la urbana.",
            "3": "Trampa de la inversión postemergencia: abandonar los impresos y asumir internet permanente es justamente lo que los rectores del pasaje evitan. El material físico queda como respaldo, no como práctica descartada.",
        },
    },
    {
        "id": "dir-apt-lec-08",
        "options": [
            "Buscaba no dejar en desventaja a los estudiantes sin conectividad permanente, al no asumir que toda la comunidad educativa contaba con acceso continuo a internet.",
            "Buscaba reducir los costos de impresión y de entrega periódica de guías, una vez superada la emergencia, como criterio de eficiencia presupuestal de las sedes rurales.",
            "Respondía a una exigencia normativa nacional de hibridación, derivada de lineamientos del MEN sobre educación remota y de la obligatoriedad de plataformas virtuales en el Decreto 1075.",
            "Se adoptó por preferencia metodológica del equipo docente, que optó por combinar plataformas digitales y materiales físicos como un enfoque pedagógico reciente, al margen de la brecha de acceso.",
        ],
        "explanation": "El stem pide una inferencia sobre la decisión de mantener estrategias híbridas. El texto cierra diciendo que se combinaron plataformas digitales cuando había conectividad con materiales físicos como respaldo, en lugar de asumir que toda la comunidad contaba con acceso permanente a internet. De ahí se sigue que la decisión buscaba no dejar en desventaja a quienes carecían de conectividad continua. El pasaje no menciona costos de impresión, ni una norma nacional de hibridación obligatoria, ni una preferencia metodológica del equipo docente. El Decreto 1075 y los lineamientos de educación remota existen en el ordenamiento; importarlos como motivo de la decisión es dominio cruzado: conocimiento verosímil que el texto no atribuye a esos rectores.",
        "normativeJustification": "No hay en el pasaje un mandato del Decreto 1075 ni de la educación remota que imponga la hibridación. La inferencia válida se ancla al contraste explícito: no asumir acceso permanente a internet para toda la comunidad educativa.",
        "theoreticalJustification": "Una inferencia se sostiene en premisas del texto, no en motivos de eficiencia, de moda pedagógica o de cumplimiento legal externo. El «en lugar de asumir» del pasaje autoriza la lectura de no dejar en desventaja a quien carece de conectividad.",
        "distractorAnalysis": {
            "1": "Trampa de la eficiencia presupuestal: atribuir la hibridación a ahorrar impresión suena a gestión de costos rurales. El pasaje no menciona costos; ancla la decisión a no asumir conectividad permanente para toda la comunidad.",
            "2": "Trampa de dominio cruzado normativo: tratar la hibridación como mandato del MEN o del Decreto 1075 parece cumplimiento legal impecable. El texto describe una opción de varios rectores, no una exigencia nacional.",
            "3": "Trampa de la preferencia docente: explicar la estrategia como enfoque metodológico del equipo omite la brecha de acceso. El pasaje contrapone plataformas y materiales físicos a la hipótesis de internet para todos.",
        },
    },
    {
        "id": "dir-apt-lec-09",
        "options": [
            "La derogación del manual de convivencia, sustituido por el Comité Escolar de Convivencia como instancia que concentra la disciplina y la ruta de atención integral en cada colegio.",
            "La obligación de que cada institución educativa conforme un Comité Escolar de Convivencia, integrado entre otros por el rector, un docente por nivel, el personero estudiantil y el presidente del consejo de padres.",
            "La creación del Sistema Institucional de Evaluación de Estudiantes (SIEE) y de las escalas de valoración, competencia que el Decreto 1290 atribuye a cada establecimiento educativo.",
            "La centralización de la disciplina escolar en la Secretaría de Educación, que activaría la ruta de atención integral y clasificaría las situaciones de convivencia según su gravedad.",
        ],
        "explanation": "Según el texto, la Ley 1620 de 2013 creó el Sistema Nacional de Convivencia Escolar y estableció que cada institución debe conformar un Comité Escolar de Convivencia, con una integración que incluye al rector, un docente por nivel, el personero estudiantil y el presidente del consejo de padres, entre otros. El stem pregunta qué estableció esa ley; la opción correcta recoge la obligación de conformar el comité, anclada al pasaje. No dice que se derogue el manual de convivencia ni que la disciplina se centralice en la Secretaría. El SIEE es creación del Decreto 1290, no de la 1620: quien responde de memoria confunde dos pilares normativos y no lee el enunciado.",
        "normativeJustification": "La Ley 1620 y el Decreto 1965 exigen el Comité Escolar de Convivencia en cada IE y conservan el manual de convivencia. El SIEE pertenece al Decreto 1290. El ítem se zanja con lo que el pasaje declara que estableció la 1620, no con el mapa completo de normas escolares.",
        "theoreticalJustification": "Identificar qué «estableció» una ley en un texto es localizar el predicado explícito, no sustituir el manual, no trasladar la ruta a la Secretaría ni importar el SIEE. La confusión 1290/1620 es el error clásico de quien no lee y evoca evaluación.",
        "distractorAnalysis": {
            "0": "Trampa de la sustitución del manual: concentrar la disciplina en el Comité Escolar de Convivencia parece actualización de la Ley 1620. El texto no deroga el manual; establece la obligación de conformar el comité en cada institución.",
            "2": "Trampa de dominio cruzado del Decreto 1290: el SIEE y las escalas de valoración son objeto de esa norma, no de la Ley 1620. Quien responde de memoria mezcla evaluación de estudiantes y convivencia escolar.",
            "3": "Trampa de la centralización en Secretaría: atribuir a esa instancia la ruta de atención y la clasificación por gravedad desplaza lo que el pasaje sitúa en cada institución y en su Comité Escolar de Convivencia.",
        },
    },
    {
        "id": "dir-apt-lec-10",
        "options": [
            "Hacer el seguimiento académico del Sistema Institucional de Evaluación de Estudiantes (SIEE), revisar escalas de valoración y decidir promociones, como si el Comité Escolar de Convivencia sustituyera al Consejo Académico.",
            "Activar la ruta de atención integral ante situaciones que afecten la convivencia escolar, clasificándolas según su gravedad y orientando la respuesta institucional correspondiente.",
            "Asumir las funciones del Consejo Directivo en la adopción del PEI, del presupuesto y del manual de convivencia, concentrando en el Comité Escolar de Convivencia el gobierno de la institución.",
            "Evaluar el desempeño académico de los docentes y concertar planes de mejoramiento, función del rector o coordinador en el marco del Decreto 1278, no del Comité Escolar de Convivencia.",
        ],
        "explanation": "El pasaje asigna al Comité Escolar de Convivencia la función de activar la ruta de atención integral ante situaciones que afecten la convivencia, clasificándolas según su gravedad y orientando la respuesta institucional. Esa es la función principal según el texto. El seguimiento académico del SIEE corresponde a otras instancias (Consejo Académico, docentes, el propio sistema de evaluación). Adoptar el PEI y el presupuesto es competencia del Consejo Directivo. Evaluar el desempeño docente es propio del rector o coordinador en el Decreto 1278. Las tres trampas son dominio cruzado de gobierno escolar y de evaluación: procedimientos reales de la escuela colombiana que el pasaje no atribuye al comité.",
        "normativeJustification": "La Ley 1620 y el Decreto 1965 asignan al comité la ruta de atención integral y la clasificación de situaciones. El SIEE (1290), el Consejo Directivo (1860) y la evaluación 1278 son instancias distintas. El ítem pregunta la función que el texto declara, no el organigrama completo.",
        "theoreticalJustification": "La función principal se lee en el predicado del comité, no en competencias vecinas del gobierno escolar. Confundir convivencia con SIEE, PEI o evaluación docente es un error de instancia: se reconoce la escuela colombiana y no se lee el pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del SIEE: hacer seguimiento académico, revisar escalas y decidir promociones es función de evaluación institucional, no del Comité Escolar de Convivencia. El texto le asigna la ruta de atención integral.",
            "2": "Trampa de la absorción del Consejo Directivo: adoptar PEI, presupuesto y manual son competencias de esa instancia del gobierno escolar. El pasaje no transfiere esas funciones al Comité Escolar de Convivencia.",
            "3": "Trampa de dominio cruzado del Decreto 1278: evaluar docentes y concertar mejoramiento corresponde al rector o coordinador. El comité del texto clasifica situaciones de convivencia y activa la ruta, no el desempeño laboral.",
        },
    },
    {
        "id": "dir-apt-lec-11",
        "options": [
            "Crear un currículo distinto o paralelo para el estudiante con discapacidad, bajo la figura de una atención especializada que lo separa del plan de estudios general de la institución.",
            "Identificar las barreras que enfrenta el estudiante y definir los apoyos y ajustes razonables a partir del currículo general de la institución, para su participación plena.",
            "Trasladar de manera automática al estudiante a un aula o institución de educación especial, como medida de atención a la discapacidad prevista por fuera de lo que el Decreto 1421 describe en el pasaje.",
            "Eximir al estudiante con discapacidad de la evaluación y de la promoción previstas en el SIEE, por su condición, en lugar de definir apoyos para su participación en el currículo general.",
        ],
        "explanation": "El texto presenta el PIAR, en el Decreto 1421 de 2017, como herramienta para identificar las barreras que enfrenta un estudiante y definir los apoyos necesarios para su participación plena, partiendo del currículo general y no de un currículo paralelo. El propósito, según el pasaje, es identificar barreras y definir ajustes razonables a partir de ese currículo general. Crear un plan de estudios distinto es justamente lo que el texto rechaza. El traslado a educación especial y la exención de evaluación del SIEE contradicen la participación plena. Quien responde con el trámite SIMAT o con una lectura de «atención especializada» separada no está leyendo el contraste que el enunciado subraya.",
        "normativeJustification": "El Decreto 1421 define el PIAR como ajustes al currículo general para la participación, no como currículo paralelo ni como exención de evaluación. El ítem se resuelve con el propósito que el pasaje formula, no con el traslado a educación especial ni con el SIEE leído como dispensa.",
        "theoreticalJustification": "El propósito de una herramienta se lee en la definición del autor del texto. Invertir esa definición (currículo paralelo, traslado, exención) o importar evaluación 1290 como dispensa es no distinguir lo que el PIAR hace de lo que la exclusión disfraza.",
        "distractorAnalysis": {
            "0": "Trampa de la inversión hacia el currículo paralelo: crear un plan de estudios distinto bajo atención especializada es precisamente el proceso de exclusión que el pasaje rechaza. El PIAR parte del currículo general de la institución.",
            "2": "Trampa del traslado a educación especial: remitir de oficio a otra modalidad parece cuidado y evoca figuras de apoyo. El texto define el PIAR para la participación plena en la institución, no para el traslado del estudiante.",
            "3": "Trampa de dominio cruzado del SIEE como dispensa: eximir de evaluación y promoción por la discapacidad parece un «ajuste». El propósito en el pasaje es identificar barreras y definir apoyos para participar en el currículo general.",
        },
    },
    {
        "id": "dir-apt-lec-12",
        "options": [
            "El PIAR se formula al margen del currículo institucional, como un plan de estudios propio que no se relaciona con el plan general de la institución educativa.",
            "El PIAR parte del currículo general de la institución y propone ajustes específicos, evitando así procesos de exclusión disfrazados de atención especializada.",
            "El PIAR se destina a estudiantes sin discapacidad y opera como instrumento general de planeación de aula, equivalente al Diseño Universal del Aprendizaje para todo el grupo.",
            "El PIAR reemplaza la planeación docente regular y el Proyecto Educativo Institucional, de modo que la programación de clase queda supeditada al formato individual de ajustes.",
        ],
        "explanation": "El pasaje distingue el PIAR de un currículo paralelo: parte del currículo general de la institución y propone ajustes específicos, evitando procesos de exclusión disfrazados de atención especializada. Esa es la diferencia que el stem solicita. Afirmar que el PIAR no se relaciona con el currículo institucional invierte el contraste. Destinarlo a estudiantes sin discapacidad o igualarlo al Diseño Universal para todo el grupo desborda y distorsiona el texto, aunque el DUA sea un referente verdadero de inclusión. Reemplazar la planeación docente regular o el PEI convierte un instrumento individual de ajustes en un sucedáneo del gobierno institucional, lectura que el pasaje no sostiene.",
        "normativeJustification": "El Decreto 1421 contrapone el PIAR al currículo paralelo y lo ancla al currículo general con ajustes razonables. El DUA y el PEI son referentes reales de la escuela inclusiva; no son la distinción que este texto formula frente al currículo paralelo.",
        "theoreticalJustification": "Una distinción textual se lee en el contraste que el autor construye (partir del currículo general frente a un plan paralelo). Invertir el vínculo, sobregeneralizar al grupo completo o sustituir el PEI son lecturas que abandonan ese contraste.",
        "distractorAnalysis": {
            "0": "Trampa de la desconexión curricular: afirmar que el PIAR no se relaciona con el currículo institucional invierte el contraste del pasaje. La distinción frente al currículo paralelo es, precisamente, partir del plan general.",
            "2": "Trampa de la sobregeneralización al grupo sin discapacidad: tratar el PIAR como planeación universal o como DUA para todos desborda el Decreto 1421 que el texto sitúa en la población con discapacidad y en ajustes individuales.",
            "3": "Trampa de dominio cruzado del gobierno institucional: reemplazar la planeación docente o el PEI por el formato PIAR convierte un ajuste individual en sucedáneo del proyecto educativo. El texto no sostiene esa sustitución.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return [str(n) for n in range(4) if n != ci]


def public_item(it: dict) -> dict:
    return {k: it[k] for k in ("id", "options", "explanation", "normativeJustification", "theoreticalJustification", "distractorAnalysis")}


def validate(items: list) -> list[str]:
    errors: list[str] = []
    if [it["id"] for it in items] != IDS_OK:
        errors.append(f"ID ORDER {[it['id'] for it in items]}")
    for it in items:
        tag = it["id"]
        ci = CI[tag]
        extra = sorted(set(it.keys()) - KEYS_OK)
        missing = sorted(KEYS_OK - set(it.keys()))
        if extra:
            errors.append(f"EXTRA KEYS {tag} {extra}")
        if missing:
            errors.append(f"MISSING KEY {tag} {missing}")
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
        expected = expected_da_keys(ci)
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
    return errors


def main() -> int:
    public = [public_item(it) for it in ITEMS]
    errors = validate(public)
    print("=== longitudes opciones ===")
    for it in public:
        lens = [len(o) for o in it["options"]]
        ci = CI[it["id"]]
        print(
            it["id"],
            "ci",
            ci,
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "NJ",
            len(it["normativeJustification"]),
            "TJ",
            len(it["theoreticalJustification"]),
            "DA",
            {k: len(v) for k, v in it["distractorAnalysis"].items()},
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
