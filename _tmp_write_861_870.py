# -*- coding: utf-8 -*-
"""Reescribe dir-apt-lec-113..120 y dir-apt-num-121..122 (posiciones 861-870) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_861_870.json"

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
TEMPLATE = (
    "aplaazar la decisión con un acta genérica",
    "imponer una salida visible",
    "delegar el conflicto a familias o chats",
    "adelantar contenidos de grados superiores",
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
    "dir-apt-lec-113": 0,
    "dir-apt-lec-114": 1,
    "dir-apt-lec-115": 2,
    "dir-apt-lec-116": 3,
    "dir-apt-lec-117": 0,
    "dir-apt-lec-118": 1,
    "dir-apt-lec-119": 2,
    "dir-apt-lec-120": 3,
    "dir-apt-num-121": 0,
    "dir-apt-num-122": 1,
}
NUM_IDS = {"dir-apt-num-121", "dir-apt-num-122"}

ITEMS = [
    {
        "id": "dir-apt-lec-113",
        "options": [
            "En el texto se describen posiciones diversas: algunos rectores prohíben el celular durante toda la jornada y otros permiten un uso pedagógico controlado en momentos específicos de clase, para formar un uso responsable de la tecnología.",
            "La Ley 1620 de 2013 obliga a permitir el uso libre del celular como derecho de los estudiantes, de modo que el Comité Escolar de Convivencia no puede restringirlo en la jornada ni consignar límites en el manual de convivencia.",
            "La posición institucional viable es la prohibición estricta durante toda la jornada, porque permitir el uso pedagógico controlado en clase diluiría la autoridad de rectoría y no formaría un uso responsable de los dispositivos.",
            "La regulación de los dispositivos móviles queda fuera del alcance de la institución educativa y, por tanto, no puede consignarse en el manual de convivencia ni discutirse con la comunidad educativa del establecimiento.",
        ],
        "explanation": "La condición de calidad pide qué posiciones existen, según el texto, frente al uso de celulares en el aula. El pasaje describe posiciones diversas: prohibición estricta durante toda la jornada frente a un uso pedagógico controlado en momentos específicos de clase. Esa dualidad es la idea central, no un mandato de uso libre ni la imposibilidad de regular. La Ley 1620 no aparece como obligación de permitir el celular; el texto pide consignar la normativa en el manual. La opción correcta parafrasea ambas posturas institucionales sin invertirlas ni importar un saber externo.",
        "normativeJustification": "El texto contrapone prohibición estricta y uso pedagógico controlado, y sitúa la regla en el manual de convivencia. La Ley 1620 no impone uso libre del celular ni saca el tema del alcance de la IE.",
        "theoreticalJustification": "Leer la idea central es reconocer la diversidad de posturas. Absolutizar la veda, declarar incompetencia institucional o importar un derecho de convivencia que el pasaje no enuncia desplaza el objeto de la pregunta.",
        "distractorAnalysis": {
            "1": "Trampa de dominio cruzado de la Ley 1620: tratar el uso libre del celular como derecho de convivencia es un saber normativo externo plausible. El texto no impone ese deber; pide consignar la normativa institucional en el manual tras discusión comunitaria.",
            "2": "Trampa de la prohibición estricta como vía única: reducir las posiciones a vedar el celular durante toda la jornada niega la diversidad que el texto describe y descarta el uso pedagógico controlado en clase.",
            "3": "Trampa de sacar el tema del manual: afirmar que la IE no puede regular dispositivos invierte el cierre del texto, que exige consignar la normativa en el manual de convivencia tras discutirla con la comunidad.",
        },
    },
    {
        "id": "dir-apt-lec-114",
        "options": [
            "La normativa sobre el uso de celulares debe incorporarse al Proyecto Educativo Institucional como documento marco de la IE, de modo que el PEI recoja esta regla y reemplace al manual de convivencia en el asunto.",
            "La normativa institucional sobre este tema debe quedar consignada en el manual de convivencia, tras un proceso de discusión con la comunidad educativa, tal como lo señala de manera expresa el texto.",
            "La normativa debe expedirse en una circular del Ministerio de Educación Nacional que unifique el uso de celulares en todas las instituciones, sin que cada establecimiento la consigne en un documento propio.",
            "La normativa debe consignarse en acta del Consejo Académico como orientación curricular sobre el uso pedagógico de dispositivos, sin pasar por el manual de convivencia ni por la discusión con la comunidad que indica el texto.",
        ],
        "explanation": "La condición de calidad pregunta dónde debe quedar consignada la normativa institucional sobre este tema, según el texto. El pasaje indica el manual de convivencia, tras discusión con la comunidad educativa. El PEI es el marco identitario, pero no es el instrumento que el texto nombra para esta regla. Una circular del MEN centralizaría lo que el texto deja en la IE. El acta del Consejo Académico es orientación curricular plausible, pero el texto no desplaza el asunto al Decreto 1860 ni saca la norma del manual.",
        "normativeJustification": "El texto fija el instrumento: manual de convivencia después de discusión comunitaria. Ni el PEI, ni una circular del MEN, ni el acta del Consejo Académico sustituyen esa consignación.",
        "theoreticalJustification": "Consignar una regla de convivencia exige el documento que el pasaje nombra. Confundir PEI, circular ministerial y orientación curricular cambia el instrumento y no responde a la condición de calidad.",
        "distractorAnalysis": {
            "0": "Trampa del PEI como documento marco: incorporar la regla de celulares al Proyecto Educativo parece coherencia institucional. El texto nombra el manual de convivencia, no el PEI, como instrumento de consignación tras la discusión comunitaria.",
            "2": "Trampa de la circular ministerial: una circular del MEN unificaría el uso de celulares y suena a orden nacional. El texto deja la normativa en la IE y en el manual, no en un acto centralizado del Ministerio.",
            "3": "Trampa de dominio cruzado del Decreto 1860: el Consejo Académico sí orienta el currículo y puede actar el uso pedagógico de dispositivos. Ese saber es correcto en gestión curricular; el texto pide el manual de convivencia, no el acta académica.",
        },
    },
    {
        "id": "dir-apt-lec-115",
        "options": [
            "El acoso escolar se caracteriza, frente al conflicto puntual, por un incidente aislado entre estudiantes, que se atiende con una mediación puntual de aula, sin reiteración, desequilibrio de poder ni intención sostenida de daño.",
            "El rasgo específico del acoso es que involucra estudiantes del mismo grado; las agresiones entre distintos grados no configurarían acoso escolar en los términos del texto y se tramitarían como conflicto puntual.",
            "El acoso escolar se distingue del conflicto puntual por la repetición sistemática de la agresión, el desequilibrio de poder entre quien agrede y quien es agredido, y la intención de causar daño de manera sostenida en el tiempo.",
            "La Guía MEN 49 descarta el acoso cuando no hay agresión física, de modo que el episodio psicológico o sistemático sin golpe se tramita como conflicto puntual de mediación y no activa la ruta de acoso.",
        ],
        "explanation": "La condición de calidad pide qué caracteriza específicamente al acoso escolar frente a un conflicto puntual, según el texto. El pasaje enumera repetición sistemática, desequilibrio de poder e intención sostenida de daño. Un incidente aislado describe el conflicto puntual, no el acoso. Involucrar al mismo grado no está en el texto. La Guía 49 no exige agresión física para configurar acoso; importar ese filtro es un saber externo que el pasaje no sostiene.",
        "normativeJustification": "El texto define acoso por reiteración, desequilibrio e intención sostenida, y reserva el incidente aislado al conflicto puntual. Ni el mismo grado ni la agresión física son requisitos del pasaje.",
        "theoreticalJustification": "Distinguir acoso de conflicto es un juicio de reiteración y de poder, no de curso ni de golpe. Confundir mediación puntual con acoso o exigir lesión física cambia el objeto de la ruta.",
        "distractorAnalysis": {
            "0": "Trampa del incidente aislado: describir un episodio con mediación puntual parece el conflicto escolar cotidiano. El texto reserva esa figura al conflicto puntual y exige reiteración, desequilibrio e intención sostenida para el acoso.",
            "1": "Trampa del mismo grado: limitar el acoso a pares de un mismo curso parece un criterio de aula ordenado. El texto no menciona el grado; el rasgo específico son repetición, poder e intención, no la homogeneidad del grupo.",
            "3": "Trampa de dominio cruzado de la Guía 49: exigir agresión física para tipificar acoso parece rigor de la ruta de convivencia. El texto no condiciona el acoso al golpe; puede ser psicológico y sistemático, y aun así activa la ruta 1620.",
        },
    },
    {
        "id": "dir-apt-lec-116",
        "options": [
            "Identificar la diferencia sirve para no activar ninguna ruta de atención institucional, de modo que el episodio quede en una mediación informal de aula y no ingrese al Comité Escolar de Convivencia ni a la Ley 1620.",
            "La identificación correcta permite aplicar de inmediato una medida punitiva a ambos estudiantes involucrados, sin distinguir acoso de conflicto puntual ni graduar la ruta de atención de la Ley 1620.",
            "La diferencia se identifica para trasladar la responsabilidad a la familia, en clave de corresponsabilidad de la Ley 1620, y cerrar la ruta escolar, de modo que el restablecimiento quede en el hogar y no en la IE.",
            "Identificar la diferencia es clave para que la institución active la ruta de atención adecuada según la Ley 1620 de 2013, y no trate el acoso como un conflicto aislado que se resuelve con una mediación puntual.",
        ],
        "explanation": "La condición de calidad pregunta por qué es importante, según el texto, identificar correctamente la diferencia entre acoso y conflicto puntual. El pasaje lo dice: para activar la ruta de atención adecuada de la Ley 1620, y no tratar el acoso como un conflicto aislado de mediación puntual. No activar ruta invierte el propósito. La medida punitiva automática a ambos ignora la proporcionalidad del texto. Trasladar el caso a la familia cierra la ruta escolar con un argumento de corresponsabilidad que el pasaje no usa.",
        "normativeJustification": "El texto vincula la distinción acoso-conflicto con la activación de la ruta de la Ley 1620, no con omitir atención, sancionar en simetría ni cerrar el caso en la familia.",
        "theoreticalJustification": "Identificar el tipo de situación orienta la ruta, no la elude. La mediación puntual, el castigo simétrico o la corresponsabilidad familiar miden otros objetos distintos al que pide el stem.",
        "distractorAnalysis": {
            "0": "Trampa de no activar ruta: dejar el episodio en mediación informal parece descongestionar el Comité. El texto sostiene lo contrario: identificar la diferencia sirve para activar la ruta adecuada de la Ley 1620, no para omitirla.",
            "1": "Trampa de la sanción simétrica: aplicar una medida punitiva a ambos parece equidad disciplinaria. El texto no pide castigo automático; pide la ruta proporcional, distinta para acoso y para conflicto puntual.",
            "2": "Trampa de dominio cruzado de la corresponsabilidad familiar: trasladar el caso al hogar con la Ley 1620 parece alinear familia y escuela. El texto no cierra la ruta escolar; pide activarla en la IE en lugar de una mediación puntual.",
        },
    },
    {
        "id": "dir-apt-lec-117",
        "options": [
            "Los modelos educativos flexibles mencionados, como la Aceleración del Aprendizaje y los programas para población en extraedad, están dirigidos a estudiantes que presentan un rezago escolar significativo respecto a su edad, según el texto.",
            "Estos modelos están pensados para estudiantes de mejor desempeño académico, a fin de que adelanten varios grados en menos tiempo como reconocimiento a su rendimiento, y no para quienes presentan rezago o extraedad.",
            "El texto sitúa los modelos flexibles en instituciones educativas privadas, como oferta de aceleración para esa matrícula, y no como estrategia avalada por el Ministerio para población con extraedad en el sector oficial.",
            "La población destinataria es la de docentes en formación continua o en plan de mejoramiento profesional del Decreto 1278, de modo que la aceleración cubra la cualificación de la planta y no la extraedad estudiantil.",
        ],
        "explanation": "La condición de calidad pregunta a qué población están dirigidos los modelos educativos flexibles mencionados en el texto. La primera oración los sitúa en estudiantes con rezago escolar significativo respecto a su edad, con Aceleración y extraedad. No están pensados para el mejor desempeño ni para la matrícula privada. El Decreto 1278 regula carrera docente, no la población de estos modelos. La opción correcta parafrasea el destinatario sin ampliarlo a otro sujeto de la gestión escolar.",
        "normativeJustification": "El texto dirige Aceleración y extraedad a estudiantes con rezago significativo respecto a su edad. No restringe el destinatario al mejor desempeño, a IE privadas ni a docentes del 1278.",
        "theoreticalJustification": "Un modelo flexible se define por el sujeto que atiende. Cambiar rezago por mérito, por sector privado o por planta docente produce otra población y no responde al stem.",
        "distractorAnalysis": {
            "1": "Trampa del talento académico: destinar la aceleración a quienes mejor desempeñan parece reconocimiento al mérito. El texto dirige los modelos flexibles al rezago y a la extraedad, no a adelantar a los de mejor desempeño.",
            "2": "Trampa de la matrícula privada: situar estos modelos en IE privadas parece una oferta de prestigio. El texto los presenta como estrategia avalada por el MEN para rezago y extraedad, sin restringirlos al sector privado.",
            "3": "Trampa de dominio cruzado del Decreto 1278: la formación continua y el plan de mejoramiento profesional sí aplican a docentes. Ese destinatario es correcto en carrera; el texto habla de estudiantes con rezago, no de la planta.",
        },
    },
    {
        "id": "dir-apt-lec-118",
        "options": [
            "En estos modelos debe suprimirse la evaluación de aprendizajes, para que la reducción del tiempo escolar no se vea frenada por evidencias de desempeño ni por verificación de competencias al cierre de los grados compactados.",
            "Debe garantizarse el logro de las competencias básicas esperadas, y no una promoción acelerada sin verificación de aprendizajes, aunque se cursen en menos tiempo los contenidos correspondientes a varios grados.",
            "La condición es que los estudiantes repitan el mismo grado varias veces, de modo que el rezago se resuelva por reiteración de la malla y no por cursar en menos tiempo los contenidos de varios grados.",
            "Debe excluirse a estos estudiantes de las pruebas Saber, para que el indicador de calidad de la IE no se vea afectado por la extraedad y el rezago, y el PMI conserve un resultado comparable ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide qué debe garantizarse en estos modelos, más allá de la reducción del tiempo escolar, según el texto. El pasaje exige el logro de las competencias básicas esperadas, y no una promoción acelerada sin verificación de aprendizajes. Suprimir la evaluación contradice esa verificación. Repetir el mismo grado varias veces invierte la idea de cursar varios grados en menos tiempo. Excluirlos de Saber protege un indicador de calidad que el texto no menciona.",
        "normativeJustification": "El texto condiciona la compactación de grados al logro de competencias básicas, no a omitir evaluación, a reiterar el mismo grado ni a excluir a la extraedad de Saber.",
        "theoreticalJustification": "Reducir tiempo no anula evidencia de aprendizaje. Sin verificación, la promoción acelerada queda vacía. Saber y la repetición de grado miden tablero o rezago por reiteración, no la condición del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de suprimir la evaluación: quitar evidencias parece facilitar la compactación de grados. El texto exige verificar competencias básicas; sin evaluación no hay la condición que pide más allá del menor tiempo escolar.",
            "2": "Trampa de la repetición de grado: reiterar la misma malla parece atender el rezago con más tiempo. Invierte el modelo flexible, que cursa varios grados en menos tiempo si se logran las competencias, no si se repite el grado.",
            "3": "Trampa de dominio cruzado de Saber: excluir a extraedad de las pruebas protege el indicador de calidad del PMI y es un cálculo de tablero conocido. El texto no menciona Saber; pide garantizar competencias, no maquillar resultados.",
        },
    },
    {
        "id": "dir-apt-lec-119",
        "options": [
            "La barrera es el exceso de oferta de transporte escolar en la zona rural, que saturaría las rutas y haría innecesaria la gestión conjunta con la entidad territorial y los recursos de regalías que menciona el texto.",
            "La asistencia irregular se explica por la falta de interés de los estudiantes rurales en asistir a clases, y no por la distancia a la sede ni por las lluvias en caminos destapados que describe el texto.",
            "La barrera es la distancia entre la vivienda de los estudiantes y la sede educativa, agravada en épocas de lluvias que dificultan el desplazamiento por caminos destapados, según lo señala el texto.",
            "La barrera principal es la reducción del calendario académico que el Decreto 1850 y el MEN habrían impuesto a las sedes rurales, acortando semanas lectivas, y no el desplazamiento por distancia y lluvias.",
        ],
        "explanation": "La condición de calidad pregunta qué barrera enfrentan los estudiantes rurales para la asistencia regular, según el texto. El pasaje identifica la distancia entre la vivienda y la sede, agravada en lluvias y caminos destapados. El exceso de transporte invierte la escasez implícita del servicio. La falta de interés no está dicha. Reducir el calendario por el Decreto 1850 es un saber de organización escolar externo; no es la barrera de desplazamiento que describe el texto.",
        "normativeJustification": "El texto ancla la inasistencia a la distancia, las lluvias y los caminos destapados. No habla de saturación de rutas, de desinterés estudiantil ni de recorte de calendario del 1850.",
        "theoreticalJustification": "Una barrera de acceso es geográfica y climática en este pasaje. Atribuirla a exceso de oferta, a motivación o a semanas lectivas cambia el objeto y no responde al stem.",
        "distractorAnalysis": {
            "0": "Trampa del exceso de rutas: hablar de saturación de transporte parece un problema de logística rural. El texto presenta la distancia y las lluvias como barrera, y el transporte como un servicio cuya existencia no está dada.",
            "1": "Trampa de la falta de interés: atribuir la inasistencia a la motivación del estudiante parece un diagnóstico de aula. El texto no lo dice; ancla la barrera a la distancia, las lluvias y los caminos destapados.",
            "3": "Trampa de dominio cruzado del calendario 1850: acortar semanas lectivas es un saber real de organización escolar. El texto no atribuye la inasistencia a ese decreto; la barrera es el desplazamiento a la sede en lluvias.",
        },
    },
    {
        "id": "dir-apt-lec-120",
        "options": [
            "La Ley 715 garantiza de forma permanente el transporte escolar rural como derecho financiado en cada vigencia, de modo que la continuidad no depende de gestión conjunta ni de regalías de un año a otro.",
            "La continuidad del transporte recae en las familias, que deben asumir el desplazamiento por caminos destapados y en épocas de lluvias, sin que la institución ni la entidad territorial gestionen la ruta.",
            "El transporte rural no requiere gestión institucional de la sede ni de la entidad territorial, porque la existencia de la ruta se da por sí sola cuando hay distancia a la sede y caminos destapados.",
            "Se infiere que el transporte, cuando existe, depende de la gestión conjunta entre la institución, la entidad territorial y, en algunos casos, recursos de regalías, y que su continuidad no está asegurada de un año a otro.",
        ],
        "explanation": "La condición de calidad pide qué se puede inferir sobre la continuidad del transporte escolar rural, según el texto. El pasaje indica gestión conjunta entre la IE, la entidad territorial y, a veces, regalías, y que esa continuidad no está asegurada de un año a otro. La Ley 715 no aparece como garantía permanente de la ruta. Las familias no son las responsables de gestionar el servicio en el texto. Afirmar que no se requiere gestión institucional niega la última oración del pasaje.",
        "normativeJustification": "El texto describe transporte contingente: gestión conjunta IE-entidad territorial y, a veces, regalías. No lo garantiza la Ley 715, ni lo asigna a las familias, ni lo declara espontáneo.",
        "theoreticalJustification": "Inferir continuidad es leer dependencia y precariedad anual, no un derecho financiado de forma permanente. Familia, SGP o ausencia de gestión cambian el sujeto y el horizonte temporal del servicio.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado de la Ley 715: tratar el transporte rural como derecho financiado de forma permanente es un saber de SGP plausible. El texto no garantiza esa continuidad; la hace depender de gestión conjunta y de cada vigencia.",
            "1": "Trampa de la carga familiar: que las familias asuman el desplazamiento por caminos destapados parece corresponsabilidad. El texto no les asigna la gestión de la ruta; habla de IE, entidad territorial y, a veces, regalías.",
            "2": "Trampa de la ruta espontánea: afirmar que el transporte no requiere gestión institucional niega la última oración del pasaje, que describe gestión conjunta y una continuidad que no está asegurada de un año a otro.",
        },
    },
    {
        "id": "dir-apt-num-121",
        "options": [
            "Consignar $1.332.000 en el acta del PMI, resultantes de (420 + 380 + 310) = 1.110 estudiantes × $1.200, como refrigerio adicional per cápita de las tres sedes, sin redondear ni cambiar la base del SIMAT.",
            "Reportar $1.200.000 en el PMI, tomando 1.000 estudiantes × $1.200 o el per cápita como si fuera el total, para alinear el refrigerio con un millar redondo comparable en tesorería y en el histórico de Secretaría.",
            "Registrar $1.280.000 como ejecución del refrigerio, omitiendo la sede de 310 (420 + 380 = 800 × $1.600) o usando 1.067 × $1.200, cifra intermedia que no tensiona el informe ante el comité de calidad.",
            "Cargar $1.400.000 como techo holgado de tesorería, aproximando 1.110 × cerca de $1.261 o 1.167 cupos × $1.200, para que el rubro de refrigerio luzca reforzado en el tablero de calidad y ante Secretaría.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación que se pide, sin redondear ni cambiar la base. Se suman las tres sedes: 420 + 380 + 310 = 1110 estudiantes. El refrigerio adicional es 1110 × 1200 = 1332000 pesos. Esa es la cifra del acta para el PMI y el SIMAT. Reportar 1200000 usa 1000 × 1200; 1280000 omite la sede de 310 o altera tarifa o n; 1400000 es un techo de tesorería.",
        "normativeJustification": "El informe de PMI y SIMAT debe conservar matrícula por sede y tarifa per cápita del caso. No sustituye 1110 × 1200 por un millar, por omitir una sede ni por un techo de tesorería.",
        "theoreticalJustification": "El total es la suma de las tres sedes multiplicada por la tarifa. Cambiar 1110 por 1000, omitir 310 o inflar a 1400000 produce otro indicador, no el refrigerio del caso.",
        "distractorAnalysis": {
            "1": "Trampa del millar redondo: $1.200.000 sale de 1000 × 1200 o de tomar el per cápita como total. Es comparable en tesorería, pero cambia la matrícula de 1110 o confunde tarifa con el gran total del refrigerio.",
            "2": "Trampa de omitir la sede de 310: $1.280.000 resulta de 800 × 1600 o de 1067 × 1200. Parece ejecución intermedia del comité, pero deja fuera una sede o altera tarifa y n del caso.",
            "3": "Trampa de dominio cruzado de tesorería: $1.400.000 es un techo holgado (1110 × cerca de 1261 o 1167 cupos × 1200) que luce reforzado en el tablero. No opera 1110 × 1200; infla el refrigerio como cupo de gestión.",
        },
    },
    {
        "id": "dir-apt-num-122",
        "options": [
            "Reportar 4 grupos de entrevista en el acta, tomando 36 docentes ÷ 9 o 45 ÷ 11, como si se omitiera a 9 docentes de la jornada o se agrandara el cupo, para un recuento ajustado de calidad.",
            "Consignar 5 grupos de entrevista, resultantes de 45 docentes ÷ 9 por grupo, como la cifra exacta de la jornada de evaluación docente, sin redondear ni sustituir el tamaño del grupo ni el n citado en el caso.",
            "Registrar 6 grupos en el PMI de la jornada, tomando 54 ÷ 9 (sumando 9 docentes de más) o 45 ÷ 7,5, para dejar un número de entrevistas que cubra holgura de agenda ante Secretaría.",
            "Cargar 9 como número de grupos de entrevista en el informe de planta, confundiendo el tamaño de cada grupo (9 docentes) con el n de grupos, porque 9 es la cifra visible de la convocatoria de evaluación.",
        ],
        "explanation": "La condición de calidad pide la cifra coherente con los datos del caso y la operación que se pide, sin redondear ni cambiar la base. Hay 45 docentes citados en grupos de 9 para las entrevistas: 45 ÷ 9 = 5 grupos. Esa es la cifra del acta de la jornada de evaluación docente. Reportar 4 omite 9 docentes (36 ÷ 9) o divide 45 entre 11. Reportar 6 usa 54 ÷ 9 o 45 ÷ 7,5; reportar 9 confunde el tamaño de cada grupo con el número de grupos.",
        "normativeJustification": "El acta de la jornada de evaluación docente reporta grupos según 45 citados y 9 por entrevista. No recorta a 36, no infla a 54 ni toma el tamaño del grupo como n de grupos.",
        "theoreticalJustification": "El número de grupos es n total dividido por el tamaño de cada grupo. 45 ÷ 9 = 5. Usar 36, 54 o reportar 9 como grupos cambia numerador, denominador o el objeto medido.",
        "distractorAnalysis": {
            "0": "Trampa de omitir nueve docentes: 4 grupos salen de 36 ÷ 9 o de 45 ÷ 11. El recuento parece ajustado, pero recorta la jornada de 45 o agranda el cupo por grupo y no es 45 ÷ 9.",
            "2": "Trampa de inflar la agenda: 6 grupos salen de 54 ÷ 9 o de 45 ÷ 7,5. Cubre holgura de entrevistas, pero suma docentes de más o reduce el tamaño de grupo respecto a los 9 del caso.",
            "3": "Trampa de dominio cruzado de la planta: reportar 9 como número de grupos toma el tamaño de cada entrevista (9 docentes) como indicador de cobertura de la jornada. Confunde n del grupo con n de grupos; no divide 45 ÷ 9.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {k: it[k] for k in ("id", "options", "explanation", "normativeJustification", "theoreticalJustification", "distractorAnalysis")}


def n_sentences(text: str) -> int:
    return text.count(".") + text.count("?") + text.count("!")


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
            low = opt.lower()
            if any(x in low for x in TEMPLATE):
                errors.append(f"TEMPLATE DISTRACTOR {tag} idx {oi}")
            if oi != ci:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
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
        n_sent = n_sentences(expl)
        if n_sent < 4 or n_sent > 7:
            errors.append(f"SENTENCES {tag} {n_sent}")
        if tag in NUM_IDS:
            elow = expl.lower()
            if "cifra coherente" not in elow:
                errors.append(f"NUM EXPL FRASE cifra coherente {tag}")
            if "sin redondear ni cambiar la base" not in elow:
                errors.append(f"NUM EXPL FRASE sin redondear {tag}")
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
            "sent",
            n_sentences(it["explanation"]),
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
