# -*- coding: utf-8 -*-
"""Reescribe dir-apt-num-133..140 y dir-apt-blan-141..142 (posiciones 881-890) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_881_890.json"

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
    "dir-apt-num-133": 0,
    "dir-apt-num-134": 1,
    "dir-apt-num-135": 2,
    "dir-apt-num-136": 3,
    "dir-apt-num-137": 0,
    "dir-apt-num-138": 1,
    "dir-apt-num-139": 2,
    "dir-apt-num-140": 3,
    "dir-apt-blan-141": 0,
    "dir-apt-blan-142": 1,
}

ITEMS = [
    {
        "id": "dir-apt-num-133",
        "options": [
            "Consignar 216 personas esperadas en el acta institucional: 180 confirmadas más 36 acompañantes (20% de 180), sin redondear ni sustituir la base del evento del auditorio ni el 20% pedido por Secretaría.",
            "Reportar 198 asistentes en el PMI, aplicando un 10% sobre las 180 confirmadas (180 × 1,10), como propone el docente, porque es un incremento «limpio» comparable con el histórico de ocupación del auditorio.",
            "Consignar 208 en el acta de calidad, sumando el 20% a otra base de 140 (180 + 28) o 160 más 30%, como insiste el segundo docente, para no tensionar el informe del evento ante Secretaría.",
            "Registrar 225 en el tablero SIMAT de ocupación, tomando el 90% del aforo máximo de 250 del auditorio, para que el indicador de uso de planta física luzca alineado con la meta de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 20% de las 180 personas confirmadas son 36 acompañantes, y 180 + 36 = 216, cifra que cabe en el aforo de 250 del auditorio. Esa es la cifra del acta institucional. 198 aplica un 10%, que es lo que propone el docente; 208 mezcla el 20% con otra base; 225 toma el 90% del aforo. Ninguna conserva 180 más el 20% pedido.",
        "normativeJustification": "El Decreto 1075 y la Guía 34 exigen que el PMI y el acta conserven la definición operativa del evento. No se sustituye el 20% de 180 por un 10% histórico, por otra base de 140 o por el 90% del aforo de 250.",
        "theoreticalJustification": "Un porcentaje se aplica a una base única. 0,20 × 180 = 36 y 180 + 36 = 216. Cambiar 20% por 10%, mezclar 140 o usar 0,90 × 250 produce otro indicador de ocupación.",
        "distractorAnalysis": {
            "1": "Trampa del 10% del docente: 198 = 180 × 1,10. Es el incremento «limpio» que propone el docente del caso. No opera el 20% de acompañantes sobre 180; cambia la alícuota y reporta otra ocupación del auditorio.",
            "2": "Trampa de mezclar otra base: 208 = 180 + 20% de 140, o 160 + 30%, como insiste el segundo docente. Conserva un 20% pero cambia las 180 confirmadas del evento del auditorio.",
            "3": "Trampa de dominio cruzado de ocupación del aforo: 225 = 90% de 250. Es un indicador plausible de uso del auditorio en el SIMAT. Sustituye 180 + 20% por un porcentaje del techo de planta física.",
        },
    },
    {
        "id": "dir-apt-num-134",
        "options": [
            "Reportar 80 kits en el PMI, omitiendo cerca de 12 estudiantes de transición (133 ÷ 5 × 3) o usando otra razón de entrega, como propone el docente, porque deja un cupo «ajustado» comparable con el histórico de material.",
            "Consignar 87 kits escolares en el acta: 145 ÷ 5 = 29 grupos de transición y 29 × 3, como la entrega exacta de tres kits por cada cinco estudiantes, sin redondear ni cambiar la matrícula de 145.",
            "Consignar 84 kits en el acta de calidad, redondeando 145 a 140 y calculando 28 grupos × 3, como insiste el segundo docente, para no tensionar el informe de material de transición ante Secretaría.",
            "Registrar 90 kits en el SIMAT, redondeando la matrícula de transición a 150 cupos (30 × 3) para el tablero de calidad, de modo que la cobertura de kits luzca alineada con la meta de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Hay 145 estudiantes de transición y se entregan 3 kits por cada 5, de modo que 145 ÷ 5 = 29 grupos y 29 × 3 = 87 kits. Esa es la cifra del acta. 80 omite parte de la matrícula; 84 redondea 145 a 140; 90 usa 150 para el SIMAT. Ninguna conserva 145 y la razón 3 por 5.",
        "normativeJustification": "La entrega de material se reporta con la matrícula real de transición y la razón institucional. El PMI no puede omitir cupos, redondear 145 a 140 ni inflar a 150 del SIMAT como si fueran 145 ÷ 5 × 3.",
        "theoreticalJustification": "Kits = (n ÷ 5) × 3. Con n=145, 29 × 3 = 87. 133 ÷ 5 × 3 ≈ 80; 140 ÷ 5 × 3 = 84; 150 ÷ 5 × 3 = 90 cambian n o la razón.",
        "distractorAnalysis": {
            "0": "Trampa de omitir matrícula de transición: 80 ≈ 133 ÷ 5 × 3, como propone el docente. Recorta cerca de 12 estudiantes o cambia la razón 3 por 5. No es 145 ÷ 5 × 3 = 87 kits.",
            "2": "Trampa del redondeo a 140: 84 = 28 × 3, como insiste el segundo docente. Suaviza 145 a una base «limpia» de 140. No conserva los 29 grupos de transición del caso.",
            "3": "Trampa de dominio cruzado del cupo SIMAT: 90 = 150 ÷ 5 × 3. Redondea a 150 para el tablero de calidad. Infla la matrícula de transición y no es 145 ÷ 5 × 3.",
        },
    },
    {
        "id": "dir-apt-num-135",
        "options": [
            "Reportar 3h 40min en el PMI (220 min = 55 × 4), omitiendo 20 pruebas del lote de 130 de comprensión lectora, como propone el docente, porque deja una carga «limpia» comparable con jornadas anteriores.",
            "Consignar 4h 00min en el acta de calidad (240 min = 60 × 4), tomando 120 pruebas o un bloque de 4 minutos «redondo», como insiste el segundo docente, para no tensionar el informe de calificación.",
            "Consignar 4h 20min por docente: 130 ÷ 2 = 65 pruebas de comprensión lectora y 65 × 4 = 260 minutos, sin cambiar el lote ni el tiempo de 4 minutos por estudiante pedido por Secretaría.",
            "Registrar 4h 40min en el tablero de calidad (280 min = 70 × 4), con 140 pruebas o un buffer de jornada, para que la holgura de calificación luzca alineada con la meta de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. Las 130 pruebas se parten en 65 por docente y 65 × 4 = 260 minutos, es decir 4h 20min. Esa es la cifra del acta de calificación. 3h 40min usa 55 × 4; 4h 00min usa 60 × 4; 4h 40min usa 70 × 4. Ninguna conserva 130 pruebas, dos docentes y 4 minutos.",
        "normativeJustification": "El tiempo de calificación se reporta con el lote institucional y los minutos por prueba. El acta no puede omitir 20 pruebas, redondear a 120 ni inflar a 140 como si fueran 130 ÷ 2 × 4.",
        "theoreticalJustification": "Minutos por docente = (n ÷ 2) × 4. Con n=130, 65 × 4 = 260 = 4h 20min. 55 × 4 = 220; 60 × 4 = 240; 70 × 4 = 280 cambian el lote o el tiempo.",
        "distractorAnalysis": {
            "0": "Trampa de omitir 20 pruebas: 3h 40min = 220 min = 55 × 4. Recorta el lote de 130 de comprensión lectora. No es 65 × 4 = 260 minutos por docente.",
            "1": "Trampa del bloque de 4 horas: 4h 00min = 240 min = 60 × 4. Usa 120 pruebas o un redondeo «limpio» de jornada. No parte 130 entre dos docentes a 4 minutos.",
            "3": "Trampa de dominio cruzado de holgura de jornada: 4h 40min = 280 min = 70 × 4. Deja buffer de calidad o 140 pruebas. Infla el tiempo y no es 65 × 4 del lote.",
        },
    },
    {
        "id": "dir-apt-num-136",
        "options": [
            "Reportar 68 presentaciones Saber en el PMI, aplicando cerca del 71% a los 96 de once o restando 28 por inasistencia de otra cohorte, como propone el docente, porque es una tasa «cauta» comparable.",
            "Consignar 70 en el acta de calidad, redondeando a decena o usando cerca del 73% de los 96 de once, como insiste el segundo docente, para no tensionar el informe de presentación Saber ante Secretaría.",
            "Registrar 76 en el tablero del PMI, tomando cerca del 79% de 96 o el 80% de 95 como techo de presentación Saber, para que el indicador luzca alineado con la meta de calidad de Secretaría.",
            "Consignar 72 estudiantes de grado once: 96 × 0,75, como el 75% exacto de la cohorte que debe presentar Saber en la fecha oficial, sin redondear ni cambiar la base de 96 del caso.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 75% de 96 estudiantes de once es 96 × 0,75 = 72 presentaciones Saber en la fecha oficial. Esa es la cifra del acta. 68 usa otra tasa o resta inasistencia; 70 redondea a decena; 76 eleva el techo PMI. Ninguna conserva el 75% de los 96 de once.",
        "normativeJustification": "La meta de presentación Saber se reporta con la cohorte de once y el porcentaje institucional. El PMI no puede usar ~71%, un redondeo a 70 ni un techo del 80% como si fueran 96 × 0,75.",
        "theoreticalJustification": "Presentaciones = n × p. Con n=96 y p=0,75, el producto es 72. 96 × 0,71 ≈ 68; ~0,73 × 96 ≈ 70; ~0,79 × 96 ≈ 76 son otras alícuotas.",
        "distractorAnalysis": {
            "0": "Trampa de otra tasa de presentación: 68 ≈ 96 × 0,71 o 96 − 28 de otra cohorte. Es la cifra «cauta» del docente. No opera el 75% de los 96 de once en Saber.",
            "1": "Trampa del redondeo a 70: usa ~73% de 96 o una decena «limpia», como insiste el segundo docente. Suaviza 96 × 0,75 = 72 y cambia la meta institucional.",
            "2": "Trampa de dominio cruzado de la meta PMI: 76 ≈ 96 × 0,79 o 80% de 95. Es un techo de presentación Saber plausible. Sustituye el 75% de 96 por otra alícuota de tablero.",
        },
    },
    {
        "id": "dir-apt-num-137",
        "options": [
            "Consignar $59.400.000 para la siguiente compra de 60 tablets: $54.000.000 × 1,10, equivalente a $900.000 × 1,10 × 60, sin redondear el 10% ni cambiar el presupuesto ni el n del caso.",
            "Reportar $56.500.000 en el PMI de compra, sumando cerca de 4,6% a los 54 millones o un ajuste informal, como propone el docente, porque deja un incremento «moderado» comparable en tesorería.",
            "Consignar $57.800.000 en el acta de calidad, aplicando un 7% (54 millones × 1,07) en vez del 10% de la siguiente compra, como insiste el segundo docente, para no tensionar el informe de tablets.",
            "Registrar $60.000.000 como techo redondo de tesorería (60 tablets × $1.000.000), para que el cupo de la siguiente compra luzca holgado en el tablero de calidad ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El presupuesto de 54 millones sube 10%, de modo que 54 millones × 1,10 = 59,4 millones, o 900 mil × 1,10 × 60. Esa es la cifra del acta de compra de tablets. 56,5 millones es un ajuste informal; 57,8 millones aplica 7%; 60 millones es un techo redondo. Ninguna conserva el 10% sobre 54 millones y 60 tablets.",
        "normativeJustification": "Los recursos de la siguiente compra se reportan con el presupuesto de la vigencia y el incremento pactado. El PMI no puede sustituir 54 millones × 1,10 por un 4,6% informal, un 7% o un techo de 60 millones.",
        "theoreticalJustification": "Nuevo total = base × 1,10. 54 millones × 1,10 = 59,4 millones. Sumar ~4,6%, aplicar 1,07 o redondear a 60 millones produce otro cupo de tablets.",
        "distractorAnalysis": {
            "1": "Trampa del ajuste informal a 56,5 millones: suma ~4,6% a 54 millones, como propone el docente. No aplica el 10% de la siguiente compra de 60 tablets; cambia la alícuota.",
            "2": "Trampa del 7% en vez del 10%: 57,8 millones ≈ 54 millones × 1,07, como insiste el segundo docente. Conserva la base de 54 millones pero no el 10% pedido.",
            "3": "Trampa de dominio cruzado del techo de tesorería: 60 millones = 60 × 1 millón. Es un cupo redondo plausible de compra. Sustituye 54 millones × 1,10 por un techo holgado de tablets.",
        },
    },
    {
        "id": "dir-apt-num-138",
        "options": [
            "Reportar 70 personas en el PMI, tomando cerca del 29% de 240 o «70 docentes» y omitiendo administrativos de la encuesta, como propone el docente, porque deja un cupo «cauto» comparable con el histórico de clima.",
            "Consignar 84 personas que no calificaron bueno o excelente: el 65% de 240 es 156 y 240 − 156 = 84 (35% de 240), sin cambiar la encuesta de clima ni la planta de 240.",
            "Consignar 78 en el acta de calidad, usando 32,5% de 240 o el 65% de 120 (mitad de la planta), como insiste el segundo docente, para no tensionar el informe de clima laboral ante Secretaría.",
            "Registrar 90 en el tablero de clima, tomando 37,5% de 240 o un techo holgado de «por mejorar», para que el indicador luzca alineado con la meta PMI de ambiente laboral.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 65% de 240 es 156 quienes calificaron bueno o excelente; el complemento es 240 − 156 = 84, equivalente al 35% de 240. Esa es la cifra del acta de clima. 70 omite administrativos o usa ~29%; 78 toma otra base o la mitad de la planta; 90 es un techo de tablero. Ninguna conserva el complemento de 156 sobre 240.",
        "normativeJustification": "El informe de clima se reporta con la misma planta encuestada (docentes y administrativos). El PMI no puede recortar a «70 docentes», usar la mitad de 240 ni un techo de 90 como si fueran 240 − 156.",
        "theoreticalJustification": "El complemento es n − (n × p). Con n=240 y p=0,65, n×p=156 y el resto es 84. ~0,29×240≈70; 0,65×120=78; 0,375×240=90 cambian la base o la alícuota.",
        "distractorAnalysis": {
            "0": "Trampa de omitir administrativos: 70 ≈ 29% de 240 o «70 docentes», como propone el docente. Recorta la encuesta de clima a una parte de la planta. No es el complemento 240 − 156 = 84.",
            "2": "Trampa de otra base o mitad de planta: 78 = 32,5% de 240 o 65% de 120, como insiste el segundo docente. Cambia 240 o el 35% complemento. No es 240 − 156.",
            "3": "Trampa de dominio cruzado del tablero de clima: 90 = 37,5% de 240 o techo holgado de «por mejorar». Luce alineado con una meta PMI. Infla el complemento y no es 84.",
        },
    },
    {
        "id": "dir-apt-num-139",
        "options": [
            "Reportar 85% de asistencia en el PMI, tomando el viernes (28 de 33) o el mínimo de la semana del curso, como propone el docente, porque es una tasa «cauta» comparable con el histórico de permanencia.",
            "Consignar 88% en el acta de calidad, usando el jueves (29 de 33) o 150 sobre 170, como insiste el segundo docente, para no tensionar el informe semanal de asistencia ante Secretaría.",
            "Consignar 91% de asistencia: el promedio (32+30+31+29+28)/5 = 30 y 30/33 ≈ 90,9%, también 150/165, sin sustituir la semana por un día ni cambiar los 33 matriculados.",
            "Registrar 94% en el tablero ISCE, tomando el miércoles (31 de 33) o la meta de permanencia del PMI, para que la asistencia del curso luzca alineada con el compromiso de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El promedio semanal es (32+30+31+29+28)/5 = 30 presentes, y 30/33 ≈ 90,9% = 91%, también 150/165. Esa es la cifra del acta de asistencia. 85% toma el viernes; 88% el jueves; 94% el miércoles o la meta PMI. Ninguna promedia los cinco días sobre 33 matriculados.",
        "normativeJustification": "La asistencia semanal se reporta con la matrícula del curso y el promedio de los días hábiles. El PMI no puede tomar el viernes, el jueves o una meta ISCE del 94% como si fueran 30 sobre 33.",
        "theoreticalJustification": "La tasa es (promedio de presentes) / matrícula. Promedio=30 y 30/33≈0,909=91%. 28/33≈85%; 29/33≈88%; 31/33≈94% son días sueltos u otra meta.",
        "distractorAnalysis": {
            "0": "Trampa del viernes como semana: 85% = 28/33, el mínimo de la semana, como propone el docente. Sustituye el promedio de cinco días por un dato puntual. No es 30/33 ≈ 91%.",
            "1": "Trampa del jueves o de otra matrícula: 88% ≈ 29/33 o 150/170, como insiste el segundo docente. Toma un día o cambia los 33 matriculados. No promedia los cinco registros.",
            "3": "Trampa de dominio cruzado ISCE/permanencia: 94% ≈ 31/33 (miércoles) o meta PMI. Es un indicador plausible de calidad. Sustituye el promedio semanal sobre 33 por un techo de tablero.",
        },
    },
    {
        "id": "dir-apt-num-140",
        "options": [
            "Reportar $420.000 en el PMI, aplicando el 15% a $2.800.000 (otro básico) o cerca de 13,1% a $3.200.000, como propone el docente, porque deja un estímulo «ajustado» comparable en tesorería.",
            "Consignar $450.000 en el acta de calidad, tomando el 15% de $3.000.000 (básico redondeado), como insiste el segundo docente, para no tensionar el informe de bonificación por desempeño.",
            "Registrar $500.000 como techo redondo de tesorería, o cerca de 15,6% de $3.200.000, para que el estímulo por desempeño luzca holgado en el tablero de calidad ante Secretaría.",
            "Consignar $480.000 de bonificación: $3.200.000 × 0,15, como el 15% exacto del salario básico mensual del docente, sin redondear el básico ni cambiar la alícuota pedida por Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 15% del básico de 3,2 millones es 3,2 millones × 0,15 = 480 mil pesos de bonificación. Esa es la cifra del acta. 420 mil usa otro básico; 450 mil redondea a 3 millones; 500 mil es un techo de tesorería. Ninguna conserva el 15% sobre 3,2 millones.",
        "normativeJustification": "La bonificación por desempeño se reporta con el básico de la vigencia y la alícuota institucional. El PMI no puede aplicar 15% a 2,8 o a 3 millones ni un techo de 500 mil como si fueran 3,2 millones × 0,15.",
        "theoreticalJustification": "Bonificación = básico × 0,15. 3,2 millones × 0,15 = 480 mil. 2,8 millones × 0,15 = 420 mil; 3 millones × 0,15 = 450 mil; un cupo de 500 mil cambia la base o la alícuota.",
        "distractorAnalysis": {
            "0": "Trampa de otro básico a 2,8 millones: 420 mil = 2,8 millones × 0,15, como propone el docente. Cambia el salario de 3,2 millones o baja la alícuota. No es 3,2 millones × 0,15.",
            "1": "Trampa del básico redondeado a 3 millones: 450 mil = 3 millones × 0,15, como insiste el segundo docente. Suaviza 3,2 millones a una base «limpia». No conserva el 15% del caso.",
            "2": "Trampa de dominio cruzado del techo de tesorería: 500 mil es un cupo redondo o ~15,6% de 3,2 millones. Refuerza el estímulo en el tablero. Infla la bonificación y no es 3,2 millones × 0,15.",
        },
    },
    {
        "id": "dir-apt-blan-141",
        "options": [
            "Revisar con discreción y objetividad los registros de evaluación del docente señalado en la queja anónima, conversar con él sobre lo hallado y recién entonces decidir, respetando el debido proceso en rectoría.",
            "Llevar la queja anónima al consejo de padres para «transparentar» el señalamiento de favoritismo en calificaciones, de modo que la comunidad vea que rectoría no oculta el caso y se proteja la imagen institucional.",
            "Expedir una circular de «cero favoritismo» en el SIEE y dejar sanción inmediata en la carpeta 1278 del docente, para que la visita de calidad encuentre evidencia de rigor, sin contrastar aún los registros de evaluación.",
            "Pedir al docente que unifique al alza las calificaciones del grupo señalado, para «cerrar equidad» frente a la queja anónima, archivar el caso en rectoría y evitar que el favoritismo siga tensionando el clima de evaluación.",
        ],
        "explanation": "La condición de calidad pregunta qué conducta es la más defendible ética e institucionalmente ante la queja anónima de favoritismo en calificaciones. Verificar con discreción los registros de evaluación y conversar con el docente antecede cualquier medida y respeta el debido proceso en rectoría. Abrir el caso en el consejo de padres parece transparencia y rompe la reserva de un señalamiento anónimo. Sancionar en la carpeta 1278 para la visita, sin contrastar registros, prioriza la imagen de calidad. Unificar notas al alza cierra el expediente y altera el SIEE. La rectoría se defiende verificando primero.",
        "normativeJustification": "El debido proceso (artículo 29 de la Constitución), el SIEE del Decreto 1290 y el régimen disciplinario docente exigen verificar registros y oír al señalado antes de decidir. Una queja anónima no autoriza sanción de plano ni a alterar calificaciones.",
        "theoreticalJustification": "La integridad directiva privilegia evidencia y reserva. Transparencia ante el consejo de padres, expediente de visita o arreglo de notas miden imagen o clima, no la verificación que el caso exige.",
        "distractorAnalysis": {
            "1": "Trampa de transparentar la queja anónima: llevarla al consejo de padres parece integridad y cuida la imagen de rectoría. Rompe la reserva del señalamiento y expone al docente antes de verificar registros de evaluación.",
            "2": "Trampa de dominio cruzado SIEE y visita 1278: la circular de «cero favoritismo» y la sanción en carpeta son evidencia impecable para calidad. El stem pide la conducta más defendible ética e institucionalmente, no un expediente de visita sin verificación.",
            "3": "Trampa de cerrar equidad al alza: unificar notas del grupo parece reparar el favoritismo y archivar la queja. Alterar el SIEE para calmar el caso no verifica los registros ni respeta el debido proceso.",
        },
    },
    {
        "id": "dir-apt-blan-142",
        "options": [
            "Aplicar de inmediato la sanción más grave prevista en el manual de convivencia y dejarla en la carpeta del estudiante para la visita de calidad, de modo que la reincidencia quede documentada con rigor visible ante Secretaría.",
            "Aplicar el debido proceso del manual considerando la reincidencia, y valorar con el equipo de convivencia si el estudiante requiere un apoyo adicional o una medida más estructurada, con registro y seguimiento.",
            "Renovar con el estudiante el mismo compromiso verbal de la falta anterior, sin convocar al equipo de convivencia ni dejar registro, para «dar otra oportunidad» y no tensionar el clima del curso tras la reincidencia.",
            "Convocar una asamblea de curso para que el grupo vote la medida frente a la reincidencia, argumentando que la participación del gobierno escolar legitima la decisión y descarga al equipo de convivencia.",
        ],
        "explanation": "La condición de calidad pregunta qué conducta es la más defendible ética e institucionalmente ante la reincidencia tras el compromiso de convivencia. El manual exige debido proceso y el equipo valora un apoyo adicional o una medida más estructurada. Aplicar de una vez la sanción más grave para la visita documenta rigor y vacía la ruta formativa. Renovar el mismo compromiso verbal, sin registro ni equipo, simula una nueva oportunidad. Que el curso vote la medida parece participación y no sustituye la Ley 1620. La reincidencia se aborda con proceso, no con espectáculo ni con omisión.",
        "normativeJustification": "La Ley 1620, el Decreto 1965 y la Guía 49 del MEN exigen debido proceso, proporcionalidad y ruta de atención ante reincidencia. El manual de convivencia no se aplica de plano ni se sustituye por un voto de curso.",
        "theoreticalJustification": "La reincidencia indica que el primer compromiso no bastó; el equipo analiza causas y apoyos. La sanción máxima, el pacto verbal suelto o la asamblea miden rigor, indulgencia o participación, no la ruta.",
        "distractorAnalysis": {
            "0": "Trampa del rigor visible para la visita: la sanción más grave del manual y la carpeta parecen autoridad ante la reincidencia. Vacían el debido proceso y el carácter formativo de la Ley 1620, que el stem pide defender.",
            "2": "Trampa de renovar el compromiso verbal: «dar otra oportunidad» suena pedagógico y cuida el clima del curso. Omite registro, equipo de convivencia y la valoración de una medida más estructurada ante la reincidencia.",
            "3": "Trampa de dominio cruzado de participación: que el curso vote la medida parece gobierno escolar. El grupo no sustituye la ruta de la Ley 1620 ni al equipo de convivencia en un caso de reincidencia.",
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
