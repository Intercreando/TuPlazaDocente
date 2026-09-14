# -*- coding: utf-8 -*-
"""Reescribe dir-apt-num-33..40 y dir-apt-blan-41..42 (posiciones 781-790)."""
import json
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_781_790.json"

ITEMS = [
    {
        "id": "dir-apt-num-33",
        "options": [
            "Consignar $8.500.000 en el PMI como materiales didácticos, tomando el 10% de $85.000.000 porque es una décima «limpia» comparable con el histórico de compras y con el informe ya radicado ante Secretaría.",
            "Reportar $9.200.000 como ejecución de materiales, aproximando el 12% a un 10,8% de gestión o mezclando el cupo de otra vigencia, para dejar un valor intermedio que no tensiona tesorería.",
            "Consignar $10.200.000, resultantes de $85.000.000 × 0,12, como el 12% exacto destinado a materiales didácticos, sin redondear ni sustituir la base del presupuesto institucional del caso.",
            "Registrar $11.000.000 como cupo de materiales, aproximando el 12% al 13% o dejando un techo holgado de gestión, para que el rubro luzca reforzado en el tablero de calidad y ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos y con la operación, sin redondear ni cambiar la base. El 12% de $85.000.000 es $85.000.000 × 0,12 = $10.200.000, y esa es la cifra del acta de materiales didácticos. $8.500.000 corresponde al 10% (otra alícuota); $9.200.000 aproxima un 10,8% o mezcla otra vigencia; $11.000.000 infla el 12% hacia un cupo de gestión. Ninguna de esas bases es el 12% del presupuesto del caso.",
        "normativeJustification": "El Decreto 1075 y la Guía 34 exigen que los indicadores del PMI conserven la definición operativa con la que se calcularon. El acta de calidad no puede sustituir el 12% de $85.000.000 por un 10% histórico, un ajuste a 10,8% o un techo holgado de $11.000.000.",
        "theoreticalJustification": "Un porcentaje se aplica a una base única. Cambiar 12% por 10% o por ~13% produce otro indicador. El valor intermedio $9.200.000 no resulta de 85.000.000 × 0,12. La cifra exacta es $10.200.000.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del 10% histórico: $8.500.000 es el 10% de $85.000.000, cifra «limpia» y comparable en compras. No opera el 12% del caso; cambia la alícuota y reporta otro rubro.",
            "1": "Trampa del ajuste informal a $9.200.000: la cifra sale de un ~10,8% o de mezclar el cupo de otra vigencia. No es $85.000.000 × 0,12; suaviza tesorería cambiando la base.",
            "3": "Trampa del cupo holgado a $11.000.000: aproximar 12% a 13% o dejar techo de gestión luce reforzado en el PMI. Infla el indicador y abandona el 12% exacto de la misma base.",
        },
    },
    {
        "id": "dir-apt-num-34",
        "options": [
            "Reportar 60% de uso sistemático del PEI en el PMI, tomando 108 de 180 docentes o recortando a una décima «prudente», para alinear el indicador con un histórico de calidad ya radicado.",
            "Consignar 65% en el acta de calidad, como ajuste entre 60% y 70% o como 117 de 180, para dejar una cifra intermedia que no tensiona el tablero ni el informe a Secretaría.",
            "Consignar 70% como proporción exacta: 126 de 180 docentes usan el PEI de manera sistemática en su planeación, sin cambiar el denominador ni redondear hacia una meta de gestión.",
            "Registrar 75% en el SIMAT pedagógico y en el PMI, tomando 135 de 180 o elevando el 70% a la meta de calidad, para que el resultado luzca alineado con el compromiso de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. 126 docentes de 180 usan el PEI de forma sistemática: 126/180 = 0,70 = 70%. Esa es la cifra del acta. El 60% usa 108/180 o un recorte; el 65% interpola o toma 117/180; el 75% usa 135/180 o una meta al alza. Ninguna de esas operaciones conserva el numerador 126 y el denominador 180.",
        "normativeJustification": "La apropiación del PEI se reporta con la muestra y la definición de la encuesta institucional. El PMI no puede sustituir 126/180 por un histórico del 60%, un punto medio del 65% o una meta del 75% presentada como resultado.",
        "theoreticalJustification": "Una proporción es n favorable sobre n total. Cambiar 126 por 108, 117 o 135 altera el numerador. El 70% es 126/180; las otras cifras corresponden a otras cuentas o a metas de tablero.",
        "distractorAnalysis": {
            "0": "Trampa del recorte a 60%: 108/180 o una décima «prudente» alinea el indicador con un histórico. No es 126/180; cambia el numerador y reporta otra cobertura del PEI.",
            "1": "Trampa del punto medio 65%: interpolar 60% y 70% o tomar 117/180 deja una cifra suave de gestión. No opera 126/180 y mezcla redondeo con el indicador de la encuesta.",
            "3": "Trampa de la meta al 75%: 135/180 o elevar el 70% a compromiso de calidad luce bien en Secretaría. Sustituye el resultado medido por una meta y cambia la base de 126 docentes.",
        },
    },
    {
        "id": "dir-apt-num-35",
        "options": [
            "Cerrar el ciclo a las 11:30 a.m. en el acta, sumando 5×50 minutos y apenas 2 descansos de 10, es decir 270 minutos desde las 7:00, como si dos pausas bastaran para el empalme de las cinco reuniones.",
            "Cerrar a las 11:50 a.m.: 5 reuniones de 50 minutos (250) más 4 descansos de 10 entre ellas (40) suman 290 minutos, o 4 h 50 min a partir de las 7:00, sin inventar pausas extra ni omitir empalmes.",
            "Reportar 12:10 p.m. como hora de cierre, contando 5 o 6 descansos de 10 minutos además de los 250 de reunión (310 minutos), como si hubiera pausa también después de la última sesión.",
            "Consignar 12:30 p.m. en el cronograma de calidad, igualando cada bloque a 50+10 y sumando un empalme o almuerzo de 30 minutos (330), para dejar holgura visible ante el comité de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. Hay 5 reuniones de 50 minutos (250) y descansos de 10 minutos entre ellas: entre 5 sesiones hay 4 pausas (40). Total 290 minutos = 4 h 50 min. Desde las 7:00 a.m. el cierre es 11:50 a.m. Las 11:30 omiten dos de las cuatro pausas (270 min). Las 12:10 cuentan 5–6 pausas (310 min). Las 12:30 añaden almuerzo o 5 bloques de 60 min más holgura.",
        "normativeJustification": "La programación de reuniones de área se reporta con la duración acordada y con los empalmes reales entre sesiones. El acta de calidad no puede omitir descansos, inventar una pausa posterior a la última reunión ni cargar un almuerzo como si fuera parte de las cinco sesiones de 50 minutos.",
        "theoreticalJustification": "El tiempo total es n×duración + (n−1)×pausa. Con n=5, las pausas son 4, no 2 ni 6. Sumar 30 minutos de otra actividad cambia el objeto del cronograma. 7:00 más 290 minutos es 11:50.",
        "distractorAnalysis": {
            "0": "Trampa de omitir empalmes: 11:30 sale de 5×50+2×10=270 minutos (4 h 30). Parece un cronograma «ajustado», pero deja dos de las cuatro pausas del caso por fuera.",
            "2": "Trampa de pausas de más: 12:10 resulta de 250+6×10=310 minutos, como si hubiera descanso después de la quinta reunión. Cambia (n−1) por n o n+1 y desplaza el cierre.",
            "3": "Trampa de dominio cruzado del almuerzo: 12:30 suma 5×(50+10) más ~30 minutos de otra actividad. Mezcla jornada de bienestar o holgura de gestión con el tiempo de las cinco reuniones.",
        },
    },
    {
        "id": "dir-apt-num-36",
        "options": [
            "Reportar 1/3 de la planta con maestría en el PMI, tomando 20 de 60 docentes o redondeando 24/60 a un tercio «limpio», comparable con el histórico de formación posgradual de Secretaría.",
            "Consignar 2/5 como fracción exacta: 24 de 60 docentes tienen título de maestría, sin sustituir el numerador por 20, 30 o 36 ni cambiar el denominador de la planta del caso.",
            "Registrar 3/5 en el acta de calidad, como si 36 de 60 tuvieran maestría, sumando otra cohorte en curso o confundiendo 24 titulados con un 60% de gestión.",
            "Cargar 1/2 de la planta en el informe de talento humano, tomando 30 de 60 como mitad simétrica de tablero, para igualar el indicador a una meta de cualificación fácil de comunicar.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. 24 docentes de 60 tienen maestría: 24/60 = 2/5. Esa es la fracción del acta. 1/3 equivale a 20/60; 3/5 a 36/60; 1/2 a 30/60. Las tres alteran el numerador 24 o redondean a una fracción de gestión. El denominador sigue siendo la planta de 60 del caso.",
        "normativeJustification": "La cualificación docente se reporta con el título ya obtenido y con la planta real. El PMI y el informe de talento humano no pueden presentar un tercio histórico, un 60% holgado o la mitad simétrica como si fueran 24/60.",
        "theoreticalJustification": "Simplificar 24/60 da 2/5. Un tercio es 20/60; 3/5 es 36/60; 1/2 es 30/60. Redondear a esas fracciones cambia el numerador y no es 24/60.",
        "distractorAnalysis": {
            "0": "Trampa del tercio «limpio»: 1/3 = 20/60 o un redondeo de 24/60 hacia el histórico de Secretaría. Cambia 24 por 20 y no conserva la fracción medida.",
            "2": "Trampa de la cohorte inflada a 3/5: 36/60 mezcla titulados con quienes cursan maestría o lee 24 como 60%. Reporta otra cobertura de formación.",
            "3": "Trampa de dominio cruzado de la mitad de gestión: 1/2 = 30/60 es una meta simétrica de cualificación. No opera 24/60; sustituye el dato por un tablero fácil de comunicar.",
        },
    },
    {
        "id": "dir-apt-num-37",
        "options": [
            "Consignar $140.000.000 como asignación PAE en el PMI, multiplicando $400.000 por 350 beneficiarios, tarifa de otra vigencia o de otro programa, porque es un millón redondo y comparable en tesorería.",
            "Reportar $145.000.000 en el acta de calidad, redondeando $147.000.000 a un cupo de tesorería «limpio», para no tensionar el informe de ejecución ante Secretaría.",
            "Consignar $147.000.000, resultantes de $420.000 × 350 estudiantes beneficiarios, como la asignación PAE exacta del caso, sin cambiar la tarifa por estudiante ni el n de beneficiarios.",
            "Registrar $150.000.000 como techo PAE, aproximando 350×$420.000 al alza o usando ~357 cupos, para dejar holgura de gestión en el tablero de alimentación escolar.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. $420.000 por estudiante × 350 beneficiarios = $147.000.000. Esa es la asignación del acta. $140.000.000 usa $400.000×350 (otra tarifa); $145.000.000 redondea tesorería; $150.000.000 es un techo al alza. Ninguna conserva tarifa y n del caso.",
        "normativeJustification": "Los recursos del PAE se reportan con la asignación por estudiante y el número de beneficiarios de la IE. El PMI no puede sustituir $420.000×350 por una tarifa de $400.000, un redondeo a $145.000.000 o un techo de $150.000.000.",
        "theoreticalJustification": "El producto tarifa × n da el total. Cambiar 420.000 por 400.000 o inflar n hacia 357 produce otro total. El redondeo a 145 millones no es 420.000×350.",
        "distractorAnalysis": {
            "0": "Trampa de otra tarifa: $140.000.000 = 400.000×350, indicador redondo de tesorería o de otra vigencia. No usa los $420.000 del caso.",
            "1": "Trampa del redondeo de tesorería a $145.000.000: suaviza $147.000.000 a un cupo «limpio». Cambia la operación 420.000×350 por un ajuste de informe.",
            "3": "Trampa del techo holgado a $150.000.000: alza el producto o usa ~357 cupos. Presenta holgura de gestión, no la asignación exacta de 350 beneficiarios.",
        },
    },
    {
        "id": "dir-apt-num-38",
        "options": [
            "Reportar 24 aciertos mínimos en el acta, tomando el 60% de 40 preguntas como umbral «prudente» comparable con un corte histórico de la prueba institucional.",
            "Consignar 26 aciertos, como 65% de 40 o como punto medio entre 24 y 28, para dejar un corte intermedio que no tensiona el informe de aprobación ante Secretaría.",
            "Consignar 28 aciertos como mínimo: el 70% de 40 preguntas es 40 × 0,70 = 28, sin sustituir el 70% por 60%, 65% o 75% ni cambiar el n de ítems del caso.",
            "Registrar 30 aciertos en el PMI de la prueba, tomando el 75% de 40 o la meta Saber de la IE, para que el umbral luzca más exigente en el tablero de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. El 70% de 40 preguntas es 40 × 0,70 = 28 aciertos. Esa es la cifra del acta. 24 es el 60%; 26 el 65% o un punto medio; 30 el 75% o una meta Saber. Las tres cambian el 70% o el producto 40×0,70.",
        "normativeJustification": "El umbral de una prueba institucional se reporta con el porcentaje y el n de ítems acordados. El acta de calidad no puede presentar un 60% histórico, un 65% intermedio o un 75% de meta Saber como si fueran el 70% de 40 preguntas.",
        "theoreticalJustification": "El mínimo de aciertos es n×p. Con n=40 y p=0,70 el producto es 28. 0,60×40=24; ~0,65×40=26; 0,75×40=30. Esas son otras políticas de corte.",
        "distractorAnalysis": {
            "0": "Trampa del corte histórico al 60%: 24 aciertos = 0,60×40. Es un umbral «prudente» de otra prueba, no el 70% del caso.",
            "1": "Trampa del punto medio 26: 65% de 40 o interpolar 24 y 28. Mezcla redondeo de gestión con el 70% exigido.",
            "3": "Trampa de dominio cruzado de la meta Saber: 30 aciertos = 75% de 40. Luce más exigente en el PMI, pero cambia el 70% del caso por otra alícuota.",
        },
    },
    {
        "id": "dir-apt-num-39",
        "options": [
            "Reportar 190 estudiantes como media en el PMI, promediando las tres sedes de 210, 180 y 165 (~185) y redondeando, o restando 40 cupos «no SIMAT» a 800, para un indicador más cauto.",
            "Consignar 195 como promedio, tomando (210+180)/2 de las dos sedes «principales» y dejando 165 y 245 por fuera del denominador, porque esas dos concentran la matrícula visible.",
            "Consignar 200 estudiantes como media exacta: 210+180+165+245 = 800 y 800/4 = 200, sin omitir una sede ni inflar el numerador con provisionales de otra jornada.",
            "Registrar 205 en el SIMAT de calidad, dividiendo 820/4 tras sumar 20 cupos de provisionales u otra jornada, para presentar una matrícula media holgada ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. Las cuatro sedes suman 210+180+165+245 = 800; la media es 800/4 = 200 estudiantes. Esa es la cifra del acta. 190 omite la sede de 245 o resta cupos no SIMAT; 195 promedia solo 210 y 180; 205 usa 820/4 al sumar 20 cupos ajenos. Las tres cambian el conjunto de cuatro sedes.",
        "normativeJustification": "La matrícula media por sede se reporta con las sedes del caso y el SIMAT de esa vigencia. El PMI no puede excluir la sede de 245, promediar solo las dos «principales» ni sumar provisionales de otra jornada como si fueran las cuatro sedes.",
        "theoreticalJustification": "La media aritmética es la suma de los cuatro valores sobre 4. Omitir un dato, usar dos o inflar la suma a 820 produce otro cociente. 800/4 = 200.",
        "distractorAnalysis": {
            "0": "Trampa de omitir una sede: 190 sale de (210+180+165)/3≈185 redondeado, o de 800−40 no SIMAT. Cambia el conjunto de cuatro sedes del caso.",
            "1": "Trampa de las dos sedes «principales»: 195 = (210+180)/2. Es un indicador de las sedes más visibles, no la media de 210, 180, 165 y 245.",
            "3": "Trampa de dominio cruzado de cupos extra: 205 = 820/4 añade ~20 provisionales u otra jornada. Infla el numerador y no es 800/4.",
        },
    },
    {
        "id": "dir-apt-num-40",
        "options": [
            "Asignar 30 minutos por componente en el acta, tomando 150 minutos (como si 3 horas fueran 2 h 30) y dividiendo entre 5, o partiendo 180 entre 6 bloques, para un cronograma «ajustado».",
            "Consignar 33 minutos por componente, dividiendo 165 minutos entre 5 o interpolando 30 y 36, como tiempo intermedio que no tensiona el reloj de la prueba de aptitudes.",
            "Consignar 36 minutos por componente: 3 horas son 180 minutos y hay 5 componentes con igual número de preguntas, de modo que 180/5 = 36, sin cambiar 180 por 150 ni 5 por 6.",
            "Registrar 40 minutos por componente, dividiendo 200 minutos entre 5 o usando 3 h 20 como jornada de la prueba, para dejar holgura visible en el cronograma de calidad.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos, sin redondear ni cambiar la base. La prueba dura 3 horas = 180 minutos y se reparte por igual entre 5 componentes: 180/5 = 36 minutos por componente. Esa es la cifra del acta. 30 minutos usa 150/5 o 180/6; 33 interpola o usa 165/5; 40 usa 200/5. Las tres cambian la duración de 180 minutos o el número de componentes.",
        "normativeJustification": "El tiempo de una prueba de aptitudes se reporta con la duración oficial y con el número de componentes. El acta no puede tratar 3 horas como 150 minutos, añadir un sexto bloque o inflar la jornada a 200 minutos para un cronograma holgado.",
        "theoreticalJustification": "El tiempo por componente es duración total / n de componentes, con la misma unidad. 180/5 = 36. 150/5 = 30; 165/5 = 33; 200/5 = 40. Esas bases no son las 3 horas ni los 5 componentes del caso.",
        "distractorAnalysis": {
            "0": "Trampa de otra duración: 30 minutos sale de 150/5 (3 h leídas como 2 h 30) o de 180/6. Cambia 180 o 5 y no reparte la prueba del caso.",
            "1": "Trampa del tiempo intermedio 33: 165/5 o interpolar 30 y 36. Mezcla redondeo de reloj con 180/5 = 36.",
            "3": "Trampa de la holgura a 40 minutos: 200/5 o 3 h 20. Presenta un cronograma más cómodo; no es 180 minutos entre 5 componentes.",
        },
    },
    {
        "id": "dir-apt-blan-41",
        "options": [
            "Aplicar de inmediato la escala de impuntualidad del manual al reiterado del último mes y archivar la sanción en la carpeta de convivencia, para que la visita de calidad vea aplicación consistente del reglamento.",
            "Indagar con el estudiante y su acudiente las causas de las tardanzas del último mes, dejar registro y, solo entonces, decidir una medida proporcional del manual, en clave de debido proceso y no de sanción automática.",
            "Convocar una jornada de puntualidad para todo el grado, con compromisos masivos en cartelera, y dar por atendido el caso individual sin escuchar al estudiante ni a la familia.",
            "Cargar cada llegada tarde en el SIMAT y en el indicador de puntualidad del PMI, como evidencia comparable ante Secretaría, sin abrir espacio de escucha con el estudiante y su acudiente.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente. El caso muestra a un rector que indaga causas con el estudiante y el acudiente antes de aplicar el manual: eso es debido proceso, no falta de autoridad. El artículo 29 de la Constitución, la Ley 1620 y el manual de convivencia exigen oír, registrar y proporcionalidad antes de la sanción. Aplicar de una vez la escala de impuntualidad luce rigurosa y deja carpeta para la visita, pero convierte el mes de tardanzas en falta automática. La jornada de grado forma en valores y no resuelve el caso ni garantiza defensa. Cargar SIMAT y PMI es trazabilidad de gestión y no sustituye la indagación. La opción correcta nombra el enfoque comprensivo y garantista que el rector ya inició.",
        "normativeJustification": "El debido proceso (art. 29 C.P.), la Ley 1620 y el Decreto 1075 impiden sancionar de plano. El manual se aplica después de oír al estudiante y a la familia, con registro. El PMI y el SIMAT no reemplazan esa garantía.",
        "theoreticalJustification": "Un enfoque restaurativo y garantista busca causas (transporte, cuidado, barrera) antes de la medida. La sanción inmediata, la campaña masiva o el indicador de calidad son respuestas de imagen o de gestión que no agotan el caso individual.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del rigor reglamentario: aplicar la escala y archivar la carpeta es impecable para una visita de convivencia. Omite la indagación del último mes y trata la tardanza reiterada como falta automática, contra el debido proceso que el stem exige.",
            "2": "Trampa de la campaña formativa de grado: la jornada de puntualidad suena pedagógica y visible. Disuelve el caso en una actividad masiva y no oye al estudiante ni al acudiente, que es la conducta defendible del caso.",
            "3": "Trampa de la trazabilidad SIMAT/PMI: cargar impuntualidad es correcto como dato de matrícula y de calidad. No es respuesta ética al conflicto: deja sin voz a la familia y confunde indicador con debido proceso.",
        },
    },
    {
        "id": "dir-apt-blan-42",
        "options": [
            "Expedir una circular que unifique un mismo quiz para el grado, presentada como equidad de formato del SIEE, y archivar ambas metodologías en desuso sin mediar el desacuerdo de las reuniones de área.",
            "Someter a votación del consejo de padres cuál metodología resulta «más rigurosa», para que la comunidad zanje la tensión entre los dos docentes y el acta de área quede legitimada ante la visita.",
            "Facilitar un diálogo estructurado, con el coordinador académico, para acordar criterios comunes de evaluación, responsables y fecha de seguimiento, sin imponer un instrumento ni disolver el conflicto en autonomía de cátedra.",
            "Dejar constancia de las dos prácticas como autonomía de cátedra del Decreto 1290 y cerrar el punto en el SIEE, sin construir criterios compartidos ni intervenir la tensión de las reuniones de área.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente. El desacuerdo frecuente sobre evaluación no se resuelve con un quiz único, con un voto de padres ni con archivar «autonomía de cátedra». El Decreto 1290 y la Guía 34 piden criterios conocidos, coherencia de área y liderazgo pedagógico del rector con el coordinador. El espacio estructurado construye acuerdos, deja rastro y cuida el clima laboral. La circular de un instrumento único parece equidad y es homogeneización. El consejo de padres no es instancia de diseño evaluativo. El 1290 reconoce autonomía institucional, no dos sistemas paralelos que tensionan el grado.",
        "normativeJustification": "El SIEE (Decreto 1290) se construye con participación y criterios comunes; el Consejo Académico y la coordinación orientan la evaluación. El consejo de padres acompaña, no vota la metodología de área. La autonomía de cátedra no autoriza incoherencia evaluativa en el mismo grado.",
        "theoreticalJustification": "La mediación estructurada trata el conflicto de fondo (criterios) sin imponer ni omitir. Un instrumento único, un voto comunitario o el archivo en el SIEE son salidas de imagen, de equidad formal o de legalismo que no producen criterios compartidos.",
        "distractorAnalysis": {
            "0": "Trampa de la equidad de formato: unificar un quiz por circular parece SIEE comparable y cierra la tensión. Homogeneiza sin diálogo y no construye los criterios comunes que el área necesita.",
            "1": "Trampa de dominio cruzado de la legitimidad comunitaria: que los padres voten «rigor» suena participativo. Desplaza al Consejo Académico y a la coordinación, y convierte un conflicto profesional en plebiscito de imagen.",
            "3": "Trampa del 1290 mal leído: archivar dos prácticas como autonomía de cátedra es impecable en el papel del SIEE. Evita la mediación y deja intacta la tensión de las reuniones de área.",
        },
    },
]


def main():
    OUT.write_text(json.dumps(ITEMS, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print("wrote", OUT.name, "n=", len(ITEMS))
    for it in ITEMS:
        lengths = [len(o) for o in it["options"]]
        print(it["id"], "opt", lengths, "expl", len(it["explanation"]))


if __name__ == "__main__":
    main()
