# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ges-73..80 y dir-apt-ped-81..82 (posiciones 821-830) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_821_830.json"

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
    "dir-apt-ges-73": 1,
    "dir-apt-ges-74": 1,
    "dir-apt-ges-75": 1,
    "dir-apt-ges-76": 1,
    "dir-apt-ges-77": 1,
    "dir-apt-ges-78": 1,
    "dir-apt-ges-79": 1,
    "dir-apt-ges-80": 1,
    "dir-apt-ped-81": 1,
    "dir-apt-ped-82": 1,
}

ITEMS = [
    {
        "id": "dir-apt-ges-73",
        "options": [
            "Que el Consejo Directivo adopte en esta revisión el plan de estudios como órgano que aprueba el PEI y el currículo, sin consulta al Consejo Académico, y archive esa adopción como acto suficiente de gobierno escolar.",
            "Que el Consejo Académico oriente la revisión del plan de estudios como órgano consultivo del currículo, estudie el plan y las reformas y rinda concepto al Consejo Directivo, de acuerdo con el Decreto 1860 y la Ley 115.",
            "Que el Consejo de Padres ejerza veto sobre las reformas del plan de estudios, de modo que ninguna modificación curricular avance sin su autorización, y se presente esa facultad como participación de la comunidad educativa.",
            "Que la Contraloría Estudiantil emita un concepto de control sobre la malla y el plan de estudios, y que ese pronunciamiento condicione la revisión curricular como veeduría estudiantil de esta jornada de gobierno escolar.",
        ],
        "explanation": "La condición de calidad pide identificar el órgano consultivo del currículo en la revisión del plan de estudios, según el Decreto 1860. El Consejo Académico estudia el plan y las reformas, orienta la actividad pedagógica y rinde concepto al Directivo; no adopta por sí el PEI. El Consejo Directivo sí adopta el PEI y el plan de estudios, y por eso suena a instancia que decide: esa es adopción, no consulta curricular. El Consejo de Padres participa y puede opinar, pero no tiene veto sobre la malla. La Contraloría Estudiantil vigila recursos y transparencia, no el currículo. La decisión defendible es consultar al Académico y, después, adoptar en el Directivo.",
        "normativeJustification": "El Decreto 1860 y la Ley 115 distinguen funciones: el Consejo Académico es órgano consultivo del currículo y del plan de estudios; el Consejo Directivo adopta el PEI. El Consejo de Padres y la Contraloría Estudiantil no sustituyen esa consulta académica.",
        "theoreticalJustification": "Gobierno escolar no es una sola mesa. Quien adopta (Directivo) no es quien conceptúa el currículo (Académico). Un veto de padres o un control estudiantil de recursos miden participación o veeduría, no la orientación pedagógica del plan.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la adopción del PEI: el Consejo Directivo sí aprueba el plan de estudios y el PEI. Es impecable como gobierno escolar, pero el stem pide el órgano consultivo del currículo, que es el Académico, no quien adopta sin consulta.",
            "2": "Trampa del veto de padres como participación: exigir autorización del Consejo de Padres sobre la malla parece corresponsabilidad comunitaria. Esa instancia acompaña; no veta el plan de estudios ni sustituye al Consejo Académico.",
            "3": "Trampa de la veeduría estudiantil: la Contraloría Estudiantil es órgano de control de recursos y de transparencia. Convertirla en filtro curricular desplaza la consulta pedagógica a un control que el Decreto 1860 no le asigna.",
        },
    },
    {
        "id": "dir-apt-ges-74",
        "options": [
            "Extender el Decreto 1278 a toda la planta oficial, incluida la vinculada por el Decreto 2277, para unificar evaluación, ingreso y escalafón en un mismo estatuto, y presentar esa unificación como equidad de carrera docente.",
            "Aplicar el Decreto 1278 a los docentes y directivos docentes que ingresaron a la carrera a partir de junio de 2002, y conservar el Decreto 2277 para quienes se vincularon antes, sin fusionar estatutos ni trasladar el 1278 a la planta privada.",
            "Tomar el Decreto 1278 como estatuto de los rectores de instituciones educativas privadas, de modo que evaluación de desempeño y escalafón de ese régimen rijan su vinculación, y dejar al margen la planta oficial del caso.",
            "Aplicar el Decreto 1278 a los docentes vinculados antes de 1979, asimilándolos al nuevo estatuto por antigüedad de servicio, y usar esa fecha como criterio de cobertura de la carrera en la institución oficial.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente ante propuestas que mezclan estatutos. El Decreto 1278 de 2002 rige a docentes y directivos docentes que ingresaron a la carrera a partir de junio de 2002; el Decreto 2277 de 1979 sigue vigente para quienes se vincularon antes. Unificar toda la planta en el 1278 parece equidad de carrera y es un error de cobertura. Aplicar el 1278 a rectores de colegios privados confunde el estatuto de la carrera oficial con la vinculación privada. Retrotraer el 1278 a vinculados anteriores a 1979 mezcla otro régimen histórico. La decisión defendible distingue fechas de ingreso y no fusiona estatutos.",
        "normativeJustification": "El Decreto 1278 cubre el ingreso a la carrera docente oficial desde junio de 2002. El 2277 permanece para la planta anterior. Ni la unificación de personal, ni el régimen privado, ni la antigüedad previa a 1979 reescriben ese ámbito.",
        "theoreticalJustification": "Un estatuto se aplica por fecha y tipo de vinculación, no por conveniencia de gestión. Igualar a toda la planta, importar rectores privados o usar 1979 como umbral produce otro sujeto de derecho, no el del 1278.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la unificación de carrera: extender el 1278 al 2277 parece equidad de personal y un mismo escalafón. Es una política de planta plausible; no es el ámbito legal del 1278, que cubre el ingreso desde junio de 2002.",
            "2": "Trampa del estatuto privado: tratar el 1278 como régimen de rectores de colegios privados parece aplicar el estatuto docente. El 1278 es carrera oficial; no sustituye la vinculación privada ni responde al caso de la IE oficial.",
            "3": "Trampa del régimen anterior a 1979: asimilar por antigüedad a quienes se vincularon antes de esa fecha parece reconocer trayectoria. Es otro estatuto histórico; no es el ámbito de quienes ingresaron con el 1278.",
        },
    },
    {
        "id": "dir-apt-ges-75",
        "options": [
            "Adoptar en el SIEE los cinco niveles cualitativos propios que ya usa un área, elevarlos a escala institucional para todas las asignaturas y presentarlos como homologación interna más detallada que la escala nacional.",
            "Incluir en el SIEE la escala nacional de desempeños Superior, Alto, Básico y Bajo, de modo que las valoraciones de 1 a 100 y las de cinco niveles propios se homologuen para movilidad y reportes, según el Decreto 1290.",
            "Imponer la escala numérica de 1 a 100 que ya aplica la otra área como escala de reporte del SIEE, y convertir todas las valoraciones a centésimas para el boletín y la homologación entre asignaturas.",
            "Sostener que la autonomía del SIEE exime a la institución de reportar escala nacional, conservar las dos escalas de área como están y resolver la homologación con equivalencias internas del plan de estudios.",
        ],
        "explanation": "La condición de calidad pide la escala nacional que el SIEE debe incluir para homologar valoraciones entre áreas. El Decreto 1290 establece cuatro desempeños nacionales —Superior, Alto, Básico y Bajo— precisamente para movilidad y comparabilidad. Los cinco niveles propios de un área son autonomía institucional, no la escala nacional. La escala 1 a 100 de la otra área es un lenguaje numérico permitido, pero no sustituye el reporte nacional. Invocar la autonomía del SIEE para no reportar escala nacional invierte el 1290: hay autonomía para el sistema, no para omitir la escala de homologación. Incluir Superior, Alto, Básico y Bajo articula las dos prácticas del caso.",
        "normativeJustification": "El Decreto 1290 obliga a incluir la escala nacional (Superior, Alto, Básico y Bajo) en el SIEE para facilitar la movilidad. La autonomía institucional cubre criterios y estrategias, no la omisión de esa escala ni su reemplazo por cinco niveles propios o por 1 a 100.",
        "theoreticalJustification": "Homologar exige un referente común de desempeño, no la escala más detallada de un área ni la más numérica de otra. Cinco niveles internos y centésimas son lenguajes locales; la comparabilidad nacional del 1290 usa cuatro desempeños.",
        "distractorAnalysis": {
            "0": "Trampa de los cinco niveles propios: elevar la escala cualitativa de un área a escala institucional parece homologación interna más fina. No es la escala nacional del 1290; conserva el desajuste que coordinación quiere resolver.",
            "2": "Trampa de dominio cruzado de la escala 1 a 100: es el lenguaje numérico correcto de la otra área y facilita boletines. No es la escala nacional; imponerla como reporte deja fuera Superior, Alto, Básico y Bajo.",
            "3": "Trampa de la autonomía del SIEE: no reportar escala nacional parece defender el Decreto 1290. La autonomía cubre criterios y estrategias, no la omisión de la escala nacional exigida para movilidad.",
        },
    },
    {
        "id": "dir-apt-ges-76",
        "options": [
            "Dejar el reclamo de evaluación en el docente que asignó la calificación, de modo que su juicio cierre el expediente sin segunda instancia, y archivar esa decisión como rigor del SIEE y como autonomía de la cátedra.",
            "Elevar el reclamo de evaluación al Consejo Académico como segunda instancia, para que revise criterios, evidencias y procedimiento del SIEE, conforme al Decreto 1290 y a las funciones consultivas del Decreto 1860.",
            "Trasladar el reclamo de evaluación a la Personería Municipal, para que esa autoridad externa revise la nota y tutelage el derecho del estudiante, y dar por agotada la vía institucional con ese radicado.",
            "Elevar el reclamo de evaluación al Ministerio de Educación Nacional, para que el nivel central homogeneice el criterio de calificación y sustituya a las instancias del gobierno escolar de la institución.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente frente a un reclamo de evaluación. El Decreto 1290 exige procedimientos de reclamación; el Decreto 1860 atribuye al Consejo Académico el estudio del sistema de evaluación y del currículo. En la práctica institucional, el Académico actúa como segunda instancia cuando el docente ya calificó. Dejar el expediente en el mismo docente cierra el derecho de contradicción. La Personería tutelage derechos externos, no la nota del SIEE. El MEN no es instancia de un reclamo de aula. Elevar al Académico con criterios y evidencias es la ruta trazable.",
        "normativeJustification": "El Decreto 1290 prevé instancias de reclamación de la evaluación. El Decreto 1860 asigna al Consejo Académico el estudio del SIEE y del plan de estudios. Ni el docente evaluador en solitario, ni la Personería, ni el MEN son esa segunda instancia escolar.",
        "theoreticalJustification": "Una calificación se revisa en clave colegiada: criterios, evidencias y procedimiento. El mismo evaluador, una autoridad de derechos externos o el nivel ministerial miden cátedra, tutela o jerarquía, no la segunda instancia del SIEE.",
        "distractorAnalysis": {
            "0": "Trampa de la autonomía de cátedra: que el docente que calificó cierre el reclamo parece rigor del SIEE y respeto a su juicio. Elimina la segunda instancia y deja al evaluado sin revisión colegiada de criterios y evidencias.",
            "2": "Trampa de dominio cruzado de la Personería: radicar el reclamo de la nota en la Personería Municipal es impecable como tutela de derechos. Desplaza el SIEE a una autoridad externa y no agota la instancia académica interna.",
            "3": "Trampa de la jerarquía ministerial: elevar la nota al MEN parece garantía de homogeneidad nacional. El Ministerio no es segunda instancia de un reclamo de evaluación; esa función corresponde al Consejo Académico.",
        },
    },
    {
        "id": "dir-apt-ges-77",
        "options": [
            "Clasificar el episodio como falta leve, grave o gravísima copiada del código penal, abrir el expediente con esa graduación y omitir la ruta escolar de la Ley 1620 y de la Guía 49 para este caso de convivencia.",
            "Clasificar la situación como Tipo I, Tipo II o Tipo III, según la gravedad, la reiteración y el impacto, para activar la ruta proporcional del Comité Escolar de Convivencia, de acuerdo con la Ley 1620 y la Guía MEN 49.",
            "Tipificar el hecho como falta académica, disciplinaria o laboral, mezclando el régimen de estudiantes con el de personal, y tramitarlo como si fuera un proceso del Decreto 1278 o una nota del SIEE.",
            "Tipificar de entrada el episodio como Tipo III y activar denuncia ante autoridad, para que la rectoría muestre firmeza ante el caso, sin el análisis de gravedad e impacto que pide la ruta escolar.",
        ],
        "explanation": "La condición de calidad pide la clasificación que permite activar la ruta proporcional de convivencia. La Ley 1620, el Decreto 1965 y la Guía MEN 49 ordenan Tipo I, Tipo II y Tipo III según gravedad, reiteración e impacto, no según el código penal ni según el estatuto laboral. Copiar leve, grave y gravísima judicializa el episodio y omite el Comité Escolar de Convivencia. Mezclar académica, disciplinaria y laboral confunde estudiantes con personal del 1278. Tipificar de entrada como Tipo III para mostrar firmeza, como duda el rector, salta la proporcionalidad. Clasificar I-II-III orienta la atención y evita tanto la subtipificación de aula como la judicialización prematura.",
        "normativeJustification": "La Ley 1620 y la Guía MEN 49 clasifican las situaciones que afectan la convivencia en Tipo I, II y III, con ruta diferenciada. El código penal, el SIEE y el Decreto 1278 no sustituyen esa tipología ni autorizan a tratar todo el episodio como Tipo III.",
        "theoreticalJustification": "La proporcionalidad exige graduar impacto y reiteración antes de la medida. Un esquema penal, un mapa de personal o la firmeza de Tipo III miden sanción, nómina o imagen, no la ruta escolar de restablecimiento.",
        "distractorAnalysis": {
            "0": "Trampa del código penal escolarizado: leve, grave y gravísima suena a rigor jurídico conocido. No es la clasificación de la Ley 1620; deja el episodio sin ruta de Comité, orientación ni restablecimiento de derechos.",
            "2": "Trampa de dominio cruzado del 1278 y del SIEE: académica, disciplinaria y laboral es un mapa correcto de gestión de personal y de notas. Mezcla faltas de docentes con situaciones de estudiantes y no activa la ruta de convivencia.",
            "3": "Trampa de la firmeza como Tipo III: judicializar de entrada parece autoridad de rectoría ante el caso. Anula el análisis de gravedad e impacto y trata la agresión como presunto delito, contra la proporcionalidad de la Guía 49.",
        },
    },
    {
        "id": "dir-apt-ges-78",
        "options": [
            "Tomar el porcentaje de docentes con maestría como componente Progreso del ISCE, porque profesionaliza la planta y suele figurar en el PMI de calidad, y reportarlo como mejora institucional del año.",
            "Tomar como Progreso la mejora de los resultados institucionales en pruebas Saber respecto al año anterior, comparando el desempeño de la misma institución consigo misma, según la definición del Índice Sintético de Calidad Educativa.",
            "Tomar el número de estudiantes que permanecen en jornada única como Progreso del ISCE, porque amplía el tiempo escolar y suele defenderse como indicador de calidad en el informe de gestión de la vigencia.",
            "Tomar el estado de la infraestructura física como Progreso del ISCE, porque la planta y el mantenimiento son visibles en la visita de calidad y se asocian a mejores condiciones de aprendizaje.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre qué mide el componente Progreso del ISCE. Progreso compara los resultados de la institución en pruebas Saber con los del año anterior: es mejora relativa, no stock de títulos, de jornada ni de planta física. El porcentaje de docentes con maestría es un indicador válido de cualificación y suele ir al PMI, pero no es Progreso. La jornada única mide tiempo escolar. La infraestructura mide condiciones. La decisión defendible reporta la mejora Saber interanual, que es la definición del componente.",
        "normativeJustification": "El ISCE (ICFES/MEN) define Progreso como la variación de resultados Saber de la IE respecto al año anterior. Cualificación docente, jornada única e infraestructura son otros indicadores de gestión; no sustituyen ese componente.",
        "theoreticalJustification": "Un índice sintético distingue mejora de aprendizajes, nivel alcanzado, eficiencia y ambiente. Importar maestrías, jornada o muros al casillero de Progreso cambia el objeto medido y rompe la comparabilidad interanual.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la cualificación docente: el porcentaje con maestría es un indicador correcto de planta y de PMI. No mide Progreso del ISCE; confunde formación del profesorado con mejora de resultados Saber.",
            "2": "Trampa de la jornada única como calidad: el número de estudiantes en jornada única es política real de tiempo escolar. El ISCE no lo llama Progreso; mezcla cobertura de jornada con evolución de aprendizajes.",
            "3": "Trampa de la infraestructura visible: el estado de la planta física es trazable en visita de calidad. No es el componente Progreso; reporta condiciones, no la variación interanual de Saber.",
        },
    },
    {
        "id": "dir-apt-ges-79",
        "options": [
            "Que el rector defina de forma autónoma la planta de cargos de la institución, según la matrícula observada y las necesidades de la jornada, y comunique esa decisión como acto de dirección del PEI.",
            "Que la entidad territorial certificada defina la planta de personal docente y directivo docente con base en los criterios técnicos del Ministerio de Educación Nacional, y no el rector, el Consejo Directivo ni la Comisión Nacional del Servicio Civil.",
            "Que el Consejo Directivo de la institución apruebe la planta de cargos en sesión, como órgano de gobierno que adopta el presupuesto y el PEI, y deje esa aprobación como definición de la planta oficial.",
            "Que la Comisión Nacional del Servicio Civil fije la planta de la institución educativa, al ser la entidad del concurso de méritos, y que esa planta quede atada al número de vacantes del último proceso de selección.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre quién define la planta. La Ley 715 y el régimen de plantas asignan a la entidad territorial certificada la definición de la planta docente y directiva, con criterios técnicos del MEN (relación técnica, matrícula, jornadas). El rector ejecuta y organiza, no crea cargos de manera autónoma. El Consejo Directivo adopta PEI y presupuesto, no la planta oficial. La CNSC adelanta el concurso de méritos, no fija el número de cargos. La decisión defendible distingue nominación y concurso de la definición técnica de la planta.",
        "normativeJustification": "La entidad territorial certificada define la planta docente y directiva con parámetros técnicos del MEN. El rector no la crea por acto propio; el Consejo Directivo no la vota como PEI; la CNSC no la inventa al abrir un concurso.",
        "theoreticalJustification": "Definir planta, nombrar y seleccionar por mérito son operaciones distintas. Confundir liderazgo de rectoría, gobierno escolar o concurso con la competencia de la ETC produce un nominador equivocado.",
        "distractorAnalysis": {
            "0": "Trampa de la autonomía de rectoría: definir la planta según matrícula y jornada parece liderazgo pedagógico del PEI. El rector no crea la planta oficial; esa competencia es de la entidad territorial certificada con criterios del MEN.",
            "2": "Trampa del Consejo Directivo como nominador: aprobar la planta en sesión parece coherente con PEI y presupuesto. El Directivo adopta el gobierno institucional, no la planta de cargos que fija la ETC.",
            "3": "Trampa de dominio cruzado del concurso: la CNSC selecciona por mérito y provee vacantes. No define cuántos cargos existen; confundir selección con planta invierte el orden de la Ley 715.",
        },
    },
    {
        "id": "dir-apt-ges-80",
        "options": [
            "Sustituir el Proyecto Educativo Institucional por el PMI, de modo que el plan de mejoramiento reemplace la identidad, los fines y el currículo del PEI, como sugiere el docente tras la autoevaluación.",
            "Establecer metas, acciones, tiempos y responsables para superar las debilidades identificadas en la autoevaluación, articularlas a las cuatro áreas de gestión de la Guía 34 y conservar el PEI y el SIEE como marcos vigentes.",
            "Redactar el PMI como el calendario académico del año, con fechas de periodos, recesos y pruebas institucionales, y presentarlo al Consejo Directivo como el plan de mejoramiento derivado de la autoevaluación.",
            "Reemplazar el Sistema Institucional de Evaluación de Estudiantes por el PMI, de modo que las metas de mejoramiento sustituyan criterios, promoción y escalas del SIEE adoptado por el Consejo Directivo.",
        ],
        "explanation": "La condición de calidad pide el propósito principal del Plan de Mejoramiento Institucional derivado de la autoevaluación. La Guía 34 articula autoevaluación, PMI y plan de acción: metas, acciones, tiempos y responsables para las debilidades halladas en las cuatro áreas de gestión. El PEI (artículo 73 de la Ley 115) es el horizonte identitario; el PMI no lo sustituye. El calendario académico es un instrumento de organización, no el PMI. El SIEE es el sistema de evaluación estudiantil; el PMI no lo reemplaza. Archivar el informe y seguir el PEI como está, como quiere el rector, deja la autoevaluación sin plan. La decisión defendible traduce hallazgos en mejora y conserva PEI y SIEE.",
        "normativeJustification": "La Guía 34 y el Decreto 1075 sitúan el PMI como plan de acción posterior a la autoevaluación. El PEI (Ley 115) y el SIEE (Decreto 1290) permanecen; ni el calendario ni la sustitución documental cumplen ese propósito.",
        "theoreticalJustification": "Mejorar es traducir brechas en metas y responsables. Reemplazar el PEI o el SIEE, o reducir el PMI a un calendario, cambia el objeto del plan y deja las debilidades de la autoevaluación sin intervención.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del PEI: sustituir el Proyecto Educativo por el PMI parece coherencia documental tras la autoevaluación. El PEI es el marco de identidad (Ley 115); el PMI es el plan de mejora, no su reemplazo.",
            "2": "Trampa del calendario como plan: fechar periodos, recesos y pruebas parece organización impecable. El calendario no atiende las debilidades de la autoevaluación ni asigna metas y responsables de mejora.",
            "3": "Trampa de reemplazar el SIEE: fundir evaluación estudiantil con el PMI parece un solo sistema de calidad. El Decreto 1290 conserva el SIEE; el PMI no redefine promoción ni escalas.",
        },
    },
    {
        "id": "dir-apt-ped-81",
        "options": [
            "Conservar en 4.° el canal de fotocopia y quiz cronometrado para todo el grupo, presentarlo como equidad de formato y evidencia comparable del SIEE, y dejar los ajustes de acceso para el día de la prueba.",
            "Diseñar desde el inicio múltiples formas de representación, de acción y expresión, y de motivación y compromiso, de modo que materiales, evidencias e interés no dependan de la fotocopia y el quiz previstos para 4.°.",
            "Aumentar la frecuencia de calificaciones numéricas en 4.° sin cambiar la fotocopia ni las formas de evidenciar, para que el promedio se vea más denso y el SIEE registre más notas del mismo canal.",
            "Publicar un ranking del tiempo de clase y del ritmo del quiz, sin ofrecer opciones de acceso al contenido ni de expresión del aprendizaje, y presentarlo como transparencia del desempeño de 4.°.",
        ],
        "explanation": "La condición de calidad pide qué debe ofrecer la planeación desde el inicio, según el DUA y la evidencia del caso de 4.°. El Diseño Universal para el Aprendizaje, alineado con el Decreto 1421, exige múltiples formas de representación, de acción y expresión, y de motivación y compromiso, diseñadas de antemano, no un ajuste el día de la prueba. El canal de fotocopia y quiz cronometrado se vende como equidad de formato y es homogeneización. Aumentar la frecuencia de notas densifica el SIEE y no cambia materiales ni evidencias. El ranking de tiempo de clase expone ritmo y no ofrece acceso ni expresión. La planeación defendible diversifica los tres principios desde el diseño.",
        "normativeJustification": "El DUA y el Decreto 1421 piden accesibilidad desde el diseño: varias vías de percibir, de demostrar y de comprometerse. Un quiz homogéneo, más notas del mismo canal o un ranking de ritmo no cumplen esos tres principios ni el pedido del docente de apoyo.",
        "theoreticalJustification": "El DUA reduce barreras anticipando representación, expresión y compromiso. Igualar el instrumento, densificar calificaciones o publicar tiempos miden comparabilidad, promedio o velocidad, no el acceso al aprendizaje de 4.°.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la equidad de formato: fotocopia y quiz iguales para todos es evidencia comparable del SIEE. Homogeneiza el acceso, deja el ajuste para el día de la prueba y no diseña representación, expresión ni compromiso.",
            "2": "Trampa de la densidad numérica: más calificaciones parecen seguimiento formativo. Conservan el mismo canal de 4.° y no cambian materiales ni formas de evidenciar, que es lo que pide el DUA.",
            "3": "Trampa del ranking de ritmo: publicar tiempos de clase y del quiz parece transparencia. No ofrece opciones de acceso ni de expresión y convierte el DUA en exposición de velocidad.",
        },
    },
    {
        "id": "dir-apt-ped-82",
        "options": [
            "Mantener una calificación de cierre de periodo, sin devolución de proceso durante las semanas, y presentar ese número como evidencia comparable del SIEE y como trato igual para evitar reclamos.",
            "Brindar retroalimentación continua con criterios conocidos, devolver a cada estudiante su logro y un siguiente paso, y ajustar la enseñanza durante el periodo, de acuerdo con el carácter formativo del Decreto 1290 y del SIEE.",
            "Concentrar la evaluación en el último día del periodo, para que los estudiantes estudien todo el contenido de una vez, y usar esa prueba como el insumo principal de la valoración del área.",
            "Devolver el desempeño mediante un ranking entre estudiantes, para tratar a todos igual y reducir reclamos, y tomar esa comparación como la principal información de mejora del periodo.",
        ],
        "explanation": "La condición de calidad pide la práctica de evaluación más defendible para ajustar la enseñanza a tiempo. El Decreto 1290 concibe la evaluación como formativa, continua y con criterios públicos: retroalimentar durante el periodo permite corregir los errores que hoy se repiten. Una calificación de cierre, que es la práctica actual del área, documenta el producto y no orienta el proceso. Evaluar el último día para que estudien todo el contenido comprime la evidencia y llega tarde para enseñar. El ranking para tratar a todos igual homogeneiza y no devuelve un siguiente paso. La decisión defendible es retroalimentación continua anclada al SIEE.",
        "normativeJustification": "El Decreto 1290 y el SIEE exigen evaluación formativa, criterios conocidos y uso de los resultados para mejorar. Una nota de cierre, un examen de último día o un ranking entre pares no permiten ajustar la enseñanza durante el periodo.",
        "theoreticalJustification": "Se forma cuando hay devolución oportuna y un siguiente paso. El cierre sumativo, la prueba tardía y la comparación entre estudiantes miden producto, control de estudio o equidad aparente, no mediación a tiempo.",
        "distractorAnalysis": {
            "0": "Trampa del cierre sumativo comparable: una nota de periodo sin devolución semanal parece SIEE limpio y trato igual. Llega tarde para ajustar la enseñanza y deja que se repitan los mismos errores del caso.",
            "2": "Trampa del examen de último día: concentrar la prueba al cierre parece rigor y estudio integral. Impide la retroalimentación continua y no permite ajustar la enseñanza a tiempo, que es lo que pide el stem.",
            "3": "Trampa de dominio cruzado de la equidad homogeneizadora: el ranking para tratar a todos igual reduce reclamos y parece imparcial. Compara estudiantes entre sí y no devuelve criterios ni un siguiente paso de mejora.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {k: it[k] for k in ("id", "options", "explanation", "normativeJustification", "theoreticalJustification", "distractorAnalysis")}


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
                if "solo tipo iii" in low:
                    errors.append(f"SOLO TIPO III {tag} idx {oi}")
                if low.startswith("solo calificación") or "solo calificación" in low:
                    errors.append(f"SOLO CALIFICACION {tag} idx {oi}")
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
        expl = it.get("explanation") or ""
        if len(expl) < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(expl)}")
        n_sent = expl.count(".") + expl.count("?") + expl.count("!")
        if n_sent < 4 or n_sent > 8:
            errors.append(f"SENTENCES {tag} {n_sent}")
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
