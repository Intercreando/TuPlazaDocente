# -*- coding: utf-8 -*-
"""Reescribe dir-apt-dis-373..380 y dir-apt-ped-381..382 (posiciones 1121-1130)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1121_1130.json"
CI = {
    "dir-apt-dis-373": 0,
    "dir-apt-dis-374": 1,
    "dir-apt-dis-375": 2,
    "dir-apt-dis-376": 3,
    "dir-apt-dis-377": 0,
    "dir-apt-dis-378": 1,
    "dir-apt-dis-379": 2,
    "dir-apt-dis-380": 3,
    "dir-apt-ped-381": 0,
    "dir-apt-ped-382": 1,
}

ITEMS = [
    {
        "id": "dir-apt-dis-373",
        "options": [
            "Leer 1789 como impulso de libertad, igualdad y fraternidad, con influencia en independencias americanas, y reenseñar que no consolidó el absolutismo ni inauguró el feudalismo.",
            "Leer la Revolución Francesa como consolidación definitiva de la monarquía absoluta, porque el desenlace napoleónico se enseña como «retorno del rey» en la línea de tiempo escolar.",
            "Leer que 1789 no influyó fuera de Francia, para acotar el DBA a Europa y no «mezclar» independencias americanas en la misma unidad de ideas.",
            "Leer 1789 como inicio del feudalismo europeo y reportarlo en el PMI de periodización de la IE, como si el hito abriera la Edad Media y no la cuestionara.",
        ],
        "explanation": "La condición de calidad pide la lectura más defendible de 1789 y el error a reenseñar. La Revolución Francesa impulsó esos ideales e influyó en procesos independentistas americanos. No consolidó el absolutismo ni inauguró el feudalismo, ni quedó encerrada en Francia. El «retorno del rey» napoleónico confunde desenlace con el programa revolucionario. El PMI que sitúa 1789 como inicio del feudalismo invierte la periodización.",
        "normativeJustification": "Los DBA de historia mundial y de independencias articulan 1789 con ideas ilustradas y con América. El PMI de periodización no autoriza a absolutizar, a encerrar el hito en Francia ni a medievizarlo.",
        "theoreticalJustification": "1789 difunde ideales y tiene alcance atlántico. Absolutismo consolidado, aislamiento francés o feudalismo cambian el objeto: de revolución a restauración, a DBA recortado o a tablero medieval.",
        "distractorAnalysis": {
            "1": "Trampa del retorno del rey: consolidar el absolutismo parece el desenlace napoleónico de la línea escolar. Contradice el programa de 1789 y no es la lectura más defendible.",
            "2": "Trampa de acotar a Francia: no influyó fuera parece no mezclar unidades. Omite la influencia en independencias americanas que el caso pide.",
            "3": "Trampa de dominio cruzado del PMI: 1789 como inicio del feudalismo luce como periodización de calidad. Invierte la Edad Media y no reenseña el error sobre el absolutismo.",
        },
    },
    {
        "id": "dir-apt-dis-374",
        "options": [
            "Explicar 1914 por la caída del Muro de Berlín (1989), desplazada setenta años, porque ambos hitos se asocian en el aula a «fin de un orden europeo».",
            "Explicar 1914 por el sistema de alianzas, los nacionalismos y las tensiones coloniales (con el atentado de Sarajevo), y reenseñar no tomar Versalles ni 1989 como causa.",
            "Explicar 1914 por el Tratado de Versalles como detonante, invirtiendo consecuencia y causa, porque Versalles es el documento más citado del DBA de entreguerras.",
            "Explicar 1914 por las independencias africanas de mediados del siglo XX, y reportarlo en el PMI de descolonización de la IE como causa «global» de la Gran Guerra.",
        ],
        "explanation": "La condición de calidad pide la explicación más precisa de las causas de 1914 y el error a reenseñar. Alianzas, nacionalismos y tensiones coloniales, con Sarajevo, sitúan el estallido. El Muro de 1989 es anacronismo. Versalles es consecuencia, no detonante. Las independencias africanas del siglo XX en el PMI de descolonización importan un indicador ajeno a 1914.",
        "normativeJustification": "Los DBA de historia del siglo XX distinguen causas de 1914, consecuencias de Versalles y 1989. El PMI de descolonización no autoriza a mover 1914 a África de mediados de siglo.",
        "theoreticalJustification": "Causa no es anacronismo ni efecto. 1989, Versalles o las independencias africanas cambian el objeto: de 1914 a Guerra Fría, a posguerra o a tablero de descolonización.",
        "distractorAnalysis": {
            "0": "Trampa del fin de un orden: el Muro de 1989 parece analogía europea. Desplaza setenta años y no explica 1914.",
            "2": "Trampa de Versalles: tomarlo como detonante parece el documento más citado del DBA. Invierte consecuencia y causa de la Gran Guerra.",
            "3": "Trampa de dominio cruzado del PMI: las independencias africanas como causa global lucen como descolonización de calidad. Son de mediados del siglo XX y no son causa de 1914.",
        },
    },
    {
        "id": "dir-apt-dis-375",
        "options": [
            "Caracterizar la Guerra Fría como guerra directa y continua entre EE. UU. y la URSS en territorio europeo, como si fuera una guerra clásica de frentes permanentes.",
            "Caracterizarla como unificación política mundial bajo un sistema, omitiendo la bipolaridad de bloques y la carrera armamentista que el ensayo contrapone.",
            "Caracterizarla como tensión bipolar, carrera armamentista y conflictos indirectos, sin enfrentamiento militar directo continuo entre las dos potencias, y reenseñar no igualarla a una guerra europea clásica entre ambas.",
            "Caracterizarla como el fin de todo conflicto internacional tras 1945, y reportarlo en el PMI de paz de la IE, como si la posguerra hubiera cancelado la tensión bipolar.",
        ],
        "explanation": "La condición de calidad pide la caracterización más precisa de la Guerra Fría y el error conceptual a reenseñar. Fue tensión política, ideológica y militar entre bloques, con carrera armamentista y conflictos indirectos, sin guerra directa continua entre EE. UU. y la URSS. La guerra clásica en Europa iguala el nombre a un frente permanente. La unificación mundial omite la bipolaridad. El PMI de paz que declara el fin de todo conflicto tras 1945 contradice 1947-1991.",
        "normativeJustification": "Los DBA de historia del siglo XX describen bipolaridad e indirectos, no guerra directa continua ni paz mundial de 1945. El PMI de paz no autoriza a cancelar la Guerra Fría.",
        "theoreticalJustification": "«Fría» nombra la ausencia de choque directo entre potencias. Guerra clásica, unificación mundial o paz de 1945 cambian el objeto: de tensión bipolar a frente, a sistema único o a tablero de paz.",
        "distractorAnalysis": {
            "0": "Trampa de la guerra clásica: frentes permanentes en Europa parecen explicar el nombre. Contradicen la ausencia de choque directo continuo entre las dos potencias.",
            "1": "Trampa de la unificación mundial: un sistema único parece el desenlace de 1945. Omite la bipolaridad y la carrera armamentista.",
            "3": "Trampa de dominio cruzado del PMI: el fin de todo conflicto tras 1945 luce como indicador de paz. Cancela 1947-1991 y no es la caracterización más precisa.",
        },
    },
    {
        "id": "dir-apt-dis-376",
        "options": [
            "Identificar el PIB con la deuda externa acumulada, porque ambos se reportan en billones y el estudiante los trata como «cuánto debe o produce el país» en el mismo esquema.",
            "Identificar el PIB con el número de empresas registradas, y consignarlo en el indicador PMI de emprendimiento de la IE, como si el censo mercantil midiera la producción del período.",
            "Identificar el PIB con el ingreso personal promedio, confundiendo el agregado de producción con el PIB per cápita que el estudiante describe como «lo que gana cada habitante».",
            "Explicar el PIB como el valor de bienes y servicios finales producidos en un período, con un ejemplo situado de cosecha local, argumentando el concepto y no recitándolo.",
        ],
        "explanation": "La condición de calidad pide la evidencia que demuestra el aprendizaje esencial del PIB. Explicar el valor de bienes y servicios finales de un período, con ejemplo situado, argumenta el concepto. La deuda externa es magnitud vecina en billones. El número de empresas del PMI de emprendimiento mide censo mercantil, no producción. El ingreso promedio es PIB per cápita, que el caso cita como error del estudiante.",
        "normativeJustification": "Los DBA de ciencias económicas distinguen PIB, PIB per cápita y deuda. El PMI de emprendimiento no homologa el registro mercantil con el valor de la producción.",
        "theoreticalJustification": "El PIB es flujo de producción final. Deuda, censo de empresas o ingreso promedio cambian el objeto: de agregado a stock, a tablero o a per cápita.",
        "distractorAnalysis": {
            "0": "Trampa de la deuda en billones: igualar PIB y deuda externa parece contabilidad nacional. Confunde producción del período con stock de pasivos.",
            "1": "Trampa de dominio cruzado del PMI: el número de empresas como emprendimiento luce como evidencia de calidad. Mide censo mercantil, no el valor de bienes y servicios finales.",
            "2": "Trampa del per cápita: «lo que gana cada habitante» parece definición intuitiva. Es el error del caso y no demuestra el aprendizaje esencial del PIB agregado.",
        },
    },
    {
        "id": "dir-apt-dis-377",
        "options": [
            "Identificar el mecanismo de mercado como la interacción de oferta y demanda que orienta qué, cómo y para quién producir, y reenseñar que la asignación central de todos los recursos describe otro sistema.",
            "Identificarlo como un organismo estatal que planifica y asigna todos los recursos a cada fábrica, que es el relato de planificación central que el estudiante atribuye al mercado.",
            "Identificarlo como un sorteo periódico del gobierno que reparte cupos de producción, para que la «equidad» del SIEE escolar se proyecte como regla de mercado.",
            "Identificarlo como un monopolio estatal único por sector, porque el mapa de empresas públicas del país se enseña como sinónimo de economía de mercado.",
        ],
        "explanation": "La condición de calidad pide el mecanismo que evidencia el sistema de mercado y el error a reenseñar. Oferta y demanda orientan en lo principal qué, cómo y para quién producir. La asignación central de cupos a cada fábrica es planificación, no mercado. El sorteo de cupos proyecta equidad del SIEE. El monopolio estatal por sector describe otra estructura, no el mecanismo de mercado del caso.",
        "normativeJustification": "Los DBA de economía contrastan mercado y planificación. El SIEE de cupos y el mapa de empresas públicas no autorizan a sortear la producción ni a definir mercado como monopolio estatal.",
        "theoreticalJustification": "El mercado coordina por precios. Planificación central, sorteo escolar o monopolio estatal cambian el objeto: de oferta-demanda a ministerio, a SIEE o a empresa pública.",
        "distractorAnalysis": {
            "1": "Trampa de la planificación: el ministerio que asigna cupos a cada fábrica parece orden económico. Es el error del estudiante y describe otro sistema, no el de mercado.",
            "2": "Trampa de dominio cruzado del SIEE: el sorteo de cupos luce como equidad escolar proyectada al mercado. No es el mecanismo de oferta y demanda.",
            "3": "Trampa del monopolio estatal: un operador único por sector parece el mapa de empresas públicas. No define el sistema de mercado ni reenseña la asignación central.",
        },
    },
    {
        "id": "dir-apt-dis-378",
        "options": [
            "Reducir cultura a las artes (música y pintura) como sinónimo exhaustivo, que es el uso coloquial de «culto» que el estudiante trae y que recorta el concepto antropológico.",
            "Concebir cultura como el conjunto de conocimientos, creencias, valores y formas de vida compartidas y transmitidas, y reenseñar no reducirla a arte, a título escolar ni a sociedades antiguas.",
            "Reducir cultura al nivel educativo formal alcanzado o al puntaje de pruebas, como si el diploma midiera la cultura del grupo en el SIEE de «calidad cultural».",
            "Reservar el concepto a sociedades tradicionales del atlas, y reportarlo en el PMI de patrimonio de la IE, como si las sociedades contemporáneas no tuvieran cultura antropológica.",
        ],
        "explanation": "La condición de calidad pide la concepción más precisa de cultura y la reducción a reenseñar. En antropología abarca conocimientos, creencias, valores y formas de vida compartidas y transmitidas. No se agota en artes, ni en el diploma, ni en sociedades «antiguas». El uso coloquial de culto recorta a pintura y música. El SIEE de calidad cultural confunde título con cultura. El PMI de patrimonio fosiliza el concepto en lo tradicional.",
        "normativeJustification": "Los DBA de ciencias sociales usan el concepto antropológico amplio. El SIEE de puntajes y el PMI de patrimonio no autorizan a reducir cultura a arte, a diploma o a sociedades del atlas.",
        "theoreticalJustification": "Cultura es transmisión de sentidos. Artes, título escolar o patrimonio tradicional cambian el objeto: de concepto amplio a coloquial, a evidencia o a tablero de patrimonio.",
        "distractorAnalysis": {
            "0": "Trampa de lo culto: música y pintura parecen el sentido cotidiano de cultura. Recortan el concepto antropológico que el caso pide.",
            "2": "Trampa del diploma: el nivel educativo y el puntaje parecen «ser culto». Confunden título con formas de vida compartidas.",
            "3": "Trampa de dominio cruzado del PMI: reservar cultura a sociedades tradicionales luce como patrimonio de calidad. Niega el concepto antropológico a las sociedades contemporáneas.",
        },
    },
    {
        "id": "dir-apt-dis-379",
        "options": [
            "Asociar la urbanización a una disminución general de la población mundial, porque el campo se «vacía» en el relato y el estudiante iguala éxodo rural con caída demográfica global.",
            "Asociarla al abandono de la agricultura en el planeta, de modo que industrialización equivalga a fin de lo rural en todos los países del atlas escolar.",
            "Asociarla a industrialización y a migración campo-ciudad, y reenseñar que lo rural no desaparece por el hecho de urbanizar ni cae la población mundial como efecto necesario.",
            "Asociarla a la desaparición de las zonas rurales en todos los países, y reportarlo en el PMI de «territorio 100% urbano» de la IE como meta de modernización.",
        ],
        "explanation": "La condición de calidad pide la asociación que evidencia el aprendizaje esencial de la urbanización y el error a reenseñar. Históricamente se liga a industrialización y a migración campo-ciudad. No implica caída demográfica mundial, ni el fin de la agricultura, ni la desaparición de lo rural en todos los países. El PMI de territorio 100% urbano convierte un proceso histórico en meta de modernización escolar.",
        "normativeJustification": "Los DBA de geografía humana articulan urbanización, industria y migración, y conservan lo rural. El PMI de modernización no autoriza a decretar el fin del campo ni la caída de la población mundial.",
        "theoreticalJustification": "Urbanizar es redistribuir población, no extinguir lo rural. Caída demográfica, abandono agrícola o territorio 100% urbano cambian el objeto: de proceso a catástrofe, a atlas o a tablero.",
        "distractorAnalysis": {
            "0": "Trampa del campo que se vacía: igualar éxodo rural con caída de la población mundial parece demografía intuitiva. El texto no afirma disminución global.",
            "1": "Trampa del fin de la agricultura: industrializar parece acabar lo rural en el atlas. No es el aprendizaje esencial ni reenseña la persistencia del campo.",
            "3": "Trampa de dominio cruzado del PMI: el territorio 100% urbano luce como meta de modernización. Decreta la desaparición rural y no asocia urbanización a industria y migración.",
        },
    },
    {
        "id": "dir-apt-dis-380",
        "options": [
            "Situar las independencias hispanoamericanas y la brasileña en la segunda mitad del siglo XX, confundiendo ese ciclo con otras descolonizaciones, porque el DBA de África y Asia se enseña como «independencias» genéricas.",
            "Situarlas en el siglo XVI, identificando conquista con independencia, porque el contacto inicial parece el origen político de las repúblicas en la línea de tiempo escolar.",
            "Situarlas en el siglo XVIII, antes de la Ilustración y de 1808, para adelantar el proceso y no «esperar» la invasión napoleónica en la periodización del plan de área.",
            "Situarlas en las primeras décadas del XIX, con ideas ilustradas e invasión napoleónica a España, y reenseñar no desplazar el proceso a la Conquista ni a las descolonizaciones del siglo XX.",
        ],
        "explanation": "La condición de calidad pide la periodización más precisa y el anacronismo a reenseñar. Las independencias de la mayoría de países latinoamericanos se concentran en las primeras décadas del siglo XIX, en contexto ilustrado y de crisis de la monarquía española (1808). El siglo XX confunde con otras descolonizaciones. El XVI identifica conquista con independencia. El XVIII «antes de la Ilustración» omite ideas y 1808.",
        "normativeJustification": "Los DBA de independencias hispanoamericanas y de Brasil periodizan el primer XIX con Ilustración y crisis napoleónica. El DBA de descolonización del XX y la línea de la Conquista no autorizan a desplazar ese ciclo.",
        "theoreticalJustification": "El tiempo del proceso es 1808-1820s, no 1500 ni 1950. Descolonización africana, conquista o siglo XVIII preilustrado cambian el objeto: de independencias a otro ciclo, a invasión inicial o a adelanto curricular.",
        "distractorAnalysis": {
            "0": "Trampa de las independencias genéricas: el siglo XX parece el DBA de África y Asia. Confunde descolonizaciones y no periodiza Hispanoamérica y Brasil.",
            "1": "Trampa de la Conquista: el siglo XVI parece el origen de las repúblicas. Identifica contacto con independencia y no es la periodización más precisa.",
            "2": "Trampa de dominio cruzado del plan de área: adelantar al XVIII antes de la Ilustración luce como cobertura curricular. Omite 1808 y las ideas que el caso pide como contexto.",
        },
    },
    {
        "id": "dir-apt-ped-381",
        "options": [
            "Desarrollar pensamiento histórico implica comprender relaciones de causalidad, cambio y continuidad entre momentos, más allá de acumular fechas aisladas para el quiz de efemérides.",
            "Acumular la mayor cantidad posible de fechas exactas del listado, sin establecer relaciones entre períodos, para que el quiz de efemérides que defiende el colega cubra el DBA de datos.",
            "Repetir de memoria los nombres de los personajes más citados, como alfabetización previa de «quién es quién», antes de analizar procesos de cambio y continuidad.",
            "Evitar relacionar distintos períodos en la prueba, y consignar fechas sueltas como evidencia comparable del SIEE, para «no mezclar temas» y conservar ítems homogéneos.",
        ],
        "explanation": "La condición de calidad pregunta qué implica principalmente desarrollar pensamiento histórico. Comprender causalidad, cambio y continuidad, más allá de fechas aisladas, responde a esa demanda frente a una evaluación que solo lista efemérides. Acumular fechas para el quiz del colega es cobertura de datos, no pensamiento. Memorizar personajes es alfabetización onomástica previa. Evitar relacionar períodos en el SIEE busca ítems homogéneos y niega la relación temporal que el caso pide.",
        "normativeJustification": "Los DBA de ciencias sociales evalúan pensamiento histórico (causalidad, cambio, continuidad), no el recuento de efemérides. El SIEE de ítems sueltos no sustituye esa comprensión relacional.",
        "theoreticalJustification": "Pensar históricamente es relacionar tiempos. El quiz de fechas, la lista de nombres o los ítems homogéneos miden memoria, onomástica o comparabilidad, no causalidad.",
        "distractorAnalysis": {
            "1": "Trampa del quiz de efemérides: acumular fechas exactas parece el rigor que defiende el colega. Cubre datos y no desarrolla causalidad, cambio y continuidad.",
            "2": "Trampa de la alfabetización onomástica: memorizar personajes parece base indispensable. Deja el pensamiento histórico en nombres y no en procesos.",
            "3": "Trampa de dominio cruzado del SIEE: fechas sueltas para no mezclar temas lucen como ítems comparables. Evitan relacionar períodos y niegan el objeto de la evaluación de historia.",
        },
    },
    {
        "id": "dir-apt-ped-382",
        "options": [
            "Tratar el acta de 1810 como intrínsecamente más confiable que el manual de 2020, sin análisis de autor, propósito ni contexto, porque «lo primario» se enseña como garantía de verdad.",
            "Distinguir que la fuente primaria proviene de la época o del hecho (el acta de 1810) y que la secundaria es una interpretación o análisis posterior (el manual escolar de 2020).",
            "Tratar las secundarias como documentos oficiales del gobierno, de modo que el manual de 2020 se lea como acto administrativo y no como interpretación didáctica posterior al hecho.",
            "Afirmar que no hay diferencia didáctica relevante entre ambos tipos y evaluarlos con la misma rúbrica del SIEE, para que acta y manual entren como evidencia comparable de «fuentes».",
        ],
        "explanation": "La condición de calidad pregunta una diferencia clave entre fuente primaria y secundaria en la enseñanza de la historia. La primaria es testimonio de la época o del hecho (acta de 1810); la secundaria interpreta después (manual de 2020). Tratar lo primario como garantía de verdad confunde tipo con confiabilidad. Leer las secundarias como documentos oficiales del gobierno anacroniza el manual. Homologar ambos en el SIEE como evidencia comparable borra la distinción didáctica del caso.",
        "normativeJustification": "Los DBA de ciencias sociales piden clasificar y contrastar fuentes. El SIEE no homologa acta y manual como el mismo tipo de evidencia, ni la oficialidad gubernamental define lo secundario.",
        "theoreticalJustification": "La diferencia es de posición temporal y de mediación, no de verdad automática ni de sello estatal. Garantía de lo primario, documento oficial o rúbrica única cambian el objeto: de tipo de fuente a credibilidad, a gobierno o a comparabilidad.",
        "distractorAnalysis": {
            "0": "Trampa de la verdad de lo primario: el acta de 1810 parece más confiable por ser de la época. Confunde tipo de fuente con garantía de verdad y no analiza autor ni propósito.",
            "2": "Trampa del documento oficial: leer lo secundario como acto de gobierno parece rigor institucional. El manual de 2020 es interpretación didáctica, no un sello estatal del hecho.",
            "3": "Trampa de dominio cruzado del SIEE: la misma rúbrica para acta y manual luce como evidencia comparable de fuentes. Borra la diferencia didáctica entre testimonio de época e interpretación posterior.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI))
