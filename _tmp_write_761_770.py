# -*- coding: utf-8 -*-
"""Reescribe dir-apt-lec-13..20 y dir-apt-num-21..22 y valida el lote 761-770."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_761_770.json"

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
    "adelantar contenidos",
)
KEYS_OK = {
    "id",
    "options",
    "explanation",
    "normativeJustification",
    "theoreticalJustification",
    "distractorAnalysis",
}

ITEMS = [
    {
        "id": "dir-apt-lec-13",
        "options": [
            "Convertir el puntaje de la evaluación anual en un umbral de desvinculación o de traslado inmediato cuando el docente quede por debajo, y exhibirlo al Consejo Directivo como rigor del 1278 y como indicador del PMI.",
            "Identificar fortalezas y aspectos por mejorar y traducirlos en un plan de desarrollo profesional concertado entre el docente y su evaluador, de modo que la evaluación anual conserve su carácter formativo además del administrativo, según el texto.",
            "Sustituir el concurso de méritos como vía de ingreso a la carrera docente, de modo que el resultado de la evaluación anual reemplace el concurso y habilite el nombramiento en propiedad al amparo del Decreto 1278.",
            "Restringir el juicio de la evaluación anual a los saberes disciplinares del docente, omitiendo el plan de desarrollo concertado y el carácter formativo que el texto atribuye al proceso previsto en el Decreto 1278.",
        ],
        "explanation": "La condición de calidad pide un propósito que el texto sostenga, no un saber externo sobre el Estatuto 1278. El pasaje afirma que la evaluación anual de desempeño laboral tiene carácter formativo además de administrativo: identifica fortalezas y aspectos por mejorar y los traduce en un plan de desarrollo profesional concertado entre el docente y su evaluador. Esa es la lectura correcta. Convertir el puntaje en umbral de desvinculación o de traslado invierte lo formativo y lo vuelve sanción de calidad. Sustituir el concurso de méritos confunde el ingreso a la carrera con la evaluación anual. Restringir el juicio a los saberes disciplinares recorta el objeto que el texto describe y omite el plan concertado.",
        "normativeJustification": "El Decreto 1278 contempla la evaluación anual de desempeño con función formativa y administrativa. El texto ancla el propósito a un plan de desarrollo concertado con el evaluador; no autoriza a reemplazar el concurso de ingreso ni a reducir el juicio a la disciplina.",
        "theoreticalJustification": "La evaluación formativa identifica brechas para mejorar, no para sancionar de inmediato. Un ranking de calidad, el concurso de méritos o un recorte disciplinar miden ingreso, sanción o contenido, no el plan concertado que el pasaje describe.",
        "distractorAnalysis": {
            "0": "Trampa de la sanción como rigor del 1278: el umbral de desvinculación o traslado parece gestión de calidad y PMI. Invierte el carácter formativo del texto y convierte el puntaje anual en gatillo punitivo.",
            "2": "Trampa de dominio cruzado del concurso de ingreso: reemplazar el mérito por la evaluación anual luce coherente con el 1278. El texto no dice que el desempeño anual sustituya el concurso ni habilite la propiedad.",
            "3": "Trampa del recorte disciplinar: juzgar saberes de la asignatura parece rigor académico. Omite fortalezas, aspectos por mejorar y el plan concertado que el texto sitúa como propósito de la evaluación anual.",
        },
    },
    {
        "id": "dir-apt-lec-14",
        "options": [
            "Un docente elegido por sorteo entre sus pares en el consejo de docentes, para que el juicio anual resulte más horizontal y la institución exhiba participación colegiada ante la visita de calidad.",
            "El rector o coordinador, que el texto señala como evaluador habitual del proceso, con quien el docente concierta el plan de desarrollo profesional que se deriva de la evaluación anual de desempeño laboral.",
            "La Secretaría de Educación como instancia que asume el juicio anual de cada docente, de modo que el establecimiento se limite a remitir evidencias y no concierte el plan de desarrollo con un evaluador interno.",
            "Una comisión del Consejo de Padres, al amparo del Decreto 1286, que revise el desempeño docente con representantes por grado, confundiendo la participación familiar en el PEI con la evaluación anual del 1278.",
        ],
        "explanation": "La condición de calidad pregunta quién suele actuar como evaluador según el texto, no según un organigrama externo. El pasaje indica que el plan de desarrollo se concerta entre el docente y su evaluador, generalmente el rector o coordinador. Expandir esa figura no cambia el sentido: es el evaluador habitual del proceso descrito. El sorteo entre pares fabrica una colegialidad que el texto no enuncia. Trasladar el juicio a la Secretaría convierte la evaluación en trámite territorial. Una comisión del Consejo de Padres (1286) es dominio cruzado: participa en el PEI, no califica el desempeño anual del 1278.",
        "normativeJustification": "En el régimen del Decreto 1278 el evaluador del desempeño anual es, de ordinario, el rector o el coordinador. El Decreto 1286 organiza la participación de las familias; no las convierte en evaluadoras del docente. La Secretaría certifica y vigila, pero el texto no le asigna el juicio anual de cada aula.",
        "theoreticalJustification": "La concertación del plan de desarrollo exige un evaluador próximo al quehacer del docente. El sorteo entre pares, el juicio de Secretaría o una comisión de padres desplazan esa proximidad y leen otra instancia como si fuera el evaluador del caso.",
        "distractorAnalysis": {
            "0": "Trampa del sorteo colegiado: elegir un par al azar parece horizontalidad y participación para la visita. El texto no describe ese mecanismo y aleja la concertación del evaluador habitual (rector o coordinador).",
            "2": "Trampa de la Secretaría como juez anual: remitir evidencias al ente territorial parece legalidad y control. El texto sitúa el evaluador dentro de la IE y no sustituye la concertación interna del plan.",
            "3": "Trampa de dominio cruzado del 1286: una comisión del Consejo de Padres con representantes por grado luce como participación familiar. Confunde revisión del PEI con la evaluación de desempeño del 1278.",
        },
    },
    {
        "id": "dir-apt-lec-15",
        "options": [
            "El exceso de docentes de planta en las sedes rurales, que saturaría la nómina y explicaría la inestabilidad pedagógica, de modo que recortar nombramientos definitivos aparecería como vía para recuperar continuidad.",
            "La alta rotación de docentes, frecuentemente asociada a nombramientos provisionales, y su efecto sobre la continuidad de los procesos pedagógicos y sobre el fortalecimiento de una cultura institucional estable, como describe el texto.",
            "La falta de interés de los estudiantes rurales por aprender, presentada como causa de la inestabilidad, de modo que la rotación docente quedaría como efecto secundario y no como el problema que el texto sitúa en el centro.",
            "El exceso de presupuesto destinado a capacitación docente, rubro que el texto no menciona, de modo que recortar esa inversión aparecería como la vía para estabilizar la planta en zona rural.",
        ],
        "explanation": "La condición de calidad pide el problema principal que el texto describe, no un diagnóstico paralelo. El pasaje sitúa la alta rotación de docentes en instituciones rurales, frecuentemente asociada a nombramientos provisionales, como obstáculo para la continuidad pedagógica y para una cultura institucional estable. Esa es la idea central. El exceso de docentes de planta invierte el fenómeno: el texto habla de rotación, no de saturación de definitivos. La falta de interés estudiantil introduce una causa ajena. El presupuesto de capacitación es un rubro externo que el pasaje no enuncia y que desplaza el problema de la planta inestable.",
        "normativeJustification": "La gestión de planta en zona rural, incluidos los provisionales del régimen docente, impacta la continuidad del PEI. El texto no denuncia exceso de definitivos ni de presupuesto de formación; describe rotación y su efecto sobre procesos y cultura institucional.",
        "theoreticalJustification": "La cultura escolar se construye con permanencia del equipo. La rotación corta la memoria pedagógica. Inventar saturación de planta, desinterés estudiantil o un recorte de capacitación explica otro problema y no el que el pasaje coloca en el centro.",
        "distractorAnalysis": {
            "0": "Trampa de la inversión de planta: el exceso de definitivos parece un diagnóstico de nómina. El texto describe rotación y provisionales, no saturación, y recortar nombramientos definitivos agravaría la inestabilidad.",
            "2": "Trampa del desinterés estudiantil: atribuir la inestabilidad a la falta de interés del grupo rural parece un problema pedagógico de aula. El pasaje no lo menciona y desplaza la rotación docente del centro.",
            "3": "Trampa del recorte de capacitación: un exceso presupuestal no dicho luce como ineficiencia de calidad. El texto no habla de ese rubro y no lo presenta como causa de la rotación rural.",
        },
    },
    {
        "id": "dir-apt-lec-16",
        "options": [
            "Recortar el número de docentes contratados para estabilizar la planta rural, de modo que menos provisionales parezcan más continuidad, sin la inducción ni el acompañamiento entre pares que el texto describe.",
            "La inducción rápida y el acompañamiento entre pares, para que el docente nuevo se apropie en pocas semanas del Proyecto Educativo Institucional y de las dinámicas propias de la comunidad, según la estrategia que el texto atribuye a algunos rectores.",
            "Suprimir desde rectoría los nombramientos provisionales, como si esa competencia residiera en el establecimiento y no en la entidad territorial, y dar por resuelta la rotación sin inducción ni pares.",
            "Un plan de estímulos salariales de la Secretaría de Educación para retener provisionales en zona rural, medida de gestión de personal que el texto no enuncia y que desplaza la inducción y el acompañamiento descritos.",
        ],
        "explanation": "La condición de calidad pregunta qué estrategia institucional menciona el texto para mitigar la rotación, no qué haría un rector con facultades que no tiene. El pasaje señala inducción rápida y acompañamiento entre pares para que el docente nuevo se apropie en pocas semanas del PEI y de las dinámicas de la comunidad. Recortar contrataciones finge estabilidad al vaciar la planta. Suprimir provisionales desde rectoría atribuye al establecimiento una competencia de la entidad territorial y no está en el texto. El plan de estímulos salariales de Secretaría es conocimiento externo de gestión de personal: puede ser plausible en otro dominio, pero el pasaje no lo enuncia.",
        "normativeJustification": "El nombramiento provisional corresponde a la entidad territorial, no a un acto de rectoría. El texto mitiga el efecto de la rotación con inducción y pares para apropiar el PEI; no recorta planta ni crea un régimen salarial de retención.",
        "theoreticalJustification": "La inducción y el acompañamiento entre pares acortan el tiempo de apropiación cultural cuando la planta gira. Recortar cupos, vetar provisionales o esperar un estímulo salarial de Secretaría no son las mediaciones que el pasaje describe.",
        "distractorAnalysis": {
            "0": "Trampa de estabilizar recortando planta: menos contrataciones parecen más continuidad. El texto no propone vaciar la sede; describe inducción y pares para que el que llega se apropie del PEI.",
            "2": "Trampa de la competencia de rectoría: suprimir provisionales parece una decisión de gobierno escolar. Esa potestad no está en el texto ni reside en el establecimiento, y deja sin la estrategia de inducción.",
            "3": "Trampa de dominio cruzado salarial: el plan de estímulos de Secretaría luce como retención de personal rural. Es un saber de gestión externa que el pasaje no menciona y que desplaza la inducción y el acompañamiento.",
        },
    },
    {
        "id": "dir-apt-lec-17",
        "options": [
            "Tratar al Consejo de Padres y a la Asociación de Padres de Familia como la misma instancia con dos nombres, de modo que la participación en el PEI y el carácter voluntario de la persona jurídica quedarían indiferenciados.",
            "El Consejo de Padres tiene representantes por cada grado y participa en aspectos como la revisión del PEI; la Asociación es persona jurídica de carácter voluntario, y su conformación no es obligatoria para el funcionamiento de la institución, según el texto.",
            "Atribuir a la Asociación de Padres los representantes por cada grado y la revisión del PEI, invirtiendo lo que el texto asigna al Consejo de Padres y dejando a este como figura de bienestar y apoyo.",
            "Presentar al Consejo de Padres como persona jurídica de carácter voluntario cuya conformación no es obligatoria, invirtiendo el estatuto que el texto reserva a la Asociación de Padres de Familia.",
        ],
        "explanation": "La condición de calidad pide una diferencia que el texto sostenga entre Consejo de Padres y Asociación. El pasaje, al amparo del Decreto 1286, distingue: el Consejo es instancia de participación con representantes por cada grado e interviene en aspectos como la revisión del PEI; la Asociación es persona jurídica voluntaria, centrada en apoyo y bienestar, y su conformación no es obligatoria para el funcionamiento de la IE. Confundirlas como dos nombres de lo mismo borra esa diferencia. Atribuir a la Asociación los representantes por grado invierte los roles. Tratar al Consejo como persona jurídica voluntaria también invierte el estatuto que el texto reserva a la Asociación.",
        "normativeJustification": "El Decreto 1286 de 2005 diferencia el Consejo de Padres (participación por grado, PEI) de la Asociación (persona jurídica voluntaria). El texto reproduce esa distinción; no las fusiona ni intercambia representantes, obligatoriedad o bienestar.",
        "theoreticalJustification": "La participación vinculante en el gobierno escolar no es lo mismo que una persona jurídica de apoyo. Fusionar nombres o intercambiar PEI y voluntariedad es un error de instancia: se lee el 1286 al revés.",
        "distractorAnalysis": {
            "0": "Trampa de la fusión de nombres: tratar Consejo y Asociación como la misma instancia parece simplificar el 1286. El texto las distingue por representación, PEI, personería y obligatoriedad.",
            "2": "Trampa de la inversión de representantes: asignar a la Asociación el cupo por grado y la revisión del PEI parece plausible. El pasaje reserva esas funciones al Consejo y deja a la Asociación en apoyo y bienestar.",
            "3": "Trampa de la inversión de personería: presentar al Consejo como persona jurídica voluntaria no obligatoria parece el estatuto del 1286. Ese régimen es el de la Asociación, no el del Consejo de Padres.",
        },
    },
    {
        "id": "dir-apt-lec-18",
        "options": [
            "En la evaluación anual de desempeño laboral de los docentes prevista en el Decreto 1278, como si el Consejo de Padres sustituyera al rector o coordinador evaluador, función que el texto no le atribuye.",
            "En la revisión del Proyecto Educativo Institucional, participación que el texto reconoce al Consejo de Padres junto con la representación por cada grado, distinta de las actividades de apoyo y bienestar propias de la Asociación.",
            "En la administración del presupuesto de mantenimiento de la planta física, como si el Consejo de Padres fuera ordenador del gasto, competencia de gestión financiera que el texto no menciona.",
            "En la contratación de docentes provisionales de la planta, confundiendo la participación familiar del Decreto 1286 con la potestad de la entidad territorial, ámbito que el texto no asigna al Consejo de Padres.",
        ],
        "explanation": "La condición de calidad pregunta en qué aspecto puede participar el Consejo de Padres según el texto. El pasaje le reconoce representantes por grado y participación en aspectos como la revisión del PEI, y distingue esa función de las actividades de apoyo y bienestar de la Asociación. La evaluación anual de desempeño del 1278 es dominio cruzado: el evaluador es el rector o coordinador, no el Consejo de Padres. Administrar el presupuesto de mantenimiento convierte a la instancia en ordenadora del gasto, lo que el texto no dice. Contratar provisionales confunde participación familiar con la potestad de la entidad territorial.",
        "normativeJustification": "El Decreto 1286 sitúa al Consejo de Padres en la participación sobre el PEI, no en el juicio del 1278 ni en la ordenación del gasto o en la vinculación de provisionales. El texto reitera la revisión del PEI como ámbito de esa instancia.",
        "theoreticalJustification": "Cada órgano del gobierno escolar tiene un objeto. El Consejo de Padres deliberá el proyecto educativo; no evalúa docentes, no ejecuta mantenimiento ni nombra planta. Esos distractores leen otra competencia como si fuera la del texto.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del 1278: hacer que el Consejo de Padres evalúe el desempeño docente parece control social de la calidad. El texto no le asigna esa función; el evaluador del pasaje paralelo es el rector o coordinador.",
            "2": "Trampa del presupuesto de mantenimiento: administrar la planta física parece gestión útil de la Asociación o del Consejo Directivo. El texto no menciona ordenación del gasto ni la atribuye al Consejo de Padres.",
            "3": "Trampa de la contratación de provisionales: intervenir la planta rural parece gobierno de la IE. Confunde el 1286 con la competencia de la entidad territorial, ausente del pasaje.",
        },
    },
    {
        "id": "dir-apt-lec-19",
        "options": [
            "Convertir el plan en un régimen de sanciones para quien no siga la ruta de evacuación, y reportarlo al Comité Escolar de Convivencia de la Ley 1620 como evidencia de disciplina, en lugar de identificar amenazas del entorno.",
            "Identificar amenazas propias del entorno —deslizamientos, inundaciones o riesgos eléctricos— y definir protocolos de respuesta, rutas de evacuación y responsables por cada zona, según el propósito que el texto asigna al instrumento.",
            "Reemplazar el manual de convivencia institucional por el plan de gestión del riesgo, de modo que las normas de clima escolar queden absorbidas por los protocolos de evacuación, lectura que el texto no sostiene.",
            "Evaluar el desempeño laboral de los docentes en situaciones de emergencia, al amparo del Decreto 1278, como si el plan escolar de riesgo fuera el instrumento anual de calificación, dominio que el texto no enuncia.",
        ],
        "explanation": "La condición de calidad pide el propósito del Plan Escolar de Gestión del Riesgo según el texto. El pasaje lo define como instrumento para identificar amenazas del entorno (deslizamientos, inundaciones, riesgos eléctricos) y para definir protocolos de respuesta, rutas de evacuación y responsables por zona. Sancionar el incumplimiento de la ruta y reportarlo al CEC de la Ley 1620 convierte el plan en disciplina de convivencia, dominio cruzado. Reemplazar el manual de convivencia absorbe el clima escolar en la evacuación, lo que el texto no afirma. Evaluar docentes en emergencias con el 1278 lee el plan como calificación anual, otro dominio.",
        "normativeJustification": "El plan escolar de gestión del riesgo identifica amenazas y protocolos; no sustituye el manual de convivencia (Ley 1620) ni la evaluación de desempeño del 1278. El texto ancla el propósito a amenazas, rutas, protocolos y responsables de zona.",
        "theoreticalJustification": "La gestión del riesgo es prevención y respuesta situada, no sanción ni juicio laboral. Usar el plan como disciplina, como manual o como evaluación docente cambia el objeto y deja sin el mapa de amenazas que el pasaje describe.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la Ley 1620: sancionar la ruta y reportarla al CEC parece convivencia trazable. El texto no vuelve el plan un régimen punitivo; lo sitúa en amenazas y protocolos de emergencia.",
            "2": "Trampa de reemplazar el manual: absorber la convivencia en la evacuación parece unificar instrumentos. El pasaje no deroga el manual ni reduce el clima escolar a protocolos de riesgo.",
            "3": "Trampa de dominio cruzado del 1278: calificar docentes en la emergencia parece rigor de desempeño. El texto no convierte el plan de riesgo en evaluación anual de la planta.",
        },
    },
    {
        "id": "dir-apt-lec-20",
        "options": [
            "El rector como responsable exclusivo de redactar y aprobar el plan, de modo que docentes, personal administrativo y organismos de socorro locales queden al margen de la elaboración que el texto describe como colectiva.",
            "Docentes, personal administrativo y, de ser posible, organismos de socorro locales, de modo que la elaboración no quede como tarea exclusiva del rector y los simulacros reflejen condiciones reales del contexto, según el texto.",
            "El grado once organizado como brigada de simulacros, de modo que la elaboración del plan recaiga en los estudiantes de media y no en docentes, administrativos y organismos de socorro que el texto convoca.",
            "La Secretaría de Educación municipal como autora del plan de cada institución, de modo que el instrumento se homogeneice en el ente territorial y la IE se limite a aplicar un protocolo ajeno a sus amenazas.",
        ],
        "explanation": "La condición de calidad pregunta quiénes deberían participar en la elaboración del plan según el texto. El pasaje afirma que no es una tarea exclusiva del rector y que debe involucrar a docentes, personal administrativo y, en lo posible, a organismos de socorro locales, para que los simulacros reflejen el contexto. Esa es la opción correcta. Dejar al rector como responsable exclusivo de redactar y aprobar invierte esa colectividad que el pasaje exige. Encargar al grado once como brigada desplaza la autoría a la media. Hacer autora a la Secretaría municipal homogeneiza un instrumento que el texto quiere situado en las amenazas de cada IE.",
        "normativeJustification": "El plan escolar de gestión del riesgo se elabora con la comunidad educativa y, cuando es viable, con organismos de socorro. El texto niega que sea tarea exclusiva del rector; no la transfiere al grado once ni a la Secretaría como autora de cada establecimiento.",
        "theoreticalJustification": "Un protocolo de riesgo es creíble si quienes lo ensayan lo han construido. El rector solitario, la brigada de once o un formato municipal de Secretaría producen un papel que no refleja las amenazas ni los responsables de zona del caso.",
        "distractorAnalysis": {
            "0": "Trampa del rector como autor exclusivo: concentrar redacción y aprobación parece liderazgo y trazabilidad. El texto niega esa exclusividad e incluye docentes, administrativos y, de ser posible, socorro local.",
            "2": "Trampa de la brigada de grado once: dejar la elaboración en la media parece protagonismo estudiantil y simulacro visible. El pasaje convoca a docentes, administrativos y organismos de socorro, no al once como autor.",
            "3": "Trampa de la Secretaría autora: un plan municipal homogéneo parece control territorial. El texto pide un instrumento de cada IE, con amenazas propias, no un protocolo ajeno aplicado sin elaboración local.",
        },
    },
    {
        "id": "dir-apt-num-21",
        "options": [
            "Reportar 252 estudiantes de la jornada de la tarde en el acta del PMI y en el SIMAT, aplicando el 30 % de 840 como décima «limpia» de gestión, en lugar del 35 % que el caso fija para esa jornada.",
            "Reportar 294 estudiantes de la jornada de la tarde, cifra que resulta de aplicar el 35 % exacto a los 840 matriculados (840 × 0,35 = 294), sin cambiar la base ni mezclar otro indicador en el acta institucional.",
            "Reportar 284 estudiantes de tarde, calculados sobre una base SIMAT recortada de 812 matriculados con registro «completo» (812 × 0,35 ≈ 284), excluyendo 28 fichas y alterando el universo de 840 que el caso entrega.",
            "Reportar 315 estudiantes de tarde, equivalentes al 37,5 % de 840 (840 × 0,375 = 315), tomando el promedio histórico municipal de esa jornada en vez del 35 % institucional que Secretaría pide para el acta.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso, sin redondear ni cambiar la base. Hay 840 estudiantes matriculados y el 35 % pertenece a la jornada de la tarde: 840 × 0,35 = 294. Esa es la cifra del acta. 252 resulta de 840 × 0,30, al «limpiar» el porcentaje a una décima de gestión. 284 resulta de aplicar el 35 % a 812 registros SIMAT «completos» (812 × 0,35 ≈ 284), otra base. 315 resulta de 840 × 0,375, el 37,5 % histórico municipal de tarde. Secretaría pide no mezclar jornadas, periodos ni porcentajes de otro proceso; 294 es la operación exacta sobre el universo dado.",
        "normativeJustification": "El PMI y el SIMAT deben reportar la matrícula con la base y el porcentaje del caso. El 35 % de 840 es 294; ni el 30 % «limpio», ni una base recortada de 812, ni el 37,5 % histórico municipal sustituyen esa operación en el acta.",
        "theoreticalJustification": "Un porcentaje se aplica al universo declarado, sin sustituir la tasa ni excluir fichas. Cambiar 35 % por 30 %, 840 por 812 o 35 % por 37,5 % produce cifras profesionales y falsas: 252, 284 y 315.",
        "distractorAnalysis": {
            "0": "Trampa del 30 % «limpio»: 840 × 0,30 = 252 parece una décima de gestión para el PMI. Cambia el 35 % del caso y subreporta la jornada de la tarde en el acta.",
            "2": "Trampa de la base SIMAT recortada: 812 × 0,35 ≈ 284 excluye 28 registros «incompletos». Opera otro universo y no los 840 matriculados que el caso entrega.",
            "3": "Trampa del promedio histórico municipal: 840 × 0,375 = 315 luce comparable con Secretaría. Sustituye el 35 % institucional por un 37,5 % ajeno al proceso pedido.",
        },
    },
    {
        "id": "dir-apt-num-22",
        "options": [
            "Asignar 10 computadores a la sede B, producto de reservar 15 equipos para un nodo de calidad y repartir por igual los 30 restantes entre las tres sedes (30 ÷ 3 = 10), abandonando la proporcionalidad a la matrícula del caso.",
            "Asignar 15 computadores a la sede B, cifra que resulta de la proporción 200/600 sobre 45 equipos (45 × 200/600 = 15), con total de matrícula 300 + 200 + 100 = 600, sin excluir sedes ni cambiar la base en el acta.",
            "Asignar 20 computadores a la sede B, calculados como 45 × 200/450 = 20, al excluir la sede C (100 estudiantes) del denominador y operar como si el total fueran 450, no los 600 que suman las tres sedes.",
            "Asignar 22 computadores a la sede B, tomando la cifra de la sede A (45 × 300/600 = 22,5, reportada como 22) y atribuyéndola a B en el acta del PMI, de modo que se carga en B el cupo proporcional de otra sede.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con el reparto proporcional, sin redondear ni cambiar la base. Hay 45 computadores y tres sedes: A 300, B 200 y C 100; el total es 300 + 200 + 100 = 600. La sede B corresponde a 200/600 = 1/3; 45 × 200/600 = 15. Esa es la cifra del acta. 10 sale de reservar 15 para un «nodo de calidad» y partir 30 ÷ 3, igualdad que abandona la matrícula. 20 sale de 45 × 200/450, al excluir C del denominador. 22 es la cifra de A (45 × 300/600 = 22,5, reportada como 22) atribuida a B. Secretaría pide no mezclar otra base; 15 es la proporción exacta de B.",
        "normativeJustification": "El acta del PMI y del comité de calidad debe asignar los 45 equipos en proporción a la matrícula de cada sede. Con total 600, B recibe 45 × 200/600 = 15; no un remanente igualitario, ni un denominador sin C, ni el cupo de A.",
        "theoreticalJustification": "La regla de tres directa usa el mismo total en el denominador. Reservar equipos, excluir la sede C (450) o copiar 45 × 300/600 en B son operaciones profesionales y falsas: producen 10, 20 y 22.",
        "distractorAnalysis": {
            "0": "Trampa del remanente igualitario: reservar 15 y partir 30 ÷ 3 = 10 parece equidad de sedes y un nodo de calidad. Abandona 45 × 200/600 y no es proporcional a la matrícula de B.",
            "2": "Trampa de excluir C del denominador: 45 × 200/450 = 20 usa 450 en vez de 600. Infla la sede B al sacar a C de la base y deja de ser el reparto de las tres sedes.",
            "3": "Trampa de atribuir la cifra de A: 45 × 300/600 = 22,5, reportada como 22, es la proporción de la sede A. El acta carga en B el cupo de otra sede y altera la regla de tres.",
        },
    },
]


def validate(items: list) -> list[str]:
    errors: list[str] = []
    ids_ok = [
        "dir-apt-lec-13",
        "dir-apt-lec-14",
        "dir-apt-lec-15",
        "dir-apt-lec-16",
        "dir-apt-lec-17",
        "dir-apt-lec-18",
        "dir-apt-lec-19",
        "dir-apt-lec-20",
        "dir-apt-num-21",
        "dir-apt-num-22",
    ]
    if [it["id"] for it in items] != ids_ok:
        errors.append(f"ID ORDER {[it['id'] for it in items]}")
    for it in items:
        tag = it["id"]
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
            if oi != 1:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                low = opt.lower()
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
        da = it["distractorAnalysis"]
        if sorted(da.keys()) != ["0", "2", "3"]:
            errors.append(f"DA KEYS {tag} {sorted(da.keys())}")
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
    # Cifras de las correctas numéricas no deben moverse.
    num21 = next(it for it in items if it["id"] == "dir-apt-num-21")
    num22 = next(it for it in items if it["id"] == "dir-apt-num-22")
    if "294" not in num21["options"][1]:
        errors.append("NUM21 CORRECT FIGURE")
    if "15" not in num22["options"][1]:
        errors.append("NUM22 CORRECT FIGURE")
    for fig, idx in (("252", 0), ("284", 2), ("315", 3)):
        if fig not in num21["options"][idx]:
            errors.append(f"NUM21 DISTRACTOR FIGURE {fig}")
    for fig, idx in (("10", 0), ("20", 2), ("22", 3)):
        if fig not in num22["options"][idx]:
            errors.append(f"NUM22 DISTRACTOR FIGURE {fig}")
    return errors


def main() -> int:
    errors = validate(ITEMS)
    print("=== longitudes opciones ===")
    for it in ITEMS:
        lens = [len(o) for o in it["options"]]
        print(
            it["id"],
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "nj",
            len(it["normativeJustification"]),
            "tj",
            len(it["theoreticalJustification"]),
            "da",
            {k: len(v) for k, v in it["distractorAnalysis"].items()},
        )
    if errors:
        print("=== ERRORES ===")
        for e in errors:
            print(e)
        print("errors", len(errors))
        return 1
    OUT.write_text(
        json.dumps(ITEMS, ensure_ascii=False, indent=2) + "\n",
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
    print("validation OK")
    print("errors", 0)
    return 0


if __name__ == "__main__":
    sys.exit(main())
