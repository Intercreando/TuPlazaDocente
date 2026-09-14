# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ges-163..172 (posiciones 911-920) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_911_920.json"

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
    "dir-apt-ges-163": 2,
    "dir-apt-ges-164": 3,
    "dir-apt-ges-165": 0,
    "dir-apt-ges-166": 1,
    "dir-apt-ges-167": 2,
    "dir-apt-ges-168": 3,
    "dir-apt-ges-169": 0,
    "dir-apt-ges-170": 1,
    "dir-apt-ges-171": 2,
    "dir-apt-ges-172": 3,
}

ITEMS = [
    {
        "id": "dir-apt-ges-163",
        "options": [
            "Adoptar la propuesta del primer actor: que la evaluación del período de prueba sustituya la evaluación anual de desempeño de los años posteriores, una vez el docente quede inscrito en el escalafón 1278.",
            "Usar esa evaluación, como insiste el segundo actor, para fijar el salario inicial del nombramiento y dejar el básico de nómina amarrado al puntaje obtenido en el período de prueba.",
            "Determinar, con la evaluación del período de prueba, si el docente reúne las condiciones idóneas para continuar en la carrera docente tras superar el concurso de méritos, con evidencia y no por circular.",
            "Adoptar la propuesta del tercero: que esa evaluación reemplace la valoración de antecedentes del concurso de la CNSC y se tome en la IE como etapa de ingreso ya superada.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre la finalidad de esa evaluación. El Decreto 1278 la usa para determinar si el docente reúne condiciones idóneas para continuar en la carrera tras el concurso. No sustituye la evaluación anual de desempeño de años posteriores, como propone el primer actor. Tampoco fija el salario inicial del nombramiento ni reemplaza la valoración de antecedentes de la CNSC. Cierra el ingreso a carrera, no la nómina ni el concurso ya superado.",
        "normativeJustification": "El Decreto 1278 de 2002 destina la evaluación del período de prueba a verificar idoneidad para la inscripción definitiva en el escalafón. La evaluación anual de desempeño, la fijación salarial y la valoración de antecedentes del concurso son actos distintos, con momentos y autoridades propias.",
        "theoreticalJustification": "Un período de prueba juzga permanencia en carrera después del mérito. Confundirlo con el ciclo anual, con el básico de nómina o con los antecedentes del concurso cambia el objeto: de idoneidad a ahorro de evaluación, a salario o a etapa ya cerrada.",
        "distractorAnalysis": {
            "0": "Trampa de sustituir el ciclo anual: usar el período de prueba para reemplazar la evaluación de desempeño de años posteriores parece eficiencia 1278. Esa evaluación decide la continuidad en carrera, no anula el ciclo anual posterior al concurso.",
            "1": "Trampa de dominio cruzado de nómina: fijar el salario inicial del nombramiento con el período de prueba es una operación salarial impecable. El stem pide la finalidad pedagógica e institucional de esa evaluación, no el básico de planta.",
            "3": "Trampa de reemplazar el concurso: tomar el período de prueba como valoración de antecedentes de la CNSC parece cerrar el ingreso. Los antecedentes ya se valoraron; aquí se juzga idoneidad para permanecer en carrera.",
        },
    },
    {
        "id": "dir-apt-ges-164",
        "options": [
            "Tratar la inscripción en el escalafón 1278 como etapa previa a la prueba de aptitudes, como si el ingreso a carrera ya hubiera ocurrido antes del concurso de méritos administrado por la CNSC.",
            "Incorporar una entrevista del Consejo Directivo como filtro de pertinencia institucional, de modo que el gobierno escolar valide al candidato antes de la valoración de antecedentes.",
            "Sustituir la prueba de aptitudes y competencias por el curso de inducción de la entidad territorial certificada, argumentando que esa inducción ya acredita el mérito para el cargo docente.",
            "Adelantar la valoración de antecedentes académicos y de experiencia, posterior a la prueba de aptitudes y competencias básicas, como etapa propia del concurso de méritos de la CNSC.",
        ],
        "explanation": "La condición de calidad pregunta qué decisión es la más defendible pedagógica e institucionalmente al identificar una etapa propia del concurso. Tras la prueba de aptitudes y competencias básicas procede la valoración de antecedentes académicos y de experiencia. Inscribirse antes en el escalafón 1278 confunde el ingreso a carrera con el concurso. La entrevista del Consejo Directivo es gobierno escolar, no etapa de selección. El curso de inducción de la ETC no reemplaza la prueba de aptitudes.",
        "normativeJustification": "El concurso docente de la CNSC incluye, después de la prueba eliminatoria de aptitudes y competencias, la valoración de antecedentes como parte del puntaje. El escalafón 1278, el Consejo Directivo y la inducción de la ETC no son etapas de ese proceso de selección.",
        "theoreticalJustification": "Seleccionar por mérito ordena prueba y luego antecedentes. Adelantar el escalafón, filtrar por gobierno escolar o sustituir la prueba por inducción territorial cambia el objeto: de concurso nacional a ingreso, a PEI o a capacitación de planta.",
        "distractorAnalysis": {
            "0": "Trampa de confundir ingreso con concurso: inscribirse en el escalafón 1278 antes de la prueba parece ordenar la carrera. El escalafón es efecto del nombramiento, no una etapa previa del concurso de la CNSC.",
            "1": "Trampa de dominio cruzado de gobierno escolar: la entrevista del Consejo Directivo es un filtro plausible de pertinencia institucional. El stem pide una etapa propia del concurso de la CNSC, no un aval del PEI al candidato.",
            "2": "Trampa de la inducción territorial: el curso de la ETC parece acreditar mérito y ahorrar la prueba. La inducción forma a quien ya fue seleccionado; no reemplaza aptitudes y competencias del concurso.",
        },
    },
    {
        "id": "dir-apt-ges-165",
        "options": [
            "Dos años desde su conformación, salvo disposición distinta en el acto administrativo del concurso, de modo que talento humano no conserve la lista de manera indefinida para el elegible.",
            "Diez años como derecho adquirido del puntaje de la prueba, según el elegible que pide el nombramiento cuando quiera porque, a su juicio, la lista no vence.",
            "Seis meses como regla de celeridad de la entidad territorial certificada para proveer vacantes, con independencia del término que fije el acto administrativo del concurso.",
            "Vigencia indefinida de la lista mientras el elegible conserve el puntaje de la prueba, de modo que el ingreso a carrera quede abierto hasta agotar los nombramientos.",
        ],
        "explanation": "La condición de calidad pregunta, de manera general, la vigencia de las listas de elegibles de un concurso docente. La regla habitual es de dos años desde la conformación, salvo que el acto del concurso disponga otro término. El elegible no puede pedir el nombramiento cuando quiera como derecho de diez años. Talento humano de la ETC no reduce esa vigencia a seis meses por celeridad. Conservar el puntaje no deja la lista indefinida ni autoriza al rector a guardarla.",
        "normativeJustification": "En los concursos docentes de la CNSC las listas de elegibles tienen, por regla general, vigencia de dos años contados desde su conformación, salvo que el acto administrativo del concurso establezca un término distinto. No hay derecho adquirido de diez años ni vigencia indefinida por conservar el puntaje.",
        "theoreticalJustification": "Una lista de elegibles es un acto de selección con término, no un derecho de carrera perpetuo. Alargar a diez años, recortar a seis meses por celeridad o dejarla indefinida mientras dure el puntaje cambia el objeto: de vigencia del concurso a patrimonio personal o a meta de provisión.",
        "distractorAnalysis": {
            "1": "Trampa del derecho adquirido: diez años y nombramiento cuando quiera parece proteger el puntaje del elegible. La lista vence; el puntaje no convierte el concurso en un cupo abierto de manera indefinida.",
            "2": "Trampa de la celeridad territorial: seis meses parece una regla eficaz de provisión de la ETC. El término lo fija el acto del concurso, de ordinario dos años, no un recorte interno de talento humano.",
            "3": "Trampa de dominio cruzado de carrera: vigencia indefinida mientras se conserve el puntaje parece ingreso abierto a planta. El stem pregunta la vigencia de la lista de elegibles, no la permanencia del puntaje en la carrera ya nombrada.",
        },
    },
    {
        "id": "dir-apt-ges-166",
        "options": [
            "Consolidar el listado de prohibiciones, sanciones y uniforme como núcleo del manual actual, de modo que la visita encuentre un código punitivo escolar sin pautas, debido proceso ni rutas de la Ley 1620.",
            "Incluir pautas de comportamiento esperado, debido proceso ante faltas y rutas de atención integral, que es el mínimo de convivencia escolar que el comité echa en falta en el manual actual.",
            "Anexar el horario de clase y el calendario de izadas de bandera como pacto de convivencia del calendario, y presentar ese anexo como el contenido mínimo que exige la normatividad escolar.",
            "Incorporar el reglamento interno de trabajo del personal administrativo como capítulo del manual, unificando convivencia escolar y régimen laboral en el mismo documento institucional.",
        ],
        "explanation": "La condición de calidad pregunta qué debe contener, como mínimo, el manual de convivencia según la normatividad escolar. La Ley 1620 y su reglamentación exigen pautas de comportamiento esperado, debido proceso ante faltas y rutas de atención integral. El listado de prohibiciones, sanciones y uniforme del manual actual no cubre ese mínimo. El horario y las izadas de bandera son calendario, no pacto de convivencia. El reglamento interno de trabajo regula al personal y no es capítulo del manual escolar.",
        "normativeJustification": "La Ley 1620 de 2013 y el Decreto 1965, con la Guía 49 del MEN, fijan como contenido mínimo del manual las pautas de comportamiento, el debido proceso y las rutas de atención integral. Ni el uniforme punitivo, ni el calendario, ni el RIT sustituyen ese núcleo.",
        "theoreticalJustification": "Un manual de convivencia forma y protege; no es un código penal escolar ni un anexo de jornada. Reducirlo a sanciones, al calendario o al reglamento laboral cambia el objeto: de ruta 1620 a disciplina visible, a horario o a planta.",
        "distractorAnalysis": {
            "0": "Trampa del código punitivo: prohibiciones, sanciones y uniforme parecen rigor para la visita, que es el manual actual del caso. Faltan pautas, debido proceso y rutas; el mínimo 1620 no es un listado sancionatorio.",
            "2": "Trampa del pacto de calendario: horario e izadas de bandera parecen un acuerdo cotidiano de convivencia. Son organización de la jornada, no el contenido mínimo de pautas, debido proceso y rutas de atención.",
            "3": "Trampa de dominio cruzado laboral: incorporar el RIT del personal como capítulo del manual unifica documentos de planta. El stem pide el mínimo de convivencia escolar, no el régimen de los trabajadores administrativos.",
        },
    },
    {
        "id": "dir-apt-ges-167",
        "options": [
            "Unificar el manual de convivencia y el reglamento interno de trabajo en un tomo con dos carátulas, para no duplicar textos y amonestar al administrativo por el horario laboral con un expediente común.",
            "Invertir los ámbitos: aplicar el reglamento interno de trabajo a los estudiantes y el manual de convivencia al personal, como pretenden al amonestar al administrativo por el horario laboral.",
            "Distinguir que el manual regula la relación con estudiantes y comunidad educativa, y el reglamento interno de trabajo las relaciones laborales del personal, de modo que el horario del administrativo no se amonesta con el manual escolar.",
            "Aplicar el manual de convivencia al docente y al administrativo por igual, como anexo de la evaluación de desempeño del 1278, para unificar el trato disciplinario de toda la planta.",
        ],
        "explanation": "La condición de calidad pregunta la diferencia principal entre el manual de convivencia y el reglamento interno de trabajo. El manual regula la relación con estudiantes y comunidad educativa; el RIT, las relaciones laborales del personal. Unificarlos en un tomo con dos carátulas no elimina esa diferencia de ámbitos. Invertir los textos para amonestar al administrativo por horario aplica el instrumento equivocado. El manual no es anexo de desempeño 1278 para docente y administrativo por igual.",
        "normativeJustification": "La Ley 1620 sitúa el manual en la convivencia de la comunidad educativa. El Código Sustantivo del Trabajo y la Resolución 652 regulan el RIT y la convivencia laboral del personal. El Decreto 1278 evalúa desempeño docente; no convierte el manual escolar en régimen del administrativo.",
        "theoreticalJustification": "Cada instrumento cubre un sujeto y un conflicto. Fusionarlos en un expediente, invertirlos o anexarlos al 1278 cambia el objeto: de diferencia de ámbitos a celeridad documental, a uso invertido o a evaluación de planta.",
        "distractorAnalysis": {
            "0": "Trampa de unificar en un tomo: dos carátulas y un expediente común parecen evitar duplicar textos y agilizar la amonestación. El horario del administrativo sigue siendo materia del RIT, no del manual de convivencia.",
            "1": "Trampa de invertir ámbitos: usar el RIT con estudiantes y el manual con el personal parece dar cauce al pedido de amonestar al administrativo. Es el uso invertido del caso; cada texto conserva su sujeto.",
            "3": "Trampa de dominio cruzado del 1278: aplicar el manual a docente y administrativo como anexo de desempeño unifica disciplina de planta. El stem pide la diferencia de ámbitos, no un capítulo de evaluación de carrera.",
        },
    },
    {
        "id": "dir-apt-ges-168",
        "options": [
            "Atender faltas Tipo I de estudiantes cuando hay un adulto involucrado, para unificar la ruta del conflicto entre los dos docentes con el Comité Escolar de Convivencia al que el rector remitió el caso.",
            "Sustituir al Comité Escolar de Convivencia de la Ley 1620 en conflictos de aula entre pares y docentes, de modo que la instancia laboral absorba las situaciones de estudiantes y educadores.",
            "Avalar el manual de convivencia institucional en lugar del Consejo Directivo, de modo que el Comité de Convivencia Laboral asuma la adopción del pacto escolar de la comunidad educativa.",
            "Prevenir y atender situaciones de acoso laboral entre los trabajadores de la institución, como el conflicto entre los dos docentes que el rector remitió, por error, al Comité Escolar de Convivencia.",
        ],
        "explanation": "La condición de calidad pregunta el propósito principal del Comité de Convivencia Laboral creado por la Resolución 652 de 2012. Esa instancia previene y atiende el acoso laboral entre los trabajadores de la institución, como el conflicto entre los dos docentes. No es la vía para faltas Tipo I de estudiantes cuando hay un adulto involucrado. Tampoco sustituye al Comité Escolar de Convivencia de la Ley 1620 en el aula. Avalar el manual de convivencia corresponde al Consejo Directivo, no a este comité laboral.",
        "normativeJustification": "La Resolución 652 de 2012 crea el Comité de Convivencia Laboral para prevenir y atender el acoso entre trabajadores. El Comité Escolar de Convivencia (Ley 1620) cubre estudiantes; el Consejo Directivo adopta el manual. El rector no puede remitir el acoso entre docentes a la instancia de aula.",
        "theoreticalJustification": "Acoso laboral y convivencia escolar son rutas distintas. Unificar Tipo I, absorber el aula o adoptar el manual cambia el objeto: de protección al trabajador a ruta 1620, a mediación de clase o a gobierno del PEI.",
        "distractorAnalysis": {
            "0": "Trampa de unificar con Tipo I: atender faltas de estudiantes cuando hay un adulto involucrado parece alinear la ruta que el rector ya activó. El conflicto es entre dos docentes; no es una falta Tipo I del Comité Escolar.",
            "1": "Trampa de absorber el aula: sustituir al Comité Escolar 1620 en conflictos entre pares y docentes parece una instancia única. La 652 no desplaza la ruta de estudiantes; cubre acoso entre trabajadores.",
            "2": "Trampa de dominio cruzado de gobierno escolar: avalar el manual en lugar del Consejo Directivo es una función plausible de adopción normativa. El propósito del comité laboral es el acoso entre trabajadores, no el pacto de convivencia.",
        },
    },
    {
        "id": "dir-apt-ges-169",
        "options": [
            "Ascender de grado o de nivel salarial dentro del escalafón, según el desempeño demostrado en la evaluación de competencias, y no por los años de servicio que el docente 1278 pretende hacer valer.",
            "Homologar el concurso de méritos de la CNSC cuando la evaluación de competencias resulte alta, de modo que el docente ingrese a la carrera sin haber superado ese concurso.",
            "Obtener el nombramiento definitivo al cerrar el primer año lectivo si el PMI lo pide, como si esa evaluación cerrara el período de prueba sin acto de la entidad territorial certificada.",
            "Sustituir la evaluación anual de desempeño por un diplomado de actualización, de modo que la formación continua reemplace el ciclo 1278 de valoración anual del docente.",
        ],
        "explanation": "La condición de calidad pregunta qué permite la evaluación de competencias en el Decreto 1278 de 2002. Permite ascender de grado o de nivel salarial según el desempeño demostrado, no por años de servicio. Una calificación alta no homologa el concurso de la CNSC ni abre el ingreso a carrera sin méritos. Tampoco otorga nombramiento definitivo al cierre del primer año lectivo porque lo pida el PMI. Un diplomado de actualización no reemplaza la evaluación anual de desempeño.",
        "normativeJustification": "El Decreto 1278 reserva la evaluación de competencias al ascenso de grado y a la reubicación de nivel salarial. El ingreso exige concurso de la CNSC; el período de prueba y la evaluación anual de desempeño son mecanismos distintos, no sustituibles por el PMI ni por un diplomado.",
        "theoreticalJustification": "Competencias en carrera miden progreso salarial, no ingreso ni cierre de prueba. Homologar el concurso, nombrar por el PMI o reemplazar el ciclo anual con formación cambia el objeto: de ascenso a selección, a planta o a capacitación.",
        "distractorAnalysis": {
            "1": "Trampa de homologar el ingreso: una evaluación de competencias alta parece equivaler al concurso de la CNSC. El 1278 no abre carrera por esa vía; el concurso de méritos sigue siendo el ingreso.",
            "2": "Trampa del nombramiento por PMI: cerrar el primer año lectivo con nombramiento definitivo parece alinear planta y mejoramiento. Esa evaluación no sustituye el período de prueba ni el acto de la ETC.",
            "3": "Trampa de dominio cruzado de formación: el diplomado de actualización parece rigor profesional y reemplazo elegante del ciclo anual. El stem pregunta qué permite la evaluación de competencias, no un sustituto de la valoración anual de desempeño.",
        },
    },
    {
        "id": "dir-apt-ges-170",
        "options": [
            "Agrupar a los educadores 1278 por años de servicio, como en el Decreto 2277, sin cruzar el título académico, según el ordenamiento de nómina que los reúne en un nivel por antigüedad.",
            "Organizar a los educadores en grados según el título académico y en niveles salariales dentro de cada grado, como explica talento humano frente al agrupamiento de nómina por antigüedad.",
            "Fijar un nivel salarial común para todos los docentes oficiales de la planta, en nombre de la equidad, sin diferenciar grados por título ni niveles salariales dentro de cada grado.",
            "Clasificarlos por el número de estudiantes a cargo en cada jornada, tomando el cupo SIMAT como categoría de escalafón, pese a que el rector pide no usar esa cifra.",
        ],
        "explanation": "La condición de calidad pregunta cómo organiza el escalafón docente del Decreto 1278 de 2002 a los educadores. Los organiza en grados según el título académico y en niveles salariales dentro de cada grado. El agrupamiento de nómina por años de servicio replica la lógica del 2277 y omite el título. Un nivel salarial común para toda la planta no es equidad de escalafón. El número de estudiantes a cargo en cada jornada es un dato de cobertura, no una categoría de carrera.",
        "normativeJustification": "El Decreto 1278 estructura el escalafón en grados asociados a la formación académica y en niveles salariales al interior de cada grado. El 2277 ponderaba antigüedad de otro modo; ni la equidad de planta ni el SIMAT reescriben esa estructura.",
        "theoreticalJustification": "El escalafón 1278 cruza título y nivel, no tiempo ni cupo. Ordenar por antigüedad, igualar el básico o clasificar por estudiantes a cargo cambia el objeto: de carrera profesional a nómina del 2277, a homogeneidad o a cobertura.",
        "distractorAnalysis": {
            "0": "Trampa del 2277 por antigüedad: agrupar por años de servicio parece el ordenamiento de nómina del caso. El 1278 no omite el título; los grados dependen de la formación académica, no del tiempo de servicio.",
            "2": "Trampa de la equidad de planta: un nivel salarial común parece trato igual para todos los oficiales. El escalafón diferencia grados y niveles; homogeneizar el básico niega esa organización.",
            "3": "Trampa de dominio cruzado SIMAT de cobertura: clasificar por estudiantes a cargo en cada jornada es un indicador plausible de carga. El stem pregunta la organización del escalafón 1278, no el cupo de la jornada.",
        },
    },
    {
        "id": "dir-apt-ges-171",
        "options": [
            "Encargar el PIAR al médico especialista que envió el diagnóstico, tratándolo como documento clínico que sustituye los ajustes de aula mientras la secretaría no visita la sede.",
            "Esperar a que la Secretaría de Educación visite la sede y elabore el PIAR, argumentando que la institución no puede ajustar sin esa visita previa al estudiante con discapacidad.",
            "Elaborar el PIAR el docente de aula, con apoyo del docente de apoyo pedagógico y participación de la familia; el diagnóstico informa, no reemplaza el plan de aula ni la corresponsabilidad cotidiana.",
            "Unificar el PIAR desde rectoría, sin el docente de aula, para un criterio institucional visible y responder al sector de la comunidad que pide una salida inmediata frente al ingreso.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre quién elabora el PIAR. El Decreto 1421 lo sitúa en el aula: lo arma el docente de aula con apoyo pedagógico y participación de la familia. El diagnóstico del médico informa, no convierte el PIAR en documento clínico. La Secretaría apoya el sistema y no sustituye el plan de aula a la espera de una visita. El rector no unifica el PIAR sin el docente para una salida institucional visible.",
        "normativeJustification": "El Decreto 1421 de 2017 concibe el PIAR como herramienta de la atención educativa, elaborada por el docente de aula con apoyo pedagógico y participación familiar. El diagnóstico clínico y la Secretaría aportan; no sustituyen esa corresponsabilidad ni el liderazgo del aula.",
        "theoreticalJustification": "Los ajustes razonables ocurren en la enseñanza cotidiana. Medicalizar el plan, esperar la visita territorial o unificarlo en rectoría cambia el objeto: de aula inclusiva a dictamen, a trámite de calidad o a gesto de gestión.",
        "distractorAnalysis": {
            "0": "Trampa de medicalizar el PIAR: encargarlo al especialista que envió el diagnóstico parece rigor clínico mientras no hay visita. El 1421 no convierte el plan de aula en documento médico; el diagnóstico informa, no lo reemplaza.",
            "1": "Trampa de la visita previa: esperar a que la Secretaría elabore el PIAR parece respetar el sistema de inclusión. La IE ajusta en el aula; la visita no es condición para que el docente de aula arme el plan.",
            "3": "Trampa de dominio cruzado de gestión: unificar el PIAR desde rectoría, sin el docente de aula, ofrece criterio institucional visible. El stem pide la decisión pedagógica del 1421, no un acto de rectoría que sustituya al aula.",
        },
    },
    {
        "id": "dir-apt-ges-172",
        "options": [
            "Atribuir la autorización formal al Consejo Directivo, como acto de gobierno escolar, de modo que el permiso de tres días quede resuelto en esa instancia y no en talento humano de la secretaría.",
            "Dejar la autorización formal del permiso de tres días en la asociación de padres, como instancia de participación que vigila el uso del tiempo de la planta docente y el servicio que las familias sostienen.",
            "Atribuir la autorización al Consejo Académico, por ser órgano consultivo del plan de estudios, de modo que el permiso se valore según el impacto curricular de los tres días de ausencia.",
            "Reservar la autorización formal a la entidad territorial certificada, a través de la dependencia de talento humano de la Secretaría de Educación, más allá del reporte inicial al rector.",
        ],
        "explanation": "La condición de calidad pregunta quién tiene la competencia para autorizar formalmente permisos y licencias de un docente oficial. Esa autorización corresponde a la entidad territorial certificada, a través de talento humano de la Secretaría de Educación. El reporte al rector no equivale al acto formal del permiso de tres días. El Consejo Directivo no resuelve esa ausencia como gobierno escolar. El Consejo Académico asesora el plan de estudios y no otorga licencias.",
        "normativeJustification": "La administración de la planta docente oficial, incluidos permisos y licencias, corresponde a la entidad territorial certificada por medio de talento humano. El rector reporta; el Consejo Directivo, la asociación de padres y el Consejo Académico no expiden ese acto.",
        "theoreticalJustification": "Un permiso de planta es acto de empleador territorial, no de gobierno escolar ni de currículo. Resolverlo en el Consejo Directivo, en las familias o en el Consejo Académico cambia el objeto: de competencia laboral a PEI, a veeduría o a plan de estudios.",
        "distractorAnalysis": {
            "0": "Trampa de gobierno escolar: autorizar en el Consejo Directivo parece un acto institucional sólido frente al permiso de palabra del rector. Esa instancia no administra la planta; el acto formal es de la ETC.",
            "1": "Trampa de la veeduría de padres: dejar el permiso en la asociación parece control social del tiempo docente. La participación familiar no sustituye la competencia de talento humano de la secretaría.",
            "2": "Trampa de dominio cruzado curricular: el Consejo Académico, como órgano consultivo del plan de estudios, parece la instancia idónea para pesar los tres días de ausencia. El stem pide quién autoriza formalmente el permiso, no quién asesora el currículo.",
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
