# -*- coding: utf-8 -*-
"""Reescribe dir-apt-num-223..232 (posiciones 971-980) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_971_980.json"

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
    "dir-apt-num-223": 2,
    "dir-apt-num-224": 3,
    "dir-apt-num-225": 0,
    "dir-apt-num-226": 1,
    "dir-apt-num-227": 2,
    "dir-apt-num-228": 3,
    "dir-apt-num-229": 0,
    "dir-apt-num-230": 1,
    "dir-apt-num-231": 2,
    "dir-apt-num-232": 3,
}
NEEDLE = {
    "dir-apt-num-223": "40%",
    "dir-apt-num-224": "3h 45min",
    "dir-apt-num-225": "16",
    "dir-apt-num-226": "9",
    "dir-apt-num-227": "15%",
    "dir-apt-num-228": "330.000",
    "dir-apt-num-229": "4.6",
    "dir-apt-num-230": "24",
    "dir-apt-num-231": "24%",
    "dir-apt-num-232": "30",
}
FRASE_CALIDAD = (
    "cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base"
)

ITEMS = [
    {
        "id": "dir-apt-num-223",
        "options": [
            "Reportar 30% de no aprobación en el PMI, tomando la mitad de los 18 que aprobaron (9/30) o 18 sobre una jornada de 60, como propone el docente, porque deja una tasa «cauta» comparable con el histórico de matemáticas del curso.",
            "Consignar 35% en el acta de calidad, usando cerca de 10,5 no aprobados sobre 30 o 18 aprobados sobre 51 cupos, como insiste el segundo docente, para no tensionar el informe de reprobación de matemáticas ante Secretaría.",
            "Consignar 40% de estudiantes que no aprobaron matemáticas: 30 − 18 = 12 y 12/30 = 40%, cifra del acta del comité de calidad, sin redondear ni cambiar la base de 30 del curso ni mezclar jornadas.",
            "Registrar 45% en el tablero PMI, tomando 18 aprobados sobre una meta de 40 (18/40) o el techo de reprobación de calidad, para que el indicador de matemáticas luzca alineado con la meta de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. En el curso de 30, 18 aprobaron matemáticas y el resto son 12, de modo que 12/30 = 40%. Esa es la cifra del acta del comité de calidad. El 30% toma la mitad de 18 o una jornada de 60; el 35% aproxima o cambia la matrícula; el 45% usa 18 sobre 40 del PMI. Ninguna conserva el complemento de 18 sobre 30.",
        "normativeJustification": "El Decreto 1075 y la Guía 34 exigen que el PMI y el acta conserven la matrícula del curso y el indicador pedido. No se sustituye (30 − 18)/30 por 9/30, por 18/51 ni por 18/40 de otra meta.",
        "theoreticalJustification": "La tasa de no aprobación es (n − aprobados)/n. Con n=30 y 18 aprobados, el resto es 12 y 12/30 = 40%. 9/30 = 30%; ~10,5/30 = 35%; 18/40 = 45% cambian el numerador o la base.",
        "distractorAnalysis": {
            "0": "Trampa de la mitad de los 18 aprobados: 30% = 9/30 o 18/60, como propone el docente. Recorta el complemento o cambia la jornada. No es (30 − 18)/30 = 40% de no aprobación en matemáticas.",
            "1": "Trampa del 35% del segundo docente: aproxima 10,5/30 o usa 18/51. Conserva un porcentaje cercano, pero cambia la matrícula de 30 o redondea. No opera 12/30 = 40%.",
            "3": "Trampa de dominio cruzado de la meta PMI: 45% = 18/40 o techo de reprobación. Es un indicador plausible de calidad. Sustituye la base de 30 del curso por 40 y no es 12/30.",
        },
    },
    {
        "id": "dir-apt-num-224",
        "options": [
            "Reportar 3h 00min en el PMI (180 min = 36 × 5), omitiendo 9 minutos diarios o usando 36 sesiones, como propone el docente, porque deja una intensidad «limpia» comparable con jornadas anteriores de matemáticas.",
            "Consignar 3h 15min en el acta de calidad (195 min = 39 × 5), recortando 6 minutos diarios, como insiste el segundo docente, para no tensionar el informe semanal de matemáticas de primaria ante Secretaría.",
            "Registrar 3h 30min en el tablero PMI (210 min = 42 × 5), tomando una intensidad «limpia» de 42 minutos, para que la jornada de matemáticas luzca alineada con la meta de calidad de Secretaría.",
            "Consignar 3h 45min de matemáticas en el acta: 45 × 5 = 225 minutos semanales, cifra del comité de calidad, sin redondear los 45 minutos diarios ni cambiar los cinco días que pide Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El docente de primaria dedica 45 minutos diarios, cinco días, de modo que 45 × 5 = 225 minutos, es decir 3h 45min. Esa es la cifra del acta de intensidad de matemáticas. 3h 00min usa 36 × 5; 3h 15min usa 39 × 5; 3h 30min usa 42 × 5 del PMI. Ninguna conserva 45 minutos por día y cinco jornadas.",
        "normativeJustification": "La intensidad horaria se reporta con los minutos reales de clase y los días de la semana lectiva. El PMI no puede recortar a 36, 39 o 42 minutos como si fueran 45 × 5.",
        "theoreticalJustification": "Minutos semanales = minutos diarios × días. Con 45 × 5 = 225 = 3h 45min. 36 × 5 = 180; 39 × 5 = 195; 42 × 5 = 210 cambian la sesión diaria.",
        "distractorAnalysis": {
            "0": "Trampa de recortar a 36 minutos: 3h 00min = 180 min = 36 × 5, como propone el docente. Omite 9 minutos diarios de la clase de matemáticas. No es 45 × 5 = 225.",
            "1": "Trampa de 39 minutos diarios: 3h 15min = 195 min = 39 × 5, como insiste el segundo docente. Recorta 6 minutos de la sesión. No conserva 45 × 5 = 225 minutos.",
            "2": "Trampa de dominio cruzado de la jornada PMI: 3h 30min = 210 min = 42 × 5. Es una intensidad «limpia» plausible de calidad. Sustituye 45 minutos por 42 y no es 225 minutos.",
        },
    },
    {
        "id": "dir-apt-num-225",
        "options": [
            "Consignar 16 aciertos en el acta institucional: 20 × 0,80 = 16 preguntas de la prueba, cifra del comité de calidad, sin redondear el 80% ni cambiar la base de 20 ítems que pide Secretaría para el PMI.",
            "Reportar 14 aciertos en el PMI, aplicando 70% a las 20 preguntas (20 × 0,70), como propone el docente, porque deja un desempeño «cauto» comparable con el histórico de la prueba del curso.",
            "Consignar 15 aciertos en el acta de calidad, usando 75% de 20 (20 × 0,75) o tres cuartos «redondos», como insiste el segundo docente, para no tensionar el informe de la prueba ante Secretaría.",
            "Registrar 18 aciertos en el tablero PMI, tomando 90% de las 20 preguntas (20 × 0,90) como techo de acierto, para que el indicador de la prueba luzca alineado con la meta de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. En la prueba de 20 preguntas el 80% de acierto es 20 × 0,80 = 16. Esa es la cifra del acta institucional. 14 aplica 70%; 15 aplica 75%; 18 aplica 90% de la meta PMI. Ninguna conserva el 80% sobre las 20 preguntas del caso.",
        "normativeJustification": "El resultado de la prueba se reporta con el número de ítems y el porcentaje de acierto institucional. El PMI no puede sustituir 20 × 0,80 por 70%, 75% ni el techo del 90%.",
        "theoreticalJustification": "Aciertos = n × p. Con n=20 y p=0,80, el producto es 16. 20 × 0,70 = 14; 20 × 0,75 = 15; 20 × 0,90 = 18 son otras alícuotas.",
        "distractorAnalysis": {
            "1": "Trampa del 70% del docente: 14 = 20 × 0,70. Es el desempeño «cauto» que propone. Cambia el 80% de acierto de la prueba. No es 20 × 0,80 = 16.",
            "2": "Trampa de los tres cuartos: 15 = 20 × 0,75, como insiste el segundo docente. Usa un 75% «redondo». No conserva el 80% sobre las 20 preguntas.",
            "3": "Trampa de dominio cruzado de la meta PMI: 18 = 20 × 0,90. Es el techo de acierto de calidad. Sustituye el 80% del caso por 90% y no es 16.",
        },
    },
    {
        "id": "dir-apt-num-226",
        "options": [
            "Reportar 8 grupos en el PMI, omitiendo 4 de los 36 estudiantes (32 ÷ 4), como propone el docente, porque deja un cupo «ajustado» comparable con el histórico de trabajo colaborativo del curso.",
            "Consignar 9 grupos de trabajo colaborativo en el acta: 36 ÷ 4 = 9, cifra del comité de calidad, sin redondear la matrícula de 36 ni cambiar el tamaño de 4 que pide Secretaría.",
            "Consignar 10 grupos en el acta de calidad, inflando a 40 estudiantes (40 ÷ 4), como insiste el segundo docente, para no tensionar el informe de trabajo colaborativo ante Secretaría.",
            "Registrar 12 grupos en el SIMAT, dividiendo 36 entre 3 (36 ÷ 3) como equipos de tres, para que el indicador colaborativo luzca alineado con la meta de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Los 36 estudiantes en grupos de 4 dan 36 ÷ 4 = 9 grupos de trabajo colaborativo. Esa es la cifra del acta. 8 omite cuatro estudiantes (32 ÷ 4); 10 infla a 40; 12 divide 36 entre 3 como cupo SIMAT. Ninguna conserva 36 estudiantes y grupos de 4.",
        "normativeJustification": "La organización colaborativa se reporta con la matrícula real y el tamaño de grupo pactado. El PMI no puede omitir cupos, inflar a 40 ni pasar a tríos del SIMAT como si fueran 36 ÷ 4.",
        "theoreticalJustification": "Grupos = n ÷ tamaño. Con n=36 y tamaño 4, hay 9 grupos. 32 ÷ 4 = 8; 40 ÷ 4 = 10; 36 ÷ 3 = 12 cambian n o el tamaño.",
        "distractorAnalysis": {
            "0": "Trampa de omitir 4 estudiantes: 8 = 32 ÷ 4, como propone el docente. Recorta la matrícula de 36. No es 36 ÷ 4 = 9 grupos de trabajo colaborativo.",
            "2": "Trampa de inflar a 40: 10 = 40 ÷ 4, como insiste el segundo docente. Cambia la base de 36. No conserva grupos de 4 sobre la matrícula del caso.",
            "3": "Trampa de dominio cruzado del SIMAT colaborativo: 12 = 36 ÷ 3. Es un recuento plausible de equipos de tres. Sustituye grupos de 4 por grupos de 3 y no es 9.",
        },
    },
    {
        "id": "dir-apt-num-227",
        "options": [
            "Reportar 10% de PIAR en el PMI, tomando 4 de 40 o recortando dos planes, como propone el docente, porque deja una tasa «cauta» comparable con el histórico de inclusión del curso.",
            "Consignar 12% en el acta de calidad, usando 6 PIAR sobre 50 cupos u otra base, como insiste el segundo docente, para no tensionar el informe de inclusión y ajustes razonables ante Secretaría.",
            "Consignar 15% de estudiantes con PIAR: 6/40 = 15%, cifra del acta del comité de calidad, sin redondear ni cambiar la base de 40 del curso ni mezclar otro indicador de inclusión.",
            "Registrar 18% en el tablero PMI, tomando 6/33 o 7,2 sobre 40 como meta de inclusión, para que el indicador de PIAR luzca alineado con el compromiso de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. De 40 estudiantes, 6 tienen PIAR, de modo que 6/40 = 15%. Esa es la cifra del acta de inclusión. El 10% toma 4/40; el 12% cambia la base a 50; el 18% es meta PMI de inclusión. Ninguna conserva 6 sobre 40.",
        "normativeJustification": "El Decreto 1421 y el informe de inclusión se reportan con la matrícula del curso y los PIAR vigentes. El PMI no puede recortar a 4/40, usar 6/50 ni un techo del 18% como si fueran 6/40.",
        "theoreticalJustification": "La proporción es k/n. Con k=6 y n=40, 6/40 = 15%. 4/40 = 10%; 6/50 = 12%; 6/33 ≈ 18% cambian k o n.",
        "distractorAnalysis": {
            "0": "Trampa de recortar a 4 PIAR: 10% = 4/40, como propone el docente. Omite dos planes del curso. No es 6/40 = 15% de estudiantes con PIAR.",
            "1": "Trampa de otra base de 50: 12% = 6/50, como insiste el segundo docente. Conserva los 6 PIAR pero cambia los 40 del curso. No es 15%.",
            "3": "Trampa de dominio cruzado de la meta de inclusión PMI: 18% = 6/33 o 7,2/40. Es un techo plausible de calidad. Sustituye 6/40 por otra alícuota y no es 15%.",
        },
    },
    {
        "id": "dir-apt-num-228",
        "options": [
            "Reportar $300.000 en el PMI, usando 15 cajas a $20.000 (15 × 20.000), como propone el docente, porque deja un gasto «ajustado» comparable con el histórico de material didáctico en tesorería.",
            "Consignar $310.000 en el acta de calidad, aproximando un unitario de cerca de $20.667, como insiste el segundo docente, para no tensionar el informe de compra de las 15 cajas ante Secretaría.",
            "Registrar $320.000 como techo redondo de tesorería, o 16 cajas a $20.000, para que el cupo de material didáctico luzca holgado en el tablero de calidad ante Secretaría.",
            "Consignar $330.000 de material didáctico en el acta: 15 × 22.000 = 330.000, cifra del comité de calidad, sin redondear el unitario de 22.000 ni cambiar las 15 cajas que pide Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Las 15 cajas a 22 mil pesos cada una son 15 × 22 mil = 330 mil. Esa es la cifra del acta de compra de material didáctico. 300 mil usa 20 mil por caja; 310 mil aproxima otro unitario; 320 mil es techo de tesorería. Ninguna conserva 15 cajas a 22 mil.",
        "normativeJustification": "La compra de material se reporta con la cantidad adquirida y el unitario de la factura. El PMI no puede bajar a 20 mil, aproximar a 310 mil ni usar un techo de tesorería de 320 mil como si fueran 15 × 22 mil.",
        "theoreticalJustification": "Total = cantidad × unitario. 15 × 22 mil = 330 mil. 15 × 20 mil = 300 mil; ~15 × 20,7 mil = 310 mil; 16 × 20 mil = 320 mil cambian n o el precio.",
        "distractorAnalysis": {
            "0": "Trampa del unitario a 20.000: $300.000 = 15 × 20.000, como propone el docente. Baja el precio de cada caja. No es 15 × 22.000 = 330.000.",
            "1": "Trampa de aproximar a 310.000: usa cerca de 20.667 por caja, como insiste el segundo docente. Redondea el producto. No conserva 15 × 22.000.",
            "2": "Trampa de dominio cruzado de tesorería: $320.000 es un techo redondo o 16 × 20.000. Es un cupo plausible de compra. Sustituye 15 × 22.000 por un techo holgado y no es 330.000.",
        },
    },
    {
        "id": "dir-apt-num-229",
        "options": [
            "Consignar 4.6 como promedio bimestral en el acta: 3.6 + 1 = 4.6 tras el punto adicional a cada uno de los 25 estudiantes, sin redondear ni cambiar la escala 1 a 5 que pide Secretaría.",
            "Reportar 4.4 en el PMI, sumando 0,8 en vez de un punto entero a cada estudiante (3.6 + 0,8), como propone el docente, porque deja un promedio «moderado» comparable con el histórico bimestral.",
            "Consignar 4.2 en el acta de calidad, sumando 0,6 al 3.6 (3.6 + 0,6), como insiste el segundo docente, para no tensionar el informe del promedio bimestral de los 25 estudiantes ante Secretaría.",
            "Registrar 4.8 en el tablero PMI/Saber, sumando 1,2 al 3.6 o tomando el 96% de 5, para que el promedio del curso luzca alineado con la meta de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Si a cada uno de los 25 estudiantes se suma un punto, el promedio 3,6 también sube un punto y queda en 4,6. Esa es la cifra del acta bimestral. 4,4 suma 0,8; 4,2 suma 0,6; 4,8 suma 1,2 o usa la meta PMI. Ninguna conserva 3,6 más un punto entero.",
        "normativeJustification": "El Decreto 1290 y el SIEE reportan el promedio del grupo con la misma operación aplicada a cada estudiante. El PMI no puede sumar 0,8, 0,6 ni 1,2 como si el punto adicional fuera otra alícuota.",
        "theoreticalJustification": "Si cada dato aumenta en c, el promedio aumenta en c. Con promedio 3,6 y c=1, el nuevo promedio es 4,6. Sumar 0,8, 0,6 o 1,2 produce otro indicador.",
        "distractorAnalysis": {
            "1": "Trampa de sumar 0,8: 4.4 = 3.6 + 0,8, como propone el docente. No aplica el punto entero a cada uno de los 25. El promedio no queda en 4.6.",
            "2": "Trampa de sumar 0,6: 4.2 = 3.6 + 0,6, como insiste el segundo docente. Recorta el punto adicional. No es 3.6 + 1 = 4.6.",
            "3": "Trampa de dominio cruzado de la meta PMI/Saber: 4.8 = 3.6 + 1,2 o 96% de 5. Es un techo plausible de calidad. Infla el promedio y no es 3.6 + 1 = 4.6.",
        },
    },
    {
        "id": "dir-apt-num-230",
        "options": [
            "Reportar 20 hojas en el PMI, inventando un grupo de 5 (5 × 4) o recortando el paquete, como propone el docente, porque deja un cupo «ajustado» comparable con el histórico de material del curso.",
            "Consignar 24 hojas para el Grupo 2 en el acta: 84 ÷ 21 = 4 por estudiante y 6 × 4 = 24, cifra del comité de calidad, sin repartir 84 en tercios ni cambiar los 6 integrantes.",
            "Consignar 28 hojas en el acta de calidad, tomando el Grupo 1 (7 × 4) o repartiendo 84 entre 3 partes iguales, como insiste el segundo docente, para no tensionar el informe de hojas ante Secretaría.",
            "Registrar 32 hojas en el SIMAT, tomando el Grupo 3 de 8 estudiantes (8 × 4), el de mayor matrícula, para que la asignación de material luzca alineada con el cupo de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Hay 84 hojas y 21 estudiantes, de modo que 84 ÷ 21 = 4 hojas por estudiante; el Grupo 2 tiene 6 y 6 × 4 = 24. Esa es la cifra del acta. 20 inventa un grupo de 5; 28 toma el Grupo 1 o reparte 84 entre 3; 32 toma el Grupo 3 del SIMAT. Ninguna conserva la proporción del Grupo 2.",
        "normativeJustification": "El material se reparte con la matrícula real de cada grupo y la razón por estudiante. El PMI no puede inventar un grupo de 5, tomar el Grupo 1 o el 3 del SIMAT como si fueran las 24 hojas del Grupo 2.",
        "theoreticalJustification": "Hojas del grupo = (total ÷ n) × integrantes. 84 ÷ 21 = 4 y el Grupo 2 es 6 × 4 = 24. 5 × 4 = 20; 7 × 4 = 28; 8 × 4 = 32 son otros grupos o un tercio de 84.",
        "distractorAnalysis": {
            "0": "Trampa de inventar un grupo de 5: 20 = 5 × 4, como propone el docente. No corresponde al Grupo 2 de 6. No es 84 ÷ 21 × 6 = 24 hojas.",
            "2": "Trampa del Grupo 1 o del tercio: 28 = 7 × 4 o 84/3, como insiste el segundo docente. Toma 7 integrantes o reparte igual, no proporcional. No es el Grupo 2.",
            "3": "Trampa de dominio cruzado del cupo SIMAT: 32 = 8 × 4 del Grupo 3, el de mayor matrícula. Es un recuento plausible de material. Sustituye el Grupo 2 y no es 24.",
        },
    },
    {
        "id": "dir-apt-num-231",
        "options": [
            "Reportar 20% de revisión en el PMI, tomando 10 de 50 minutos o recortando 2 minutos, como propone el docente, porque deja un uso del tiempo «cauto» comparable con el histórico de la clase.",
            "Consignar 22% en el acta de calidad, usando 11/50 minutos de revisión, como insiste el segundo docente, para no tensionar el informe de uso del tiempo de la clase de 50 minutos ante Secretaría.",
            "Consignar 24% del tiempo de clase en revisión de tareas: 12/50 = 24%, cifra del acta del comité de calidad, sin redondear ni cambiar los 12 minutos ni la base de 50 que pide Secretaría.",
            "Registrar 26% en el tablero PMI, tomando 13/50 o la meta de revisión time-on-task, para que el uso del tiempo de clase luzca alineado con el compromiso de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Los 12 minutos de revisión sobre 50 de clase son 12/50 = 24%. Esa es la cifra del acta de uso del tiempo. El 20% toma 10/50; el 22% toma 11/50; el 26% es meta PMI de time-on-task. Ninguna conserva 12 sobre 50.",
        "normativeJustification": "El uso del tiempo de clase se reporta con los minutos reales de la actividad y la duración de la sesión. El PMI no puede recortar a 10 u 11 minutos ni elevar a 13 como meta de tablero.",
        "theoreticalJustification": "La proporción es minutos de revisión / minutos de clase. 12/50 = 24%. 10/50 = 20%; 11/50 = 22%; 13/50 = 26% cambian el numerador.",
        "distractorAnalysis": {
            "0": "Trampa de recortar a 10 minutos: 20% = 10/50, como propone el docente. Omite 2 minutos de revisión de tareas. No es 12/50 = 24% del tiempo de clase.",
            "1": "Trampa de 11 minutos: 22% = 11/50, como insiste el segundo docente. Cambia los 12 minutos del caso. No conserva 12/50 = 24%.",
            "3": "Trampa de dominio cruzado del time-on-task PMI: 26% = 13/50 o meta de revisión. Es un techo plausible de calidad. Infla los 12 minutos y no es 24%.",
        },
    },
    {
        "id": "dir-apt-num-232",
        "options": [
            "Reportar 24 libros de otras categorías en el PMI, tomando 60 × 0,40 (el 30% más un 10%), como propone el docente, porque deja un inventario «ajustado» comparable con el histórico de la biblioteca de aula.",
            "Consignar 26 en el acta de calidad, usando cerca del 43% de 60 o 18 de literatura más 8, como insiste el segundo docente, para no tensionar el informe de otras categorías ante Secretaría.",
            "Registrar 28 en el inventario PMI, como techo de «otras categorías» o 60 − 32, para que el fondo de la biblioteca de aula luzca alineado con la meta de calidad de Secretaría.",
            "Consignar 30 libros de otras categorías en el acta: 60 × 0,50, complemento del 30% de literatura infantil y del 20% de ciencias, sin redondear ni cambiar la base de 60 de la biblioteca de aula.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 30% de literatura infantil y el 20% de ciencias suman 50%, de modo que el resto de otras categorías es 60 × 0,50 = 30 libros. Esa es la cifra del acta de biblioteca de aula. 24 toma el 40%; 26 aproxima otro complemento; 28 es techo de inventario PMI. Ninguna conserva el 50% restante sobre 60.",
        "normativeJustification": "El inventario de la biblioteca de aula se reporta con el fondo total y las categorías declaradas. El PMI no puede usar 40%, un 43% aproximado ni un techo de 28 como si el resto fuera 60 × 0,50.",
        "theoreticalJustification": "El resto es n × (1 − 0,30 − 0,20) = n × 0,50. Con n=60, hay 30 libros de otras categorías. 60 × 0,40 = 24; ~0,43 × 60 = 26; 60 − 32 = 28 cambian el complemento.",
        "distractorAnalysis": {
            "0": "Trampa del 40%: 24 = 60 × 0,40 (30% + 10%), como propone el docente. Suma un 10% extra a literatura o cambia el complemento. No es 60 × 0,50 = 30 de otras categorías.",
            "1": "Trampa de aproximar a 26: cerca del 43% de 60 o 18 + 8, como insiste el segundo docente. Mezcla literatura con otro recorte. No es el 50% restante sobre 60.",
            "2": "Trampa de dominio cruzado del inventario PMI: 28 es techo de otras categorías o 60 − 32. Es un cupo plausible de biblioteca. Recorta el resto y no es 60 × 0,50 = 30.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {
        k: it[k]
        for k in (
            "id",
            "options",
            "explanation",
            "normativeJustification",
            "theoreticalJustification",
            "distractorAnalysis",
        )
    }


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
        needle = NEEDLE.get(tag)
        if needle and needle not in opts[ci]:
            errors.append(f"MISSING FIGURE {tag} {needle} {opts[ci][:90]}")
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
                if not str(v).startswith("Trampa"):
                    errors.append(f"DA PREFIX {tag} {k}")
        expl = it.get("explanation") or ""
        if len(expl) < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(expl)}")
        if FRASE_CALIDAD not in expl:
            errors.append(f"MISSING QUALITY PHRASE {tag}")
        n_sent = expl.count(".") + expl.count("?") + expl.count("!")
        if n_sent < 4 or n_sent > 7:
            errors.append(f"SENTENCES {tag} {n_sent}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")
            if "p. ej." in val.lower() or "p.ej." in val.lower():
                errors.append(f"P EJ {field} {tag}")
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
        needle = NEEDLE[it["id"]]
        cruz = sum(
            1 for v in it["distractorAnalysis"].values() if "dominio cruzado" in v.lower()
        )
        print(
            it["id"],
            "ci",
            ci,
            "needle",
            needle,
            "in_ci",
            needle in it["options"][ci],
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "sent",
            it["explanation"].count(".") + it["explanation"].count("?") + it["explanation"].count("!"),
            "NJ",
            len(it["normativeJustification"]),
            "TJ",
            len(it["theoreticalJustification"]),
            "DA",
            {k: len(v) for k, v in it["distractorAnalysis"].items()},
            "cruz",
            cruz,
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
