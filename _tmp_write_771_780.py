# -*- coding: utf-8 -*-
"""Reescribe dir-apt-num-23..32 (posiciones 771-780) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_771_780.json"
SRC = ROOT / "_tmp_in_771_780.json"

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

# correctIndex original (NO se vuelca al JSON de salida).
META = {
    "dir-apt-num-23": {
        "ci": 2,
        "figures": ["3,80", "3,85", "3,92", "4,00"],
    },
    "dir-apt-num-24": {
        "ci": 1,
        "figures": ["3 horas", "5 horas", "6 horas", "8 horas"],
    },
    "dir-apt-num-25": {
        "ci": 2,
        "figures": ["$24.000.000", "$30.000.000", "$36.000.000", "$40.000.000"],
    },
    "dir-apt-num-26": {
        "ci": 1,
        "figures": ["2", "3", "4", "5"],
    },
    "dir-apt-num-27": {
        "ci": 2,
        "figures": ["35", "38", "40", "42"],
    },
    "dir-apt-num-28": {
        "ci": 2,
        "figures": ["80", "85", "90", "95"],
    },
    "dir-apt-num-29": {
        "ci": 2,
        "figures": ["8%", "9%", "10%", "12%"],
    },
    "dir-apt-num-30": {
        "ci": 2,
        "figures": ["20", "22", "24", "26"],
    },
    "dir-apt-num-31": {
        "ci": 2,
        "figures": ["1.200", "1.320", "1.440", "1.500"],
    },
    "dir-apt-num-32": {
        "ci": 2,
        "figures": ["30 minutos", "45 minutos", "60 minutos", "90 minutos"],
    },
}

ITEMS = [
    {
        "id": "dir-apt-num-23",
        "options": [
            "Consignar 3,80 como promedio del grupo en el PMI, conservando el indicador de los 25 estudiantes porque es comparable con el histórico institucional y con el informe ya radicado ante Secretaría.",
            "Reportar 3,85 en el acta de calidad, como punto medio entre 3,80 y 3,90, para dejar una décima «limpia» que atenúa el retiro de la nota 1,0 sin rehacer la suma sobre los 24 restantes.",
            "Consignar 3,92 como nuevo promedio de los 24 estudiantes: se resta 1,0 a la suma 25×3,8 y se divide entre 24, sin redondear y sin cambiar la base del indicador de la prueba.",
            "Registrar 4,00 en el SIMAT y en el tablero del PMI, redondeando el promedio a la unidad de gestión para que el resultado luzca alineado con la meta institucional y con el reporte de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y con la operación, sin redondear ni cambiar la base. La suma de los 25 estudiantes es 25×3,8=95; al retirar la nota 1,0 queda 94; el nuevo promedio sobre 24 es 94/24=3,92. Esa es la cifra del acta. Conservar 3,80 reporta el promedio de la base vieja; 3,85 es un ajuste informal entre décimas; 4,00 redondea a unidad de gestión y cambia la escala.",
        "normativeJustification": "El Decreto 1075 y la Guía 34 exigen que los indicadores del PMI conserven la definición operativa con la que se calcularon. El acta de calidad no puede sustituir el promedio recalculado sobre 24 por un histórico, un ajuste informal o un redondeo de tablero.",
        "theoreticalJustification": "Un promedio ponderado cambia si cambia n y la suma. Restar un 1,0 y dividir entre 24 altera el valor; reutilizar 3,80 o redondear a 4,00 reporta otro indicador. La décima 3,85 no corresponde a 94/24.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del promedio viejo: 3,80 es el indicador correcto de los 25 estudiantes antes del retiro. Reportarlo como nuevo promedio conserva la base original y no opera (25×3,8−1,0)/24.",
            "1": "Trampa del ajuste informal a 3,85: la cifra sale de promediar 3,80 con 3,90 o de una décima «limpia» de gestión. No resta 1,0 ni divide entre 24; mezcla redondeo con el indicador de la prueba.",
            "3": "Trampa del redondeo de gestión a 4,00: la unidad «limpia» luce comparable en el PMI y ante Secretaría. Cambia la escala del promedio y abandona la base de 24 y el 3,92 exacto.",
        },
    },
    {
        "id": "dir-apt-num-24",
        "options": [
            "Reportar 3 horas adicionales en el PMI, tomando 27 horas como mínimo de otra jornada o restando la mitad de la jornada diaria a las 30 semanales, para un indicador «prudente» ante Secretaría.",
            "Consignar 5 horas adicionales por semana, resultantes de 6×5=30 menos el mínimo de 25 de primaria, sin sustituir el excedente por la jornada diaria ni por un referente de horas de otro ciclo.",
            "Consignar 6 horas como tiempo adicional semanal, igualando el indicador a la jornada diaria de 6 horas, porque esa cifra ya está en el horario y resulta fácil de defender en el acta de calidad.",
            "Registrar 8 horas adicionales, sumando 2 horas de descanso o de otra jornada a las 6 diarias, y presentarlas como ampliación de la oferta para el informe de calidad y el PMI.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. La jornada suma 6×5=30 horas semanales; el mínimo de primaria es 25; el adicional es 30−25=5 horas. Esa es la operación del acta. Reportar 3 horas usa otro mínimo (p. ej. 27) o parte la jornada; 6 horas toma la jornada diaria como si fuera el excedente semanal; 8 horas suma descansos u otra base.",
        "normativeJustification": "La jornada y la intensidad horaria se reportan con la definición del Decreto 1075 y de la organización escolar de la IE. El PMI no puede presentar como «horas adicionales» la jornada diaria, un mínimo de otro ciclo o un recargo de descansos.",
        "theoreticalJustification": "El excedente semanal es total ofertado menos mínimo de la misma base. Confundir horas/día con horas extra, o cambiar el 25 por 27, produce otro indicador. Sumar descansos infla la oferta sin operar 30−25.",
        "distractorAnalysis": {
            "0": "Trampa de cambiar el mínimo: 3 horas sale de 30−27 o de partir la jornada diaria (6/2). Es un referente de otro ciclo o un recorte «prudente», no el adicional sobre las 25 horas de primaria.",
            "2": "Trampa de dominio cruzado de la jornada diaria: 6 horas es el indicador correcto de la duración del día escolar. Reportarla como adicional semanal sustituye 30−25 por el dato del horario cotidiano.",
            "3": "Trampa de otra base con descansos: 8 horas suma 6+2 (recreo u otra jornada) y la presenta como ampliación. Mezcla tiempo de descanso con el excedente lectivo 30−25=5.",
        },
    },
    {
        "id": "dir-apt-num-25",
        "options": [
            "Consignar $24.000.000 como cifra del semestre en el PMI, correspondiente al 40% ya ejecutado del presupuesto de $60.000.000, porque es el giro trazable en tesorería y en el acta de compras.",
            "Reportar $30.000.000 como saldo disponible, tomando la mitad del presupuesto anual de $60.000.000 para igualar semestres y dejar un cupo simétrico en el tablero de calidad.",
            "Consignar $36.000.000 como saldo no ejecutado: el 40% de $60.000.000 ya se usó, resta el 60% exacto para el segundo semestre, sin cambiar la base ni reportar la ejecución como si fuera el disponible.",
            "Registrar $40.000.000 como cupo del segundo semestre, aproximando dos tercios del presupuesto o el 40% «al alza», para dejar un techo de gestión holgado en el PMI y ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. Ejecutado el 40% de $60.000.000, el no ejecutado es el 60%: 60.000.000×0,60=$36.000.000, que es el disponible del segundo semestre. $24.000.000 es la ejecución (otro indicador); $30.000.000 parte el presupuesto por mitades; $40.000.000 usa dos tercios o un cupo redondeado de gestión.",
        "normativeJustification": "La ejecución presupuestal de una IE oficial se reporta distinguiendo lo girado de lo disponible, con la misma base anual. El acta de calidad y el PMI no pueden presentar la ejecución, la mitad simétrica o un cupo redondeado como si fueran el saldo del segundo semestre.",
        "theoreticalJustification": "Si se ejecutó el 40%, el complemento es 60% de la misma base. Reportar lo ejecutado es correcto para tesorería e incorrecto para el saldo. La mitad y los dos tercios cambian el porcentaje y la operación.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la ejecución: $24.000.000 es el 40% ya girado, indicador correcto de tesorería y compras. No es el saldo; confunde lo ejecutado con lo disponible para el segundo semestre.",
            "1": "Trampa de la mitad simétrica: $30.000.000 divide $60.000.000 entre dos semestres iguales. Cambia el 60% no ejecutado por un 50% de conveniencia de tablero y no opera 60.000.000×0,60.",
            "3": "Trampa del cupo redondeado a $40.000.000: dos tercios o un 40% «al alza» lucen como techo holgado de gestión. Alteran el porcentaje y no conservan el 60% exacto de la base de $60.000.000.",
        },
    },
    {
        "id": "dir-apt-num-26",
        "options": [
            "Reportar 2 turnos de vigilancia por patio en el acta, omitiendo el empalme de 15 minutos, porque dos franjas cubren el grueso del descanso de 45 minutos y alivian la programación docente.",
            "Consignar 3 turnos de 15 minutos por patio, pues 45/15 cubre el descanso completo sin añadir un receso extra ni omitir el empalme, y esa es la cifra coherente con los datos del caso.",
            "Registrar 4 turnos por patio, al incluir un receso extra de control o al partir el descanso como si los tramos fueran de unos 10 minutos, para reforzar la vigilancia ante el comité de convivencia.",
            "Cargar 5 turnos en el informe de convivencia, contando patios de otra sede o dividiendo 45 entre 9 minutos, de modo que el dispositivo luzca más cubierto en la visita de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. El descanso dura 45 minutos y cada turno dura 15; 45/15=3 turnos por patio. Esa es la cobertura mínima del acta. Reportar 2 omite un empalme; 4 añade un receso extra o parte en tramos de ~10 minutos; 5 usa 9 minutos u otra sede. Ninguna de esas bases es la de 15 minutos del caso.",
        "normativeJustification": "El Manual de Convivencia y el plan de vigilancia de la IE deben reportar turnos con la duración acordada. El acta de calidad no puede omitir un tramo, añadir un receso de control o importar la densidad de otra sede como si fuera el mínimo del patio del caso.",
        "theoreticalJustification": "El número mínimo de turnos es duración del descanso entre duración del turno, con la misma unidad. Cambiar 15 por 10 o por 9, o restar un empalme, produce otro cociente. Contar patios de otra sede cambia el objeto del indicador.",
        "distractorAnalysis": {
            "0": "Trampa de omitir el empalme: 2 turnos cubren 30 de 45 minutos y parece programación «realista». La operación falsa es 45/15−1 o ignorar un tramo; no cubre el descanso completo con la base de 15.",
            "2": "Trampa del receso extra: 4 turnos salen de incluir un control adicional o de partir 45 entre ~10 minutos. Cambia la duración del turno y reporta un dispositivo más denso que 45/15=3.",
            "3": "Trampa de dominio cruzado de otra sede: 5 turnos resultan de 45/9 o de contar patios distintos. Es un indicador de otra zona o de otra duración; no el mínimo por patio del caso.",
        },
    },
    {
        "id": "dir-apt-num-27",
        "options": [
            "Reportar 35 docentes en el PMI, dividiendo 1.120 entre 32 como si la relación técnica fuera la de otra sede o de un promedio municipal, y no la de 28 a 1 del caso.",
            "Consignar 38 docentes, redondeando 1.120/29,5 o aplicando un recorte «prudente» a la planta, para alinear el indicador con un histórico de calidad sin usar 28 como denominador.",
            "Consignar 40 docentes según 1.120/28, que es la relación estudiante-docente del caso, sin mezclar el 32 de otra sede ni incluir cargos directivos en el numerador de aula.",
            "Registrar 42 docentes, dividiendo 1.120 entre 26,7 o sumando rectoría y coordinación a la planta de aula, para presentar una cobertura «holgada» en el informe de planta.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. Con 1.120 estudiantes y relación 28 a 1, los docentes de aula son 1.120/28=40. Esa es la planta que el acta debe consignar. 35 usa 32 como denominador (otra sede o promedio municipal); 38 redondea 1.120/29,5 o recorta la planta; 42 usa ~26,7 o suma directivos al conteo de aula.",
        "normativeJustification": "La relación técnica estudiante-docente se reporta con el parámetro de la IE, no con el de otra sede ni con cargos de dirección mezclados. El PMI y el informe de planta al Decreto 1075 deben conservar el 28 a 1 del caso cuando esa es la base acordada.",
        "theoreticalJustification": "El cociente matrícula/relación da el n de docentes de esa definición. Cambiar 28 por 32 o 29,5 altera el denominador. Incluir rectoría infla el numerador de un indicador de aula. El redondeo «prudente» no es 1.120/28.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de otra sede: 35=1.120/32, relación técnica distinta (municipal u otra jornada). Es el indicador correcto de ese otro parámetro, no de la relación 28 a 1 del caso.",
            "1": "Trampa del recorte a 38: la cifra sale de 1.120/29,5 o de un redondeo de gestión a la baja. Cambia el denominador 28 y presenta una planta «prudente» que no es el cociente exacto.",
            "3": "Trampa de sumar directivos: 42≈1.120/26,7 o 40 más rectoría y coordinación. Mezcla cargos de dirección con docentes de aula y cambia la base de la relación técnica.",
        },
    },
    {
        "id": "dir-apt-num-28",
        "options": [
            "Reportar 80 estudiantes en insuficiente, aplicando el 16% de 500 o el corte de otra aplicación Saber, cifra que suele usarse en el PMI como meta de reducción del nivel bajo.",
            "Consignar 85 en insuficiente, tomando el 17% de 500 o un promedio histórico municipal, para suavizar el 18% del caso y presentar un indicador más «limpio» ante Secretaría.",
            "Consignar 90 estudiantes en nivel insuficiente, porque 500×0,18 mantiene la base de evaluados y el 18% del caso, sin sustituirlo por el 16%, el 17% ni el 19% de otro reporte.",
            "Registrar 95 en insuficiente, usando el 19% de 500 o sumando cinco casos de otra jornada, de modo que el PMI recoja un techo de alerta más amplio que el 18% institucional.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. El 18% de 500 evaluados es 500×0,18=90 estudiantes en insuficiente. Esa es la magnitud del acta. 80 aplica 16% (meta PMI u otra aplicación); 85 aplica 17% o un histórico municipal; 95 aplica 19% o suma casos de otra jornada. Todas cambian el porcentaje o la cohorte.",
        "normativeJustification": "Los resultados Saber se reportan con el n evaluado y el porcentaje del nivel, sin sustituirlos por metas del PMI o por el consolidado de otra jornada. El acta de calidad debe conservar 500 y 18% cuando esos son los datos del caso.",
        "theoreticalJustification": "La frecuencia absoluta es n×p con el mismo p. Usar 0,16, 0,17 o 0,19 produce cabezas distintas. Importar casos de otra jornada cambia la base. Una meta de reducción no es el conteo observado.",
        "distractorAnalysis": {
            "0": "Trampa de la meta del 16%: 80=500×0,16, corte de otra aplicación o propósito de PMI. Es un indicador de gestión de mejora, no el conteo del 18% observado en los 500 evaluados.",
            "1": "Trampa del histórico al 17%: 85=500×0,17 o promedio municipal «limpio». Suaviza el insuficiente y cambia el porcentaje del caso; no opera 500×0,18.",
            "3": "Trampa de dominio cruzado de otra jornada: 95=500×0,19 o 90 más cinco de otra jornada. Amplía la alerta con otra base o otro porcentaje; no es el 18% institucional de los 500.",
        },
    },
    {
        "id": "dir-apt-num-29",
        "options": [
            "Reportar 8% de crecimiento en el SIMAT, dividiendo 95 entre una base municipal cercana a 1.187 o recortando el incremento a 76 sobre 950, para un porcentaje «prudente» de PMI.",
            "Consignar 9% de variación, tomando 95/1.045 o 95/1.055 —la matrícula de llegada u otra cohorte— y redondeando a la baja, en lugar de usar 950 como denominador del crecimiento.",
            "Consignar 10% de crecimiento: el incremento es 1.045−950=95 y 95/950=0,10, con la matrícula de partida como base, sin redondear ni cambiar el denominador del indicador.",
            "Registrar 12% de crecimiento, operando 114/950 o midiendo un numerador mayor sobre 1.045, para mostrar un salto más visible en el PMI y en el tablero de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. El incremento es 1.045−950=95; la tasa sobre la matrícula de partida es 95/950=0,10=10%. Esa es la cifra del SIMAT en el acta. 8% usa ~95/1.187 o un incremento recortado (76/950); 9% toma 1.045 o 1.055 como denominador; 12% usa 114/950 u otro numerador sobre la llegada.",
        "normativeJustification": "El SIMAT y el PMI reportan el crecimiento de matrícula como variación relativa a la base de partida del periodo, no a la matrícula de llegada ni a un consolidado municipal. Cambiar el denominador o el numerador altera el indicador oficial de la IE.",
        "theoreticalJustification": "La tasa de crecimiento es (final−inicial)/inicial. Dividir 95 entre 1.045 es variación sobre la llegada; 76/950 o 114/950 cambian el numerador. Un porcentaje «prudente» o «visible» no es 95/950.",
        "distractorAnalysis": {
            "0": "Trampa del recorte a 8%: 95/1.187≈0,08 o 76/950. Usa una base municipal u otro incremento. No es 95/950; presenta un crecimiento «prudente» de PMI con denominador o numerador distintos.",
            "1": "Trampa de la base de llegada: 9% sale de 95/1.045≈0,091 redondeado o de 95/1.055. Cambia el denominador de 950 a la matrícula final u otra cohorte; no es la tasa sobre la partida.",
            "3": "Trampa del salto visible a 12%: 114/950=0,12 o un numerador mayor sobre 1.045. Infla el incremento o mezcla la base de llegada; no conserva 95/950=10%.",
        },
    },
    {
        "id": "dir-apt-num-30",
        "options": [
            "Reportar 20 estudiantes por grupo, como si 192 se repartieran en 9 o 10 grupos, o restando 12 al promedio de 32, cifra que suele citarse como tope «cómodo» de calidad en otra sede.",
            "Consignar 22 por grupo, aproximando 192/8,7 o cruzando 32×8/12, un recálculo de otra reorganización de sede que deja un tamaño intermedio para el acta de calidad.",
            "Consignar 24 estudiantes por grupo: el total 6×32=192 se reparte en 8 grupos (192/8), sin reducir el denominador ni usar el 32 original como si no hubiera reorganización.",
            "Registrar 26 por grupo, dividiendo 192 entre 7,4 o restando 6 al promedio de 32, para mostrar un recorte «moderado» de tamaño en el informe de calidad y el PMI.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. El total se conserva: 6×32=192 estudiantes; al pasar a 8 grupos, 192/8=24 por grupo. Esa es la cifra del acta. 20 supone ~9,6 grupos o resta 12 al 32; 22 aproxima 192/8,7 o cruza 32×8/12; 26 usa ~7,4 grupos o 32−6. Todas cambian n de grupos o el total.",
        "normativeJustification": "La reorganización de grupos se reporta conservando la matrícula del grado y el número de grupos acordado. El PMI no puede presentar el tamaño de otra sede, un recorte al promedio viejo o un denominador distinto de 8 como si fuera el resultado de esa reorganización.",
        "theoreticalJustification": "Si el total es invariante, el nuevo cupo es total/nuevos grupos. Restar al 32 ignora el total. Cambiar 8 por 9,6 o 7,4 cambia el denominador. Un cruce 32×8/12 mezcla otra reorganización.",
        "distractorAnalysis": {
            "0": "Trampa del tope «cómodo» de 20: 192/9,6 o 32−12, típico de otra sede o de un cupo de calidad. Cambia el número de grupos o resta al promedio viejo; no es 192/8.",
            "1": "Trampa del tamaño intermedio 22: 192/8,7 o 32×8/12, recálculo de otra malla de grupos. Mezcla bases de otra reorganización y no divide el total de 192 entre 8.",
            "3": "Trampa del recorte moderado a 26: 192/7,4 o 32−6. Conserva un eco del promedio original y un denominador distinto de 8; no opera (6×32)/8=24.",
        },
    },
    {
        "id": "dir-apt-num-31",
        "options": [
            "Reportar 1.200 libros de otras colecciones, tomando el 50% de 2.400 como si infantil y referencia sumaran la mitad, y dejar esa mitad como resto en el inventario del PMI.",
            "Consignar 1.320 como saldo, aplicando el 55% de 2.400 —un recorte de cinco puntos al 60%— para alinear el indicador con un histórico de biblioteca y de calidad institucional.",
            "Consignar 1.440 libros restantes: 25% infantil más 15% de referencia suman 40%, y el 60% de 2.400 es 1.440, sin sustituir ese resto por el 50% ni por el 55% de otro inventario.",
            "Registrar 1.500 como resto del inventario, usando el 62,5% de 2.400 o un cupo «redondo» de gestión, para presentar una colección general más holgada en el acta de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. Infantil 25% más referencia 15% suman 40%; el resto es 60% de 2.400: 2.400×0,60=1.440. Esa es la colección general del acta. 1.200 toma el 50%; 1.320 el 55% (histórico recortado); 1.500 el 62,5% o un cupo redondo. Ninguna conserva 25%+15% y el complemento del 40%.",
        "normativeJustification": "El inventario de biblioteca del PMI debe usar los porcentajes declarados del acervo y el mismo n=2.400. No es válido sustituir el resto por la mitad, por un histórico del 55% o por un cupo redondo de gestión que no sale de 25%+15%.",
        "theoreticalJustification": "El complemento es 1−(0,25+0,15)=0,60 de la misma base. 0,50, 0,55 y 0,625 son otras particiones. Un número «redondo» de 1.500 no es 2.400×0,60. Mezclar inventarios cambia el indicador.",
        "distractorAnalysis": {
            "0": "Trampa de la mitad: 1.200=50% de 2.400, como si infantil y referencia agotaran la mitad. Cambia 0,40+0,60 por 0,50/0,50; reporta un inventario simétrico, no el resto del 40% declarado.",
            "1": "Trampa del histórico al 55%: 1.320=2.400×0,55, recorte de cinco puntos al 60%. Alinea el saldo con otro año o sede y no opera el complemento 1−0,40.",
            "3": "Trampa del cupo redondo 1.500: 62,5% de 2.400 o cifra de gestión. Infla la colección general y abandona 2.400×0,60=1.440; es otro porcentaje, no el resto del caso.",
        },
    },
    {
        "id": "dir-apt-num-32",
        "options": [
            "Reportar 30 minutos de faltante, como si el ritmo fuera de 4,5 minutos por prueba o se descontaran 2,5 horas de las 3, y dejar media hora como ajuste «manejable» en el acta de calidad.",
            "Consignar 45 minutos adicionales, igualando el faltante a un receso de 45 minutos o a 240−195, para cuadrar la jornada con un bloque de descanso ya previsto en el horario institucional.",
            "Consignar 60 minutos de faltante: 40×6=240 minutos menos 180 de la jornada de 3 horas dejan exactamente una hora, sin sustituir ese saldo por un receso ni por un ritmo distinto de 6 minutos.",
            "Registrar 90 minutos de faltante, restando 150 minutos a 240 o dejando un residuo de 40×2,25, para pedir un bloque de hora y media en la programación de calidad y el PMI.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. Calificar 40 pruebas a 6 minutos exige 40×6=240 minutos (4 horas); la jornada disponible es 3 horas=180 minutos; el faltante es 240−180=60 minutos. 30 minutos usa 4,5 min/prueba o 2,5 h descontadas; 45 iguala un receso o 240−195; 90 resta 150 a 240. Todas cambian ritmo o tiempo disponible.",
        "normativeJustification": "La programación de calificación se reporta con el ritmo y la jornada declarados, no con un receso del horario ni con un bloque «redondo» de hora y media. El acta de calidad debe conservar 40×6 y 180 minutos cuando esos son los datos del caso.",
        "theoreticalJustification": "El faltante es tiempo requerido menos tiempo disponible, en la misma unidad. Cambiar 6 por 4,5 minutos, 180 por 150 o 195, o igualar el hueco a un receso, produce otro saldo. 40×6−180=60 no admite esos sustitutos.",
        "distractorAnalysis": {
            "0": "Trampa del ajuste a 30 minutos: 3 h−2,5 h o 40×4,5−150. Cambia el ritmo de 6 minutos o el disponible de 180. Presenta un faltante «manejable» que no es 240−180.",
            "1": "Trampa de dominio cruzado del receso: 45 minutos es la duración correcta de un descanso escolar, o 240−195. Reportar ese bloque como faltante de calificación sustituye 40×6−180 por otro indicador del horario.",
            "3": "Trampa del bloque de 90 minutos: 240−150 o 40×2,25 como residuo. Usa 2,5 horas disponibles u otro ritmo y pide hora y media; no conserva la jornada de 180 minutos.",
        },
    },
]


def validate(items: list) -> list[str]:
    """Valida longitudes, cifras, DA y palabras prohibidas."""
    errors: list[str] = []
    src_items = json.loads(SRC.read_text(encoding="utf-8"))
    src_by_id = {s["id"]: s for s in src_items}
    opt_norm: dict[str, list] = {}

    if len(items) != 10:
        errors.append(f"COUNT {len(items)} expected 10")

    for i, it in enumerate(items):
        tag = f"{it.get('id')}[{i}]"
        extra = sorted(set(it.keys()) - KEYS_OK)
        missing = sorted(KEYS_OK - set(it.keys()))
        if extra:
            errors.append(f"EXTRA KEYS {tag} {extra}")
        if missing:
            errors.append(f"MISSING KEY {tag} {missing}")
        iid = it.get("id")
        meta = META.get(iid)
        if not meta:
            errors.append(f"NO META {tag}")
            continue
        src = src_by_id.get(iid)
        if src and src.get("correctIndex") != meta["ci"]:
            errors.append(f"CI META {tag} meta={meta['ci']} src={src.get('correctIndex')}")
        ci = meta["ci"]
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
            fig = meta["figures"][oi]
            if fig not in opt:
                errors.append(f"MISSING FIGURE {tag} idx {oi} {fig!r}")
            if oi != ci:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                low = opt.lower()
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
            key = re.sub(r"\s+", " ", opt.strip().lower())[:90]
            opt_norm.setdefault(key, []).append((iid, oi))
        da = it["distractorAnalysis"]
        expected = [str(n) for n in range(4) if n != ci]
        if sorted(da.keys()) != expected:
            errors.append(
                f"DA KEYS {tag} {sorted(da.keys())} expected {expected} ci={ci}"
            )
        else:
            for k, v in da.items():
                if not isinstance(v, str) or len(v) < 80:
                    errors.append(
                        f"SHORT DA {tag} {k} {len(v) if isinstance(v, str) else None}"
                    )
        expl = it.get("explanation") or ""
        if len(expl) < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(expl)}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")

    for k, locs in opt_norm.items():
        if len(locs) > 1:
            errors.append(f"DUP PREFIX {locs} {k[:80]}")
    return errors


def main() -> int:
    errors = validate(ITEMS)
    print("=== longitudes opciones ===")
    for it in ITEMS:
        lens = [len(o) for o in it["options"]]
        da_lens = {k: len(v) for k, v in it["distractorAnalysis"].items()}
        print(
            it["id"],
            "ci",
            META[it["id"]]["ci"],
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "DA",
            da_lens,
            "norm",
            len(it["normativeJustification"]),
            "theo",
            len(it["theoreticalJustification"]),
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
    print("errors=0")
    return 0


if __name__ == "__main__":
    sys.exit(main())
