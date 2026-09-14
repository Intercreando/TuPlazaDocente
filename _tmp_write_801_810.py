# -*- coding: utf-8 -*-
"""Reescribe dir-apt-blan-53..60 y dir-apt-ges-61..62 (posiciones 801-810)."""
import json
import re
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_801_810.json"
SRC = ROOT / "_tmp_in_801_810.json"

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
    "chats de familias",
)

CI = {
    "dir-apt-blan-53": 1,
    "dir-apt-blan-54": 1,
    "dir-apt-blan-55": 1,
    "dir-apt-blan-56": 1,
    "dir-apt-blan-57": 1,
    "dir-apt-blan-58": 1,
    "dir-apt-blan-59": 1,
    "dir-apt-blan-60": 1,
    "dir-apt-ges-61": 0,
    "dir-apt-ges-62": 1,
}

ITEMS = [
    {
        "id": "dir-apt-blan-53",
        "options": [
            "Adjudicar en el Consejo Directivo la inversión a la mejora de conectividad a internet, porque ya figura como meta TIC del PMI, y reportar ese avance de calidad, dejando la cubierta del patio con filtraciones como rubro residual.",
            "Priorizar en el Consejo Directivo la reparación de la cubierta del patio con filtraciones, por el riesgo inminente en época de lluvias sobre la comunidad, y programar la conectividad a internet para la siguiente vigencia presupuestal.",
            "Repartir el presupuesto a mitades entre la conectividad a internet y la cubierta del patio con filtraciones, presentando ese 50-50 como equidad entre proyectos del PMI, sin ponderar cuál inversión atiende el riesgo de lluvias.",
            "Dejar en suspenso las dos inversiones del Consejo Directivo hasta que la Secretaría de Educación emita una circular que fije el orden entre conectividad y cubierta, y no decidir mientras no llegue ese acto territorial.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente en el conflicto de inversión del Consejo Directivo. Priorizar la cubierta del patio con filtraciones atiende un riesgo inminente para la comunidad en época de lluvias y deja la conectividad para la siguiente vigencia: es proporcionalidad y deber de cuidado, no desinterés por las TIC. El Decreto 1075 y la gestión del riesgo escolar obligan a proteger la integridad antes de un indicador de conectividad. Elegir internet porque está en la meta TIC del PMI es gestión de calidad impecable y no pondera el peligro de la cubierta. Partir el presupuesto por mitades finge equidad entre proyectos y evacua el análisis de urgencia. Esperar una circular de Secretaría dilata una decisión que el gobierno escolar ya puede y debe tomar.",
        "normativeJustification": "El Decreto 1075 y el plan de gestión del riesgo escolar exigen priorizar la integridad de la comunidad educativa. La Guía 34 articula el PMI a brechas reales: una meta TIC no desplaza la reparación de una cubierta con filtraciones que ya representa peligro en lluvias.",
        "theoreticalJustification": "La priorización ética pondera urgencia e impacto, no el brillo de un indicador. Un rubro TIC del PMI, un 50-50 de equidad formal o la espera de una circular miden tablero, simetría o trámite, no el riesgo inminente del patio.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del PMI TIC: elegir internet porque está en la meta de conectividad es impecable como tablero de calidad. No pondera el riesgo inminente de la cubierta con filtraciones que el Consejo Directivo debe priorizar.",
            "2": "Trampa de la equidad como mitades: partir 50-50 suena imparcial entre proyectos del PMI. Evacua el análisis de urgencia y trata el riesgo de lluvias del patio como un proyecto más, no como peligro inminente.",
            "3": "Trampa del formalismo de Secretaría: esperar la circular parece legalidad y prudencia territorial. Dilata una decisión de priorización que el gobierno escolar ya puede tomar ante un riesgo inminente en la cubierta.",
        },
    },
    {
        "id": "dir-apt-blan-54",
        "options": [
            "Encargar al personero estudiantil que medie de inmediato entre el estudiante denunciante y el docente, como si esa figura cerrara el caso de trato inadecuado y sustituyera el protocolo institucional de convivencia.",
            "Activar el protocolo de la Ley 1620, indagar los hechos con imparcialidad y garantizar el debido proceso al estudiante y al docente, con registro institucional y reserva, sin prejuzgar a ninguna de las partes.",
            "Disponer el traslado del docente esta misma semana y comunicarlo a las familias como gesto de protección ante la denuncia que llegó por el personero, sin indagación ni derecho de defensa del maestro.",
            "Radicar la denuncia de trato inadecuado como reclamo académico ante el Consejo Académico, por tratarse de un docente, y tramitarla como revisión de práctica de aula, sin activar la ruta de convivencia.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante la denuncia de trato inadecuado que llega por el personero. La Ley 1620 y la Guía 49 exigen activar el protocolo, indagar con imparcialidad y garantizar debido proceso al estudiante y al docente, con reserva. Esa ruta no prejuzga ni convierte al personero en juez del caso. Pedirle que medie entre las partes confunde su función de conducto con la indagación institucional. Trasladar al docente esta semana calma a las familias y lesiona el derecho de defensa. Radicar el hecho como reclamo académico en el Consejo Académico es instancia cruzada: la disciplina de aula no es la ruta de convivencia.",
        "normativeJustification": "La Ley 1620 y la Guía 49 del MEN obligan a protocolo, confidencialidad y debido proceso para ambas partes. El personero canaliza la denuncia; no indaga ni media como si fuera el Comité. El Consejo Académico no sustituye la ruta de convivencia.",
        "theoreticalJustification": "Un enfoque garantista investiga antes de mover personas o de etiquetar el hecho. La mediación del personero, el traslado visible o el trámite académico miden imagen, instancia vecina o rapidez, no imparcialidad ni defensa.",
        "distractorAnalysis": {
            "0": "Trampa de la instancia del personero: pedirle que medie entre estudiante y docente parece cercanía y celeridad. Confunde el conducto de la denuncia con el protocolo: el personero no indaga ni cierra un trato inadecuado.",
            "2": "Trampa de la protección visible: trasladar al docente esta semana y avisarlo a las familias parece resguardar al denunciante. Omite indagación y defensa, y convierte la denuncia del personero en sanción de hecho.",
            "3": "Trampa de dominio cruzado del Consejo Académico: radicar el trato inadecuado como reclamo de aula luce profesional y pedagógico. Desplaza la Ley 1620 y trata una denuncia de convivencia como revisión académica.",
        },
    },
    {
        "id": "dir-apt-blan-55",
        "options": [
            "Mantener el cambio de metodología de evaluación ya decidido y anexar con posterioridad un acta de socialización con los docentes resistentes, de modo que la carpeta del SIEE muestre participación formal sin reabrir la consulta previa.",
            "Reconocer ante el equipo que el cambio de metodología de evaluación se implementó sin consulta previa, abrir un espacio de retroalimentación y ajustar el cronograma de implementación con acuerdos y fecha de seguimiento.",
            "Retirar de tajo el cambio de metodología y restaurar de inmediato el SIEE anterior, presentando esa marcha atrás como vía para recuperar el clima con los docentes que se sintieron excluidos de la consulta.",
            "Llevar el desacuerdo a votación de autoridad en el Consejo Directivo para imponer el nuevo método de evaluación, sin diálogo pedagógico con los docentes que reclaman no haber sido consultados.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando el cambio de metodología de evaluación genera resistencia por falta de consulta. El Decreto 1290 y la Guía 34 exigen construcción participativa del SIEE y un liderazgo que legitime el cambio, no la imposición documental. Reconocer la omisión, abrir retroalimentación y ajustar la implementación corrige el proceso y conserva el propósito pedagógico. Anexar después un acta de socialización simula participación y deja intacta la exclusión. Retirar el cambio para recuperar el clima sacrifica la mejora por apaciguamiento. Llevarlo a votación de autoridad en el Consejo Directivo desplaza el diálogo pedagógico a un acto de poder.",
        "normativeJustification": "El SIEE (Decreto 1290) se construye con participación docente y se adopta con el gobierno escolar; no se socializa a posteriori para maquillar un cambio ya impuesto. El Consejo Directivo adopta, no sustituye el diálogo de implementación pedagógica.",
        "theoreticalJustification": "La legitimidad de un cambio evaluativo depende de la consulta y del ajuste, no del archivo ni del veto emocional. El acta tardía, la marcha atrás del SIEE o la votación de autoridad miden formalismo, clima o poder, no corresponsabilidad.",
        "distractorAnalysis": {
            "0": "Trampa del formalismo documental: anexar un acta de socialización posterior parece participación trazable en el SIEE. Conserva el cambio sin consulta y convierte la resistencia docente en un anexo, no en retroalimentación real.",
            "2": "Trampa del apaciguamiento climático: restaurar el SIEE anterior parece cuidar al equipo que no fue consultado. Cancela el propósito del cambio y enseña que la resistencia, sin mediación, basta para revertir la política evaluativa.",
            "3": "Trampa de dominio cruzado del Consejo Directivo: votar el método como acto de autoridad luce gobierno escolar firme. Omite el diálogo pedagógico con quienes reclaman consulta y convierte un problema de implementación en imposición.",
        },
    },
    {
        "id": "dir-apt-blan-56",
        "options": [
            "Abrir de entrada un expediente disciplinario por la entrega tardía reiterada de informes, como precedente visible para la visita de calidad, sin conversar primero las causas con quien incurrió en la falta leve de primera vez.",
            "Conversar con el funcionario las causas del retraso reiterado en los informes, acordar un plan de mejora con plazos y dejar constancia del compromiso, en proporción a una falta leve de primera vez.",
            "Reasignar este mes la elaboración de los informes a otro funcionario administrativo, para que las entregas salgan a tiempo, sin abordar con la persona las causas de la falta leve ni dejar un plan de mejora.",
            "Reportar de entrada el retraso de informes a control interno de la Secretaría de Educación, como hallazgo de gestión documental, sin agotar el diálogo formativo interno propio de una falta leve sin antecedentes.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante una falta leve de primera vez por informes tardíos. El debido proceso y la proporcionalidad (artículo 29 de la Constitución y reglamento interno) impiden saltar de un hecho menor sin antecedentes a un expediente de imagen o a un reporte territorial. Conversar las causas, acordar un plan de mejora y dejar constancia forma y deja rastro, sin desproporción. Abrir expediente para la visita de calidad convierte el retraso en sanción de vitrina. Reasignar los informes a otro funcionario tapa el síntoma y no corrige el hábito. Reportar de entrada a control interno de Secretaría es trazabilidad territorial que salta el manejo interno proporcional.",
        "normativeJustification": "La falta leve de primera vez se atiende con llamado de atención, plan y constancia, según reglamento interno y debido proceso. Ni la visita de calidad ni el control interno de Secretaría autorizan a omitir esa gradualidad en un retraso de informes.",
        "theoreticalJustification": "La gestión formativa busca causa y compromiso antes de la sanción. El expediente de precedente, el parche de reasignar informes o el oficio a Secretaría miden imagen, operación o control externo, no proporcionalidad.",
        "distractorAnalysis": {
            "0": "Trampa del precedente para la visita: abrir expediente por informes tardíos parece rigor disciplinario y carpeta de calidad. Es desproporcionado frente a una falta leve de primera vez y omite oír las causas al funcionario.",
            "2": "Trampa del parche operativo: reasignar los informes a otro funcionario este mes asegura entregas y parece gestión eficaz. No forma a quien incurrió en la falta leve ni deja compromiso; desplaza el problema de persona.",
            "3": "Trampa de dominio cruzado de control interno: reportar el retraso a Secretaría luce trazabilidad y legalidad documental. Salta el diálogo formativo interno y trata una falta leve como hallazgo territorial de entrada.",
        },
    },
    {
        "id": "dir-apt-blan-57",
        "options": [
            "Expedir una circular que señale al turno de personal que actuó el día de la emergencia de salud como responsable de la desorganización, y archivarla como evidencia de control ante la comunidad educativa.",
            "Revisar con el equipo lo ocurrido en la emergencia de salud del estudiante, identificar las fallas de conocimiento del protocolo y realizar un simulacro de refuerzo con responsables y fecha, para que la ruta se apropie.",
            "Contratar una charla externa de primeros auxilios y programarla para una jornada con familias, dando por cerrado el desorden de la emergencia de salud, sin revisar por qué el personal no conocía el protocolo.",
            "Actualizar el Plan de Gestión del Riesgo en el documento institucional y dejarlo listo para la visita de calidad, sin reunir al equipo ni ensayar el protocolo que falló en la emergencia de salud del estudiante.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente después de una emergencia de salud en la que el personal no conocía el protocolo. El plan de gestión del riesgo escolar y el Decreto 1075 exigen aprendizaje institucional: revisar fallas, formar y ensayar, no buscar un culpable de turno. El simulacro de refuerzo cierra la brecha de conocimiento que desorganizó la atención al estudiante. Una circular que señala al turno produce imagen punitiva y no enseña la ruta. La charla para una jornada con familias exhibe primeros auxilios y deja intacto el protocolo fallido. Actualizar el documento para la visita es formalismo de calidad sin apropiación del equipo.",
        "normativeJustification": "El Decreto 1075 y los lineamientos del plan de gestión del riesgo escolar obligan a protocolos conocidos, ensayados y evaluados tras un evento. Una circular de culpa, una charla de imagen o un documento actualizado para la visita no sustituyen ese aprendizaje del equipo.",
        "theoreticalJustification": "Tras una crisis, la institución aprende si diagnostica la falla y practica la ruta. Señalar al turno, exhibir una charla o editar el plan miden sanción, vitrina o archivo, no competencia del personal en la emergencia.",
        "distractorAnalysis": {
            "0": "Trampa de la circular punitiva: señalar al turno del día de la emergencia parece control y deja evidencia ante la comunidad. Atribuye culpa individual y no corrige el desconocimiento colectivo del protocolo.",
            "2": "Trampa de la charla de imagen: una capacitación externa de primeros auxilios en jornada con familias parece respuesta formativa visible. No revisa por qué el personal desconoció el protocolo el día de la emergencia.",
            "3": "Trampa de dominio cruzado del documento de riesgo: actualizar el Plan de Gestión del Riesgo para la visita luce cumplimiento de calidad. Deja el protocolo en el papel y no ensaya con el equipo la falla vivida.",
        },
    },
    {
        "id": "dir-apt-blan-58",
        "options": [
            "Exigir al docente de mayor antigüedad evidencia de uso digital en el próximo componente de la evaluación 1278, sin indagar sus razones ni ofrecer acompañamiento, como palanca de cumplimiento de las capacitaciones ya dictadas.",
            "Indagar con el docente de mayor antigüedad las razones de su resistencia a las herramientas digitales y ofrecer un acompañamiento personalizado y gradual en el aula, con hitos de práctica y seguimiento del coordinador.",
            "Emparejarlo en los descansos con un docente joven que ya usa las herramientas, para que aprenda de paso, sin plan institucional, sin tiempos protegidos ni criterios de incorporación en su práctica pedagógica.",
            "Comprar más dispositivos para el aula del docente renuente, fotografiarlos y cargarlos como avance TIC del PMI, dando por resuelta la resistencia pedagógica a las herramientas digitales con infraestructura visible.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente frente al docente de mayor antigüedad renuente a las herramientas digitales pese a las capacitaciones. El Decreto 1278 y la Guía 34 orientan acompañamiento situado y desarrollo profesional, no amenaza evaluativa ni compra de equipos como sustituto pedagógico. Indagar razones y ofrecer un plan gradual atiende barreras de dominio, sentido didáctico o temor, y deja seguimiento del coordinador. Exigir evidencia digital en el próximo componente 1278 convierte la evaluación en palanca punitiva. Emparejarlo en descansos con un colega joven es un parche informal, sin tiempos ni criterios. Fotografiar dispositivos para el PMI TIC es infraestructura que no cambia la práctica.",
        "normativeJustification": "La evaluación de desempeño del Decreto 1278 es formativa y concertada, no un ultimátum digital. La gestión académica de la Guía 34 exige acompañamiento y seguimiento. El PMI de infraestructura no reemplaza el cambio de práctica en el aula del docente antiguo.",
        "theoreticalJustification": "La resistencia a lo digital se trabaja con diagnóstico y andamiaje, no con amenaza, mentoría de pasillo ni inventario. El 1278 como palanca, el emparejamiento en descansos o la foto de equipos miden control, informalidad o tablero TIC.",
        "distractorAnalysis": {
            "0": "Trampa del 1278 como palanca: exigir evidencia digital en el próximo componente parece alineación con las capacitaciones. Omite indagar causas y convierte la evaluación de desempeño en amenaza, no en desarrollo profesional.",
            "2": "Trampa de la mentoría de pasillo: emparejarlo en descansos con un docente joven parece apoyo entre pares. Carece de plan, tiempos y criterios; deja la incorporación digital al azar del recreo y no a la gestión del coordinador.",
            "3": "Trampa de dominio cruzado del PMI TIC: comprar y fotografiar dispositivos luce como avance de infraestructura y de calidad. No toca las razones pedagógicas de la resistencia del docente de mayor antigüedad.",
        },
    },
    {
        "id": "dir-apt-blan-59",
        "options": [
            "Dejar que la crítica poco respetuosa continúe en la reunión de área y minutar cada frase para la carpeta de evaluación 1278 del docente, como evidencia de clima laboral, sin detener el agravio hacia el colega.",
            "Interrumpir con respeto la crítica al colega, recordar las normas de comunicación asertiva de la reunión de área y, si el fondo lo requiere, proponer un espacio privado al finalizar, sin humillar a quien habló ni silenciar el trabajo.",
            "Cambiar de inmediato la agenda de la reunión de área por un taller de convivencia, aprovechando el momento de la crítica, y dar por atendido el incidente sin nombrar la agresión al colega ni mediar entre las partes.",
            "Pedir al personero estudiantil o al consejo de padres que medie entre los dos docentes, como si una instancia de participación estudiantil o familiar resolviera el trato irrespetuoso ocurrido en la reunión de área.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando, en una reunión de área, un docente critica con poco respeto el trabajo de un colega. El coordinador que lidera debe proteger el clima laboral y el objeto de la reunión: interrumpir con asertividad, recordar normas de comunicación y, si hace falta, abrir un espacio privado. El respeto laboral y el liderazgo de la reunión exigen detener el agravio en el acto; el 1278 no se usa para minutar en vivo un ultraje como si fuera prueba. Dejar continuar y archivar frases para la carpeta 1278 finge rigor y abandona la mediación. Cambiar la agenda a un taller de convivencia elude el incidente. Pedir al personero o al consejo de padres que medie entre docentes es instancia cruzada: esas figuras no dirimen un conflicto laboral de área.",
        "normativeJustification": "Quien preside la reunión de área debe garantizar un trato digno (reglamento interno y deber de cuidado laboral). La evaluación 1278 no autoriza a documentar un agravio en curso en lugar de mediarlo. Personero y consejo de padres no son instancias de conflictos entre docentes.",
        "theoreticalJustification": "La mediación oportuna nombra el hecho, protege a quien fue expuesto y conserva el trabajo de área. Minutar para el 1278, disolver en un taller o exportar el caso a gobierno estudiantil o familiar evaden la intervención del coordinador.",
        "distractorAnalysis": {
            "0": "Trampa del rigor documental 1278: minutar la crítica irrespetuosa parece evidencia de clima y de evaluación. Permite que el agravio continúe en la reunión de área y convierte al coordinador en notario, no en mediador.",
            "2": "Trampa del taller oportunista: cambiar la agenda a convivencia parece pedagogía inmediata. Elude nombrar la crítica al colega, no media entre las partes y disuelve el incidente en una actividad genérica de clima.",
            "3": "Trampa de dominio cruzado de instancias de participación: pedir al personero o al consejo de padres que medie entre docentes suena a gobierno escolar amplio. Esas figuras no resuelven un conflicto laboral de una reunión de área.",
        },
    },
    {
        "id": "dir-apt-blan-60",
        "options": [
            "Congelar la reasignación a la sede con mayores necesidades hasta obtener un concepto del sindicato sobre el desplazamiento, y dejar el punto en suspenso mientras llega esa voz laboral, con la sede a la espera.",
            "Escuchar las razones del docente sobre el desplazamiento, revisar alternativas viables dentro del marco de planta y de sedes, y comunicar con claridad los criterios de la decisión final, incluida la necesidad pedagógica de la sede.",
            "Ofrecer un bono con recursos del Fondo de Servicios Educativos para compensar el desplazamiento, y dar por zanjada la objeción, sin examinar si la sede de mayores necesidades queda con el docente que requiere.",
            "Dejar la sede de mayores necesidades sin el docente de carrera y gestionar un provisional mientras tanto, para no tensionar a quien objeta el desplazamiento, sin resolver con criterios la cobertura del servicio.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente en la reasignación a una sede de mayores necesidades, objetada por desplazamiento. La organización del establecimiento (Decreto 1075) obliga a cubrir el servicio con criterios conocidos y a oír al docente, sin ceder la decisión a un veto ni a un parche de caja. Escuchar razones, revisar alternativas legales y comunicar los criterios equilibra necesidad institucional y trato digno. Congelar el traslado hasta un concepto sindical desplaza el gobierno de la IE a una instancia laboral. Un bono del FSE compra el consentimiento y no examina si la sede queda descubierta. Contratar un provisional deja la necesidad pedagógica sin el docente de carrera y normaliza la precariedad.",
        "normativeJustification": "El rector organiza la planta dentro de la IE con criterios de servicio y debido proceso laboral interno. El sindicato representa y conceptúa; no congela una reasignación de sede. El FSE no se usa para comprar un traslado, ni el provisional sustituye de oficio la decisión de cobertura.",
        "theoreticalJustification": "Una decisión de talento humano es defendible si oye, examina alternativas y explica el criterio de necesidad de la sede. El congelamiento sindical, el bono o el provisional miden conflicto laboral, caja o parche, no equilibrio institucional.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado laboral: congelar la reasignación hasta el concepto sindical parece respeto a la organización de trabajadores. Traslada al sindicato una decisión de cobertura de sede y deja en suspenso la necesidad pedagógica.",
            "2": "Trampa del bono del FSE: compensar el desplazamiento con recursos del fondo parece acuerdo razonable y cuida al docente. No examina la necesidad de la sede y convierte un criterio de servicio en una negociación de caja.",
            "3": "Trampa del provisional puente: dejar la sede descubierta y contratar un transitorio parece no forzar al docente. Sacrifica la continuidad pedagógica de la sede con mayores necesidades y evade la decisión de reasignación.",
        },
    },
    {
        "id": "dir-apt-ges-61",
        "options": [
            "Consignar en el PEI, para la autoevaluación que exige el Consejo Directivo, las cuatro áreas de la Guía 34 articuladas —directiva, académica, administrativa-financiera y de la comunidad— y no sustituirlas por un capítulo de caja aparte que desconecte al pagador.",
            "Reorganizar el PEI en capítulos de imagen pedagógica, financiera, disciplinaria y deportiva, de modo que lo académico y lo disciplinario del rector y la caja del pagador queden visibles, sin articular el mapa de cuatro áreas de la Guía 34.",
            "Adoptar como mapa de autoevaluación las áreas directiva, académica, deportiva y cultural, cubriendo la actualización que el rector ya inició, e omitir la gestión comunitaria y la administrativa-financiera que el pagador pidió como capítulo aparte.",
            "Estructurar el PEI en gestión administrativa, comunitaria, financiera y tecnológica, atendiendo el reclamo de caja del pagador y un componente TIC, sin incluir las gestiones directiva y académica que la Guía 34 exige articular.",
        ],
        "explanation": "La condición de calidad pregunta qué cuatro áreas de gestión debe articular el PEI según el mapa de la Guía 34, frente a un rector que redujo el documento a lo académico y lo disciplinario y a un pagador que pide un capítulo de caja aparte. La Guía 34 del MEN organiza la gestión institucional en directiva, académica, administrativa-financiera y de la comunidad, articuladas para la autoevaluación y el PMI. Ese es el mapa que el Consejo Directivo exige. Capítulos de imagen pedagógica, financiera, disciplinaria y deportiva no coinciden con el referente. Directiva, académica, deportiva y cultural omiten lo comunitario y lo financiero. Administrativa, comunitaria, financiera y tecnológica omiten lo directivo y lo académico, que el rector ya estaba recortando de hecho.",
        "normativeJustification": "La Guía 34 del MEN fija cuatro áreas articuladas de gestión escolar: directiva, académica, administrativa-financiera y de la comunidad. El PEI y la autoevaluación no se fragmentan en un capítulo de caja del pagador ni en rúbricas de imagen disciplinaria o deportiva.",
        "theoreticalJustification": "La gestión institucional es un sistema de cuatro áreas, no un listado de capítulos visibles. Recortar a lo académico-disciplinario, aislar la caja o añadir deporte, cultura o TIC como si fueran áreas del mapa desplaza el referente de la Guía 34.",
        "distractorAnalysis": {
            "1": "Trampa de los capítulos de imagen: pedagógica, financiera, disciplinaria y deportiva parecen cubrir lo que el rector y el pagador ya nombran. No son las cuatro áreas de la Guía 34 y convierten el PEI en vitrina, no en mapa de autoevaluación.",
            "2": "Trampa del recorte a lo visible del rector: directiva, académica, deportiva y cultural prolongan «lo académico» y añaden oferta extracurricular. Omiten la gestión comunitaria y la administrativa-financiera que el mapa articula.",
            "3": "Trampa de dominio cruzado de la caja y la TIC: administrativa, comunitaria, financiera y tecnológica atienden al pagador y a la innovación. Omiten las gestiones directiva y académica, núcleo que la Guía 34 no autoriza a recortar.",
        },
    },
    {
        "id": "dir-apt-ges-62",
        "options": [
            "Resolver que el Consejo Académico adopte el nuevo manual de convivencia en esta semana, por cuanto toca la disciplina de aula, y dejar sin efecto la circular con la que el rector pretendía expedirlo.",
            "Someter el nuevo manual de convivencia a adopción del Consejo Directivo, conforme a la Ley 115 y al Decreto 1860, con construcción participativa, y no reemplazar esa instancia por una circular de rectoría ni por el voto de otra mesa.",
            "Facultar al personero estudiantil para adoptar el manual de convivencia, en su calidad de vocero de derechos, y cerrar con su visto bueno el desacuerdo entre la circular de rectoría, el Consejo Académico y los padres.",
            "Convocar la asamblea general de la Asociación de Padres para votar y adoptar el nuevo manual de convivencia, otorgando a esa votación el carácter de acto de gobierno escolar que el rector quería resolver por circular.",
        ],
        "explanation": "La condición de calidad pregunta qué instancia del gobierno escolar corresponde para adoptar el manual de convivencia, según la Ley 115 y el Decreto 1860, en el desacuerdo entre una circular de rectoría, el Consejo Académico y la asamblea de padres. El Consejo Directivo adopta el manual, con participación de la comunidad educativa; el rector lo ejecuta y no lo expide por acto unilateral de esta semana. El Consejo Académico orienta lo pedagógico y puede conceptuar sobre disciplina de aula, pero no adopta el manual. El personero promueve derechos y deberes estudiantiles; no es órgano de adopción. La Asociación de Padres participa y puede opinar; su asamblea no sustituye al Consejo Directivo.",
        "normativeJustification": "La Ley 115 y el Decreto 1860 asignan al Consejo Directivo la adopción del manual de convivencia. El rector lidera y ejecuta; el Consejo Académico asesora lo pedagógico; el personero y la Asociación de Padres participan, sin adoptar el acto.",
        "theoreticalJustification": "El gobierno escolar distingue adopción, ejecución y participación. Una circular de rectoría, un concepto de disciplina de aula, la firma del personero o un voto de asamblea de padres miden celeridad o legitimidad vecina, no la instancia de adopción.",
        "distractorAnalysis": {
            "0": "Trampa de dominio cruzado del Consejo Académico: adoptar el manual porque toca disciplina de aula parece coherencia pedagógica. Esa instancia orienta lo académico; no reemplaza al Consejo Directivo ni anula la circular usurpando la adopción.",
            "2": "Trampa del personero como órgano de adopción: su visto bueno parece garantizar derechos estudiantiles en el nuevo manual. El personero promueve y vigila; no adopta normas de convivencia ni cierra el desacuerdo de gobierno escolar.",
            "3": "Trampa de la asamblea de padres: votar el manual en la Asociación parece participación máxima y frena la circular del rector. La comunidad opina y vela; no adopta el manual en lugar del Consejo Directivo.",
        },
    },
]


def n_sent(s: str) -> int:
    return len([p for p in re.split(r"(?<=[.!?])\s+", s.strip()) if p])


def validate(items):
    src = json.loads(SRC.read_text(encoding="utf-8"))
    errors = []
    print("id\tci\tlens\tskew\texpl\tsent\tNJ\tTJ")
    for src_it, it in zip(src, items):
        cid = it["id"]
        ci = CI[cid]
        if cid != src_it["id"]:
            errors.append(f"ID ORDER {cid} vs {src_it['id']}")
        opts = it["options"]
        lens = [len(o) for o in opts]
        skew = max(lens) - min(lens)
        expl = it["explanation"]
        sent = n_sent(expl)
        print(
            f"{cid}\t{ci}\t{lens}\t{skew}\t{len(expl)}\t{sent}\t"
            f"{len(it['normativeJustification'])}\t{len(it['theoreticalJustification'])}"
        )
        if len(opts) != 4:
            errors.append(f"OPTS {cid}")
        if skew >= 180:
            errors.append(f"SKEW {cid} {lens} {skew}")
        for oi, o in enumerate(opts):
            if not (80 <= len(o) <= 340):
                errors.append(f"OPT LEN {cid}[{oi}] {len(o)}")
            if oi != ci and FORBIDDEN.search(o):
                errors.append(f"FORBIDDEN {cid}[{oi}] {FORBIDDEN.search(o).group(0)}")
            low = o.lower()
            if oi != ci and any(x in low for x in OBVIOUS):
                errors.append(f"OBVIOUS {cid}[{oi}]")
        if len(expl) < 280 or not (4 <= sent <= 7):
            errors.append(f"EXPL {cid} len={len(expl)} sent={sent}")
        for f in ("normativeJustification", "theoreticalJustification"):
            if len(it[f]) < 80:
                errors.append(f"SHORT {f} {cid} {len(it[f])}")
        expected = [str(n) for n in range(4) if n != ci]
        da = it["distractorAnalysis"]
        if sorted(da.keys()) != expected:
            errors.append(f"DA KEYS {cid} {sorted(da.keys())} != {expected}")
        for k, v in da.items():
            if len(v) < 80 or not v.startswith("Trampa"):
                errors.append(f"DA {cid}[{k}] len={len(v)} start={v[:20]!r}")
    print("---")
    if errors:
        for e in errors:
            print("ERR", e)
    else:
        print("OK")
    return errors


def main():
    errors = validate(ITEMS)
    OUT.write_text(json.dumps(ITEMS, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print("wrote", OUT.name, "n=", len(ITEMS))
    if errors:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
