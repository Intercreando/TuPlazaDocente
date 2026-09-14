# -*- coding: utf-8 -*-
"""Reescribe dir-apt-lec-313..320 y dir-apt-num-321..322 (posiciones 1061-1070)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1061_1070.json"
CI = {
    "dir-apt-lec-313": 0,
    "dir-apt-lec-314": 1,
    "dir-apt-lec-315": 2,
    "dir-apt-lec-316": 3,
    "dir-apt-lec-317": 0,
    "dir-apt-lec-318": 1,
    "dir-apt-lec-319": 2,
    "dir-apt-lec-320": 3,
    "dir-apt-num-321": 0,
    "dir-apt-num-322": 1,
}
NEEDLE = {
    "dir-apt-num-321": "3 km",
    "dir-apt-num-322": "11.5",
}

ITEMS = [
    {
        "id": "dir-apt-lec-313",
        "options": [
            "El cambio climático tiene efectos sobre la geografía humana —asentamientos, agricultura y desplazamientos— que deben analizarse también desde las ciencias sociales, junto a las causas físicas.",
            "El cambio climático es un fenómeno atmosférico ajeno a las ciencias sociales, de modo que asentamientos, agricultura y desplazamientos no entrarían en el análisis de las dinámicas territoriales.",
            "El cambio climático debe estudiarse desde una perspectiva estrictamente atmosférica, dejando fuera las dinámicas sociales, económicas y territoriales de las comunidades afectadas.",
            "Los patrones de asentamiento no se ven afectados por el cambio climático, y el PRAE o el indicador ambiental del PMI bastan para reportar calidad sin leer efectos sobre la geografía humana.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que el cambio climático no se agota como fenómeno atmosférico, porque sus efectos sobre asentamientos, agricultura y desplazamientos deben analizarse también desde las ciencias sociales. Tratarlo como ajeno a esas ciencias invierte esa tesis. Reducirlo a una perspectiva estrictamente atmosférica niega las dinámicas sociales, económicas y territoriales. Reportarlo como indicador del PRAE o del PMI importa un tablero de calidad que el texto no usa como idea central.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre cambio climático y geografía humana. Lo afirmado es el análisis también desde las ciencias sociales, no el recorte atmosférico ni el indicador ambiental del PMI.",
        "theoreticalJustification": "La idea principal articula causas físicas y efectos territoriales sobre la población. Una inversión disciplinar, un recorte atmosférico y un tablero del PRAE son lecturas ilegítimas del pasaje.",
        "distractorAnalysis": {
            "1": "Trampa de declarar el fenómeno ajeno a las ciencias sociales: parece separar clima y sociedad. El texto afirma lo contrario: hay que analizar también los efectos sobre las dinámicas sociales, económicas y territoriales.",
            "2": "Trampa del recorte atmosférico: estudiar el clima como atmósfera pura parece rigor de ciencias naturales. El pasaje niega ese encierro y pide leer asentamientos, agricultura y desplazamientos.",
            "3": "Trampa de dominio cruzado del PRAE y el PMI: negar efectos sobre asentamientos y reportar el indicador ambiental parece gestión escolar sólida. El texto centra la geografía humana, no el tablero de calidad.",
        },
    },
    {
        "id": "dir-apt-lec-314",
        "options": [
            "Ninguna consecuencia relevante sobre los patrones de asentamiento, de modo que la geografía humana permanecería estable frente al aumento del mar y a la alteración de la lluvia.",
            "Alteraciones en los patrones de asentamiento, en las actividades agrícolas y, en algunos casos, desplazamientos de población, como consecuencias sobre la geografía humana que el texto enumera.",
            "Un aumento generalizado y uniforme de la población en todas las regiones, como si el cambio climático homogeneizara el crecimiento demográfico territorial descrito.",
            "La eliminación de las actividades agrícolas como meta del PRAE o del indicador productivo del PMI, de modo que el tablero de calidad sustituya las consecuencias que el texto enumera.",
        ],
        "explanation": "La condición de calidad pregunta qué tipo de consecuencias puede generar el cambio climático sobre la población. El texto enumera alteraciones en asentamientos, actividades agrícolas y, en algunos casos, desplazamientos. Negar consecuencias sobre el asentamiento invierte esa enumeración. El aumento uniforme de población no aparece. Convertir la agricultura en meta del PRAE o del PMI importa un indicador de gestión que el stem no pide.",
        "normativeJustification": "El ítem pide las consecuencias que el pasaje enumera sobre la geografía humana. No autoriza la negación del asentamiento, un crecimiento demográfico uniforme ni el tablero productivo del PRAE.",
        "theoreticalJustification": "Las consecuencias se leen en la enumeración explícita del fragmento. Una inversión, una homogeneización demográfica y un indicador ambiental-productivo cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de negar el asentamiento: afirmar que no hay consecuencias relevantes parece preservar la geografía humana. El texto cita alteraciones de asentamientos, agricultura y, en algunos casos, desplazamientos.",
            "2": "Trampa del aumento uniforme: homogeneizar la población en todas las regiones parece una consecuencia demográfica ordenada. El pasaje no describe un crecimiento generalizado; describe alteraciones y desplazamientos puntuales.",
            "3": "Trampa de dominio cruzado del PRAE y el PMI: eliminar la agricultura como meta de calidad parece un indicador ambiental-productivo. El texto no pide un tablero escolar; enumera consecuencias sobre la población.",
        },
    },
    {
        "id": "dir-apt-lec-315",
        "options": [
            "La Constitución de 1991 no introdujo cambios relevantes respecto de la de 1886, de modo que el catálogo de derechos y las instituciones habrían permanecido en lo esencial iguales.",
            "La acción de tutela quedó eliminada por la Constitución de 1991, de modo que la protección ágil de derechos fundamentales no formaría parte de esa transformación constitucional.",
            "La Constitución de 1991 amplió los derechos fundamentales, creó la tutela y la Corte Constitucional, y principios como el Estado Social de Derecho siguen vigentes en el debate actual.",
            "La Corte Constitucional fue creada antes de 1991, dato de historia institucional que el texto no sostiene, o se reporta como indicador de calidad jurídica del gobierno escolar.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje describe la transformación de 1991 frente a 1886: ampliación de derechos fundamentales, tutela, Corte Constitucional y vigencia del Estado Social de Derecho en el debate actual. Negar cambios respecto de 1886 invierte esa tesis. Afirmar que la tutela fue eliminada contradice el mecanismo que el texto cita. Situar la Corte antes de 1991 o en el gobierno escolar importa un dato extra-textual de gestión.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre la Constitución de 1991. Lo afirmado es la ampliación de derechos, la tutela, la Corte y el Estado Social de Derecho, no la continuidad de 1886 ni un indicador de gobierno escolar.",
        "theoreticalJustification": "La idea principal sintetiza cambios institucionales y su vigencia en el debate. Una inversión frente a 1886, borrar la tutela o adelantar la Corte cambian el objeto del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de la continuidad con 1886: afirmar que 1991 no cambió el catálogo parece prudencia histórica. El texto habla de una transformación importante: derechos, tutela y Corte Constitucional.",
            "1": "Trampa de eliminar la tutela: borrar el mecanismo ágil parece un giro institucional. El pasaje lo cita como creación de 1991 para proteger derechos fundamentales de manera ágil.",
            "3": "Trampa de dominio cruzado de la historia institucional y el gobierno escolar: situar la Corte antes de 1991 o como indicador jurídico de calidad parece saber cívico. El texto la establece como institución nueva de 1991.",
        },
    },
    {
        "id": "dir-apt-lec-316",
        "options": [
            "El referendo, como mecanismo de participación ciudadana de 1991, se tomaría como la vía ágil para proteger derechos fundamentales, confundiendo la consulta al pueblo con la tutela que el texto nombra.",
            "La consulta popular, prevista como mecanismo de participación, se leería como el instrumento ágil de protección de derechos fundamentales que el pasaje atribuye a la acción de tutela.",
            "El plebiscito, como pronunciamiento popular sobre una decisión política, se tomaría como el mecanismo ágil creado en 1991 para amparar derechos fundamentales de manera expedita.",
            "La acción de tutela, creada por la Constitución de 1991 para proteger de manera ágil los derechos fundamentales, junto con el catálogo ampliado y la Corte Constitucional que el texto menciona.",
        ],
        "explanation": "La condición de calidad pregunta qué mecanismo se creó en 1991 para proteger de manera ágil los derechos fundamentales. El texto nombra de forma explícita la acción de tutela. El referendo, la consulta popular y el plebiscito son mecanismos reales de participación, pero el pasaje no los presenta como esa vía ágil de amparo. Confundirlos con la tutela es una mallectura de participación versus protección judicial.",
        "normativeJustification": "El ítem pide el mecanismo ágil que el fragmento asocia a la protección de derechos fundamentales: la acción de tutela. No autoriza a sustituirla por referendo, consulta popular o plebiscito.",
        "theoreticalJustification": "Participación ciudadana y amparo de derechos son instituciones distintas. El texto cita la tutela como vía ágil; los mecanismos de votación popular responden a otro objeto constitucional.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la participación ciudadana: el referendo es un mecanismo real de 1991 y parece la vía «ágil» del pueblo. El stem pide protección de derechos fundamentales; el texto nombra la tutela, no la consulta al electorado.",
            "1": "Trampa de la consulta popular: tomarla como instrumento ágil de derechos parece coherente con el catálogo participativo de 1991. El pasaje no la menciona; atribuye esa agilidad a la acción de tutela.",
            "2": "Trampa del plebiscito: leer el pronunciamiento popular como amparo expedito confunde decisión política y protección judicial. El texto crea la tutela para proteger derechos fundamentales de manera ágil.",
        },
    },
    {
        "id": "dir-apt-lec-317",
        "options": [
            "El crecimiento acelerado de las ciudades latinoamericanas, sin una planeación urbana adecuada, generó desigualdades territoriales que persisten hasta hoy en varias ciudades de la región.",
            "El crecimiento de las ciudades latinoamericanas estuvo acompañado de una planeación urbana suficiente y proporcional a la migración rural, de modo que la periferia habría quedado ordenada.",
            "La migración desde zonas rurales no tuvo influencia en el crecimiento de las ciudades latinoamericanas, de modo que la expansión periférica se explicaría por otras causas ajenas al texto.",
            "Los asentamientos informales desaparecieron con programas de calidad urbana del PMI, de modo que el tablero de gestión acreditaría equidad territorial ya resuelta en la región.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje vincula el crecimiento urbano acelerado, impulsado por la migración rural y sin planeación adecuada, con desigualdades territoriales que persisten. Afirmar que hubo planeación suficiente invierte esa tesis. Negar la influencia de la migración contradice el impulso que el texto describe. Dar por desaparecidos los asentamientos informales vía PMI importa un tablero de calidad que el fragmento no sostiene.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre ciudades latinoamericanas. Lo afirmado es la persistencia de desigualdades por falta de planeación, no una planeación suficiente ni un indicador urbano del PMI.",
        "theoreticalJustification": "La idea principal articula migración, planeación deficiente y desigualdad persistente. Invertir la planeación, borrar la migración o importar el PMI desplazan el objeto del pasaje.",
        "distractorAnalysis": {
            "1": "Trampa de la planeación suficiente: afirmar que el crecimiento urbano fue ordenado y proporcional a la migración parece un relato de gestión. El texto dice que no estuvo acompañado de una planeación urbana adecuada.",
            "2": "Trampa de negar la migración rural: explicar la ciudad sin ese impulso parece otra causalidad urbana. El pasaje sitúa la migración desde zonas rurales como motor del crecimiento acelerado.",
            "3": "Trampa de dominio cruzado del PMI urbano: dar por desaparecidos los asentamientos informales con programas de calidad parece gestión territorial exitosa. El texto afirma que la desigualdad persiste en varias ciudades de la región.",
        },
    },
    {
        "id": "dir-apt-lec-318",
        "options": [
            "Un acceso amplio y garantizado a servicios públicos, transporte y equipamientos educativos, como si la periferia informal hubiera nacido con la cobertura plena de la ciudad planificada.",
            "Un acceso limitado a servicios públicos, transporte y equipamientos educativos, característico de muchos asentamientos informales surgidos en las periferias urbanas según el texto.",
            "Una planeación urbana ejemplar desde su origen, de modo que los asentamientos de la periferia habrían surgido con trazado, servicios y equipamientos ya resueltos.",
            "La ausencia de población migrante en la periferia, como si el SIMAT de matrícula rural-urbana negara el origen migratorio que el texto asocia a esos asentamientos informales.",
        ],
        "explanation": "La condición de calidad pregunta qué caracterizó a muchos de los asentamientos informales de las periferias urbanas. El texto señala acceso limitado a servicios públicos, transporte y equipamientos educativos. Afirmar un acceso amplio invierte esa caracterización. Atribuirles planeación ejemplar contradice el déficit de planeación del pasaje. Negar población migrante vía SIMAT importa un cupo de matrícula que el stem no pide.",
        "normativeJustification": "El ítem pide la caracterización que el fragmento asigna a los asentamientos informales: acceso limitado a servicios, transporte y escuela. No autoriza cobertura plena, planeación ejemplar ni un recuento SIMAT sin migrantes.",
        "theoreticalJustification": "La característica se lee en la cláusula de acceso limitado. Una inversión de cobertura, una planeación ejemplar y un cupo de matrícula cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa del acceso amplio: atribuir cobertura plena de servicios, transporte y escuela parece un asentamiento ya urbanizado. El texto describe acceso limitado en las periferias informales.",
            "2": "Trampa de la planeación ejemplar: situar un trazado resuelto desde el origen parece orden urbano. El pasaje asocia esos asentamientos a la falta de planeación adecuada durante el crecimiento acelerado.",
            "3": "Trampa de dominio cruzado del SIMAT: negar población migrante en la periferia parece un recuento limpio de matrícula. El texto vincula esos asentamientos a la migración rural-urbana, no a la ausencia de migrantes.",
        },
    },
    {
        "id": "dir-apt-lec-319",
        "options": [
            "Los derechos humanos han tenido el mismo catálogo desde el inicio del proceso histórico, sin ampliación de civiles y políticos hacia los económicos, sociales, culturales y colectivos.",
            "Los derechos económicos, sociales y culturales fueron los primeros en reconocerse históricamente, de modo que civiles y políticos vendrían después en la evolución descrita.",
            "La noción de derechos humanos ha evolucionado históricamente, ampliándose de los civiles y políticos a los económicos, sociales y culturales, y más recientemente a los colectivos.",
            "El derecho a un ambiente sano fue el primer derecho humano reconocido, y el PRAE lo reportaría como indicador fundacional de dignidad, invirtiendo el orden que el texto describe.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje describe una ampliación progresiva: civiles y políticos, luego económicos, sociales y culturales, y más recientemente colectivos como el ambiente sano. Afirmar un catálogo fijo desde el inicio niega esa evolución. Situar los DESC como los primeros invierte el orden. Tomar el ambiente sano como primer derecho y reportarlo en el PRAE importa un indicador ambiental extra-textual.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre la evolución de los derechos humanos. Lo afirmado es la ampliación por generaciones, no un catálogo inmóvil ni el PRAE como origen del ambiente sano.",
        "theoreticalJustification": "La idea principal es la ampliación histórica de la dignidad. Un catálogo fijo, invertir DESC y civiles, o fundar todo en el PRAE, desplazan el objeto del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa del catálogo fijo: afirmar el mismo alcance desde el inicio parece continuidad jurídica. El texto habla de un proceso histórico de ampliación progresiva de distintas categorías de derechos.",
            "1": "Trampa de invertir el orden: situar educación y salud como los primeros derechos parece priorizar lo social. El pasaje coloca primero los civiles y políticos, y los DESC en un segundo momento.",
            "3": "Trampa de dominio cruzado del PRAE: tratar el ambiente sano como el primer derecho y como indicador de dignidad parece gestión ambiental escolar. El texto lo sitúa como reconocimiento más reciente, no como origen.",
        },
    },
    {
        "id": "dir-apt-lec-320",
        "options": [
            "Los derechos civiles y políticos, como la libertad de expresión o el voto, se tomarían como el reconocimiento más reciente, invirtiendo el orden histórico que el texto describe.",
            "Homologar el catálogo más reciente con una vía de comprensión del DBA o del PEI, como si una representación evaluativa del curso reemplazara a los derechos colectivos del pasaje.",
            "Los derechos económicos y sociales, como educación o salud, se tomarían como el reconocimiento más reciente, cuando el texto los sitúa en un segundo momento y no en el último.",
            "Derechos colectivos, como el derecho a un ambiente sano, descritos como el reconocimiento más reciente en esta evolución histórica de la dignidad humana que el texto sitúa al cierre.",
        ],
        "explanation": "La condición de calidad pregunta qué tipo de derechos se reconocieron más recientemente según lo descrito. El texto sitúa al final los derechos colectivos, ilustrados con el ambiente sano. Tomar civiles y políticos como lo más reciente invierte el orden. Homologar esa respuesta con una vía del DBA o del PEI importa una representación evaluativa ajena al pasaje. Tomar los DESC como lo más reciente los confunde con el segundo momento, no con el último.",
        "normativeJustification": "El ítem pide la categoría más reciente que el fragmento nombra: derechos colectivos como el ambiente sano. No autoriza civiles y políticos, DESC como cierre ni una vía de comprensión del DBA.",
        "theoreticalJustification": "Lo más reciente se lee en la última etapa de la enumeración. Invertir el origen, importar el PEI o detenerse en los DESC cambia el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de invertir el origen: tomar expresión y voto como lo más reciente parece actualizar el catálogo civil. El texto los sitúa al inicio, no al cierre de la evolución.",
            "1": "Trampa de dominio cruzado del DBA y el PEI: una vía de comprensión evaluativa parece rigor de malla. El stem pide la categoría de derechos más reciente del pasaje, no una representación de aula.",
            "2": "Trampa del segundo momento: educación y salud parecen el horizonte actual de dignidad. El texto los coloca después de los civiles y políticos, y reserva lo más reciente a los colectivos.",
        },
    },
    {
        "id": "dir-apt-num-321",
        "options": [
            "Consignar 3 km en el acta institucional: 6 cm × 50.000 = 300.000 cm = 3 km, cifra del comité de calidad, sin redondear ni cambiar la escala 1:50.000 que pide Secretaría.",
            "Reportar 2.5 km en el PMI, tomando 5 cm × 50.000 (omite 1 cm del mapa) o una conversión recortada, como propone el docente, porque deja una distancia «cauta» comparable con el histórico.",
            "Consignar 3.5 km en el acta de calidad, usando 7 cm × 50.000 o una escala inflada, como insiste el segundo docente, para no tensionar el informe de distancia ante Secretaría.",
            "Registrar 4 km en el tablero SIMAT, tomando 8 cm × 50.000 o un aforo de calidad institucional, para que el tramo entre ciudades luzca alineado con la meta de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. En el mapa a escala 1:50000, 6 cm equivalen a 6 × 50000 = 300000 cm, es decir 3 km. Esa es la cifra del acta del PMI. Reportar 2,5 km usa 5 cm o un recorte; 3,5 km infla a 7 cm; 4 km toma un aforo del SIMAT. Ninguna conserva 6 cm y la escala 1:50000.",
        "normativeJustification": "La distancia del informe se reporta con la medida real del mapa y la escala 1:50000. El PMI no puede omitir 1 cm, inflar a 7 cm ni usar 4 km de aforo SIMAT como si fueran 6 × 50000.",
        "theoreticalJustification": "Distancia real = medida × escala. 6 × 50000 = 300000 cm = 3 km. 5 × 50000 = 2,5 km; 7 × 50000 = 3,5 km; 8 × 50000 = 4 km cambian la medida.",
        "distractorAnalysis": {
            "1": "Trampa de omitir 1 cm: 2.5 km = 5 cm × 50.000, como propone el docente. Recorta la distancia del mapa. No es 6 × 50000 = 300000 cm ni 3 km.",
            "2": "Trampa de inflar a 7 cm: 3.5 km = 7 cm × 50.000, como insiste el segundo docente. Conserva la escala pero cambia los 6 cm del caso. No es la cifra del acta.",
            "3": "Trampa de dominio cruzado del cupo SIMAT: 4 km = 8 cm × 50.000 o aforo de calidad. Es un tramo plausible de meta institucional. Sustituye 6 cm por un indicador de cupo, no por la escala del caso.",
        },
    },
    {
        "id": "dir-apt-num-322",
        "options": [
            "Reportar 10.5 millones rurales en el PMI, tomando 48 × 0,22 o una base de 42 × 0,25, como propone el docente, porque deja un cupo rural «cauto» comparable con el histórico de hábitat.",
            "Consignar 11.5 millones rurales en el acta institucional: 48 × 0,24 = 11,52 (o 48 − 36,48), cifra del comité de calidad, sin redondear ni cambiar la base de 48 millones que pide Secretaría.",
            "Consignar 12.5 millones en el acta de calidad, usando 50 × 0,25 o 48 × 0,26, como insiste el segundo docente, para no tensionar el informe de población rural ante Secretaría.",
            "Registrar 13.5 millones en el tablero SIMAT, aplicando 54 × 0,25 o un techo de cupo, para que el indicador rural luzca alineado con la meta de calidad de Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base. El 24 por ciento rural de 48 millones es 48 × 0,24 = 11,52, consignado como 11,5 millones, equivalente a 48 − 36,48. Esa es la cifra del acta institucional. Reportar 10,5 recorta la alícuota rural; 12,5 la infla; 13,5 toma un cupo del SIMAT. Ninguna conserva 48 millones y el 24 por ciento pedido.",
        "normativeJustification": "El informe de PMI y SIMAT debe conservar los 48 millones y el complemento rural del 76 por ciento urbano. No recorta a 0,22, no infla a 0,26 ni usa 54 cupos como si fueran 48 × 0,24.",
        "theoreticalJustification": "Rural = n × 0,24. Con n=48, el producto es 11,52 (11,5 millones). 48 × 0,22 = 10,56; 50 × 0,25 = 12,5; 54 × 0,25 = 13,5 cambian la base o la alícuota.",
        "distractorAnalysis": {
            "0": "Trampa de recortar la alícuota rural: 10.5 = 48 × 0,22 o 42 × 0,25, como propone el docente. Baja el 24 por ciento o la base de 48. No es 48 × 0,24 = 11,52 ni 11,5 millones.",
            "2": "Trampa de inflar a 12.5: 50 × 0,25 o 48 × 0,26, como insiste el segundo docente. Cambia la población o el porcentaje rural. No conserva 48 − 36,48.",
            "3": "Trampa de dominio cruzado del cupo SIMAT: 13.5 = 54 × 0,25. Infla la base a 54 para el tablero de calidad. Sustituye 48 × 0,24 por un indicador de cupo, no por la población del caso.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI, NEEDLE))
