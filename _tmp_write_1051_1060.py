# -*- coding: utf-8 -*-
"""Reescribe dir-apt-lec-303..312 (posiciones 1051-1060)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1051_1060.json"
CI = {
    "dir-apt-lec-303": 2,
    "dir-apt-lec-304": 3,
    "dir-apt-lec-305": 0,
    "dir-apt-lec-306": 1,
    "dir-apt-lec-307": 2,
    "dir-apt-lec-308": 3,
    "dir-apt-lec-309": 0,
    "dir-apt-lec-310": 1,
    "dir-apt-lec-311": 2,
    "dir-apt-lec-312": 3,
}

ITEMS = [
    {
        "id": "dir-apt-lec-303",
        "options": [
            "Colombia se presenta como una unidad geográfica nacional homogénea, de modo que climas, ecosistemas y poblamiento se lean como un territorio continuo, sin regiones naturales distintas ni desarrollo desigual de vías.",
            "La cordillera de los Andes influye poco en la diversidad geográfica frente a las costas, de modo que el Caribe y el Pacífico explicarían las regiones y el poblamiento más que los tres ramales.",
            "La diversidad geográfica de Colombia, marcada por la cordillera de los Andes y sus tres ramales, ha influido en el desarrollo desigual de las vías de comunicación y de las actividades económicas regionales.",
            "Las cinco regiones naturales deben consignarse con el mismo clima en el indicador de equidad territorial del PMI, para que el informe de calidad acredite homogeneidad ambiental entre Andina, Caribe y Amazonía.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que la diversidad geográfica, resultado en buena parte de los Andes y de su división en tres ramales, da origen a cinco regiones naturales y ha influido en el desarrollo desigual de vías y de actividades económicas. Leer a Colombia como una unidad geográfica homogénea invierte esa diversidad de climas, ecosistemas y poblamiento. Minimizar el papel de los Andes frente a las costas contradice el peso que el texto les asigna al ingresar al territorio. Homogeneizar el clima de las cinco regiones en un indicador de equidad del PMI importa un reporte de calidad que el pasaje no afirma.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre geografía colombiana. Lo afirmado es la diversidad marcada por los Andes y el desarrollo desigual de vías y economía, no la homogeneidad territorial ni el clima uniforme del PMI.",
        "theoreticalJustification": "La idea principal sintetiza Andes, regiones naturales y desigualdad de vías y economía. La unidad homogénea, el privilegio de las costas y el indicador de equidad climática son inferencias ilegítimas frente al pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de la homogeneidad territorial: leer unidad geográfica nacional parece cohesión del país. El texto describe regiones distintas y un desarrollo desigual de vías y economía, no un territorio continuo.",
            "1": "Trampa de minimizar los Andes: privilegiar costas del Caribe y del Pacífico parece explicar dos regiones nombradas. El pasaje sitúa los tres ramales como origen de la diversidad y del poblamiento desigual.",
            "3": "Trampa de dominio cruzado del PMI: consignar el mismo clima en las cinco regiones parece equidad territorial de un informe. El texto las distingue por climas, ecosistemas y poblamiento, no por homogeneidad de calidad.",
        },
    },
    {
        "id": "dir-apt-lec-304",
        "options": [
            "La división en tres ramales elimina las regiones naturales del país, de modo que Andina, Caribe, Pacífica, Orinoquía y Amazonía dejarían de diferenciarse por clima, ecosistema y poblamiento.",
            "Esa configuración reduce la diversidad de ecosistemas, de modo que climas y formas de poblamiento se uniforman entre las zonas del territorio nacional a pesar de los tres ramales andinos.",
            "La división en tres ramales origina el mapa de departamentos y municipios, de modo que el DBA de ciencias sociales tome esa malla político-administrativa como el efecto geográfico de los Andes.",
            "La división en tres ramales da origen a regiones naturales distintas, como la Andina, la Caribe, la Pacífica, la Orinoquía y la Amazonía, cada una con climas, ecosistemas y poblamiento propios.",
        ],
        "explanation": "La condición de calidad pregunta qué origina la división de los Andes en tres ramales. El texto afirma que esa configuración da origen a regiones naturales distintas: Andina, Caribe, Pacífica, Orinoquía y Amazonía, con climas, ecosistemas y poblamiento propios. Eliminar las regiones invierte ese efecto de diferenciación territorial. Reducir la diversidad de ecosistemas contradice la distinción que el pasaje describe. Tomar los ramales como mapa de departamentos adelanta un DBA político-administrativo que el texto no sostiene.",
        "normativeJustification": "El ítem pide el efecto que el texto atribuye a los tres ramales: regiones naturales distintas. No autoriza su eliminación, la uniformidad de ecosistemas ni la malla de departamentos del DBA.",
        "theoreticalJustification": "La configuración andina se lee como origen de cinco regiones naturales. Borrar regiones, uniformar ecosistemas o sustituirlas por departamentos cambia el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de eliminar las regiones: unificar Andina, Caribe, Pacífica, Orinoquía y Amazonía parece leer los ramales como fusión territorial. El texto dice que esa configuración da origen a regiones distintas.",
            "1": "Trampa de reducir ecosistemas: la fragmentación andina parece amenazar la diversidad. El pasaje afirma lo contrario: climas, ecosistemas y poblamiento propios en cada región natural.",
            "2": "Trampa de dominio cruzado del DBA: tomar departamentos y municipios como efecto de los ramales luce como mapa de ciencias sociales. El texto origina regiones naturales, no la malla político-administrativa.",
        },
    },
    {
        "id": "dir-apt-lec-305",
        "options": [
            "La relación entre oferta y demanda influye en los precios, aunque la intervención estatal, los monopolios o la información imperfecta pueden alterar ese comportamiento esperado en distintos mercados.",
            "Los precios de un bien o servicio quedan determinados por los costos de producción, de modo que oferta y demanda ocuparían un lugar secundario frente a esa contabilidad de insumos y márgenes.",
            "La intervención estatal garantiza el precio justo en los mercados, de modo que monopolios e información imperfecta quedarían corregidos y la relación oferta-demanda perdería capacidad de alterar valores.",
            "Oferta y demanda se reportan como cupos y lista de espera del SIEE, sin relación con los precios de mercado, de modo que el indicador de matrícula sustituya la lectura económica del texto.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje plantea que oferta y demanda influyen en los precios, y que intervención estatal, monopolios o información imperfecta pueden alterar ese comportamiento esperado. Determinar los precios por costos de producción importa una teoría vecina que el fragmento no usa. Tratar la intervención estatal como garantía de precio justo sobregeneraliza un factor que el texto cita como alteración posible. Reportar oferta y demanda como cupos del SIEE desplaza el objeto hacia la matrícula escolar.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre oferta, demanda y precios. Lo afirmado es esa relación matizada por intervención, monopolios o información imperfecta, no los costos de producción ni los cupos del SIEE.",
        "theoreticalJustification": "La idea principal articula precios con oferta y demanda, y admite factores que alteran el resultado. Costos, precio justo estatal y cupos escolares son inferencias ilegítimas.",
        "distractorAnalysis": {
            "1": "Trampa de los costos de producción: fijar el precio por insumos y márgenes parece teoría económica ordenada. El texto no la usa; sitúa oferta y demanda, con factores que pueden alterar el comportamiento esperado.",
            "2": "Trampa de garantizar el precio justo: leer la intervención estatal como corrección plena parece defensa del consumidor. El pasaje la cita como un factor que puede alterar la relación, no como garantía del valor.",
            "3": "Trampa de dominio cruzado del SIEE: reportar oferta y demanda como cupos y lista de espera luce como economía escolar. El texto habla de precios de mercado, no del indicador de matrícula.",
        },
    },
    {
        "id": "dir-apt-lec-306",
        "options": [
            "Cuando la demanda supera ampliamente la oferta, el precio tiende a reducirse, como ocurriría si los productores ofrecieran una cantidad mayor a la que los consumidores están dispuestos a adquirir.",
            "Cuando la cantidad demandada supera la cantidad ofrecida, suele producirse una tendencia al aumento del precio del bien o servicio, según la relación descrita entre consumidores y productores.",
            "El bien o servicio desaparece del mercado, porque el desajuste entre lo que piden los consumidores y lo que ofrecen los productores agotaría de modo irreversible la existencia del producto.",
            "El precio no varía, porque las listas institucionales del SIEE o el tarifario de la sede congelan el valor y anulan la tendencia que el texto asocia al desajuste entre demanda y oferta.",
        ],
        "explanation": "La condición de calidad pregunta qué tiende a ocurrir cuando la demanda supera ampliamente la oferta. El texto señala una tendencia al aumento del precio. La reducción de precio corresponde al caso contrario, cuando la oferta supera a la demanda. La desaparición del bien es un desenlace catastrofista que el pasaje no afirma. Congelar el valor con listas del SIEE importa un tarifario institucional ajeno a la tendencia descrita.",
        "normativeJustification": "El ítem pide la tendencia que el texto asocia a demanda mayor que oferta: el aumento del precio. No autoriza la bajada del caso inverso, la desaparición del bien ni el congelamiento del SIEE.",
        "theoreticalJustification": "El desajuste demanda-oferta se lee como presión al alza del precio. Invertir la flecha, catastrofizar el bien o importar el tarifario escolar cambia el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de invertir la flecha: reducir el precio parece el ajuste de un mercado tensionado. Esa tendencia corresponde, en el texto, a una oferta que supera a la demanda, no al caso pedido.",
            "2": "Trampa de la desaparición del bien: agotar el producto parece la consecuencia extrema de la escasez. El pasaje habla de tendencia al aumento del precio, no de que el bien deje el mercado.",
            "3": "Trampa de dominio cruzado del SIEE: congelar el valor con listas institucionales parece orden de tarifas escolares. El texto no anula la tendencia al alza cuando la demanda supera a la oferta.",
        },
    },
    {
        "id": "dir-apt-lec-307",
        "options": [
            "La democracia representativa ha quedado desplazada en Colombia, de modo que elegir gobernantes mediante el voto ya no complementaría al referendo, la consulta popular o el plebiscito.",
            "El referendo, la consulta popular y el plebiscito reemplazan la elección periódica de representantes, de modo que la ciudadanía se pronuncia sin necesidad de gobernantes elegidos por voto.",
            "Los mecanismos de participación directa, como el referendo, la consulta popular o el plebiscito, complementan la democracia representativa, y su efectividad depende de información clara y de garantías.",
            "El plebiscito opera como mecanismo principal de calidad democrática en el gobierno escolar, de modo que el informe de participación acredite esa figura por encima del voto de representantes.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que mecanismos como el referendo, la consulta popular o el plebiscito complementan la democracia representativa, y que su uso efectivo depende de información clara y de garantías. Afirmar que la representativa ha sido desplazada invierte ese complemento. Tratar los mecanismos directos como reemplazo de la elección de representantes niega el voto periódico que el texto mantiene. Elevar el plebiscito a mecanismo principal del gobierno escolar importa un indicador de participación que el fragmento no usa como idea central.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre democracia. Lo afirmado es el complemento de mecanismos directos a la representativa, condicionado a información y garantías, no su reemplazo ni el plebiscito del gobierno escolar.",
        "theoreticalJustification": "La idea principal articula voto de representantes, mecanismos directos y condiciones de efectividad. Desplazar la representativa, sustituir el voto o reportar el plebiscito escolar cambia el objeto del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de desplazar la representativa: leer el referendo y el plebiscito como sucesor del voto parece profundizar la participación. El texto los presenta como complemento, no como desplazamiento de elegir gobernantes.",
            "1": "Trampa del reemplazo del voto: pronunciarse sobre decisiones específicas parece hacer innecesaria la elección periódica. El pasaje mantiene esa elección y sitúa los mecanismos más allá de ella, no en su lugar.",
            "3": "Trampa de dominio cruzado del gobierno escolar: elevar el plebiscito a indicador de calidad democrática luce como participación institucional. El texto no lo pone como mecanismo principal ni lo sitúa en el gobierno escolar.",
        },
    },
    {
        "id": "dir-apt-lec-308",
        "options": [
            "Del trámite de votaciones del gobierno escolar y de la rectoría de turno, de modo que el mecanismo quede acreditado como participación institucional sin las condiciones de información y garantías que el texto nombra.",
            "De eliminar la democracia representativa, de modo que el referendo, la consulta popular y el plebiscito operen sin la elección periódica de gobernantes mediante el voto ciudadano.",
            "De aplicarlos en las elecciones presidenciales, de modo que el pronunciamiento ciudadano coincida con el calendario de voto para cargos y no con decisiones específicas más allá de esa elección.",
            "Del acceso a información clara y de la existencia de garantías para una participación libre e informada, condiciones de las que depende el uso efectivo de estos mecanismos según el texto.",
        ],
        "explanation": "La condición de calidad pregunta de qué depende el uso efectivo de los mecanismos de participación directa. El texto nombra el acceso a información clara y las garantías para una participación libre e informada. Atarlo al trámite del gobierno escolar o a la rectoría de turno importa un procedimiento institucional que el pasaje no cita. Eliminar la democracia representativa contradice el complemento descrito. Aplicarlos en elecciones presidenciales confunde el pronunciamiento sobre decisiones específicas con el calendario del voto para cargos.",
        "normativeJustification": "El ítem pide las condiciones que el texto asocia al uso efectivo: información clara y garantías de participación libre e informada. No autoriza el trámite del gobierno escolar, eliminar la representativa ni el calendario presidencial.",
        "theoreticalJustification": "El uso efectivo se lee en las condiciones de información y garantías. El gobierno escolar, el fin de la representativa o las elecciones presidenciales cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del gobierno escolar: acreditar el mecanismo como votación de rectoría parece participación institucional ordenada. El texto no cita ese trámite; pide información clara y garantías de participación libre.",
            "1": "Trampa de eliminar la representativa: operar sin elección de gobernantes parece radicalizar la democracia directa. El pasaje mantiene el voto periódico y no lo pone como condición del uso efectivo.",
            "2": "Trampa del calendario presidencial: aplicar los mecanismos en la elección de cargos parece el momento natural de pronunciarse. El texto los sitúa en decisiones específicas, más allá de esa elección periódica.",
        },
    },
    {
        "id": "dir-apt-lec-309",
        "options": [
            "El reconocimiento constitucional del carácter pluriétnico implica derechos concretos, entre ellos la consulta previa frente a decisiones que afecten territorios y la jurisdicción especial indígena para ciertos conflictos.",
            "Ese reconocimiento se agota en un enunciado simbólico, de modo que lenguas, cosmovisiones y organización propia no se traducirían en consulta previa ni en jurisdicción especial indígena.",
            "Los pueblos indígenas carecen de formas de organización propias, de modo que lenguas y cosmovisiones no sostendrían ni la consulta previa ni una jurisdicción para resolver conflictos según normas propias.",
            "La consulta previa se tramita como mecanismo de etnoeducación del PEI, de modo que el acuerdo de aula sustituya el derecho territorial que el texto asocia a decisiones sobre sus territorios.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje afirma que el reconocimiento constitucional pluriétnico no se limita a un enunciado simbólico e implica derechos concretos: consulta previa territorial y jurisdicción especial indígena. Agotar el reconocimiento en lo simbólico invierte esa tesis. Negar la organización propia de los pueblos contradice lenguas, cosmovisiones y formas propias que el texto enumera. Tramitar la consulta previa como etnoeducación del PEI importa un acuerdo escolar que el fragmento no sostiene.",
        "normativeJustification": "El ítem lee la idea principal del fragmento pluriétnico. Lo afirmado es el paso del reconocimiento a derechos concretos de consulta previa y jurisdicción especial, no el enunciado simbólico ni el PEI de etnoeducación.",
        "theoreticalJustification": "La idea principal articula reconocimiento constitucional y derechos territoriales de consulta y jurisdicción. Lo simbólico, la falta de organización y el mecanismo escolar son inferencias ilegítimas.",
        "distractorAnalysis": {
            "1": "Trampa de lo simbólico: dejar el reconocimiento en un enunciado parece lectura constitucional formal. El texto niega ese techo e implica consulta previa y jurisdicción especial como derechos concretos.",
            "2": "Trampa de negar la organización propia: tratar lenguas y cosmovisiones como insuficientes parece dudar de la autonomía. El pasaje reconoce formas de organización propias junto a esos elementos.",
            "3": "Trampa de dominio cruzado del PEI: tramitar la consulta previa como etnoeducación de aula luce como inclusión escolar. El texto la sitúa frente a decisiones que puedan afectar territorios, no como acuerdo del PEI.",
        },
    },
    {
        "id": "dir-apt-lec-310",
        "options": [
            "Disponer de un margen pleno frente al ordenamiento nacional, de modo que las normas y procedimientos propios cubran el conjunto de controversias y no apenas ciertos conflictos del pasaje.",
            "Resolver ciertos conflictos según sus propias normas y procedimientos, como implica el reconocimiento constitucional junto a la consulta previa frente a decisiones sobre territorios.",
            "Dejar sin efecto la consulta previa frente a decisiones que afecten territorios, de modo que la jurisdicción especial reemplace ese derecho y no lo acompañe como implica el texto.",
            "Participar en las elecciones del gobierno escolar y en las votaciones locales, de modo que esa vía de representación se tome como si fuera la jurisdicción especial indígena del pasaje.",
        ],
        "explanation": "La condición de calidad pregunta qué le permite a los pueblos indígenas la jurisdicción especial. El texto indica resolver ciertos conflictos según sus propias normas y procedimientos. Un margen pleno frente al ordenamiento sobregeneraliza ese alcance. Dejar sin efecto la consulta previa opone dos derechos que el pasaje presenta juntos. Equiparar la jurisdicción especial a las elecciones del gobierno escolar o a las votaciones locales importa una vía de representación que el texto no identifica con esa figura.",
        "normativeJustification": "El ítem pide lo que el texto atribuye a la jurisdicción especial indígena: resolver ciertos conflictos según normas y procedimientos propios. No autoriza un margen pleno, anular la consulta previa ni el gobierno escolar.",
        "theoreticalJustification": "La jurisdicción especial se lee con alcance acotado a ciertos conflictos. El margen pleno, el recambio de la consulta previa o las elecciones locales cambian el objeto de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa del margen pleno: cubrir el conjunto de controversias parece autonomía fuerte. El texto acota la jurisdicción especial a ciertos conflictos según normas y procedimientos propios, no a un retiro del ordenamiento.",
            "2": "Trampa de anular la consulta previa: hacer que la jurisdicción especial la reemplace parece concentrar el reconocimiento. El pasaje presenta ambos derechos juntos, no en recambio.",
            "3": "Trampa de dominio cruzado del gobierno escolar: votar en elecciones locales o de sede parece participación indígena ordenada. El texto no identifica esa vía de representación con la jurisdicción especial.",
        },
    },
    {
        "id": "dir-apt-lec-311",
        "options": [
            "Los movimientos migratorios se explican de modo suficiente por la búsqueda de mejores oportunidades laborales, sin combinar esa causa con la violencia, los desastres naturales o la persecución política.",
            "La violencia, los desastres naturales y la persecución política quedan como factores ajenos o menores, de modo que no se combinarían con los motivos económicos en los procesos migratorios.",
            "Los procesos migratorios suelen tener múltiples causas combinadas, y comprender esa multicausalidad sirve para evitar explicaciones simplistas y para diseñar políticas públicas más integrales.",
            "Las políticas públicas omiten las causas del desplazamiento y se reportan en el registro SIMAT de matrícula migrante, de modo que el cupo escolar sustituya la lectura multicausal del texto.",
        ],
        "explanation": "La condición de calidad pide la idea principal del texto. El pasaje sostiene que los movimientos migratorios suelen combinar causas económicas con violencia, desastres naturales o persecución política, y que comprender esa multicausalidad evita simplismos y orienta políticas integrales. Tomar el empleo como explicación suficiente recorta una causa que el texto combina. Relegar violencia y desastres a factores ajenos niega esa combinación. Sustituir las causas por el registro SIMAT de matrícula migrante importa un cupo escolar que el fragmento no usa como idea central.",
        "normativeJustification": "El ítem lee la idea principal del fragmento sobre migración. Lo afirmado es la multicausalidad y su valor para evitar simplismos y diseñar políticas integrales, no la causa laboral como techo ni el SIMAT.",
        "theoreticalJustification": "La idea principal articula causas combinadas, rechazo del simplismo y políticas integrales. El empleo como explicación suficiente, el retiro de la violencia o el cupo SIMAT desplazan el objeto del pasaje.",
        "distractorAnalysis": {
            "0": "Trampa de la causa laboral suficiente: la búsqueda de empleo parece la explicación más citada. El texto la combina con violencia, desastres y persecución política, y niega que una causa baste.",
            "1": "Trampa de relegar violencia y desastres: tratarlos como ajenos parece reservar la migración a lo económico. El pasaje los nombra como motivos que suelen combinarse con las oportunidades laborales.",
            "3": "Trampa de dominio cruzado del SIMAT: reportar la matrícula migrante parece política pública escolar ordenada. El texto pide comprender causas combinadas, no sustituirlas por el registro de cupo.",
        },
    },
    {
        "id": "dir-apt-lec-312",
        "options": [
            "Para justificar el control de matrícula migrante en el SIMAT y el cierre de cupos, de modo que comprender las causas sirva a un filtro de ingreso y no al diseño de políticas públicas integrales.",
            "Para atribuir la responsabilidad de su situación a la propia población migrante, de modo que las causas combinadas queden como un cargo individual y no como base de política pública.",
            "Para reducir la migración a un problema económico de empleo, de modo que violencia, desastres naturales y persecución política queden fuera del diseño de las políticas públicas.",
            "Para evitar explicaciones simplistas sobre los procesos migratorios y para diseñar políticas públicas que respondan de manera integral a las distintas necesidades de la población migrante.",
        ],
        "explanation": "La condición de calidad pregunta para qué es importante comprender la multicausalidad de la migración. El texto lo sitúa en evitar explicaciones simplistas y en diseñar políticas públicas más integrales. Usarlo para controlar cupos en el SIMAT desplaza el propósito hacia un filtro de matrícula. Atribuir la situación a la propia población migrante invierte el diseño de política. Reducir el fenómeno a un problema económico omite violencia, desastres y persecución que el pasaje combina.",
        "normativeJustification": "El ítem pide el propósito que el texto asigna a comprender la multicausalidad: evitar simplismos y diseñar políticas integrales. No autoriza el filtro SIMAT, el cargo a la población migrante ni recortar a lo económico.",
        "theoreticalJustification": "La multicausalidad orienta lectura compleja y política integral. El control de cupos, la culpa individual o el recorte económico cambian el para qué de la pregunta.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del SIMAT: controlar matrícula y cerrar cupos parece gestión de ingreso escolar. El texto no justifica ese filtro; pide evitar simplismos y diseñar políticas más integrales.",
            "1": "Trampa de atribuir la situación a quienes migran: el cargo individual parece una lectura de responsabilidad. El pasaje orienta políticas públicas, no un reproche a la población migrante.",
            "2": "Trampa de recortar a lo económico: centrar el empleo parece usar la causa más visible. Omitir violencia, desastres y persecución es justo el simplismo que el texto pide evitar.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI, {}))
