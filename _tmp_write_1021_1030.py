# -*- coding: utf-8 -*-
"""Reescribe dir-apt-dis-273..280 y dir-apt-ped-281..282 (posiciones 1021-1030)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1021_1030.json"
CI = {
    "dir-apt-dis-273": 0,
    "dir-apt-dis-274": 1,
    "dir-apt-dis-275": 2,
    "dir-apt-dis-276": 3,
    "dir-apt-dis-277": 0,
    "dir-apt-dis-278": 1,
    "dir-apt-dis-279": 2,
    "dir-apt-dis-280": 3,
    "dir-apt-ped-281": 0,
    "dir-apt-ped-282": 1,
}

ITEMS = [
    {
        "id": "dir-apt-dis-273",
        "options": [
            "Orientar el intestino delgado como principal sitio de absorción de nutrientes y reenseñar que el estómago principalmente digiere, y que el intestino grueso absorbe sobre todo agua, no «todo lo que queda».",
            "Orientar el estómago porque «moler» ya sería absorber, y aceptar esa lectura del esquema del tubo digestivo como función esencial de nutrientes.",
            "Orientar el esófago porque «baja el alimento», de modo que el tránsito se tome como absorción en la socialización del esquema.",
            "Orientar el intestino grueso como absorción de nutrientes por ser «más largo en el dibujo», y reportarlo como evidencia comparable de tubo digestivo en el SIEE.",
        ],
        "explanation": "La condición de calidad pide qué órgano orientar como aprendizaje esencial de absorción y qué error reenseñar. El intestino delgado absorbe lo esencial de los nutrientes. El estómago digiere. El esófago conduce. El intestino grueso absorbe sobre todo agua; su longitud en el dibujo no lo convierte en sitio de nutrientes ni en evidencia del SIEE.",
        "normativeJustification": "Los DBA de ciencias del cuerpo humano distinguen digestión, tránsito y absorción por órgano. El SIEE no homologa el intestino grueso ni el estómago como sitio principal de nutrientes.",
        "theoreticalJustification": "La absorción de nutrientes ocurre sobre todo en el intestino delgado. Triturar, bajar el bolo o medir el dibujo son otras funciones o sesgos perceptivos.",
        "distractorAnalysis": {
            "1": "Trampa de moler como absorber: el estómago parece el órgano «que trabaja». Confunde digestión mecánica y química con absorción de nutrientes.",
            "2": "Trampa del tránsito: el esófago parece esencial porque el alimento baja. Conduce el bolo y no es el sitio de absorción pedido.",
            "3": "Trampa de dominio cruzado del SIEE: el intestino grueso «más largo en el dibujo» luce como evidencia comparable. Absorbe sobre todo agua y no es el aprendizaje esencial de nutrientes.",
        },
    },
    {
        "id": "dir-apt-dis-274",
        "options": [
            "Validar el carbón como renovable porque es un recurso natural que «sale de la tierra», y aceptar esa clasificación del equipo en la rúbrica de energías.",
            "Validar la energía solar como renovable y reenseñar que carbón, petróleo y gas no se reponen a escala de tiempos humanos, pese a su origen terrestre u orgánico.",
            "Validar el petróleo como renovable por su origen orgánico, de modo que «venir de seres vivos» baste como criterio de reposición en el cuaderno.",
            "Validar el gas natural como renovable por emitirse «más limpio» y reportarlo como evidencia comparable de sostenibilidad en el SIEE o el PRAE.",
        ],
        "explanation": "La condición de calidad pide qué clasificación orientar como aprendizaje esencial y qué error conceptual reenseñar. Solar es renovable a escala humana. Carbón, petróleo y gas son fósiles no renovables. «Salir de la tierra» o el origen orgánico no definen reposición. «Más limpio» es un criterio ambiental distinto, útil al PRAE, no al de renovable.",
        "normativeJustification": "Los DBA de ciencias de la Tierra piden el criterio de reposición en tiempos humanos. El PRAE y el SIEE no pueden homologar el gas «limpio» como renovable.",
        "theoreticalJustification": "Renovable se reponen en escala humana. Los fósiles no. Origen natural, orgánico o menor emisión son otros ejes de clasificación.",
        "distractorAnalysis": {
            "0": "Trampa del recurso natural: el carbón parece renovable porque sale de la tierra. El criterio pedido es la reposición, no el origen geológico.",
            "2": "Trampa del origen orgánico: el petróleo parece renovable porque «vino de seres vivos». Esa historia geológica no ocurre a escala humana.",
            "3": "Trampa de dominio cruzado del PRAE/SIEE: el gas «más limpio» luce como evidencia de sostenibilidad. Es un criterio de emisiones, no de reposición a escala humana.",
        },
    },
    {
        "id": "dir-apt-dis-275",
        "options": [
            "Validar a los carnívoros (el zorro) como productores porque «producen energía al cazar» o «producen crías», leyendo el verbo cotidiano sobre la cadena pasto–conejo–zorro.",
            "Validar a los descomponedores como productores porque «producen tierra», y tomar ese rol de suelo como la base trófica de la cadena del caso.",
            "Validar a las plantas como productoras por la fotosíntesis y reenseñar que «productor» no significa quien cría, quien caza ni quien come a los productores.",
            "Validar a los consumidores primarios (el conejo) como productores porque «comen productores», y reportarlo como evidencia comparable de cadena en el SIEE.",
        ],
        "explanation": "La condición de calidad pide qué rol evidencia el concepto de productor y qué error reenseñar. Las plantas elaboran alimento por fotosíntesis y son la base de pasto–conejo–zorro. El zorro es consumidor. Los descomponedores reciclan materia. El conejo es consumidor primario. La rúbrica pide rol trófico, no la palabra «producir» en sentido cotidiano ni una evidencia del SIEE.",
        "normativeJustification": "Los DBA de ecosistemas distinguen productores, consumidores y descomponedores. El SIEE no homologa al conejo ni al zorro como productores por el verbo «producir».",
        "theoreticalJustification": "Productor es quien elabora materia orgánica a partir de energía lumínica. Cazar, criar, hacer tierra o comer plantas son otros roles.",
        "distractorAnalysis": {
            "0": "Trampa del verbo cotidiano: el zorro «produce» crías o energía al cazar. Es consumidor y no la base fotosintética de la cadena.",
            "1": "Trampa de producir tierra: los descomponedores parecen la base porque «hacen suelo». Reciclan; no sustituyen a las plantas como productoras.",
            "3": "Trampa de dominio cruzado del SIEE: etiquetar al conejo como productor porque come productores luce como evidencia de cadena. Invierte el rol trófico y no es la planta del caso.",
        },
    },
    {
        "id": "dir-apt-dis-276",
        "options": [
            "Validar Medellín como capital por su peso industrial y económico, y aceptar esa «capital» simbólica regional como respuesta del mapa en la socialización.",
            "Validar Cali como capital por ser referente del Pacífico, de modo que la fachada occidental quede representada como sede político-administrativa del país.",
            "Validar Cartagena como capital por sus hitos coloniales, argumentando que la historia urbana equivale a capital de la República en el eje del taller.",
            "Validar Bogotá como capital de la República y reenseñar que el prestigio industrial, del Pacífico o colonial no sustituye el criterio constitucional de sede político-administrativa.",
        ],
        "explanation": "La condición de calidad pide qué identificación evidencia el aprendizaje esencial y qué error reenseñar. Bogotá es la capital político-administrativa. Medellín, Cali y Cartagena son referentes regionales, económicos o históricos, no la capital del Estado. El mapa pide el criterio constitucional, no el prestigio.",
        "normativeJustification": "La Constitución sitúa en Bogotá la sede de los poderes públicos nacionales. El SIEE no puede homologar «capitales» simbólicas regionales como capital de la República.",
        "theoreticalJustification": "Capital política no es capital económica ni histórica. El prestigio de una ciudad no cambia el criterio constitucional.",
        "distractorAnalysis": {
            "0": "Trampa del peso económico: Medellín parece capital porque es industrial. Confunde centralidad productiva con sede del Estado.",
            "1": "Trampa del referente del Pacífico: Cali parece representar una fachada del país. No es la capital político-administrativa.",
            "2": "Trampa de dominio cruzado de la historia urbana: Cartagena luce como evidencia colonial comparable. El hito histórico no la convierte en capital de la República.",
        },
    },
    {
        "id": "dir-apt-dis-277",
        "options": [
            "Identificar el océano Pacífico como el que baña la región Pacífica y reenseñar que el Caribe o el Atlántico corresponden a otra fachada, no a ese litoral occidental.",
            "Unificar Pacífico y Caribe/Atlántico en un mismo mar, porque «Colombia tiene mar al norte y eso es lo mismo», y aceptar esa lectura en el mapa de regiones.",
            "Identificar el Mar Caribe como «el mar de Colombia» en el lenguaje cotidiano, y situar allí la región Pacífica por ser el litoral más nombrado en clase.",
            "Identificar el Índico porque también es océano y «queda al otro lado», y reportarlo como evidencia comparable de océanos en el SIEE de geografía.",
        ],
        "explanation": "La condición de calidad pide qué océano corresponde a la región Pacífica y qué confusión reenseñar. El litoral occidental colombiano da al Pacífico. El Caribe/Atlántico es otra fachada. Unificarlos «porque hay mar al norte» borra regiones. El Índico no baña a Colombia; reportarlo en el SIEE es un océano verdadero en otro continente, no el del caso.",
        "normativeJustification": "Los DBA de geografía de Colombia distinguen fachada Pacífica y Caribe. El SIEE no homologa el Índico ni un mar único nacional.",
        "theoreticalJustification": "La región se nombra por el océano que la baña. El Caribe no es el Pacífico. Un océano lejano no sustituye el mapa del país.",
        "distractorAnalysis": {
            "1": "Trampa de unificar litorales: un mismo mar parece simplificar «Colombia tiene mar». Borra la región Pacífica y la fachada Caribe/Atlántica.",
            "2": "Trampa del mar cotidiano: el Caribe parece «el mar de Colombia». Sitúa mal la región Pacífica en la fachada norte.",
            "3": "Trampa de dominio cruzado del SIEE: el Índico es un océano verdadero y luce como evidencia de océanos. No baña la región Pacífica colombiana.",
        },
    },
    {
        "id": "dir-apt-dis-278",
        "options": [
            "Validar 1986 por cercanía a la Regeneración o a la carta de 1886, y aceptar esa década como vigencia actual en el eje cronológico del taller.",
            "Validar 1991 como año de promulgación de la Constitución vigente, con la Asamblea Nacional Constituyente, y reenseñar que 1886 no es la carta actual ni 1994 el año de promulgación.",
            "Validar 1994 confundiendo el primer gobierno de esa carta con la promulgación, de modo que el calendario político sustituya el año constituyente.",
            "Validar 1998 por un hito electoral posterior y reportarlo como evidencia comparable de «Constitución reciente» en el SIEE de sociales.",
        ],
        "explanation": "La condición de calidad pide qué datación evidencia el aprendizaje esencial y qué error reenseñar. La Constitución vigente se promulgó en 1991. 1886 rigió antes. 1986 es cercanía engañosa. 1994 confunde primer gobierno con promulgación. 1998 es un hito posterior útil a un eje electoral del SIEE, no al año de la carta.",
        "normativeJustification": "El aprendizaje constitucional de básicas sitúa 1991 como promulgación vigente. El SIEE no puede homologar 1998 ni 1986 como año de esa carta.",
        "theoreticalJustification": "Promulgación no es primer gobierno ni hito electoral posterior. La duración de 1886 no la deja vigente.",
        "distractorAnalysis": {
            "0": "Trampa de la carta larga: 1986 o 1886 parecen «la Constitución que duró». No son el año de la vigente.",
            "2": "Trampa del primer gobierno: 1994 parece el arranque político de la carta. Confunde mandato presidencial con promulgación de 1991.",
            "3": "Trampa de dominio cruzado del SIEE: 1998 luce como hito electoral comparable de «Constitución reciente». No es el año de promulgación vigente.",
        },
    },
    {
        "id": "dir-apt-dis-279",
        "options": [
            "Asignar al Congreso administrar justicia penal, confundiendo la función legislativa con la de jueces y tribunales en el esquema de ramas del poder.",
            "Asignar al Congreso dirigir las Fuerzas Militares, confundiendo la función legislativa con el mando que corresponde al Ejecutivo.",
            "Orientar que al Congreso le corresponde hacer, reformar y derogar leyes, y reenseñar que no administra justicia ni dirige la fuerza pública ni nombra gobernadores.",
            "Asignar al Congreso nombrar gobernadores, como si sustituyera la elección territorial, y reportarlo como evidencia comparable de control político en el SIEE.",
        ],
        "explanation": "La condición de calidad pide qué función del Congreso orientar como aprendizaje esencial y qué error reenseñar. La función legislativa es hacer, reformar y derogar leyes. Administrar justicia es de la rama judicial. El mando militar es del Ejecutivo. Nombrar gobernadores no es su función principal ni una evidencia de control en el SIEE. El caso pide no mezclar ramas.",
        "normativeJustification": "La Constitución separa ramas: Congreso legisla; jueces administran justicia; el Ejecutivo conduce la fuerza pública. El SIEE no homologa el nombramiento de gobernadores como función esencial del Congreso.",
        "theoreticalJustification": "Separación de poderes distingue legislar, juzgar y ejecutar. Trasladar justicia, mando militar o nombramientos territoriales al Congreso mezcla ramas.",
        "distractorAnalysis": {
            "0": "Trampa de administrar justicia: el Congreso parece «el que pone orden». Esa función es de la rama judicial, no la legislativa del caso.",
            "1": "Trampa del mando militar: dirigir las Fuerzas Militares parece poder nacional. Corresponde al Ejecutivo, no al Congreso.",
            "3": "Trampa de dominio cruzado del SIEE: nombrar gobernadores luce como control político comparable. No es la función legislativa esencial y confunde elección territorial con el Congreso.",
        },
    },
    {
        "id": "dir-apt-dis-280",
        "options": [
            "Usar el mapa político como línea del tiempo porque «también tiene fechas en la leyenda», y aceptar esa herramienta espacial como eje de hitos históricos.",
            "Usar el cronómetro que mide segundos de un acto cívico como herramienta de cronología, porque registra tiempo y cierra el taller de hitos con un instrumento preciso.",
            "Usar la tabla comparativa de PIB por país porque «ordena datos», y tomarla como organización del tiempo histórico en el eje del caso.",
            "Usar la representación gráfica cronológica de hechos (línea del tiempo) y reenseñar que el mapa político y la tabla estadística no sustituyen el eje temporal.",
        ],
        "explanation": "La condición de calidad pide qué herramienta evidencia el aprendizaje esencial de cronología y qué confusión reenseñar. La línea del tiempo organiza hechos en el tiempo. El mapa representa el espacio, aunque la leyenda traiga una fecha. El cronómetro mide duración de un acto, no hitos históricos. La tabla de PIB ordena magnitudes, no el eje temporal. Espacio y estadística no sustituyen cronología.",
        "normativeJustification": "Los DBA de pensamiento temporal piden representar secuencias históricas. El SIEE no homologa el mapa, el cronómetro o el PIB como línea del tiempo.",
        "theoreticalJustification": "Cronología ordena eventos en el tiempo. El mapa es espacial; el cronómetro es duración puntual; la tabla es comparación de magnitudes.",
        "distractorAnalysis": {
            "0": "Trampa de las fechas en la leyenda: el mapa político parece cronológico porque trae un año. Organiza el espacio, no la secuencia de hitos.",
            "1": "Trampa del tiempo medido: el cronómetro parece la herramienta del tiempo. Mide segundos de un acto cívico, no el orden histórico pedido.",
            "2": "Trampa de dominio cruzado de la estadística: la tabla de PIB ordena datos y luce como evidencia comparable. No es el eje temporal de los hitos del caso.",
        },
    },
    {
        "id": "dir-apt-ped-281",
        "options": [
            "Caracterizar las operaciones concretas (aprox. 7-11 años) como la posibilidad de operar con lógica sobre objetos y situaciones concretas, aún con dificultad para el pensamiento abstracto pleno, propio de la etapa siguiente.",
            "Caracterizar esa etapa como pensamiento con símbolos abstractos y sin referente concreto, y organizar 4° con tareas formales desancladas, como si el grupo ya consolidara la etapa de operaciones formales.",
            "Caracterizarla como egocentrismo de no distinguir el propio punto de vista del de los demás, propio de la etapa preoperacional, y planear 4° como si los 9 años no descentraran aún.",
            "Caracterizarla como dependencia de reflejos y acciones sensoriomotoras sobre el entorno, y reportar circuitos corporales como evidencia comparable de «operaciones» en el SIEE de 4°.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente la etapa de operaciones concretas (aprox. 7-11 años) según Piaget. A esa edad se razona sobre lo concreto; lo abstracto pleno se consolida después. El caso de 4° (9 años) lo recuerda. Pensar sin referente concreto es operaciones formales. El egocentrismo es preoperacional. Los reflejos son sensoriomotores; reportarlos en el SIEE de 4° cruza evaluación con otra etapa.",
        "normativeJustification": "Piaget y los DBA de desarrollo piden alinear la tarea al estadio. El SIEE de 4° no convierte circuitos sensoriomotores ni símbolos sin referente en evidencia de operaciones concretas.",
        "theoreticalJustification": "Operaciones concretas = lógica sobre lo manipulable. Formales = abstracto. Preoperacional = egocentrismo. Sensoriomotor = acción directa. Confundir estadios cambia el objeto de 4°.",
        "distractorAnalysis": {
            "1": "Trampa de las operaciones formales: símbolos sin referente concreto parecen «más rigurosos» para 4°. Adelantan un estadio y contradicen el recuerdo de Piaget en el caso.",
            "2": "Trampa del egocentrismo: atribuir a 9 años la indistinción de puntos de vista parece cuidado del desarrollo. Esa marca es preoperacional, no de operaciones concretas.",
            "3": "Trampa de dominio cruzado del SIEE: circuitos sensoriomotores como evidencia de operaciones lucen comparables y activos. Pertenecen a otra etapa y no caracterizan las operaciones concretas de 7-11 años.",
        },
    },
    {
        "id": "dir-apt-ped-282",
        "options": [
            "Caracterizar el descubrimiento de Bruner como entregar la conclusión ya armada y la información organizada, sin exploración, para ahorrar tiempo de clase y garantizar que 4° reciba el principio correcto.",
            "Caracterizarlo como exploración activa del estudiante que construye conclusiones con guía del docente, no como recepción de la conclusión ya armada ni como examen sorpresa o trámite de caritas.",
            "Sustituir la exploración por una autoevaluación de caritas al cierre, de modo que «descubrir» quede como percepción de logro sin contrastar lo construido con el principio de la clase.",
            "Unificar la evidencia en un examen acumulativo sorpresa y reportarlo como descubrimiento comparable en el SIEE, argumentando que el reto inesperado equivale a construir el principio.",
        ],
        "explanation": "La condición de calidad pregunta qué caracteriza principalmente al aprendizaje por descubrimiento de Bruner. El estudiante explora y construye conclusiones con guía; el docente no entrega el principio ya elaborado. El caso contrapone la conclusión armada. Las caritas no contrastan lo descubierto. El examen sorpresa del SIEE es evaluación acumulativa, no descubrimiento guiado.",
        "normativeJustification": "Bruner y la mediación docente piden estructura de la exploración. El SIEE no convierte el examen sorpresa en descubrimiento; las caritas no sustituyen la construcción del principio.",
        "theoreticalJustification": "Descubrir es elaborar con andamiaje, no recibir el producto ni simular logro. La conclusión armada, las caritas o el examen sorpresa cambian el objeto: de construcción a entrega, a trámite o a prueba.",
        "distractorAnalysis": {
            "0": "Trampa de la conclusión armada: entregar la información ya organizada parece garantizar el principio correcto. Es lo que el caso rechaza: no hay exploración ni construcción.",
            "2": "Trampa de las caritas: la autoevaluación percibida parece cierre de descubrimiento. No contrasta lo explorado con el principio y deja el aprendizaje como trámite de logro.",
            "3": "Trampa de dominio cruzado del SIEE: el examen acumulativo sorpresa luce como reto y evidencia comparable. Evalúa de golpe; no es la exploración guiada que Bruner pide.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI, {}))
