# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ped-93..100 y dir-apt-lec-101..102 (posiciones 841-850) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_841_850.json"

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
    "dir-apt-ped-93": 1,
    "dir-apt-ped-94": 1,
    "dir-apt-ped-95": 0,
    "dir-apt-ped-96": 1,
    "dir-apt-ped-97": 1,
    "dir-apt-ped-98": 1,
    "dir-apt-ped-99": 1,
    "dir-apt-ped-100": 1,
    "dir-apt-lec-101": 0,
    "dir-apt-lec-102": 1,
}

ITEMS = [
    {
        "id": "dir-apt-ped-93",
        "options": [
            "Aceptar la propuesta del colega de bajar la meta de aprendizaje para todo el grupo, de modo que el estudiante con discapacidad y sus compañeros compartan un propósito reducido y el SIEE evite reclamos por trato diferenciado.",
            "Ajustar tiempos, metodologías o formas de evidencia del estudiante con discapacidad, sin renunciar al aprendizaje esencial del grado, y dejar esos apoyos registrados para garantizar participación en igualdad de condiciones.",
            "Dispensar de la evaluación al estudiante con discapacidad, sustituyendo la evidencia del grado por un concepto de bienestar, para no exponerlo a instrumentos que podrían generar frustración o reclamos de la familia.",
            "Aplicar la flexibilización curricular como régimen propio de las instituciones de educación especial, y conservar en esta aula regular la malla homogénea, de modo que el ajuste no opere en la IE ordinaria.",
        ],
        "explanation": "La condición de calidad pide qué implica principalmente la flexibilización curricular en inclusión. El Decreto 1421 exige ajustes razonables de tiempos, metodologías y formas de evidencia, con registro, sin renunciar al aprendizaje esencial del grado. Bajar la meta para todo el grupo, como propone el colega, homogeneiza hacia abajo y no es inclusión. Dispensar de la evaluación al estudiante con discapacidad elimina la evidencia de aprendizaje. Tratar la flexibilización como régimen de educación especial desplaza el aula regular a otra modalidad. La implicación principal es ajustar el cómo y conservar el qué.",
        "normativeJustification": "El Decreto 1421 y el PIAR ordenan apoyos y ajustes en el aula regular, sin reducir el propósito esencial ni eximir de evaluación. La flexibilización no es un régimen paralelo de educación especial ni una meta bajada para todo el grupo.",
        "theoreticalJustification": "Incluir es ajustar el cómo (tiempos, método, evidencia) y sostener el qué. Homogeneizar hacia abajo, omitir la evaluación o remitir el caso a otra modalidad cambian el objeto de la inclusión.",
        "distractorAnalysis": {
            "0": "Trampa de la equidad homogeneizadora: bajar la meta para todos parece evitar reclamos y tratar igual al grupo. Renuncia al aprendizaje esencial y convierte la inclusión en un propósito reducido, no en un ajuste del cómo.",
            "2": "Trampa de la protección por omisión: no evaluar al estudiante con discapacidad parece cuidado y evita frustración. Suprime la evidencia de aprendizaje y contradice la flexibilización, que ajusta el cómo y no elimina el qué.",
            "3": "Trampa de dominio cruzado de educación especial: reservar la flexibilización a las IE especializadas es coherente con un régimen de modalidad. En el aula regular el Decreto 1421 exige el ajuste; no es un régimen paralelo de otra institución.",
        },
    },
    {
        "id": "dir-apt-ped-94",
        "options": [
            "Entregar la nota del quiz de fracción al cierre del periodo y ofrecer recuperación con el mismo instrumento, para conservar evidencia comparable del SIEE, sin una nueva enseñanza que ancle el algoritmo al sentido de parte-todo.",
            "Diagnosticar los saberes previos de parte-todo que los estudiantes ya traen del contexto y anclar el algoritmo de fracción a esa comprensión, de modo que la fórmula no se presente desconectada del significado.",
            "Socializar la rúbrica de fracción el mismo día de los resultados, para no adelantar la respuesta a los estudiantes, y dejar que el quiz del algoritmo funcione como evidencia ciega de desempeño.",
            "Decidir la promoción con el promedio aritmético y un concepto cualitativo genérico, sin evidencias de proceso sobre parte-todo, y presentar ese cierre numérico como rigor del Decreto 1290.",
        ],
        "explanation": "La condición de calidad pide, según Ausubel, qué decisión hace significativo el aprendizaje de la fracción. El aprendizaje significativo ancla el contenido nuevo en las estructuras previas: hay que diagnosticar el sentido de parte-todo antes del algoritmo. Entregar la nota del quiz y recuperar con el mismo instrumento documenta el SIEE y no reconstruye significado. Socializar la rúbrica el día de los resultados impide que el criterio oriente el estudio. Decidir promoción con promedio y concepto genérico es cierre del 1290, no mediación cognitiva. La decisión defendible es anclar la fórmula a la comprensión de parte-todo que ya traen del contexto.",
        "normativeJustification": "El Decreto 1290 pide usar la evaluación para mejorar, no para repetir el mismo quiz ni para promover con promedio sin proceso. El diagnóstico de saberes previos es coherente con esa función formativa y con la mediación del contenido.",
        "theoreticalJustification": "Ausubel sostiene que hay aprendizaje significativo cuando el nuevo contenido se subsume en ideas previas claras. Empezar por el algoritmo de fracción sin parte-todo deja la fórmula como material arbitrario.",
        "distractorAnalysis": {
            "0": "Trampa del SIEE comparable: entregar la nota y recuperar con el mismo quiz parece rigor y equidad de instrumento. No enseña de nuevo ni ancla el algoritmo al parte-todo; documenta el producto y no el significado.",
            "2": "Trampa de la rúbrica tardía: socializar criterios el día de los resultados parece no adelantar la respuesta. Impide que el estudiante oriente el estudio de la fracción y deja el quiz como evidencia ciega.",
            "3": "Trampa de dominio cruzado de promoción del 1290: el promedio y el concepto genérico son un cierre legal de periodo. No hacen significativo el aprendizaje de la fracción; omiten evidencias de proceso de parte-todo.",
        },
    },
    {
        "id": "dir-apt-ped-95",
        "options": [
            "Pedir que, tras resolver los problemas, verbalicen las estrategias usadas y los criterios de éxito, y contrastarlos con la evidencia del trabajo, de modo que el pensamiento quede visible y no quede reducida la valoración a la respuesta.",
            "Aumentar el número de quizzes sobre los mismos problemas para tener más notas en el SIEE, sin devolver criterios ni un siguiente paso de mejora, y presentar esa densidad numérica como seguimiento formativo.",
            "Dejar la autoevaluación como una escala de percepción al cierre de la clase, sin contrastarla con el trabajo producido ni con los criterios de éxito, y tomarla como evidencia de metacognición.",
            "Unificar la evidencia en un examen acumulativo sorpresa de los problemas, para que el SIEE registre un cierre comparable, pese al carácter formativo previsto y a la ausencia de verbalización del pensamiento.",
        ],
        "explanation": "La condición de calidad pide qué práctica desarrolla metacognición de forma coherente con evaluación formativa. Verbalizar estrategias y criterios de éxito, contrastados con la evidencia del trabajo, hace visible el pensamiento y permite ajustar el cómo se resolvió el problema. Aumentar quizzes densifica notas y no devuelve un siguiente paso. La autoevaluación de percepción sin contrastar el producto simula reflexión. Un examen acumulativo sorpresa unifica evidencia del SIEE y anula el carácter formativo. La práctica defendible es pensar sobre el propio pensamiento con criterios públicos.",
        "normativeJustification": "El Decreto 1290 concibe la evaluación como formativa: criterios conocidos, devolución y uso de resultados para mejorar. Más quizzes, escalas de percepción o un examen sorpresa no desarrollan metacognición ni el carácter formativo del SIEE.",
        "theoreticalJustification": "La metacognición es monitorear y regular las propias estrategias frente a un criterio de éxito. Calificar la respuesta, percibir un puntaje o unificar en un examen miden producto, no el pensamiento sobre el pensamiento.",
        "distractorAnalysis": {
            "1": "Trampa de la densidad de notas: más quizzes sobre los problemas parecen seguimiento formativo. No devuelven criterios ni un siguiente paso y dejan la metacognición reducida a acumular calificaciones.",
            "2": "Trampa de la autoevaluación de percepción: una escala al cierre parece reflexión del estudiante. Sin contrastar el trabajo producido ni los criterios de éxito, no hay metacognición, hay trámite de opinión.",
            "3": "Trampa de dominio cruzado del SIEE comparable: un examen acumulativo sorpresa unifica evidencia y parece rigor de periodo. Anula el carácter formativo y la verbalización de estrategias que pide el stem.",
        },
    },
    {
        "id": "dir-apt-ped-96",
        "options": [
            "Dejar el grupo sin roles definidos para preservar la libertad de organización de quienes copian y de quienes esperan, y esperar que la colaboración surja de esa autonomía informal, sin meta común ni interdependencia.",
            "Diseñar roles, una meta común e interdependencia positiva, de modo que quien hoy copia y quienes esperan asuman responsabilidad individual y colectiva sobre el producto, con mediación del docente.",
            "Restringir la valoración al desempeño individual de cada integrante, sin componente de equipo, para que el SIEE evite reclamos y no premie a quienes esperaron mientras uno copiaba el producto.",
            "Retirar al docente durante toda la actividad para garantizar una colaboración auténtica entre estudiantes, y dejar que el grupo que hoy copia y espera se autorregule sin mediación ni roles.",
        ],
        "explanation": "La condición de calidad pide qué caracteriza al trabajo colaborativo, a diferencia del grupal en el que uno copia y los demás esperan. El colaborativo exige interdependencia positiva y responsabilidad individual y colectiva, con roles y meta común. Dejar el grupo sin roles, en nombre de la libertad, reproduce la espera. Restringir la valoración al desempeño individual borra el componente de equipo. Retirar al docente toda la actividad confunde autonomía con abandono de la mediación. La caracterización defendible articula roles, meta compartida y responsabilidad dual.",
        "normativeJustification": "Los lineamientos de trabajo en equipo y de evaluación formativa piden evidenciar tanto el aporte individual como el producto compartido. La ausencia de roles, la nota meramente individual o el retiro del docente no convierten el grupo en colaboración.",
        "theoreticalJustification": "Johnson y Johnson describen colaboración como interdependencia positiva más responsabilidad individual. Un grupo informal, una nota suelta o un docente ausente reproducen el patrón de uno que copia y otros que esperan.",
        "distractorAnalysis": {
            "0": "Trampa de la libertad sin roles: no definir funciones parece respetar la autonomía del grupo. En el caso, uno copia y los demás esperan; sin meta común ni interdependencia esa libertad reproduce el trabajo meramente grupal.",
            "2": "Trampa de la nota individual como equidad: restringir la valoración al desempeño individual parece no premiar a quienes esperaron. Borra el componente colectivo y no obliga a la interdependencia que define lo colaborativo.",
            "3": "Trampa de dominio cruzado de la autonomía estudiantil: retirar al docente toda la actividad parece garantizar colaboración auténtica. Confunde autonomía con abandono y deja sin mediación al grupo que hoy copia y espera.",
        },
    },
    {
        "id": "dir-apt-ped-97",
        "options": [
            "Aplicar la misma actividad, en el mismo tiempo, a todos los estudiantes, para tratarlos igual y evitar reclamos de equidad, y presentar esa homogeneidad de formato como rigor comparable del aula.",
            "Ajustar contenidos, procesos o productos según las necesidades y ritmos de aprendizaje de los estudiantes, de modo que la diferenciación no homogeneice la actividad ni separe de forma permanente por rendimiento.",
            "Separar físicamente de forma permanente a los estudiantes según su rendimiento académico, para organizar grupos más homogéneos y facilitar la planeación, y presentar ese agrupamiento como atención a la diversidad.",
            "Reemplazar la evaluación formativa por una evaluación sumativa comparable, para que el SIEE registre un cierre único de rigor, y dejar de ajustar procesos y productos durante el periodo.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente ante las propuestas en conflicto sobre diferenciación. Diferenciar es ajustar contenidos, procesos o productos según necesidades y ritmos, no igualar el formato. La misma actividad en el mismo tiempo, que un actor defiende como equidad, homogeneiza y no atiende diversidad. Separar físicamente de forma permanente según rendimiento es agrupamiento rígido, no inclusión. Reemplazar la formativa por sumativa aporta rigor comparable del SIEE y llega tarde para ajustar. La decisión defendible diferencia el proceso sin segregar ni sustituir la formativa por un cierre sumativo.",
        "normativeJustification": "El Decreto 1421, los EBC y el Decreto 1290 piden atender ritmos y usar la evaluación para mejorar. Homogeneizar la actividad, segregar por rendimiento o sustituir la formativa por un cierre sumativo no son la decisión institucional defendible.",
        "theoreticalJustification": "La diferenciación pedagógica varía contenido, proceso o producto y conserva un aula común. Igualar el formato, separar de forma permanente o cerrar de entrada con un sumativo miden equidad aparente, tracking o rigor, no atención a la diversidad.",
        "distractorAnalysis": {
            "0": "Trampa de la equidad homogeneizadora: la misma actividad en el mismo tiempo parece trato igual y evita reclamos. Niega ritmos y necesidades y no es diferenciación; es el formato único que un actor del caso defiende.",
            "2": "Trampa del agrupamiento permanente: separar por rendimiento parece organizar mejor la planeación. Es tracking físico, no diferenciación en el aula común, y contradice la inclusión que el stem pide defender.",
            "3": "Trampa de dominio cruzado del SIEE sumativo: reemplazar la formativa por un cierre comparable parece rigor de calidad. Llega tarde para ajustar contenidos, procesos o productos y no responde a la diferenciación del caso.",
        },
    },
    {
        "id": "dir-apt-ped-98",
        "options": [
            "Definir de manera obligatoria la carrera profesional del estudiante de media, para dar una salida visible a la comunidad que pide elegir oficio ya, y archivar esa decisión como orientación vocacional cumplida.",
            "Acompañar la reflexión sobre intereses, metas y decisiones futuras del estudiante de media, sin imponer un oficio y sin sustituir el área de ética, con mediación de orientación vocacional.",
            "Reemplazar la orientación vocacional por un test estandarizado único que asigne un perfil, y tomar ese resultado como el Proyecto de Vida, sin acompañar la reflexión de intereses y metas.",
            "Evaluar el Proyecto de Vida como evidencia del área de ética, sin acompañamiento de orientación, y presentar esa nota como cumplimiento curricular de la media y como cierre de la estrategia.",
        ],
        "explanation": "La condición de calidad pide qué busca principalmente el Proyecto de Vida como estrategia en educación media. Es un acompañamiento a la reflexión sobre intereses, metas y decisiones futuras, no la imposición de un oficio ni el reemplazo del área de ética. Definir de manera obligatoria la carrera responde al pedido de elegir ya y cierra el proceso. Sustituir la orientación por un test estandarizado único reduce la reflexión a un perfil. Evaluarlo como evidencia de ética, sin orientación, cambia el dominio del acompañamiento. La búsqueda principal es reflexionar con mediación, no certificar un destino laboral.",
        "normativeJustification": "Los lineamientos de educación media y de orientación escolar sitúan el Proyecto de Vida como acompañamiento, no como imposición de carrera ni como nota exclusiva de ética. El test puede informar; no sustituye la mediación vocacional.",
        "theoreticalJustification": "Un proyecto de vida es un proceso identitario y de decisión, no un oficio asignado. Obligar la carrera, reducirla a un test o calificarla en ética miden cierre, perfil o área, no la reflexión que la estrategia busca.",
        "distractorAnalysis": {
            "0": "Trampa de la carrera ya decidida: imponer el oficio parece responder a la comunidad que pide elegir ya. Cierra el Proyecto de Vida como trámite vocacional y anula la reflexión de intereses y metas de la media.",
            "2": "Trampa del test como orientación: un instrumento estandarizado único parece diagnóstico eficiente. Reemplaza el acompañamiento por un perfil y no busca la reflexión que caracteriza al Proyecto de Vida.",
            "3": "Trampa de dominio cruzado del área de ética: evaluar el proyecto como evidencia de esa asignatura parece cumplimiento curricular. Desplaza la orientación vocacional y convierte el acompañamiento en una nota de área.",
        },
    },
    {
        "id": "dir-apt-ped-99",
        "options": [
            "Adoptar un enfoque biológico y reproductivo a cargo del área de ciencias naturales, de modo que la educación para la sexualidad se reduzca a anatomía y prevención, sin dimensiones socioafectivas ni de derechos.",
            "Adoptar un enfoque integral del PESCC que articule dimensiones biológicas, socioafectivas y de derechos, con participación de la comunidad educativa, y no reducir el tema a una sesión ni reservarlo al hogar.",
            "Cumplir la cobertura con una sesión anual a cargo de ciencias naturales, archivar esa evidencia en el plan de área y dar por cerrado el PESCC para el resto del año lectivo.",
            "Reservar el tema a la familia y no trabajarlo en la institución, para proteger la privacidad del hogar y evitar tensiones con padres, y dejar el PESCC fuera del aula y de la comunidad educativa.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente frente a las propuestas del PESCC. El Programa de Educación para la Sexualidad y Construcción de Ciudadanía articula dimensiones biológicas, socioafectivas y de derechos, con participación de la comunidad. El enfoque biológico-reproductivo a cargo de naturales recorta el tema a anatomía. Una sesión anual archiva cobertura y no forma. Reservar el tema a la familia y no trabajarlo en la institución invierte la corresponsabilidad: el hogar participa, no sustituye a la escuela. La decisión defendible es el enfoque integral con la comunidad educativa.",
        "normativeJustification": "El PESCC del MEN concibe la educación para la sexualidad como proceso integral y de derechos, con la comunidad educativa. No se agota en ciencias naturales, ni en una sesión anual, ni se cede por completo al hogar.",
        "theoreticalJustification": "Una sexualidad ciudadana articula cuerpo, vínculo y derechos. Reducirla a biología, a un acto de cobertura o a la privacidad familiar deja fuera la formación escolar y la participación que el programa exige.",
        "distractorAnalysis": {
            "0": "Trampa del enfoque biológico-reproductivo: dejar el tema en ciencias naturales parece rigor disciplinar de anatomía y prevención. Recorta el PESCC y omite las dimensiones socioafectivas y de derechos del caso.",
            "2": "Trampa de la sesión anual de cobertura: una clase de naturales parece cumplimiento visible del plan de área. Archiva evidencia y no desarrolla el proceso integral que el stem pide defender.",
            "3": "Trampa de dominio cruzado de la privacidad familiar: reservar el tema al hogar parece proteger a los padres y evitar tensiones. El PESCC se trabaja en la IE con la comunidad; la familia participa, no sustituye a la escuela.",
        },
    },
    {
        "id": "dir-apt-ped-100",
        "options": [
            "Conservar opacos los criterios de evaluación hasta el cierre del periodo, para que los estudiantes no se adelanten, y presentar esa reserva como equidad de instrumento y rigor del SIEE.",
            "Hacer transparentes los criterios de evaluación antes de las evidencias y promover la autorregulación del estudiante frente a lo esperado, con retroalimentación docente y tiempo de planeación protegido.",
            "Eliminar la retroalimentación docente para no sesgar la autoevaluación, y dejar que cada estudiante interprete su desempeño sin devolución de criterios ni siguiente paso de mejora.",
            "Recortar el tiempo dedicado a la planeación para ganar horas de clase visibles, y presentar esa eficiencia de planta como mejora de cobertura lectiva, a costa de criterios y devolución.",
        ],
        "explanation": "La condición de calidad pide la decisión más defendible pedagógica e institucionalmente sobre criterios y autorregulación. La evaluación formativa del Decreto 1290 exige transparencia previa de lo esperado y retroalimentación que permita autorregularse. Conservar opacos los criterios hasta el cierre impide que el estudiante se oriente. Eliminar la devolución docente, para no sesgar la autoevaluación, deja el juicio sin contraste. Recortar la planeación para ganar horas visibles es eficiencia de planta, no calidad de evaluación. La decisión defendible publica criterios, conserva la devolución y protege el tiempo de diseñar.",
        "normativeJustification": "El Decreto 1290 y el SIEE exigen criterios conocidos, evaluación formativa y uso de resultados para mejorar. La opacidad, la ausencia de retroalimentación o el recorte de planeación no son la decisión institucional defendible.",
        "theoreticalJustification": "La autorregulación requiere saber qué se espera y recibir devolución oportuna. Ocultar criterios, suprimir la voz docente o recortar la planeación miden sorpresa, imparcialidad aparente o cobertura, no formación.",
        "distractorAnalysis": {
            "0": "Trampa de la opacidad como rigor: reservar los criterios hasta el cierre parece equidad de instrumento y evita que se adelanten. Impide la autorregulación y contradice la transparencia que el stem pide defender.",
            "2": "Trampa de la autoevaluación sin sesgo: eliminar la retroalimentación docente parece no influir el juicio del estudiante. Deja el desempeño sin contraste ni siguiente paso y vacía la evaluación formativa.",
            "3": "Trampa de dominio cruzado de la eficiencia de planta: recortar planeación para ganar horas de clase es un argumento correcto de cobertura lectiva. No responde a criterios ni a autorregulación; sacrifica el diseño de la evaluación.",
        },
    },
    {
        "id": "dir-apt-lec-101",
        "options": [
            "El tránsito entre básica primaria y básica secundaria es un momento crítico en el que la deserción tiende a incrementarse, y algunas instituciones lo atienden con inducción, seguimiento individual a estudiantes en riesgo y articulación entre docentes de quinto y sexto.",
            "La deserción escolar se concentra en la educación media, cuando el estudiante ya asumió la jornada de secundaria, y ese tramo es el que el informe identifica como el principal factor de abandono institucional.",
            "El cambio de sede en el tránsito de quinto a sexto elimina el riesgo de deserción, porque el estudiante se adapta a una jornada más exigente y el desplazamiento deja de operar como factor de abandono.",
            "La articulación entre docentes de quinto y sexto grado constituye un mandato legal de gobierno escolar de la Ley 115, de modo que el Consejo Directivo debe adoptarla como obligación de permanencia y no como estrategia de algunas instituciones.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El informe señala que la deserción tiende a incrementarse en el tránsito de básica primaria a básica secundaria, y que algunas instituciones responden con inducción, seguimiento individual y articulación entre quinto y sexto. Concentrar la deserción en media toma un tramo que el texto no afirma como el crítico. Afirmar que el cambio de sede elimina el riesgo invierte lo dicho: ese desplazamiento puede agravarlo. Presentar la articulación 5-6 como mandato de la Ley 115 importa un saber normativo externo. La idea central es el tránsito crítico y las estrategias de acompañamiento de algunas IE.",
        "normativeJustification": "El texto identifica el tránsito primaria-secundaria como momento de mayor deserción y describe estrategias de algunas instituciones. No afirma que la articulación 5-6 sea mandato legal ni que el cambio de sede elimine el riesgo.",
        "theoreticalJustification": "La idea principal articula el problema (tránsito crítico) y la respuesta descrita (acompañamiento de algunas IE). Un detalle de media, una inversión protectora o un mandato legal externo desplazan ese núcleo.",
        "distractorAnalysis": {
            "1": "Trampa del detalle invertido: situar la deserción en la educación media parece el tramo más visible del abandono. El texto sitúa el incremento en el tránsito de primaria a secundaria, no en media.",
            "2": "Trampa de la sobregeneralización protectora: el cambio de sede parece una solución de planta que elimina el riesgo. El texto lo presenta como factor que puede agravar el tránsito, no como remedio.",
            "3": "Trampa de dominio cruzado de la Ley 115: la articulación 5-6 como mandato de gobierno escolar es un saber normativo externo plausible. El texto la describe como estrategia de algunas instituciones, no como obligación legal.",
        },
    },
    {
        "id": "dir-apt-lec-102",
        "options": [
            "Reducir el número de sedes de la institución para evitar el desplazamiento en el tránsito de quinto a sexto, y presentar esa reorganización de planta como la estrategia de permanencia descrita en el informe.",
            "Implementar jornadas de inducción, seguimiento individual a estudiantes en riesgo y articulación entre los docentes de quinto y sexto grado, para que el cambio de nivel no se convierta en un factor adicional de abandono.",
            "Aumentar la exigencia académica en sexto grado, de modo que la jornada más exigente opere como filtro de calidad y el estudiante se adapte más rápido al cambio de nivel y de sede.",
            "Acelerar en quinto la malla de los Derechos Básicos de Aprendizaje de sexto, para preparar el tránsito con cobertura curricular adelantada y reportar ese avance como estrategia de permanencia.",
        ],
        "explanation": "La condición de calidad pide, según el texto, qué estrategia se menciona para reducir el riesgo de deserción en ese tránsito. El pasaje cita jornadas de inducción, seguimiento individual a estudiantes en riesgo y articulación entre docentes de quinto y sexto. Reducir el número de sedes es una reorganización de planta que el texto no describe. Aumentar la exigencia en sexto invierte el factor de riesgo de las jornadas más exigentes. Acelerar la malla de DBA de sexto en quinto es un saber de cobertura curricular externo. La estrategia mencionada es el acompañamiento institucional en el cambio de nivel.",
        "normativeJustification": "El texto menciona inducción, seguimiento individual a estudiantes en riesgo y articulación entre quinto y sexto. No describe recorte de sedes, aumento de exigencia en sexto ni aceleración de la malla de DBA.",
        "theoreticalJustification": "Una estrategia se lee en lo que el pasaje enumera. Importar planta, rigor de sexto o cobertura de DBA responde a otros dominios de gestión y no a lo que el informe afirma.",
        "distractorAnalysis": {
            "0": "Trampa de la reorganización de planta: reducir sedes parece atacar el desplazamiento del tránsito. El texto no menciona esa medida; describe acompañamiento pedagógico, no recorte de sedes.",
            "2": "Trampa de la inversión de la exigencia: subir la exigencia en sexto parece rigor de calidad. El texto presenta las jornadas más exigentes como factor de riesgo de deserción, no como estrategia.",
            "3": "Trampa de dominio cruzado de los DBA: acelerar en quinto la malla de sexto parece cobertura curricular preventiva. El texto no afirma esa aceleración; cita inducción, seguimiento y articulación docente.",
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
                if "no solo" in low or "no sólo" in low:
                    errors.append(f"NO SOLO {tag} idx {oi}")
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
