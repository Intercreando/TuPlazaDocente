# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ges-63..72 (posiciones 811-820) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_811_820.json"
SRC = ROOT / "_tmp_in_811_820.json"

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
    "dir-apt-ges-63": 1,
    "dir-apt-ges-64": 1,
    "dir-apt-ges-65": 0,
    "dir-apt-ges-66": 1,
    "dir-apt-ges-67": 1,
    "dir-apt-ges-68": 0,
    "dir-apt-ges-69": 1,
    "dir-apt-ges-70": 0,
    "dir-apt-ges-71": 1,
    "dir-apt-ges-72": 1,
}

ITEMS = [
    {
        "id": "dir-apt-ges-63",
        "options": [
            "Adoptar el SIEE por resolución de rectoría, publicarlo en la página web institucional y remitir esa publicación a la Secretaría como acto de adopción, sin construcción participativa ni acuerdo del Consejo Directivo.",
            "Aprobar el SIEE mediante acuerdo del Consejo Directivo, tras un proceso de construcción participativa con los docentes que reclamaron y demás estamentos, de modo que el acto de adopción sea válido ante la Secretaría.",
            "Pedir que la Secretaría de Educación municipal expida el acto de adopción del SIEE ya publicado en la web, para homologarlo territorialmente y dar por cerrado el reclamo de participación de los docentes.",
            "Autorizar que cada docente consolide los criterios de evaluación de su asignatura, los socialice con su grupo y los archive como autonomía del Decreto 1290, sin un SIEE institucional adoptado por el gobierno escolar.",
        ],
        "explanation": "La condición de calidad pregunta quién debe aprobar el SIEE para que el acto de adopción sea válido, no quién lo publica ni quién lo vigila. El Decreto 1290 establece que el Sistema Institucional de Evaluación de los Estudiantes hace parte del PEI y se aprueba mediante acuerdo del Consejo Directivo, previo proceso de construcción participativa. Publicarlo en la página web, como hizo el rector del caso, es difusión, no adopción. La Secretaría puede pedir el acto y ejercer inspección, pero no sustituye al Consejo Directivo. Un SIEE por asignatura fragmenta el sistema institucional y no responde al reclamo de los docentes. La opción correcta articula instancia, participación y validez del acto que la Secretaría está pidiendo.",
        "normativeJustification": "El Decreto 1290 y la Ley 115 sitúan el SIEE como componente del PEI. El Consejo Directivo lo aprueba por acuerdo, después de construcción participativa. La publicación web y la vigilancia de la Secretaría no equivalen a ese acto de adopción.",
        "theoreticalJustification": "La legitimidad de un sistema de evaluación institucional exige participación de los estamentos y una instancia de gobierno que adopte. La difusión digital, la homologación territorial o la autonomía de cada asignatura no producen un SIEE oponible ni cierran el reclamo de los docentes.",
        "distractorAnalysis": {
            "0": "Trampa del acto de rectoría en la web: publicar el SIEE y remitirlo a Secretaría parece celeridad y transparencia. Es difusión, no adopción: omite la construcción participativa y el acuerdo del Consejo Directivo que el stem exige para la validez.",
            "2": "Trampa de dominio cruzado de la homologación territorial: que la Secretaría expida el acto luce impecable como control municipal. Confunde inspección y petición del acto con la competencia de adopción, que reside en el Consejo Directivo de la IE.",
            "3": "Trampa de la autonomía por asignatura: archivar criterios de aula suena a Decreto 1290 y a participación docente. Fragmenta el SIEE institucional y deja sin acto de adopción colegiado el reclamo de quienes no participaron.",
        },
    },
    {
        "id": "dir-apt-ges-64",
        "options": [
            "Atribuir al coordinador mayor jerarquía de representación legal durante la comisión del rector, para que firme ante terceros y cierre la duda del Consejo Directivo con un acto de suplencia pedido por la Secretaría.",
            "Precisar que el rector es el representante legal del establecimiento y que el coordinador apoya la gestión académica y de convivencia bajo su orientación, de modo que la firma ante terceros no se desplaza por la comisión.",
            "Tratar al coordinador como vocero cercano a los estudiantes que sustituye al rector en los actos institucionales, de forma que la representación legal quede en su despacho mientras dura la comisión.",
            "Autorizar que rector y coordinador firmen contratos y actos de personal de manera indistinta, para no detener trámites ante terceros y responder a la Secretaría mientras el rector está en comisión.",
        ],
        "explanation": "La condición de calidad pide la diferencia funcional más precisa entre rector y coordinador, no un arreglo de suplencia para la comisión. El rector es el representante legal del establecimiento (Ley 115 y Decreto 1860); el coordinador apoya la gestión académica y de convivencia bajo su orientación. Esa diferencia no se borra porque el rector esté en comisión ni porque «en la práctica sea lo mismo», como alega el coordinador del caso. Atribuirle mayor jerarquía de representación legal invierte el organigrama. Confundirlo con un vocero estudiantil mezcla instancias de participación. Autorizar firmas indistintas de contratos y de personal es un atajo administrativo que deja al Consejo Directivo sin certeza sobre quién responde ante terceros.",
        "normativeJustification": "La Ley 115 y el Decreto 1860, compilados en el Decreto 1075, asignan al rector la representación legal. El coordinador es un cargo de apoyo académico y de convivencia, no un segundo representante ni un suplente automático por comisión.",
        "theoreticalJustification": "La representación legal es una función de gobierno, no de cercanía operativa. La comisión no transfiere por sí sola la firma ante terceros. Suplencia jerárquica, vocería estudiantil o rúbrica indistinta de contratos confunden organigrama, participación y contratación con esa diferencia funcional.",
        "distractorAnalysis": {
            "0": "Trampa de la suplencia jerárquica: dar al coordinador mayor representación legal durante la comisión parece resolver el pedido de la Secretaría. Invierte la diferencia funcional y no responde quién es, en derecho, el representante legal.",
            "2": "Trampa de la vocería estudiantil: tratar al coordinador como quien «está más cerca» de los estudiantes y puede sustituir al rector suena a liderazgo cotidiano. Mezcla participación estudiantil con representación legal, que el stem pide distinguir.",
            "3": "Trampa de dominio cruzado contractual: firmar contratos y actos de personal de manera indistinta es impecable como celeridad de tesorería y de planta. No aclara la diferencia funcional y deja al Consejo Directivo sin responsable ante terceros.",
        },
    },
    {
        "id": "dir-apt-ges-65",
        "options": [
            "Consolidar el ISCE del Día E con progreso, desempeño, eficiencia y ambiente escolar, según el desagregado oficial del MEN con el que se diseñó el índice, sin mezclar infraestructura ni presupuesto de planta.",
            "Presentar en el Día E el ISCE como asistencia, disciplina, infraestructura y presupuesto, según el relato del docente, y conservarlo en el acta de calidad para que las familias vean orden y planta.",
            "Sustituir el índice por matrícula, deserción, cobertura y nómina docente, indicadores de SIMAT y de planta que la coordinación pide no confundir con el ISCE en esa jornada de calidad.",
            "Armar el tablero del Día E con evaluación docente, planta física, transporte escolar y PAE, como gestión de servicios y de planta, y presentarlo como si fuera el desagregado oficial del ISCE.",
        ],
        "explanation": "La condición de calidad pide los componentes del ISCE según el desagregado oficial con el que se diseñó ese índice, no el tablero de planta, de SIMAT o de servicios. El MEN construyó el Índice Sintético de Calidad Educativa con cuatro componentes: progreso, desempeño, eficiencia y ambiente escolar. Esa es la lectura que el segundo docente trae al Día E y la que coordinación pide no mezclar con infraestructura. Asistencia, disciplina y presupuesto reproducen el relato del primer docente. Matrícula, deserción, cobertura y nómina son indicadores de gestión de cupos y de planta. Evaluación docente, transporte y PAE pertenecen a otro tablero de servicios. Ninguno de esos conjuntos es el ISCE.",
        "normativeJustification": "El ISCE, definido por el MEN para el Día E y el ciclo de calidad, se desagrega en progreso, desempeño, eficiencia y ambiente escolar. El Decreto 1075 y la Guía 34 distinguen esos resultados de los indicadores de planta física, SIMAT, transporte o PAE.",
        "theoreticalJustification": "Un índice sintético no admite cambiar de constructo. Mezclar asistencia, infraestructura, cobertura o alimentación escolar con el ISCE altera lo que el índice mide y distorsiona el acta del Día E.",
        "distractorAnalysis": {
            "1": "Trampa del relato del docente: asistencia, disciplina, infraestructura y presupuesto suenan a «orden escolar» visible para las familias. No son los cuatro componentes oficiales y mezclan planta física con el índice, justo lo que coordinación pide evitar.",
            "2": "Trampa de los indicadores SIMAT: matrícula, deserción, cobertura y nómina son datos reales de gestión de cupos. Sustituyen el ISCE por otro tablero y no responden al desagregado oficial del stem.",
            "3": "Trampa de dominio cruzado de servicios: evaluación docente, planta, transporte y PAE lucen como gestión administrativa-financiera de la Guía 34. Son otro objeto de calidad; no el diseño del ISCE que la jornada debe reportar.",
        },
    },
    {
        "id": "dir-apt-ges-66",
        "options": [
            "Que el rector de la institución educativa expida el acto de nombramiento en propiedad del docente o directivo, lo archive en personal y lo presente como decisión de planta de la IE, según propone el primer actor.",
            "Que el nominador de la entidad territorial certificada expida el acto de nombramiento, con fundamento en la lista de elegibles y en las reglas de carrera, y no por circular interna de la institución.",
            "Que la Comisión Nacional del Servicio Civil nombre en la planta de la IE y notifique el acto al Consejo Directivo, como si el concurso de méritos agotara la vinculación sin el nominador territorial.",
            "Que el Consejo Directivo de cada institución apruebe el nombramiento por acuerdo y lo comunique a Secretaría, para dar legitimidad colegiada a la vinculación que el tercer actor sugiere.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente frente a las tres propuestas de vinculación del caso. El nombramiento de docentes y directivos docentes de carrera en una IE oficial corresponde al nominador de la entidad territorial certificada, con fundamento en la lista de elegibles (Decreto 1278 y Ley 715), no a una circular interna. El rector gestiona la IE y puede reportar vacantes, pero no es la autoridad nominadora. La CNSC organiza el concurso y conforma listas; no nombra en la planta de cada colegio. El Consejo Directivo adopta PEI, SIEE y presupuesto; no nombra la carrera docente. La opción correcta separa concurso, nominación y gobierno escolar.",
        "normativeJustification": "El Decreto 1278 y la Ley 715 asignan el nombramiento al nominador de la entidad territorial certificada. La CNSC adelanta el concurso y elabora listas de elegibles. El rector y el Consejo Directivo no expiden el acto de vinculación en propiedad.",
        "theoreticalJustification": "En la carrera docente el mérito (concurso) y la nominación (acto de personal territorial) son momentos distintos. Confundirlos con la rectoría o con el gobierno escolar produce una vinculación sin autoridad nominadora.",
        "distractorAnalysis": {
            "0": "Trampa de la rectoría como nominadora: que el rector nombre y archive en personal parece liderazgo de planta y cierra la discusión interna. En una IE oficial esa competencia no reside en el establecimiento; el primer actor confunde gestión con nominación.",
            "2": "Trampa de dominio cruzado del concurso: que la CNSC nombre de forma directa es coherente con el mérito y con las listas. El concurso no agota la vinculación: el acto de nombramiento lo expide el nominador de la entidad territorial certificada.",
            "3": "Trampa de la legitimidad colegiada: que el Consejo Directivo apruebe el nombramiento suena a gobierno escolar y a evidencia ante Secretaría. Ese órgano adopta PEI y presupuesto, no vincula la carrera docente que el caso discute.",
        },
    },
    {
        "id": "dir-apt-ges-67",
        "options": [
            "Tomar el Manual de Convivencia actualizado como carta que orienta la organización pedagógica, administrativa y de gestión, por ser el documento vigente más reciente que el rector nuevo encuentra.",
            "Tomar el Proyecto Educativo Institucional como marco que orienta la organización pedagógica, administrativa y de gestión, del cual derivan el manual, el SIEE y el plan operativo, conforme al artículo 73 de la Ley 115.",
            "Tomar el Plan Operativo Anual de caja como documento que orienta la organización pedagógica, administrativa y de gestión, porque ordena giros, metas de tesorería y la vigencia que el rector acaba de recibir.",
            "Tomar el Sistema Institucional de Evaluación como marco de la organización institucional, porque regula promoción y parece el instrumento más técnico entre los tres documentos hallados por el rector.",
        ],
        "explanation": "La condición de calidad pregunta cuál instrumento orienta la organización pedagógica, administrativa y de gestión de la IE. El artículo 73 de la Ley 115 define el Proyecto Educativo Institucional como la carta que articula fines, gobierno, currículo y gestión; el manual de convivencia, el SIEE y el plan operativo derivan de ese marco. El rector nuevo encuentra tres documentos vigentes, pero ninguno reemplaza al PEI. El manual actualizado rige la convivencia (Ley 1620), no toda la organización. El POA de caja ordena la vigencia financiera. El SIEE regula evaluación y promoción (Decreto 1290). Tomar cualquiera de los tres como marco es leer un instrumento satélite como si fuera el proyecto educativo.",
        "normativeJustification": "El artículo 73 de la Ley 115 y el Decreto 1860 sitúan el PEI como carta de navegación de la IE. El Manual de Convivencia, el SIEE (Decreto 1290) y el plan operativo son desarrollos; no sustituyen esa orientación integral.",
        "theoreticalJustification": "La organización escolar se articula en un proyecto institucional, no en un reglamento de convivencia, un presupuesto anual ni un sistema de calificaciones. Cada satélite es correcto en su dominio y insuficiente como marco de toda la IE.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del manual vigente: el Manual de Convivencia actualizado es el documento más visible y reciente del caso, y rige la convivencia. No orienta la organización pedagógica, administrativa y de gestión que el stem pide.",
            "2": "Trampa del POA de caja: ordenar giros y metas de tesorería parece «gestión real» de la vigencia. El plan operativo ejecuta; no es la carta que articula pedagogía, administración y gobierno.",
            "3": "Trampa del SIEE como marco técnico: regular promoción luce como el instrumento más pedagógico de los tres hallados. El Decreto 1290 cubre evaluación, no la organización administrativa y de gestión de la IE.",
        },
    },
    {
        "id": "dir-apt-ges-68",
        "options": [
            "Adoptar como órganos del gobierno escolar al rector, al Consejo Directivo y al Consejo Académico, de acuerdo con el Decreto 1860, y no sustituirlos por el organigrama de cargos ni por instancias de participación.",
            "Conformar el gobierno escolar con rector, coordinador y secretario académico, según el organigrama de cargos que uno de los actores propone, y presentarlo como evidencia de dirección ante la visita de calidad.",
            "Declarar órganos de gobierno al Consejo Directivo, a la Asociación de Padres y al personero estudiantil, mezclando el trío del Decreto 1860 con instancias de participación que sí operan en la IE.",
            "Integrar el gobierno escolar con rector, Consejo Estudiantil y Contraloría Estudiantil, para exhibir protagonismo estudiantil en el acta de calidad y cerrar la discusión del equipo con esa lectura.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre los órganos del gobierno escolar. El Decreto 1860 de 1994 (compilado en el Decreto 1075) constituye ese gobierno con rector, Consejo Directivo y Consejo Académico. El coordinador y el secretario académico son cargos de apoyo, no órganos de gobierno. La Asociación de Padres y el personero son instancias de participación (Decreto 1286 y Ley 115), no el trío del 1860. El Consejo Estudiantil y la Contraloría Estudiantil amplían la voz estudiantil, pero no sustituyen al Consejo Directivo ni al Académico. La opción correcta distingue gobierno escolar de organigrama y de participación, frente a las tres propuestas del caso.",
        "normativeJustification": "El Decreto 1860 define los órganos del gobierno escolar: rector, Consejo Directivo y Consejo Académico. El Decreto 1286 y la Ley 115 organizan Asociación de Padres, personero, consejo estudiantil y contraloría estudiantil como participación, no como ese trío de gobierno.",
        "theoreticalJustification": "Gobierno escolar no equivale a nómina de cargos ni a todas las voces de la comunidad. Confundirlos produce un organigrama o un mapa de participación presentado como si fuera el 1860.",
        "distractorAnalysis": {
            "1": "Trampa del organigrama de cargos: rector, coordinador y secretario académico describen la operación cotidiana y lucen «evidencia de dirección» para la visita. No son los órganos de gobierno que el Decreto 1860 constituye.",
            "2": "Trampa de dominio cruzado de la participación: Consejo Directivo, Asociación de Padres y personero sí existen y uno de los actores los propone. Mezcla gobierno con instancias del 1286 y de la Ley 115, y omite rector y Consejo Académico del trío legal.",
            "3": "Trampa del protagonismo estudiantil: Consejo Estudiantil y Contraloría Estudiantil son figuras reales de voz de los estudiantes. No reemplazan al Consejo Directivo ni al Académico como órganos de gobierno del 1860.",
        },
    },
    {
        "id": "dir-apt-ges-69",
        "options": [
            "Aceptar que el personero represente al Consejo Directivo ante la Secretaría de Educación y «defienda al rector», para atender esa presión del caso y mostrar unidad institucional en la visita territorial.",
            "Sostener que la función principal del personero, elegido por los estudiantes, es promover el ejercicio de sus derechos y deberes, y rechazar que «defienda al rector» en Secretaría o que apruebe el presupuesto.",
            "Encargar al personero la definición del currículo institucional, presentándola como la vía para dar voz a los estudiantes que reclaman representación en derechos y deberes.",
            "Autorizar que el personero apruebe el presupuesto anual de la institución, para responder a la presión de caja del caso y agilizar los giros del Fondo de Servicios Educativos.",
        ],
        "explanation": "La condición de calidad pregunta la función principal del personero estudiantil ante las presiones del caso. El artículo 94 de la Ley 115 y el Decreto 1860 asignan al personero promover el ejercicio de los derechos y deberes de los estudiantes, elegido por ellos. «Defender al rector en Secretaría» desplaza esa función hacia la representación del Consejo Directivo. Definir el currículo es competencia del Consejo Académico y del PEI. Aprobar el presupuesto corresponde al Consejo Directivo, con el rector como ordenador del FSE. Los estudiantes del caso le piden exactamente lo que la norma describe: representación en derechos y deberes. Esa es la respuesta institucionalmente defendible frente a las dos presiones.",
        "normativeJustification": "La Ley 115 (art. 94) y el Decreto 1860 definen al personero como vocero de derechos y deberes de los estudiantes. No representa al Consejo Directivo ante Secretaría, no adopta el currículo ni aprueba el presupuesto del FSE.",
        "theoreticalJustification": "El personero es una figura de garantía estudiantil, no de imagen de rectoría ni de tesorería. Desplazar su mandato hacia Secretaría, el currículo o el FSE responde a la presión del caso y vacía la función que los estudiantes reclaman.",
        "distractorAnalysis": {
            "0": "Trampa de la unidad ante Secretaría: que el personero «defienda al rector» parece lealtad institucional y cierra la presión del caso. Invierte el mandato: deja de representar a los estudiantes para representar al Consejo Directivo.",
            "2": "Trampa del currículo como voz estudiantil: definir el plan de estudios parece empoderar a quienes piden representación. Esa función es del Consejo Académico y del PEI, no la función principal del personero.",
            "3": "Trampa de dominio cruzado del FSE: aprobar el presupuesto agiliza caja y responde a la segunda presión del caso. Esa competencia es del Consejo Directivo y del rector ordenador, no del personero.",
        },
    },
    {
        "id": "dir-apt-ges-70",
        "options": [
            "Que el Consejo Directivo apruebe el presupuesto del Fondo de Servicios Educativos y que el rector actúe como ordenador del gasto, conforme al Decreto 1075, frente a las tres propuestas en conflicto.",
            "Que la Secretaría de Educación municipal administre de forma directa el Fondo de Servicios Educativos de la IE, como control territorial de caja, y deje al rector como ejecutor de giros ya definidos.",
            "Que la Asociación de Padres de Familia administre el Fondo de Servicios Educativos y autorice los giros, en clave de legitimidad comunitaria, como propone el segundo actor del caso.",
            "Que el Consejo Académico administre el Fondo y priorice rubros pedagógicos, porque conoce el plan de estudios y parece la instancia más cercana a la calidad del servicio educativo.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre quién administra el Fondo de Servicios Educativos. El Decreto 1075 (antes Decreto 4791 de 2008) asigna al Consejo Directivo la adopción del presupuesto del FSE y al rector la calidad de ordenador del gasto. La Secretaría municipal certifica, inspecciona y gira recursos; no administra de forma directa la caja de la IE. La Asociación de Padres puede apoyar proyectos, pero no es ordenadora ni instancia presupuestal del Fondo. El Consejo Académico orienta lo pedagógico, no los giros. Las tres propuestas del caso confunden vigilancia territorial, participación familiar o academia con la administración del FSE.",
        "normativeJustification": "El Decreto 1075 regula el FSE: el Consejo Directivo aprueba el presupuesto y el rector es ordenador del gasto. La Secretaría ejerce inspección; la Asociación de Padres y el Consejo Académico no administran ese fondo.",
        "theoreticalJustification": "La tesorería escolar exige una instancia de gobierno que priorice y un ordenador que ejecute con responsabilidad. La vigilancia territorial, el apoyo de padres o el criterio académico son insumos; no sustituyen esa administración.",
        "distractorAnalysis": {
            "1": "Trampa de dominio cruzado de la vigilancia territorial: que la Secretaría administre de forma directa el FSE luce como control legal de caja. Confunde certificación e inspección con la administración del fondo, que reside en Consejo Directivo y rector ordenador.",
            "2": "Trampa de la legitimidad comunitaria: que la Asociación de Padres autorice giros parece participación y cierra la propuesta del segundo actor. El Decreto 1286 no la convierte en administradora del FSE.",
            "3": "Trampa del criterio pedagógico de caja: que el Consejo Académico priorice rubros suena a calidad del servicio. Esa instancia orienta el currículo, no el presupuesto ni la ordenación del gasto del Fondo.",
        },
    },
    {
        "id": "dir-apt-ges-71",
        "options": [
            "Aceptar la tesis del concejal: que el colegio financie y contrate toda la planta docente con recursos propios de caja, como si el SGP no organizara transferencias ni competencias entre Nación y entidades territoriales.",
            "Establecer, con la Ley 715, la distribución de recursos de la Nación hacia las entidades territoriales certificadas para prestar el servicio educativo, con competencias diferenciadas, y no con un relato de caja del colegio.",
            "Centralizar la contratación docente en el Ministerio de Educación Nacional, de modo que la entidad territorial y la IE queden al margen de la planta y de las transferencias del Sistema General de Participaciones.",
            "Tratar el SGP como un marco que regula la evaluación de los estudiantes y deja el financiamiento por fuera, desplazando la Ley 715 hacia el SIEE y el Decreto 1290 que la visita no pidió.",
        ],
        "explanation": "La condición de calidad pregunta qué establece el SGP para educación en el desacuerdo entre el concejal y el rector; la visita pide el marco de la Ley 715, no un relato de caja. El Sistema General de Participaciones organiza la distribución de recursos de la Nación hacia las entidades territoriales y define competencias para prestar el servicio educativo. No obliga al colegio a contratar toda la planta con recursos propios, que es la tesis del concejal. Tampoco centraliza la contratación docente en el MEN: la Ley 715 descentraliza planta y administración en las entidades certificadas. Regular la evaluación de estudiantes es objeto del Decreto 1290 y del SIEE, no del SGP. La opción correcta separa transferencias y competencias de tesorería institucional y de evaluación.",
        "normativeJustification": "La Ley 715 organiza el SGP y las competencias de la Nación y de las entidades territoriales certificadas para financiar y prestar el servicio educativo. No elimina la financiación estatal, no concentra la planta en el MEN ni regula el SIEE.",
        "theoreticalJustification": "El federalismo fiscal educativo distingue transferencia, competencia territorial y caja de la IE. La tesis del concejal, la recentralización en el MEN o el desplazamiento al 1290 leen otro problema que el que la visita formula.",
        "distractorAnalysis": {
            "0": "Trampa de la tesis del concejal: financiar la planta con caja propia parece autonomía y «esfuerzo local». Invierte el SGP: el colegio no es el financiador de la carrera docente ni sustituye las transferencias de la Ley 715.",
            "2": "Trampa de la recentralización en el MEN: concentrar la contratación docente en el Ministerio parece orden nacional. La Ley 715 hace lo contrario: asigna planta y administración a las entidades territoriales, no al relato de caja ni al MEN como empleador único.",
            "3": "Trampa de dominio cruzado del SIEE: leer el SGP como marco de evaluación es coherente con el Decreto 1290, que sí regula juicios y promoción. La visita pidió financiación y competencias, no el sistema de evaluación.",
        },
    },
    {
        "id": "dir-apt-ges-72",
        "options": [
            "Publicar un ranking comparable de sedes con el formato copiado del año anterior, para que la comunidad vea quién sube y quién baja y el Consejo Directivo reciba un tablero de imagen en vez de un diagnóstico.",
            "Identificar fortalezas y brechas en las cuatro áreas de gestión y traducirlas en insumos del plan de mejoramiento institucional, con evidencia para el Consejo Directivo y no con un ranking de sedes.",
            "Sustituir el PEI por un informe de prensa dirigido a la Secretaría, de forma que la autoevaluación se agote en comunicación externa y no produzca un plan de mejoramiento con las cuatro áreas.",
            "Reemplazar el PMI y el SIEE por un promedio de satisfacción familiar, presentado como evidencia comunitaria de calidad, sin diagnóstico de las cuatro áreas de gestión que pide el coordinador.",
        ],
        "explanation": "La condición de calidad pregunta el propósito principal de la autoevaluación institucional anual en ese ciclo de mejoramiento. La Guía 34 del MEN sitúa la autoevaluación como diagnóstico de fortalezas y brechas en las cuatro áreas de gestión —directiva, académica, administrativa-financiera y comunitaria— y como insumo del PMI. Copiar el formato del año anterior y publicar un ranking de sedes produce imagen, que es lo que el Consejo Directivo pide no recibir. Un informe de prensa no sustituye al PEI ni cierra el ciclo. Un promedio de satisfacción familiar puede ser un dato de gestión comunitaria, pero no reemplaza PMI ni SIEE. La opción del coordinador es la que articula evidencia y mejoramiento.",
        "normativeJustification": "La Guía 34 y el Decreto 1075 organizan el ciclo autoevaluación–PMI–seguimiento sobre las cuatro áreas de gestión. El ejercicio no es un ranking de sedes, un informe de prensa ni un sustituto del PEI o del SIEE.",
        "theoreticalJustification": "La mejora continua parte de un diagnóstico de brechas, no de una vitrina comparativa ni de un dato de satisfacción. Sin las cuatro áreas, el PMI no tiene objeto y el Consejo Directivo no recibe la evidencia que pide.",
        "distractorAnalysis": {
            "0": "Trampa del ranking de imagen: copiar el formato y publicar quién sube y quién baja parece transparencia y competencia sana entre sedes. Es el uso punitivo-mediático que el caso describe, no el propósito de autoevaluación del ciclo de mejoramiento.",
            "2": "Trampa del informe de prensa: comunicar a Secretaría con un recorte periodístico luce como rendición de cuentas. Sustituye el PEI y deja sin PMI el diagnóstico de las cuatro áreas que el coordinador pide.",
            "3": "Trampa de dominio cruzado de la satisfacción familiar: un promedio de familias es un dato real de gestión comunitaria. No reemplaza PMI ni SIEE y omite las cuatro áreas de la Guía 34 que el Consejo Directivo necesita como evidencia.",
        },
    },
]


def _sentences(text: str) -> int:
    parts = [p for p in re.split(r"(?<=[.!?])\s+", text.strip()) if p]
    return len(parts)


def validate(items: list) -> int:
    src = json.loads(SRC.read_text(encoding="utf-8"))
    errors = 0
    print("=== LONGITUDES ===")
    for i, (it, src_it) in enumerate(zip(items, src)):
        cid = it["id"]
        ci = CI[cid]
        assert src_it["id"] == cid
        assert src_it["correctIndex"] == ci
        extra = set(it.keys()) - KEYS_OK
        missing = KEYS_OK - set(it.keys())
        if extra or missing:
            print("KEYS", cid, extra, missing)
            errors += 1
        opts = it["options"]
        lengths = [len(o) for o in opts]
        skew = max(lengths) - min(lengths)
        flag = "OK" if skew < 180 else "SKEW"
        print(f"{cid} ci={ci} lens={lengths} skew={skew} {flag}")
        print(f"  expl={len(it['explanation'])} sent={_sentences(it['explanation'])} NJ={len(it['normativeJustification'])} TJ={len(it['theoreticalJustification'])}")
        if skew >= 180:
            errors += 1
        for oi, opt in enumerate(opts):
            if len(opt) < 80 or len(opt) > 340:
                print("  OPT RANGE", oi, len(opt))
                errors += 1
            if oi != ci and FORBIDDEN.search(opt):
                print("  FORBIDDEN", oi, FORBIDDEN.search(opt).group(0))
                errors += 1
            low = opt.lower()
            if oi != ci and any(x in low for x in OBVIOUS):
                print("  OBVIOUS", oi)
                errors += 1
            for bad in ("aunque ahorre", "aunque parezca", "aunque se presente"):
                if bad in low:
                    print("  MULETILLA", oi, bad)
                    errors += 1
        da = it["distractorAnalysis"]
        expected = [str(n) for n in range(4) if n != ci]
        if sorted(da.keys()) != expected:
            print("  DA KEYS", sorted(da.keys()), expected)
            errors += 1
        for k, v in da.items():
            if not v.startswith("Trampa"):
                print("  DA START", k, v[:40])
                errors += 1
            if len(v) < 80:
                print("  SHORT DA", k, len(v))
                errors += 1
        if len(it["explanation"]) < 280:
            print("  SHORT EXPL")
            errors += 1
        sent = _sentences(it["explanation"])
        if sent < 4 or sent > 7:
            print("  SENT COUNT", sent)
            errors += 1
        for field in ("normativeJustification", "theoreticalJustification"):
            if len(it[field]) < 80:
                print("  SHORT", field)
                errors += 1
        cruz = sum(1 for v in da.values() if "dominio cruzado" in v.lower())
        if cruz != 1:
            print("  CRUZADOS", cruz)
            errors += 1
    print("--- errors", errors)
    return errors


def main() -> int:
    errors = validate(ITEMS)
    OUT.write_text(
        json.dumps(ITEMS, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print("WROTE", OUT)
    # roundtrip
    loaded = json.loads(OUT.read_text(encoding="utf-8"))
    assert loaded == ITEMS
    print("JSON OK", len(loaded))
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
