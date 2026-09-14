# -*- coding: utf-8 -*-
"""Reescribe dir-apt-blan-143..152 (posiciones 891-900) y valida el lote."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_891_900.json"

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
    "acta genérica",
    "delegar el conflicto a familias",
    "familias o chats",
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
    "dir-apt-blan-143": 2,
    "dir-apt-blan-144": 3,
    "dir-apt-blan-145": 0,
    "dir-apt-blan-146": 1,
    "dir-apt-blan-147": 2,
    "dir-apt-blan-148": 3,
    "dir-apt-blan-149": 0,
    "dir-apt-blan-150": 1,
    "dir-apt-blan-151": 2,
    "dir-apt-blan-152": 3,
}

ITEMS = [
    {
        "id": "dir-apt-blan-143",
        "options": [
            "Mantener al docente titular en la aplicación del primer bloque de la prueba institucional y diferir el permiso por la emergencia familiar hasta el receso, para no romper el calendario del SIEE ni dejar el instrumento del grupo sin el aplicador previsto.",
            "Autorizar la salida del docente cuando termine de aplicar la prueba institucional a su grupo, pidiéndole que posponga la emergencia familiar hasta cerrar el bloque, de modo que el instrumento del día conserve al aplicador titular.",
            "Conceder de inmediato el permiso por la emergencia familiar y organizar, esa misma mañana, un reemplazo o la reprogramación de la prueba institucional del grupo, de modo que la contingencia humana no deje al titular desprotegido ni al curso sin evidencia.",
            "Suspender la prueba institucional del grado y sustituirla por una encuesta de percepción de clima para el tablero del PMI, argumentando que así se evita tensionar al equipo el día de la emergencia familiar y se recogen datos de bienestar.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando el docente solicita, la misma mañana, permiso por emergencia familiar el día de la prueba institucional. Conceder el permiso y organizar de inmediato un reemplazo o la reprogramación atiende la dignidad del titular y sostiene la evidencia del grupo, que es liderazgo equilibrado y no abandono del SIEE. Diferir el permiso al receso para proteger el calendario privilegia el instrumento sobre la urgencia humana. Autorizar la salida apenas termine de aplicar le pide posponer la emergencia familiar. Suspender la prueba del grado y sustituirla por una encuesta de percepción para el PMI cuida el clima del equipo y pierde el propósito evaluativo del día.",
        "normativeJustification": "El Decreto 1075 y la gestión de talento humano amparan el permiso por emergencia; el SIEE permite reprogramar evidencias. El PMI y una encuesta de clima no sustituyen la prueba institucional ni autorizan a posponer el cuidado del docente.",
        "theoreticalJustification": "El liderazgo ético prioriza la contingencia humana y resuelve operativamente la evidencia. Proteger el calendario, posponer la emergencia o cambiar la prueba por clima miden SIEE, dilación o PMI, no el cuidado pedido.",
        "distractorAnalysis": {
            "0": "Trampa de proteger el calendario del SIEE: diferir el permiso al receso y conservar al titular en el primer bloque parece rigor evaluativo. Privilegia el instrumento programado sobre la emergencia familiar y no es la conducta más defendible ética e institucionalmente.",
            "1": "Trampa de posponer la emergencia familiar: autorizar la salida cuando termine de aplicar parece un punto medio razonable. En la práctica le pide al docente aplazar el cuidado urgente para sostener la prueba institucional del grupo.",
            "3": "Trampa de dominio cruzado del PMI y el clima: suspender la prueba y recoger una encuesta de percepción luce como bienestar del equipo. Cambia el objeto del día y pierde la evidencia institucional que sí puede reprogramarse con reemplazo.",
        },
    },
    {
        "id": "dir-apt-blan-144",
        "options": [
            "Resolver el caso mixto del estudiante mediante una circular de rectoría que fije una medida única de convivencia, para unificar el criterio visible entre el coordinador académico y el de convivencia y cerrar la discrepancia con un acto de liderazgo.",
            "Pedir al consejo de padres que vote cuál coordinador —académico o de convivencia— lleva el caso del estudiante con dificultades académicas y disciplinarias, para dotar de legitimidad comunitaria la asignación y zanjar el desacuerdo de las dos coordinaciones.",
            "Asignar el caso del estudiante al coordinador con mayor antigüedad en la planta, archivar el otro informe como duplicidad administrativa y dar por resuelta la discrepancia entre académico y convivencia sin un análisis conjunto del caso mixto.",
            "Facilitar un espacio conjunto de análisis del caso entre el coordinador académico y el de convivencia, para construir una decisión integral y consensuada que articule las dificultades académicas y disciplinarias del estudiante.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando el coordinador académico y el de convivencia no logran acordar la medida para un estudiante con dificultades académicas y disciplinarias. Facilitar un espacio conjunto de análisis permite una decisión integral y consensuada sobre el caso mixto, que no se parte en dos expedientes. Resolver por circular de rectoría con una medida única de convivencia unifica el criterio visible y aplasta una de las dos dimensiones. Asignar el caso al de mayor antigüedad y archivar el otro informe sustituye el análisis por jerarquía de planta. Pedir al consejo de padres que vote cuál coordinador lleva el caso confunde legitimidad comunitaria con la conducción técnica que el rector debe ejercer.",
        "normativeJustification": "El Decreto 1075 y el gobierno escolar sitúan al rector como quien articula gestión académica y convivencia. El consejo de padres no asigna el caso mixto; una circular única o la antigüedad no reemplazan el análisis conjunto.",
        "theoreticalJustification": "Un caso con dimensión académica y de convivencia exige mirada integral. La circular de unificación, el voto de familias o la antigüedad de planta miden imagen, legitimidad o jerarquía, no consenso técnico.",
        "distractorAnalysis": {
            "0": "Trampa de la circular que unifica criterio: una medida única de convivencia parece liderazgo visible y cierra la discrepancia. Aplasta la dimensión académica del caso mixto y sustituye el análisis conjunto por un acto de rectoría.",
            "1": "Trampa de dominio cruzado del gobierno de familias: que el consejo de padres vote el coordinador responsable luce como legitimidad comunitaria impecable. Confunde participación del 1286 con la conducción técnica del caso mixto que el rector debe articular.",
            "2": "Trampa de la antigüedad como criterio: asignar el caso al coordinador más antiguo y archivar el otro informe parece orden de planta. Sustituye el análisis integral por jerarquía y deja una de las dos dimensiones del estudiante sin voz.",
        },
    },
    {
        "id": "dir-apt-blan-145",
        "options": [
            "Conversar en privado con el docente sobre el impacto institucional de la crítica publicada en sus redes sociales personales y orientarlo a los canales internos para expresar desacuerdos, sin responder en el hilo ni exponer el caso ante las familias que ya comentaron.",
            "Pedirle al docente un descargo en el mismo hilo de sus redes sociales personales, para transparentar ante los padres que ya comentaron la crítica a la decisión institucional y mostrar que rectoría no oculta el debate público.",
            "Abrir de inmediato un proceso disciplinario del Decreto 1278 y emitir una circular de uso de redes para la visita de calidad, sin diálogo previo con el docente, de modo que quede evidencia de control institucional sobre la crítica pública.",
            "Llevar el hilo de las redes sociales personales al consejo de padres para que las familias medien con el docente la crítica a la decisión institucional y el caso quede socializado como asunto de clima y de imagen comunitaria.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante la crítica del docente en redes personales y los comentarios de padres. Conversar en privado sobre el impacto institucional y orientar a los canales internos desescala, cuida la reserva laboral y abre una vía de disenso. Pedirle un descargo en el mismo hilo transparenta ante las familias y agrava la exposición pública. Llevar el hilo al consejo de padres para que medien convierte un asunto de ética profesional en veeduría familiar. Abrir de inmediato el Decreto 1278 y una circular de uso de redes para la visita de calidad documenta rigor y omite el diálogo que el caso pide primero.",
        "normativeJustification": "El Decreto 1075 y el artículo 15 de la Constitución amparan reserva y canales internos de disenso. El Decreto 1278 no se abre como primer gesto; el consejo de padres no media un conflicto laboral en redes.",
        "theoreticalJustification": "El diálogo privado reconduce el desacuerdo al canal institucional. El descargo en el hilo, la mediación familiar o el 1278 para la visita miden transparencia de imagen, gobierno de padres o expediente, no ética de liderazgo.",
        "distractorAnalysis": {
            "1": "Trampa del descargo en el hilo de redes: responder en el mismo espacio parece honestidad ante los padres que ya comentaron. Agrava la exposición pública de la crítica y sustituye el canal interno por un debate en redes personales.",
            "2": "Trampa de dominio cruzado del 1278 y la visita: abrir proceso y circular de redes luce impecable como control de calidad. Omite el diálogo privado previo y convierte un desacuerdo público en cargo disciplinario de primer paso.",
            "3": "Trampa de la mediación del consejo de padres: socializar el hilo con las familias parece clima y participación. Expone al docente, vulnera reserva laboral y desplaza un asunto ético-profesional a veeduría comunitaria.",
        },
    },
    {
        "id": "dir-apt-blan-146",
        "options": [
            "Programar una charla general de valores al grado sobre el respeto a la diferencia, sin activar la ruta de la Ley 1620 ni atender de forma diferenciada al estudiante en condición de discapacidad que recibió los comentarios discriminatorios de algunos compañeros.",
            "Activar la ruta de convivencia correspondiente, atender de inmediato al estudiante en condición de discapacidad que fue objeto de comentarios discriminatorios y desarrollar con el grupo procesos formativos de inclusión, con registro y seguimiento institucional.",
            "Separar al estudiante en condición de discapacidad del grupo «para protegerlo» de los comentarios discriminatorios y continuar el programa homogéneo del grado, argumentando que así se resguarda su bienestar y se evita tensionar al resto de compañeros.",
            "Bajar la exigencia del área y registrar en el SIEE un «ajuste de clima» para el estudiante en condición de discapacidad, sin elaborar PIAR ni activar la ruta de la Ley 1620, presentando esa medida como inclusión administrativa del Decreto 1421.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante en condición de discapacidad es objeto de comentarios discriminatorios de algunos compañeros. Activar la ruta de convivencia, atender al afectado y trabajar inclusión con el grupo articula la Ley 1620, el Decreto 1421 y la Guía 49. Una charla general de valores al grado simula prevención y deja sin ruta ni cuidado al estudiante afectado. Separarlo del grupo para protegerlo homogeneiza el programa y puede excluirlo. Bajar la exigencia del área y registrar un ajuste de clima en el SIEE parece inclusión del 1421 y omite el PIAR y la ruta 1620.",
        "normativeJustification": "La Ley 1620 y la Guía 49 exigen ruta de atención al afectado; el Decreto 1421 exige PIAR y ajustes razonables, no bajar la exigencia ni separar al estudiante. Una charla de valores no sustituye esa ruta.",
        "theoreticalJustification": "La inclusión combina cuidado al afectado y formación del grupo. La charla general, la separación protectora o el ajuste de clima en el SIEE miden prevención aparente, exclusión o evaluación, no la ruta pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la charla general de valores: hablar de respeto al grado parece prevención formativa. Deja sin ruta 1620 y sin atención diferenciada al estudiante en condición de discapacidad que ya recibió comentarios discriminatorios.",
            "2": "Trampa de separar para proteger: retirar al estudiante del grupo parece resguardo de bienestar. Homogeneiza el programa, puede excluirlo y no trabaja inclusión ni ruta con los compañeros que emitieron los comentarios.",
            "3": "Trampa de dominio cruzado del SIEE y el 1421: bajar la exigencia y registrar un ajuste de clima parece inclusión administrativa. Omite el PIAR y la ruta 1620, y trata la discriminación como un problema de nota, no de convivencia.",
        },
    },
    {
        "id": "dir-apt-blan-147",
        "options": [
            "Emitir una circular al equipo docente anunciando que el contrato del provisional no se renovará por razones presupuestales ajenas al desempeño, antes de reunirse con el afectado, para que la planta conozca el recorte con transparencia y nadie se entere por rumores.",
            "Pedir al coordinador que comunique la no renovación del provisional en la sala de docentes, para que el equipo se prepare a cubrir la carga y la noticia laboral difícil circule primero entre colegas y no en un espacio privado con el afectado.",
            "Reunirse en privado con el docente provisional, explicar con claridad y respeto que la no renovación obedece a razones presupuestales ajenas a su desempeño, y ofrecer la información pertinente sobre el proceso y los tiempos del contrato.",
            "Esperar a que venza el contrato del provisional sin adelantar la conversación sobre la no renovación presupuestal, argumentando que así se evita generar angustia en el clima laboral y se protege el ambiente del equipo hasta el último día.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente al comunicar al provisional que su contrato no se renovará por razones presupuestales ajenas al desempeño. Reunirse en privado, explicar con claridad y respeto e informar el proceso protege la dignidad y la reserva de una noticia laboral difícil. Circular el recorte al equipo antes de hablar con el afectado finge transparencia presupuestal y expone a la persona. Pedir al coordinador que lo anuncie en la sala de docentes prepara la planta y humilla. Esperar a que venza el contrato para no generar angustia cuida el clima aparente y niega el derecho a una conversación oportuna.",
        "normativeJustification": "El Decreto 1075 y la gestión de talento humano exigen comunicar con reserva y claridad una decisión de no renovación. La transparencia presupuestal no autoriza a circular el nombre del afectado ni a dilatar el diálogo hasta el vencimiento.",
        "theoreticalJustification": "La noticia laboral difícil se da en privado, con razones y proceso. La circular al equipo, el anuncio en sala o la espera por clima miden imagen, logística de planta o evitación, no respeto al provisional.",
        "distractorAnalysis": {
            "0": "Trampa de la circular de transparencia presupuestal: anunciar la no renovación al equipo antes de hablar con el afectado parece honestidad institucional. Expone al provisional, rompe reserva y trata una noticia laboral personal como recorte de planta.",
            "1": "Trampa del anuncio en la sala de docentes: que el coordinador informe al claustro parece preparación logística de la carga. Humilla al afectado y desplaza la conversación privada que la dignidad de la no renovación exige primero.",
            "3": "Trampa de dominio cruzado del clima que dilata: esperar el vencimiento para no generar angustia luce como cuidado del ambiente laboral. Niega información oportuna al provisional y convierte la prudencia de clima en silencio hasta el último día del contrato.",
        },
    },
    {
        "id": "dir-apt-blan-148",
        "options": [
            "Recibir en portería al grupo de padres reunidos a la entrada por el estado de la infraestructura y prometerles «obra este mes» sin soportes de las gestiones reales, para que perciban celeridad de rectoría y se dispersen de la puerta.",
            "Proponer en la puerta un recaudo extraordinario votado por las familias presentes, con cargo al Fondo de Servicios Educativos, para resolver ya el estado de la infraestructura y mostrar que rectoría actúa con recursos de la comunidad.",
            "Trasladar la inconformidad por infraestructura al personero estudiantil y cerrar el canal de rectoría con los padres de la entrada, argumentando que esa instancia del gobierno escolar debe formular la respuesta institucional al reclamo.",
            "Acercarse a escuchar las inquietudes de los padres reunidos a la entrada, explicar el estado real de las gestiones sobre la infraestructura y proponer un espacio formal de seguimiento, sin prometer obras que aún no tienen soporte.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un grupo de padres se reúne a la entrada por el estado de la infraestructura. Escuchar, explicar el estado real de las gestiones y proponer un espacio formal de seguimiento atiende el reclamo sin crear falsas expectativas de obra. Recibirlos en portería y prometer intervención este mes simula celeridad sin soportes. Trasladar la inconformidad al personero y cerrar el canal de rectoría confunde una instancia de participación estudiantil con quien debe gestionar. Proponer un recaudo extraordinario votado en la puerta parece solución ágil del Fondo de Servicios Educativos y elude el procedimiento formal de recursos.",
        "normativeJustification": "El Decreto 1075 y la Ley 715 reservan al rector informar gestiones reales y al FSE un recaudo con procedimiento, no una votación en portería. El personero no sustituye el canal de rectoría frente a infraestructura.",
        "theoreticalJustification": "La escucha con seguimiento formal desescala sin simular. La promesa de celeridad, el recaudo en la puerta o el traslado al personero miden imagen, tesorería improvisada o instancia cruzada.",
        "distractorAnalysis": {
            "0": "Trampa de la promesa de celeridad en portería: ofrecer «obra este mes» parece atención inmediata al grupo de la entrada. Crea una expectativa sin soportes de gestión y simula liderazgo de infraestructura que el seguimiento formal debe sostener con verdad.",
            "1": "Trampa de dominio cruzado del recaudo del FSE: votar un extraordinario en la puerta luce como solución financiera comunitaria. Elude el procedimiento del Fondo de Servicios Educativos y convierte un reclamo de infraestructura en captación improvisada.",
            "2": "Trampa de la instancia del personero: trasladar el reclamo y cerrar rectoría parece respeto al gobierno escolar. El personero representa estudiantes; no formula la respuesta de infraestructura ni sustituye el canal del rector con las familias de la entrada.",
        },
    },
    {
        "id": "dir-apt-blan-149",
        "options": [
            "Mantener criterios claros y conocidos por el claustro para los reconocimientos institucionales, y explicarlos abiertamente cuando algunos colegas perciban favoritismo hacia el docente distinguido por el logro obtenido con sus estudiantes.",
            "Retirar el reconocimiento público ya concedido al docente por el logro con sus estudiantes, para igualar el clima del equipo y calmar a los colegas que expresaron percepción de favoritismo, dejando el mérito del trabajo con el grupo sin visibilidad institucional.",
            "Publicar en la cartelera institucional un ranking de logros de todos los docentes, para demostrar meritocracia ante quienes perciben favoritismo y dejar evidencia visible de que el reconocimiento público responde a resultados comparables.",
            "Pedir al consejo de padres que vote quién merece el reconocimiento público por el logro con estudiantes, de modo que la percepción de favoritismo entre colegas quede zanjada con legitimidad comunitaria y no con criterio de rectoría.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando, al conceder un reconocimiento público por un logro con estudiantes, algunos colegas perciben favoritismo. Mantener criterios claros y conocidos y explicarlos abiertamente responde a la percepción sin retirar el mérito ni convertir el premio en plebiscito. Retirar el reconocimiento para igualar el clima calma al equipo y niega el logro ya concedido. Pedir al consejo de padres que vote quién merece el distintivo desplaza un criterio institucional a legitimidad comunitaria. Publicar un ranking de logros en cartelera parece meritocracia visible y convierte el reconocimiento en comparativo de imagen.",
        "normativeJustification": "La Guía 34 y el Decreto 1075 respaldan reconocimientos con criterios públicos y conocidos. El consejo de padres no elige al distinguido; un ranking en cartelera no sana la percepción ni autoriza a retirar el mérito.",
        "theoreticalJustification": "La transparencia de criterios responde al favoritismo percibido. Retirar el premio, ranquear al claustro o plebiscitar con familias miden clima, imagen o legitimidad comunitaria, no equidad de reconocimiento.",
        "distractorAnalysis": {
            "1": "Trampa de retirar el reconocimiento para igualar: quitar el distintivo al docente parece cuidado del clima y de los colegas. Niega el logro con los estudiantes y enseña que la percepción de favoritismo anula un criterio institucional ya aplicado.",
            "2": "Trampa de dominio cruzado del ranking de imagen: publicar logros en cartelera parece meritocracia comparable y evidencia para la visita. Convierte el reconocimiento en comparativo público y no explica los criterios; cuida imagen, no equidad.",
            "3": "Trampa del voto del consejo de padres: que las familias elijan al distinguido parece legitimidad y cierra el reclamo de los colegas. Desplaza un criterio de rectoría y de gestión humana a un órgano de participación que no otorga reconocimientos docentes.",
        },
    },
    {
        "id": "dir-apt-blan-150",
        "options": [
            "Dejar la escucha pedagógica en el docente titular que recibió el relato, registrar una nota en el observador del estudiante y reevaluar la semana siguiente si la manifestación persiste, para no sobredimensionar un comentario de aula ni activar alarmas prematuras.",
            "Activar de inmediato la ruta institucional de atención en salud mental, contactar a la familia y a los profesionales de apoyo psicosocial disponibles, y sostener el cuidado sin minimizar lo que el estudiante manifestó al docente.",
            "Citar al cierre de la semana al Comité Escolar de Convivencia para documentar entonces lo relatado al docente, argumentando que conviene no alarmar a la familia ni al equipo psicosocial mientras el estudiante sigue en clase con aparente normalidad.",
            "Tratar lo relatado al docente como una falta al manual de convivencia y abrir un proceso Tipo II de la Ley 1620, para dejar evidencia de cuidado institucional y trazabilidad de ruta ante una posible visita de calidad.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un docente informa que un estudiante manifestó riesgo para su vida. Activar de inmediato la ruta de salud mental, contactar a la familia y al apoyo psicosocial es el cuidado proporcional, sin minimizar ni dilatar. Dejar la escucha pedagógica en el titular, anotar el observador y reevaluar la semana siguiente si persiste trata un riesgo vital como seguimiento de aula. Citar a convivencia al cierre de la semana para no alarmar pospone la ruta y la familia. Abrir un proceso Tipo II de la Ley 1620 deja evidencia de rigor y trata el riesgo como falta al manual.",
        "normativeJustification": "La Ley 1620, la Guía 49 y los lineamientos de salud mental escolar exigen activar de inmediato ruta, familia y apoyo psicosocial. El observador, la cita semanal o un Tipo II no sustituyen esa atención ni convierten el relato en falta.",
        "theoreticalJustification": "El riesgo vital se aborda con ruta inmediata, no con contención de aula ni con expediente de convivencia. Minimizar, diferir para no alarmar o tipificar como Tipo II miden prudencia aparente o rigor documental, no cuidado.",
        "distractorAnalysis": {
            "0": "Trampa de la escucha pedagógica diferida: dejar el relato en el titular, anotar el observador y reevaluar la semana siguiente parece prudencia de no sobredimensionar. Minimiza un riesgo vital y dilata familia, psicosocial y ruta de salud mental.",
            "2": "Trampa de no alarmar hasta el cierre de la semana: citar entonces a convivencia parece cuidado del clima y de la familia. Pospone la activación inmediata y trata el relato al docente como un tema que puede esperar documentación.",
            "3": "Trampa de dominio cruzado del Tipo II de la 1620: abrir proceso por falta al manual luce como protocolo de cuidado y evidencia para la visita. Judicializa un riesgo de salud mental y desplaza la ruta de atención hacia un expediente punitivo.",
        },
    },
    {
        "id": "dir-apt-blan-151",
        "options": [
            "Dejar constancia de un «seguimiento posterior» en el acta de rectoría sobre la inquietud de conflicto de interés en las cotizaciones, sin pedir aún los soportes de la compra institucional, para no adelantar juicios mientras no haya pruebas contundentes.",
            "Publicar las cotizaciones de la compra institucional en la cartelera y en el grupo de padres, para que la veeduría comunitaria examine el posible conflicto de interés del docente encargado y la transparencia sustituya la reserva del proceso.",
            "Revisar con objetividad el proceso de cotizaciones de la compra institucional, solicitar los soportes documentales correspondientes y reasignar la responsabilidad del docente mientras se aclara la inquietud de conflicto de interés, aún sin pruebas contundentes.",
            "Dejar la compra institucional a cargo del docente con una declaración verbal de imparcialidad, para no retrasar el contrato ni el cronograma de adquisición, y archivar la inquietud de conflicto de interés hasta que aparezcan pruebas contundentes.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante una inquietud, aún sin pruebas contundentes, de conflicto de interés del docente que recibe cotizaciones de una compra institucional. Revisar el proceso con objetividad, solicitar soportes y reasignar la responsabilidad mientras se aclara es preventivo y proporcional. Dejar constancia de seguimiento posterior en el acta sin pedir soportes simula trazabilidad y no verifica. Dejar la compra al docente con una declaración verbal de imparcialidad privilegia el cronograma del contrato. Publicar las cotizaciones en cartelera y en el grupo de padres parece veeduría ciudadana y rompe la reserva del proceso de adquisición.",
        "normativeJustification": "La contratación pública y el Decreto 1075 exigen objetividad, soportes y prevención del conflicto de interés, incluso sin pruebas contundentes. El acta dilatoria, la declaración verbal o la veeduría en cartelera no cumplen ese estándar.",
        "theoreticalJustification": "La prevención proporcional verifica y reasigna mientras se aclara. El seguimiento en acta, la imparcialidad verbal o la publicación a familias miden formalismo, celeridad o transparencia de imagen, no integridad de la compra.",
        "distractorAnalysis": {
            "0": "Trampa del seguimiento posterior en acta: dejar constancia sin pedir soportes parece prudencia de no juzgar sin pruebas. Simula trazabilidad y deja intacto el proceso de cotizaciones del docente encargado de la compra institucional.",
            "1": "Trampa de dominio cruzado de la veeduría comunitaria: publicar cotizaciones en cartelera y en el grupo de padres luce como transparencia impecable. Rompe la reserva del proceso de adquisición y sustituye la verificación objetiva por escrutinio familiar.",
            "3": "Trampa de la declaración verbal de imparcialidad: dejar la compra al docente para no retrasar el contrato parece continuidad del servicio. Archiva la inquietud y confía en una promesa oral lo que exige soportes y, de ser preciso, reasignación preventiva.",
        },
    },
    {
        "id": "dir-apt-blan-152",
        "options": [
            "Cerrar de inmediato la reunión de retroalimentación y dejar constancia de «resistencia al proceso» en la carpeta de evaluación del Decreto 1278, para que la reacción defensiva del docente quede documentada ante una eventual visita de supervisión.",
            "Retirar o suavizar el puntaje de la evaluación de desempeño para preservar el clima laboral, argumentando que sostener la calificación frente a la reacción defensiva del docente tensionaría al equipo y al proceso del Decreto 1278.",
            "Convocar al área para que los colegas validen en grupo el puntaje de la evaluación de desempeño, buscando un consenso que respalde al coordinador y reduzca la defensa del docente, con lo cual la carpeta del Decreto 1278 quedaría expuesta al claustro.",
            "Escuchar el punto de vista del docente que cuestiona la validez del proceso, explicar con claridad los criterios y las evidencias utilizados en la evaluación de desempeño, y mantener la conversación en un tono respetuoso y profesional.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando el docente reacciona de forma defensiva y cuestiona la validez de la evaluación de desempeño. Escuchar su punto de vista, explicar criterios y evidencias y sostener un tono profesional convierte la defensa en diálogo formativo del Decreto 1278. Cerrar la reunión y anotar resistencia en la carpeta convierte la emoción en cargo anticipado. Suavizar o retirar el puntaje para preservar el clima es paternalismo que vacía el juicio. Convocar al área para que valide el puntaje en grupo busca consenso y rompe la reserva de la evaluación.",
        "normativeJustification": "El Decreto 1278 concibe la evaluación anual como formativa: criterios, evidencias y diálogo. No autoriza a archivar «resistencia», a alterar el puntaje por clima ni a validar en grupo un juicio reservado.",
        "theoreticalJustification": "La retroalimentación profesional sostiene el juicio y oye la defensa. Cerrar con cargo, suavizar por clima o consensuar con el área miden expediente, paternalismo o ruptura de reserva, no el 1278 formativo.",
        "distractorAnalysis": {
            "0": "Trampa de documentar resistencia en la carpeta 1278: cerrar la reunión y anotar la reacción defensiva parece trazabilidad para la visita. Convierte la emoción del docente en cargo y omite explicar criterios y evidencias en tono profesional.",
            "1": "Trampa del puntaje suavizado por clima: retirar o bajar la calificación parece cuidado del ambiente laboral. Vacía el juicio de desempeño y enseña que la defensa del docente modifica el resultado del Decreto 1278.",
            "2": "Trampa de dominio cruzado del consenso del área: que los colegas validen el puntaje en grupo luce como legitimidad pedagógica. Rompe la reserva de la evaluación de desempeño y expone la carpeta 1278 al claustro.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {k: it[k] for k in ("id", "options", "explanation", "normativeJustification", "theoreticalJustification", "distractorAnalysis")}


def validate(items: list) -> list[str]:
    errors: list[str] = []
    opt_norm = {}
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
            key = re.sub(r"\s+", " ", (opt or "").strip().lower())[:90]
            opt_norm.setdefault(key, []).append((tag, oi))
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
        if n_sent < 4 or n_sent > 7:
            errors.append(f"SENTENCES {tag} {n_sent}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")
        n_cross = sum(1 for v in da.values() if "dominio cruzado" in v.lower())
        if n_cross != 1:
            errors.append(f"CROSS DOMAIN {tag} {n_cross}")
    for k, locs in opt_norm.items():
        if len(locs) > 1:
            errors.append(f"DUP PREFIX {locs} {k[:80]}")
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
