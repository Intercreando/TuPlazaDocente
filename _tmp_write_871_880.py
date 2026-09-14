# -*- coding: utf-8 -*-
"""Reescribe dir-apt-num-123..132 (posiciones 871-880) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_871_880.json"

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
    "dir-apt-num-123": 2,
    "dir-apt-num-124": 3,
    "dir-apt-num-125": 0,
    "dir-apt-num-126": 1,
    "dir-apt-num-127": 2,
    "dir-apt-num-128": 3,
    "dir-apt-num-129": 0,
    "dir-apt-num-130": 1,
    "dir-apt-num-131": 2,
    "dir-apt-num-132": 3,
}

ITEMS = [
    {
        "id": "dir-apt-num-123",
        "options": [
            "Reportar 10 horas de proyectos transversales en el PMI, tomando el 50% de las 20 horas de libre inversión porque es una mitad «limpia» comparable con el histórico de jornada ya radicado ante Secretaría.",
            "Consignar 11 horas en el acta de calidad, aproximando el 60% del PEI a un 55% de gestión o interpolando 10 y 12, para dejar una cifra intermedia que no tensiona el informe de libre inversión.",
            "Consignar 12 horas transversales, resultantes de 20 × 0,60, como el 60% exacto de las horas de libre inversión del PEI, sin redondear ni sustituir la alícuota ni la base mensual del caso.",
            "Registrar 14 horas en el tablero de calidad, tomando el 70% de las 20 horas de libre inversión como meta PMI de transversalidad, para que el indicador luzca alineado con el compromiso de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. El 60% de las 20 horas de libre inversión es 20 × 0,60 = 12 horas de proyectos transversales, y esa es la cifra del acta. Diez horas corresponden al 50% (otra alícuota); once aproximan un 55% o interpolan; catorce toman el 70% de meta PMI. Ninguna de esas bases es el 60% de las 20 horas del PEI.",
        "normativeJustification": "El Decreto 1075 y la Guía 34 exigen que los indicadores del PMI conserven la definición operativa del PEI. El acta no puede sustituir el 60% de 20 horas por un 50% histórico, un 55% intermedio o un 70% de meta de calidad.",
        "theoreticalJustification": "Un porcentaje se aplica a una base única. Cambiar 60% por 50%, ~55% o 70% produce otro indicador de transversalidad. El producto exacto es 20 × 0,60 = 12 horas.",
        "distractorAnalysis": {
            "0": "Trampa de la mitad «limpia»: 10 horas = 0,50 × 20. Es un 50% histórico de jornada comparable en el PMI. No opera el 60% del PEI; cambia la alícuota y reporta otra cobertura transversal.",
            "1": "Trampa del ajuste informal a 11 horas: la cifra sale de un ~55% o de interpolar 10 y 12. No es 20 × 0,60; suaviza el informe de libre inversión cambiando la base.",
            "3": "Trampa de dominio cruzado de la meta PMI: 14 horas = 0,70 × 20. El 70% es una meta de calidad plausible. Sustituye el 60% del PEI por otra alícuota de tablero.",
        },
    },
    {
        "id": "dir-apt-num-124",
        "options": [
            "Reportar 65 estudiantes no aprobados en el PMI, tomando cerca del 10% de 625 (62,5 redondeado) como tasa «limpia» de no aprobación comparable con el histórico de calidad ya radicado.",
            "Consignar 70 no aprobados en el acta de calidad, como punto medio entre 65 y 75 o como 625 − 555, para dejar una cifra intermedia que no tensiona el informe de aprobación ante Secretaría.",
            "Registrar 80 no aprobados en el SIMAT y en el PMI, tomando cerca del 13% de 625 o un techo holgado de gestión, para que la no aprobación luzca alineada con la meta de calidad.",
            "Consignar 75 estudiantes no aprobados: 625 × 0,88 = 550 aprobados y 625 − 550 = 75, sin redondear la tasa del 88% ni cambiar la base de evaluados de esta vigencia.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. El 88% de 625 evaluados son 625 × 0,88 = 550 aprobados; los no aprobados son 625 − 550 = 75. Esa es la cifra del acta. 65 aproxima el 10% de 625; 70 interpola o usa 625 − 555; 80 es un techo cercano al 13%. Ninguna conserva 550 aprobados y 75 no aprobados.",
        "normativeJustification": "El Decreto 1290 y el informe de calidad reportan aprobación con la misma cohorte evaluada. El PMI no puede presentar un 10% histórico, un punto medio de 70 o un techo del 13% como si fueran 625 − 550.",
        "theoreticalJustification": "No aprobados = n − (n × p). Con n=625 y p=0,88, n×p=550 y el complemento es 75. 0,10×625≈65; 625−555=70; ~0,13×625=80 son otras cuentas.",
        "distractorAnalysis": {
            "0": "Trampa de la tasa del 10%: 65 ≈ 0,10 × 625 (62,5 redondeado). Es una no aprobación «limpia» de histórico. No resta 550 a 625; cambia el 12% real de no aprobados.",
            "1": "Trampa del punto medio 70: interpolar 65 y 75 o usar 625 − 555. Mezcla redondeo de gestión con 625 − 550 = 75 y no conserva el 88%.",
            "2": "Trampa de dominio cruzado del techo de tablero: 80 ≈ 13% de 625. Luce alineado con una meta de no aprobación del PMI. Infla el complemento y no es 625 − 550.",
        },
    },
    {
        "id": "dir-apt-num-125",
        "options": [
            "Consignar $408.000 como costo de los ejemplares restantes: 780 − 300 = 480 y 480 × $850, sin cambiar la tarifa de imprenta ni el n de manuales de convivencia aún no impresos.",
            "Reportar $380.000 en el PMI de imprenta, calculando 400 ejemplares restantes a $950 (otra tarifa o otro tiraje), porque es un cupo redondo comparable en tesorería y en el histórico de Secretaría.",
            "Consignar $396.000 en el acta de calidad, aplicando $825 por ejemplar a los 480 restantes o una tarifa de otra vigencia, para no tensionar el informe de ejecución del manual.",
            "Registrar $420.000 como techo de imprenta, aproximando 480 × $850 al alza o usando ~494 cupos, para dejar holgura de gestión en el tablero de calidad ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. Restan 780 − 300 = 480 ejemplares del manual y 480 × 850 = 408 mil pesos. Esa es la cifra del acta de imprenta. 380 mil usa 400 restantes a 950 pesos; 396 mil aplica 825 a los 480; 420 mil es un techo holgado. Ninguna conserva 480 ejemplares a 850 pesos.",
        "normativeJustification": "Los recursos de material institucional se reportan con la tarifa y el n pendientes de la misma vigencia. El PMI no puede sustituir 480 × 850 por 400 × 950, por 480 × 825 o por un techo de 420 mil.",
        "theoreticalJustification": "El costo restante es (total − ya impresos) × tarifa. (780 − 300) × 850 = 408 mil. Cambiar 480 por 400 o 850 por 950 o 825 produce otro total.",
        "distractorAnalysis": {
            "1": "Trampa de otra tarifa y otro n: 380 mil = 400 × 950. Mezcla ejemplares redondeados con una tarifa de otra vigencia. No es 480 × 850 del manual de convivencia.",
            "2": "Trampa de la tarifa de imprenta a 825: 396 mil = 480 × 825. Conserva los 480 restantes pero cambia los 850 pesos del caso por otra alícuota de imprenta.",
            "3": "Trampa de dominio cruzado del cupo holgado: 420 mil aproxima 480 × ~875 o ~494 × 850. Presenta techo de gestión ante Secretaría, no el costo exacto de los 480 manuales.",
        },
    },
    {
        "id": "dir-apt-num-126",
        "options": [
            "Reportar 20 sillas para el Salón B en el PMI, partiendo 96 entre cinco espacios (96/5) o usando 50/240, como si hubiera un quinto salón comparable en el inventario de planta física.",
            "Consignar 24 sillas para el Salón B: 96 × (60/240) = 24, proporción exacta de los 60 estudiantes de ese salón sobre 240, sin omitir el total ni añadir un quinto espacio.",
            "Asignar 22 sillas al Salón B en el acta, interpolando 20 y 24 o tomando 96 × (55/240), para dejar un reparto intermedio que no tensiona el informe de mobiliario ante Secretaría.",
            "Registrar 26 sillas para el Salón B en el SIMAT de planta física, usando 96 × (65/240) o holgura de mobiliario, para que el cupo luzca reforzado ante la visita de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. El Salón B tiene 60 de 240 estudiantes, de modo que 96 × (60/240) = 24 sillas. Esa es la cifra del acta de mobiliario. 20 parte 96 entre cinco espacios; 22 interpola o usa 55/240; 26 infla a 65/240. Ninguna conserva la proporción 60 sobre 240 del Salón B.",
        "normativeJustification": "La distribución de mobiliario se reporta con la matrícula de cada salón sobre el total. El PMI no puede partir 96 entre cinco espacios, interpolar 22 ni holgar a 26 como si fueran 96 × (60/240) del Salón B.",
        "theoreticalJustification": "La asignación proporcional es total × (parte/todo). 96 × (60/240) = 24. 96/5=19,2≈20; 96×(55/240)=22; 96×(65/240)=26 cambian el peso del Salón B.",
        "distractorAnalysis": {
            "0": "Trampa del quinto espacio: 20 = 96/5 o 96 × (50/240). Inventa un quinto salón o cambia 60 por 50. No es la proporción del Salón B sobre 240.",
            "2": "Trampa del punto medio 22: interpolar 20 y 24 o usar 96 × (55/240). Suaviza el reparto de mobiliario y no opera 96 × (60/240) del Salón B.",
            "3": "Trampa de dominio cruzado de la holgura de planta: 26 = 96 × (65/240) o ajuste de inventario. Refuerza el cupo ante Secretaría; no es la proporción 60/240 del Salón B.",
        },
    },
    {
        "id": "dir-apt-num-127",
        "options": [
            "Reportar 15 puntos de encuentro en el PMI, dividiendo 900 estudiantes entre grupos de 60 (otra capacidad de evacuación), porque es un tamaño «limpio» comparable con simulacros anteriores de Secretaría.",
            "Consignar 18 puntos en el acta de calidad, dividiendo 900 entre 50 o interpolando 15 y 20, para dejar una cifra intermedia que no tensiona el informe de gestión del riesgo.",
            "Consignar 20 puntos de encuentro: 900 ÷ 45 = 20, con los grupos de 45 del simulacro, sin cambiar el tamaño del grupo ni inflar la matrícula con visitantes de otra jornada.",
            "Registrar 22 puntos en el tablero de calidad, dividiendo 990 entre 45 tras sumar cupos de visitantes u otra jornada, para dejar holgura visible en el simulacro ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. 900 estudiantes en grupos de 45 dan 900 ÷ 45 = 20 puntos de encuentro. Esa es la cifra del acta del simulacro. 15 usa grupos de 60; 18 usa grupos de 50; 22 divide 990 entre 45 con visitantes. Ninguna conserva 900 y 45 del caso.",
        "normativeJustification": "El simulacro de evacuación se reporta con la matrícula y el aforo acordado por punto. El acta de calidad no puede cambiar 45 por 60 o por 50 ni sumar visitantes como si fueran los 900 del colegio.",
        "theoreticalJustification": "El número de puntos es n ÷ tamaño de grupo. 900 ÷ 45 = 20. 900 ÷ 60 = 15; 900 ÷ 50 = 18; 990 ÷ 45 = 22. Esas bases no son las del caso.",
        "distractorAnalysis": {
            "0": "Trampa de otro tamaño de grupo: 15 = 900 ÷ 60. Usa una capacidad de evacuación distinta a 45. Cambia el denominador del simulacro y no produce 20 puntos.",
            "1": "Trampa de grupos de 50: 18 = 900 ÷ 50 o interpola 15 y 20. No es 900 ÷ 45; mezcla otro aforo con el acta de puntos de encuentro.",
            "3": "Trampa de dominio cruzado de visitantes: 22 = 990 ÷ 45. Suma cupos extra de otra jornada o de visitantes. Infla el numerador y no es 900 ÷ 45.",
        },
    },
    {
        "id": "dir-apt-num-128",
        "options": [
            "Reportar $4.000.000 por período en el PMI, tomando $16.000.000 anuales (otra vigencia o un recorte) entre 4 períodos, porque es un millón redondo comparable en tesorería y en compras.",
            "Consignar $4.250.000 en el acta de calidad, dividiendo $17.000.000 entre 4 o interpolando 4 y 4,5 millones, para no tensionar el informe de material didáctico ante Secretaría.",
            "Registrar $4.750.000 como cupo por período, dividiendo $19.000.000 entre 4 o dejando techo holgado de tesorería, para que el rubro luzca reforzado en el tablero de calidad.",
            "Consignar $4.500.000 por período: $18.000.000 ÷ 4, como distribución exacta del presupuesto de material didáctico, sin cambiar el total anual ni el número de períodos del caso.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. El presupuesto de 18 millones dividido en 4 períodos es 18 millones ÷ 4 = 4,5 millones de pesos. Esa es la cifra del acta de material didáctico. 4 millones usa 16 millones anuales; 4,25 millones usa 17 millones; 4,75 millones usa 19 millones. Ninguna conserva los 18 millones entre 4 períodos.",
        "normativeJustification": "Los recursos de material didáctico se reportan con el presupuesto de la vigencia y el n de períodos. El PMI no puede sustituir 18 millones ÷ 4 por 16, 17 o 19 millones anuales presentados como el mismo cupo.",
        "theoreticalJustification": "El cupo por período es total ÷ 4. 18 millones ÷ 4 = 4,5 millones. 16÷4=4; 17÷4=4,25; 19÷4=4,75. Cambiar el numerador anual produce otro indicador.",
        "distractorAnalysis": {
            "0": "Trampa de otra vigencia a 16 millones: 4 millones = 16 000 000 ÷ 4. Es un millón redondo de tesorería. No divide los 18 millones de material didáctico del caso.",
            "1": "Trampa del recorte a 17 millones: 4,25 millones = 17 000 000 ÷ 4 o interpola 4 y 4,5. Cambia el presupuesto anual y no es 18 millones entre 4 períodos.",
            "2": "Trampa de dominio cruzado de tesorería holgada: 4,75 millones = 19 000 000 ÷ 4. Deja techo de gestión en el PMI. Infla la base y no es 18 millones entre 4 períodos.",
        },
    },
    {
        "id": "dir-apt-num-129",
        "options": [
            "Consignar 399 estudiantes en el plan de apoyo: 950 × 0,42, según el 42% identificado por el SIEE en básica, sin redondear ni sustituir la alícuota ni la matrícula del caso.",
            "Reportar 380 cupos de apoyo en el PMI, tomando el 40% de 950 porque es una décima «limpia» comparable con el histórico de recuperación ya radicado ante Secretaría.",
            "Consignar 390 en el acta de calidad, redondeando 399 o aplicando ~41%, para dejar una cifra intermedia que no tensiona la carga de docentes de apoyo ni el informe a Secretaría.",
            "Registrar 410 en el SIMAT pedagógico, tomando cerca del 43% de 950 o un techo de cupos de apoyo, para que la cobertura luzca alineada con la meta de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. El 42% de 950 estudiantes de básica es 950 × 0,42 = 399 para el plan de apoyo. Esa es la cifra que coordinación necesita. 380 es el 40%; 390 redondea 399 o usa ~41%; 410 aproxima un 43% de techo. Ninguna conserva el 42% de la matrícula del SIEE.",
        "normativeJustification": "El SIEE y el Decreto 1290 identifican quién entra a plan de apoyo con el porcentaje institucional. El PMI no puede presentar un 40% histórico, un redondeo a 390 o un techo del 43% como si fueran 950 × 0,42.",
        "theoreticalJustification": "El n de apoyo es matrícula × p. 950 × 0,42 = 399. 0,40×950=380; redondear 399 a 390; ~0,43×950=410. Esas son otras alícuotas o un ajuste de carga.",
        "distractorAnalysis": {
            "1": "Trampa del 40% «limpio»: 380 = 0,40 × 950. Es una décima histórica de recuperación. No opera el 42% del SIEE; cambia la alícuota del plan de apoyo.",
            "2": "Trampa del redondeo a 390: suaviza 399 o aplica ~41%. Cambia 950 × 0,42 por un ajuste de carga docente y no es 399 estudiantes de apoyo.",
            "3": "Trampa de dominio cruzado de la carga docente: 410 ≈ 0,43 × 950 o techo de cupos. Luce alineado con una meta de apoyo; infla el 42% de la matrícula de básica.",
        },
    },
    {
        "id": "dir-apt-num-130",
        "options": [
            "Reportar 840 horas anuales en el PMI, multiplicando 21 × 40 al omitir una hora semanal, porque deja un total «ajustado» comparable con otra asignación de la planta ya radicada.",
            "Consignar 880 horas anuales: 22 × 40 semanas efectivas, como el producto exacto de la intensidad semanal del docente, sin recortar una hora ni inflar la jornada ni el calendario.",
            "Consignar 800 horas en el acta de calidad, tomando 20 × 40 como jornada «limpia» de otra vigencia o de otro cargo, para no tensionar el informe de horas ante Secretaría.",
            "Registrar 900 horas en el tablero de calidad, usando 22,5 × 40 o 22 × ~41 semanas, para dejar holgura de gestión en el indicador de tiempo escolar ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. 22 horas semanales por 40 semanas efectivas son 22 × 40 = 880 horas anuales. Esa es la cifra del acta. 840 omite una hora (21 × 40); 800 usa 20 × 40 como jornada «limpia»; 900 infla a 22,5 × 40. Ninguna conserva 22 y 40 del caso.",
        "normativeJustification": "La intensidad horaria anual se reporta con las horas semanales del docente y las semanas efectivas del calendario. El PMI no puede omitir una hora, usar 20 semanales ni inflar a 22,5 o a 41 semanas.",
        "theoreticalJustification": "El total anual es horas/semana × semanas. 22 × 40 = 880. 21 × 40 = 840; 20 × 40 = 800; 22,5 × 40 = 900. Esas bases no son las del caso.",
        "distractorAnalysis": {
            "0": "Trampa de omitir una hora: 840 = 21 × 40. Recorta la intensidad semanal de 22. Reporta otra asignación de planta, no 22 × 40 semanas efectivas.",
            "2": "Trampa de la jornada «limpia» a 20 horas: 800 = 20 × 40. Usa otra intensidad o otra vigencia. No es 22 × 40 semanas efectivas del docente del caso.",
            "3": "Trampa de dominio cruzado de las 40 semanas con holgura: 900 = 22,5 × 40 o 22 × ~41. Infla el tiempo escolar en el tablero; no conserva 22 y 40.",
        },
    },
    {
        "id": "dir-apt-num-131",
        "options": [
            "Reportar 2 estudiantes en nivel bajo en el PMI, restando 34 a 36 o cargando mal 9+15+10, como si el resto del diagnóstico fuera más estrecho y comparable con un histórico cauto.",
            "Consignar 3 en nivel bajo en el acta de calidad, restando 33 a 36 o interpolando 2 y 4, para dejar una cifra intermedia que no tensiona el informe de la prueba diagnóstica.",
            "Consignar 4 estudiantes en nivel bajo: 9 + 15 + 8 = 32 y 36 − 32 = 4, como el resto exacto del curso, sin inflar el cupo de Bajo ni cambiar los tres niveles ya contados.",
            "Registrar 5 en nivel bajo en el SIMAT de calidad, dejando un cupo holgado de desempeño Bajo del Decreto 1290, para que el tablero luzca alineado con la meta de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. Superior, alto y básico suman 9 + 15 + 8 = 32, y el resto en nivel bajo es 36 − 32 = 4. Esa es la cifra del acta diagnóstica. 2 resta de más; 3 interpola o resta 33; 5 deja un cupo holgado de Bajo. Ninguna conserva el complemento de 32 sobre 36.",
        "normativeJustification": "El Decreto 1290 reporta desempeños con la misma cohorte de la prueba. El PMI no puede restar 34 o 33 a 36 ni dejar un cupo holgado de 5 en Bajo como si fueran 36 − (9+15+8).",
        "theoreticalJustification": "El nivel bajo es el complemento: n − (superior+alto+básico). 36 − 32 = 4. 36−34=2; 36−33=3; un cupo de 5 cambia el resto medido.",
        "distractorAnalysis": {
            "0": "Trampa de restar de más: 2 = 36 − 34, como si superior, alto y básico sumaran 34. Cambia 9+15+8=32 y no deja 4 en nivel bajo.",
            "1": "Trampa del punto medio 3: resta 33 a 36 o interpola 2 y 4. No opera 36 − 32; suaviza el resto del diagnóstico y no es 4 en nivel bajo.",
            "3": "Trampa de dominio cruzado del cupo Bajo 1290: 5 deja un cupo holgado de desempeño Bajo para el reporte de calidad. No es el complemento 36 − 32 del curso.",
        },
    },
    {
        "id": "dir-apt-num-132",
        "options": [
            "Reportar $250.000 por docente en el PMI, dividiendo $2.000.000 (otra vigencia o un recorte) entre 8, porque es un cuarto de millón redondo comparable en tesorería y en estímulos previos.",
            "Consignar $280.000 en el acta de calidad, dividiendo $2.240.000 entre 8 o interpolando 250 y 300 mil, para no tensionar el informe de bonificaciones del proyecto especial.",
            "Registrar $320.000 como estímulo por docente, dividiendo $2.560.000 entre 8 o dejando techo holgado, para que el incentivo luzca reforzado en el tablero de calidad ante Secretaría.",
            "Consignar $300.000 por docente: $2.400.000 ÷ 8, como reparto exacto de las bonificaciones del proyecto especial, sin cambiar el fondo ni el n de docentes que participaron.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y la operación, sin redondear ni cambiar la base. El fondo de 2,4 millones entre 8 docentes es 2,4 millones ÷ 8 = 300 mil pesos por persona. Esa es la cifra del acta de bonificaciones. 250 mil usa 2 millones; 280 mil usa 2,24 millones; 320 mil usa 2,56 millones. Ninguna conserva 2,4 millones entre 8 docentes.",
        "normativeJustification": "Las bonificaciones se reportan con el fondo de la vigencia y el n de docentes del proyecto. El PMI no puede sustituir 2,4 millones ÷ 8 por 2 millones, 2,24 millones o 2,56 millones presentados como el mismo estímulo.",
        "theoreticalJustification": "El cupo por docente es total ÷ 8. 2,4 millones ÷ 8 = 300 mil. 2 millones ÷ 8 = 250 mil; 2,24 ÷ 8 = 280 mil; 2,56 ÷ 8 = 320 mil. Cambiar el numerador produce otro valor.",
        "distractorAnalysis": {
            "0": "Trampa de otra vigencia a 2 millones: 250 mil = 2 000 000 ÷ 8. Es un cuarto de millón redondo de tesorería. No divide los 2,4 millones del proyecto especial.",
            "1": "Trampa del recorte a 2,24 millones: 280 mil = 2 240 000 ÷ 8 o interpola 250 y 300 mil. Cambia el fondo de bonificaciones y no es 2,4 millones entre 8.",
            "2": "Trampa de dominio cruzado de estímulos holgados: 320 mil = 2 560 000 ÷ 8. Refuerza el incentivo en el tablero de calidad. Infla la base y no es 2,4 millones entre 8.",
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
