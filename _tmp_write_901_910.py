# -*- coding: utf-8 -*-
"""Reescribe dir-apt-blan-153..160 y dir-apt-ges-161..162 (posiciones 901-910)."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_901_910.json"

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
    "dir-apt-blan-153": 0,
    "dir-apt-blan-154": 1,
    "dir-apt-blan-155": 2,
    "dir-apt-blan-156": 3,
    "dir-apt-blan-157": 0,
    "dir-apt-blan-158": 1,
    "dir-apt-blan-159": 2,
    "dir-apt-blan-160": 3,
    "dir-apt-ges-161": 0,
    "dir-apt-ges-162": 1,
}

ITEMS = [
    {
        "id": "dir-apt-blan-153",
        "options": [
            "Presentar a la comunidad educativa los resultados Saber más bajos de lo esperado con transparencia, contextualizarlos con el ISCE y el diagnóstico de la IE, y compartir el plan de acción institucional para atender las áreas de oportunidad identificadas.",
            "Reservar el reporte del ISCE y de las pruebas Saber al Consejo Directivo, y no socializarlo con las familias, para no generar alarma ni tensionar el clima de la comunidad educativa mientras rectoría redacta una explicación interna.",
            "Presentar en la reunión de padres un ranking por área y por docente de los resultados Saber más bajos de lo esperado, para que se note responsabilidad y las familias sepan a quién reclamar en las áreas evaluadas.",
            "Esperar el Día E o la visita de calidad para mostrar el PMI ya redactado con las áreas de oportunidad de Saber, de modo que la comunidad reciba los resultados en el calendario oficial de mejoramiento y no en este momento.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente al comunicar resultados Saber más bajos de lo esperado. Presentarlos con transparencia, contextualizarlos y compartir el plan de acción institucional atiende el derecho de la comunidad a una información fundada y abre mejora, sin ocultar ni personalizar culpas. Reservar el ISCE al Consejo Directivo para no generar alarma cuida el clima aparente y niega socialización. El ranking por área y docente en reunión de padres finge responsabilidad y expone al equipo. Esperar el Día E o la visita para mostrar el PMI ya redactado es calendario de calidad, no la comunicación ética que el caso exige ahora.",
        "normativeJustification": "El Decreto 1075 y la Guía 34 exigen comunicar resultados y planes de mejoramiento a la comunidad educativa. El ISCE y las pruebas Saber no se reservan al Consejo Directivo ni se convierten en ranking de docentes; el Día E no aplaza la transparencia debida.",
        "theoreticalJustification": "La transparencia con plan de acción construye confianza. Reservar por alarma, exhibir responsables o esperar el calendario de calidad sustituyen ética institucional por clima, señalamiento o evidencia de visita.",
        "distractorAnalysis": {
            "1": "Trampa de reservar el ISCE al Consejo Directivo: no socializar los Saber más bajos con las familias parece prudencia de clima y evita alarma. Niega transparencia a la comunidad educativa y deja el plan de acción sin interlocutores.",
            "2": "Trampa del ranking por área y docente: exhibir responsables en la reunión de padres parece rendición de cuentas. Personaliza los Saber más bajos, vulnera reserva laboral y convierte la comunicación institucional en señalamiento.",
            "3": "Trampa de dominio cruzado del calendario de calidad: esperar el Día E o la visita para mostrar el PMI ya redactado luce impecable como ciclo de mejoramiento. Dilata la comunicación exigida ahora y sustituye transparencia presente por evidencia de visita.",
        },
    },
    {
        "id": "dir-apt-blan-154",
        "options": [
            "Agradecer la feria de emprendimiento de grado once y diferirla al próximo año lectivo, cuando exista un rubro en el Fondo de Servicios Educativos, para no comprometer la vigencia actual ni improvisar un gasto sin línea presupuestal.",
            "Explorar con los estudiantes de grado once alternativas de gestión —alianzas, autogestión y apoyo de padres— y orientar institucionalmente la feria de emprendimiento, en lugar de negar la iniciativa por falta de rubro presupuestal.",
            "Autorizar la feria de emprendimiento de grado once como evidencia de PMI, pedir fotografías para el tablero de calidad y prescindir de acompañar la gestión de recursos o de revisar el Fondo de Servicios Educativos.",
            "Pedir a grado once un bono de entrada para financiar la feria de emprendimiento, recaudado entre familias y visitantes, sin acuerdo del Consejo Directivo ni marco del Fondo de Servicios Educativos de la vigencia.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante la feria de emprendimiento de grado once sin rubro. Explorar alianzas, autogestión y apoyo de padres, con orientación institucional, sostiene la iniciativa sin comprometer recursos inexistentes ni improvisar un cobro. Diferirla al próximo año cuando exista línea en el FSE es prudencia presupuestal que dilata el proyecto de los estudiantes. Autorizarla como evidencia de PMI y pedir fotos para el tablero simula calidad y deja sin acompañamiento la gestión de recursos. El bono de entrada sin Consejo Directivo ni marco del FSE convierte la feria en recaudo informal.",
        "normativeJustification": "El Decreto 1075 y el régimen del Fondo de Servicios Educativos exigen rubro, Consejo Directivo y trazabilidad del gasto. La ausencia de línea no autoriza a diferir la iniciativa, a simular evidencia de PMI ni a recaudar un bono al margen del FSE.",
        "theoreticalJustification": "Acompañar alternativas de gestión fomenta la iniciativa sin gastar lo que no existe. La dilación al próximo año, las fotos para el tablero o el bono informal sustituyen orientación institucional por presupuesto, imagen de calidad o recaudo.",
        "distractorAnalysis": {
            "0": "Trampa de la dilación presupuestal: esperar al próximo año a que exista rubro en el FSE parece orden de tesorería. Niega acompañamiento a grado once y convierte la falta de línea en veto diferido de la feria de emprendimiento.",
            "2": "Trampa de dominio cruzado del PMI: autorizar la feria y pedir fotos para el tablero luce como evidencia de emprendimiento. No acompaña la gestión de recursos ni revisa el FSE; simula calidad y deja a los estudiantes sin orientación.",
            "3": "Trampa del bono de entrada: recaudar entre familias y visitantes parece autogestión inmediata. Carece de acuerdo del Consejo Directivo y de marco del FSE, y convierte la feria de grado once en un cobro informal.",
        },
    },
    {
        "id": "dir-apt-blan-155",
        "options": [
            "Suspender el reconocimiento de mejor docente del año y comunicarlo al equipo como gesto de equidad, para igualar el clima y detener la competencia poco sana entre los dos docentes que se disputan el distintivo.",
            "Elegir de inmediato a un ganador entre los dos docentes, publicarlo en las redes de la institución y dar por cerrada la disputa del reconocimiento, de modo que el equipo vea una decisión tomada y deje de tensionarse.",
            "Conversar por separado con cada docente sobre el impacto de esta dinámica en el equipo, y reforzar que el reconocimiento de mejor docente del año no debe entenderse como una competencia entre colegas.",
            "Convocar al consejo de padres para que vote quién merece el reconocimiento de mejor docente del año, y zanjar la tensión del equipo con la legitimidad comunitaria de esa votación ante las familias.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante la competencia poco sana por el reconocimiento de mejor docente del año. Conversar por separado con cada docente sobre el impacto en el equipo y reforzar que el reconocimiento no es una competencia entre colegas desactiva la rivalidad sin humillar ni espectacularizar. Suspender el distintivo para igualar el clima retira un reconocimiento legítimo y enseña que la tensión se resuelve cancelando. Elegir un ganador de inmediato y publicarlo en redes cierra la disputa con imagen y puede agravar la herida. Que el consejo de padres vote al mejor docente traspasa a las familias una decisión de gestión del talento.",
        "normativeJustification": "El Decreto 1278 y la Guía 34 sitúan el reconocimiento docente en criterios institucionales de desempeño, no en una contienda ni en un plebiscito de familias. El consejo de padres no elige al mejor docente ni la rectoría cancela el distintivo para calmar el clima.",
        "theoreticalJustification": "El diálogo privado reconduce el sentido del reconocimiento. Suspenderlo, publicarlo en redes o votarlo con padres tratan la tensión con equidad aparente, imagen o legitimidad comunitaria, no con ética de equipo.",
        "distractorAnalysis": {
            "0": "Trampa de igualar el clima cancelando: suspender el reconocimiento de mejor docente del año parece equidad y calma al equipo. Retira un distintivo institucional y enseña que la competencia poco sana se resuelve anulando, no reconvirtiendo su sentido.",
            "1": "Trampa de cerrar la disputa en redes: elegir un ganador de inmediato y publicarlo parece liderazgo resolutivo. Convierte la tensión entre los dos docentes en espectáculo y puede profundizar la herida en el equipo.",
            "3": "Trampa de dominio cruzado de legitimidad comunitaria: que el consejo de padres vote al mejor docente luce como participación. Traspasa a las familias una decisión de gestión del talento y no atiende el impacto de la rivalidad en el equipo.",
        },
    },
    {
        "id": "dir-apt-blan-156",
        "options": [
            "Entregar al padre un informe de contexto sobre el otro menor involucrado en el incidente con su hijo, bajo reserva verbal de no difundirlo, para que entienda lo ocurrido y perciba transparencia de rectoría.",
            "Citar a ambos acudientes a una misma reunión para transparentar el incidente entre los dos estudiantes, de modo que cada familia conozca la versión de la otra y el rector no parezca ocultar información.",
            "Orientar al padre a solicitar la carpeta del otro estudiante ante el personero estudiantil o ante el ICBF, para que una instancia de protección o de gobierno escolar le entregue lo que rectoría no muestra.",
            "Explicarle con respeto que, por confidencialidad y protección de datos de menores, la información del otro estudiante no puede compartirse, y orientarlo sobre lo que sí puede conocer del proceso que involucra a su hijo.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un padre pide información confidencial de otro estudiante involucrado en un incidente con su hijo. Explicar la confidencialidad y la protección de datos, y orientar lo que sí puede conocer del proceso de su hijo, protege al tercero y no deja desinformado al acudiente. El informe de contexto del otro menor, incluso con reserva verbal, revela datos de un niño. Citar a ambos acudientes juntos para transparentar el incidente expone a los dos estudiantes. Remitirlo al personero o al ICBF por la carpeta del otro menor cruza instancias y no resuelve el derecho de información del padre sobre su propio hijo.",
        "normativeJustification": "La Ley 1581, el Código de Infancia y Adolescencia y el Decreto 1075 amparan datos de menores. El padre tiene derecho a conocer el proceso de su hijo, no el de un tercero; el personero y el ICBF no son ventanilla de esa carpeta ajena.",
        "theoreticalJustification": "La confidencialidad con orientación precisa equilibra reserva y derecho a ser informado. El informe de contexto, la reunión conjunta o el traslado a otra instancia revelan, exponen o desplazan lo que rectoría debe explicar y lo que debe callar.",
        "distractorAnalysis": {
            "0": "Trampa del informe de contexto con reserva verbal: entregar datos del otro menor para que el padre entienda parece transparencia acotada. Revela información de un niño y la «reserva» oral no sana la vulneración de confidencialidad.",
            "1": "Trampa de transparentar el incidente con ambos acudientes: la reunión conjunta parece honestidad y cierra sospechas de ocultamiento. Expone a los dos estudiantes y convierte un hecho reservado en careo de familias.",
            "2": "Trampa de dominio cruzado de instancia: remitir al personero o al ICBF por la carpeta del otro menor luce como conducto de protección. Cruza gobierno escolar y autoridad de infancia, y no orienta al padre sobre lo que sí puede conocer del proceso de su hijo.",
        },
    },
    {
        "id": "dir-apt-blan-157",
        "options": [
            "Realizar un acompañamiento y una retroalimentación oportuna al docente en período de prueba antes de la fecha límite, documentando el desempeño irregular, para que la decisión de continuidad quede sustentada ante la ETC.",
            "Concentrar la evidencia del desempeño irregular en la última semana previa al vencimiento, para que el informe 1278 a la ETC quede fresco y el expediente de planta luzca actualizado al cierre del período de prueba.",
            "Calificar satisfactorio el período de prueba pese al desempeño irregular, para no tensionar la planta ni interrumpir el servicio, y dar continuidad al nombramiento mientras el acompañamiento se programa después.",
            "Comunicar de palabra al docente la decisión sobre el período de prueba y dejar el formato 1278 para cuando haya tiempo, de modo que la ETC reciba pronto la novedad de planta y el papel se complete después.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante el docente en período de prueba con desempeño irregular y fecha límite cercana. El acompañamiento y la retroalimentación oportuna, documentados antes del vencimiento, sustentan una decisión justa y comunicable a la ETC conforme al Decreto 1278. Concentrar la evidencia en la última semana para que el informe luzca fresco niega la oportunidad de mejora y fabrica un expediente de cierre. Calificar satisfactorio para no tensionar la planta simula continuidad del servicio y falsea el juicio. Comunicar de palabra y dejar el formato 1278 para después privilegia la celeridad de planta sobre la trazabilidad de la evaluación.",
        "normativeJustification": "El Decreto 1278 exige evaluación en período de prueba con evidencias, retroalimentación y acto oportuno ante la ETC. Ni el expediente de última semana, ni un satisfactorio por clima, ni el aviso verbal sustituyen ese proceso documentado.",
        "theoreticalJustification": "La decisión de continuidad se sostiene en acompañamiento y registro. Compactar pruebas al cierre, aprobar por servicio o adelantar la novedad de planta miden frescura documental, paz laboral o celeridad, no justicia evaluativa.",
        "distractorAnalysis": {
            "1": "Trampa de la evidencia de última semana: concentrar pruebas para que el informe 1278 a la ETC quede fresco parece rigor de cierre. Niega acompañamiento oportuno al desempeño irregular y fabrica un expediente tardío.",
            "2": "Trampa del satisfactorio por continuidad del servicio: calificar bien para no tensionar la planta parece cuidado de la prestación. Falsea el período de prueba y deja sin juicio honesto el desempeño irregular ya observado.",
            "3": "Trampa de dominio cruzado de celeridad de planta: comunicar de palabra y dejar el formato 1278 para después luce como agilidad ante la ETC. Privilegia la novedad de personal sobre la trazabilidad que la evaluación de prueba exige.",
        },
    },
    {
        "id": "dir-apt-blan-158",
        "options": [
            "Convocar una asamblea del curso para que el rumor no confirmado de acoso entre estudiantes salga a la luz ante el grupo, de modo que testigos hablen en público y el coordinador documente lo declarado en esa sesión.",
            "Indagar con discreción y de manera oportuna el rumor de acoso entre estudiantes del mismo curso, sin exponer a los presuntos involucrados, para verificar si existe una situación real que deba activarse formalmente en la ruta.",
            "Activar de inmediato una situación Tipo III por el rumor de acoso y comunicar cero tolerancia al grado, para dejar evidencia de rigor de la Ley 1620 y de protección visible ante las familias del curso.",
            "Pedir a las familias del curso que indaguen en el chat del grupo si el rumor de acoso entre estudiantes se confirma, y que reporten al coordinador lo que encuentren en esas conversaciones de acudientes.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente ante un rumor no confirmado de acoso entre estudiantes del mismo curso. Indagar con discreción y de manera oportuna, sin exponer, permite verificar si hay hechos que activen la ruta de la Ley 1620 y la Guía 49. La asamblea de curso para que el rumor salga a la luz expone a posibles víctimas y convierte un indicio en espectáculo. Activar de inmediato Tipo III y proclamar cero tolerancia al grado es rigor visible que salta la verificación. Pedir a las familias que indaguen en el chat del grupo delega la pesquisa y compromete la reserva.",
        "normativeJustification": "La Ley 1620 y la Guía 49 exigen indagación reservada y tipificación proporcional. Un rumor no confirmado no se ventila en asamblea, no se declara Tipo III de entrada ni se investiga en el chat de las familias del curso.",
        "theoreticalJustification": "La discreción oportuna verifica sin revictimizar. La asamblea, el Tipo III visible o el chat de acudientes tratan el rumor como escarmiento público, protocolo espectacular o pesquisa comunitaria.",
        "distractorAnalysis": {
            "0": "Trampa de la asamblea que saca el rumor a la luz: que el curso declare en público parece transparencia y recolección de testigos. Expone a posibles víctimas del acoso no confirmado y convierte un indicio en espectáculo de aula.",
            "2": "Trampa de dominio cruzado del 1620 de rigor visible: activar Tipo III de inmediato y comunicar cero tolerancia al grado luce como protección plena. Salta la verificación del rumor y usa la ruta punitiva como mensaje al grupo.",
            "3": "Trampa del chat de familias: pedir a los acudientes que indaguen en el grupo parece alianza y celeridad. Delega la pesquisa institucional, expone el rumor y compromete la reserva de los estudiantes del curso.",
        },
    },
    {
        "id": "dir-apt-blan-159",
        "options": [
            "Priorizar al candidato interno que ya reemplaza de hecho la coordinación vacante, para no interrumpir el servicio ni desmontar los acuerdos de la jornada, y explicar al otro que el encargo existente resolvió el empate de calificaciones.",
            "Aplicar una encuesta anónima al equipo docente sobre cuál de los dos candidatos internos genera mejor clima, y adoptar el resultado como criterio de legitimidad para cubrir la coordinación vacante entre igualmente calificados.",
            "Definir y aplicar criterios objetivos adicionales —experiencia específica, evaluación de desempeño o entrevista estructurada— y comunicar la decisión con transparencia a ambos candidatos internos igualmente calificados para la coordinación.",
            "Rotar el encargo de coordinación mes a mes entre los dos candidatos internos hasta que baje la tensión del equipo, y dejar la vacante en interinidad mientras el clima laboral se estabiliza y cesa la comparación.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente al decidir entre dos candidatos internos igualmente calificados para la coordinación vacante. Criterios objetivos adicionales —experiencia específica, desempeño, entrevista estructurada— y comunicación transparente a ambos dan legitimidad al empate. Priorizar a quien ya reemplaza de hecho cuida la continuidad del servicio y convierte el encargo informal en ventaja indebida. La encuesta anónima al equipo plebiscita el clima y no evalúa méritos del cargo. Rotar el encargo mes a mes hasta que baje la tensión dilata la provisión y trata la vacante como termómetro laboral.",
        "normativeJustification": "El Decreto 1278 y la Guía 34 exigen criterios objetivos y trazables para encargos directivos. El reemplazo de hecho, la encuesta de clima o la rotación mensual no sustituyen experiencia específica, desempeño ni entrevista estructurada, ni la comunicación a ambos.",
        "theoreticalJustification": "La transparencia de criterios resuelve un empate sin clientelismo. La continuidad del servicio, el plebiscito del equipo o la rotación por clima miden operación, popularidad o dilación, no mérito del cargo de coordinación.",
        "distractorAnalysis": {
            "0": "Trampa de la continuidad del servicio: priorizar a quien ya reemplaza de hecho la coordinación parece no interrumpir la jornada. Convierte el encargo informal en ventaja y deja al otro candidato interno sin criterios objetivos ante el empate.",
            "1": "Trampa de la encuesta de clima: el voto anónimo del equipo parece legitimidad y cuida el ambiente. Plebiscita simpatías y no aplica experiencia específica, desempeño ni entrevista estructurada al cargo vacante.",
            "3": "Trampa de dominio cruzado de dilación por clima: rotar el encargo mes a mes hasta que baje la tensión luce como cuidado del equipo. Dilata la provisión de la coordinación y trata la vacante como termómetro laboral, no como decisión de mérito.",
        },
    },
    {
        "id": "dir-apt-blan-160",
        "options": [
            "Hacer un llamado de atención al docente en la sala de profesores, delante del equipo, para que vea el límite frente a alzar la voz en clase y el claustro perciba que coordinación no deja pasar el incidente con el estudiante.",
            "Abrir de inmediato un proceso del Decreto 1278 y una circular de trato digno para la visita de calidad, sin diálogo privado previo, dejando el alzar la voz frente al grupo como evidencia temprana de desempeño.",
            "Citar al acudiente del estudiante y al grupo para que el docente se disculpe en público por haber alzado la voz, y dejar constancia en el observador como gesto restaurativo visible ante la clase.",
            "Conversar en privado con el docente sobre lo ocurrido al alzar la voz frente al grupo, revisar la situación con calma y acordar estrategias para manejar situaciones similares sin perder el control delante de la clase.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un docente alza la voz de forma notoria frente al grupo. Conversar en privado, revisar con calma y acordar estrategias de manejo corrige sin exponer al docente ni humillarlo ante colegas, familias o estudiantes. El llamado de atención en la sala de profesores convierte un hecho de aula en escarmiento público. Abrir de inmediato el 1278 y una circular de trato digno para la visita salta el diálogo y fabrica evidencia de calidad. Citar al acudiente y al grupo para una disculpa pública restaura en apariencia y vulnera la reserva del docente.",
        "normativeJustification": "El Decreto 1278 evalúa con debido proceso y reserva; el Decreto 1075 y la Guía 49 piden corrección formativa, no escarmiento en sala ni disculpa ante el grupo. La visita de calidad no abre por sí sola un proceso disciplinario.",
        "theoreticalJustification": "El abordaje privado y formativo restaura el control de aula sin espectáculo. El llamado en la sala, el expediente 1278 inmediato o la disculpa pública miden límite visible, evidencia de visita o restauración teatral.",
        "distractorAnalysis": {
            "0": "Trampa del límite visible en la sala de profesores: el llamado de atención delante del equipo parece autoridad de coordinación. Expone al docente que alzó la voz, convierte un hecho de aula en escarmiento y omite el diálogo privado.",
            "1": "Trampa de dominio cruzado del 1278 para la visita: abrir proceso y circular de trato digno sin diálogo previo luce como rigor de calidad. Salta la conversación formativa y fabrica evidencia temprana con el incidente frente al grupo.",
            "2": "Trampa de la disculpa pública: citar al acudiente y al grupo parece restauración y cuidado del estudiante. Humilla al docente, expone el incidente y sustituye el acuerdo de estrategias por un gesto visible ante la clase.",
        },
    },
    {
        "id": "dir-apt-ges-161",
        "options": [
            "Según el abogado de la secretaría en el consejo, el Decreto 1075 de 2015 es el Decreto Único Reglamentario del Sector Educación, que compiló decretos reglamentarios previos del sector y no se confunde con una ley de SGP ni con el 1278.",
            "Tratar el Decreto 1075 de 2015, pese a la aclaración del abogado en el consejo, como la ley que crea el Sistema General de Participaciones y reparte los recursos a las entidades territoriales, al estilo de la Ley 715.",
            "Entender, contra lo dicho por el abogado en el consejo, que el Decreto 1075 de 2015 es el régimen que regula la evaluación de los estudiantes y el SIEE, y que por eso alguien lo citó como el decreto de evaluación.",
            "Sostener en el consejo, pese al abogado de la secretaría, que el Decreto 1075 de 2015 crea la Comisión Nacional del Servicio Civil y organiza los concursos docentes, mezclándolo con el 1278 que otro asistente invocó.",
        ],
        "explanation": "La condición de calidad pregunta qué es el Decreto 1075 de 2015 en el sector educativo colombiano, según el marco y la evidencia del caso. El abogado de la secretaría aclara en el consejo que es el Decreto Único Reglamentario del Sector Educación, que compiló decretos reglamentarios previos del sector. No es la ley que crea el Sistema General de Participaciones, función propia de la Ley 715 y del giro a las ETC. Tampoco es el régimen del SIEE ni el decreto de evaluación que alguien invocó en la mesa como si fuera el único cuerpo. Ni crea la Comisión Nacional del Servicio Civil, que otro asistente mezcló con el Decreto 1278.",
        "normativeJustification": "El Decreto 1075 de 2015 es el DUR del Sector Educación y compila decretos reglamentarios previos. La Ley 715 crea y regula el SGP; el SIEE proviene del Decreto 1290 compilado; la CNSC no nace de ese DUR.",
        "theoreticalJustification": "Un DUR unifica reglamentación sectorial; no crea el sistema de participaciones, no se agota en evaluación estudiantil ni instituye la comisión de carrera. Confundir esas normas vecinas es leer mal al abogado del consejo.",
        "distractorAnalysis": {
            "1": "Trampa de dominio cruzado de la Ley 715 y el SGP: tratar el 1075 como la ley que crea el Sistema General de Participaciones parece unificar financiamiento y DUR. El abogado del consejo precisa que el 1075 compila decretos reglamentarios del sector, no crea el SGP.",
            "2": "Trampa del SIEE como cuerpo de evaluación: llamar al 1075 el decreto de evaluación parece coherente con quien lo citó en el consejo. El DUR compila muchos decretos; el régimen de evaluación estudiantil no agota ni define el 1075.",
            "3": "Trampa de la creación de la CNSC: mezclar el 1075 con la comisión de carrera y con el 1278 parece ordenar concursos en un solo tomo. El abogado aclara que el DUR del sector no crea la Comisión Nacional del Servicio Civil.",
        },
    },
    {
        "id": "dir-apt-ges-162",
        "options": [
            "Que el colegio administre el servicio y la planta si supera mil estudiantes, porque ese tamaño equivaldría a certificación y respaldaría el anuncio del alcalde de nombrar docentes por estar el establecimiento en su territorio.",
            "Que administre el servicio la entidad territorial certificada: el departamento, en este municipio no certificado, o un distrito o municipio que sí haya asumido la administración, y no el alcalde por el hecho de que el colegio esté en su territorio.",
            "Que administre el servicio la universidad más cercana con acreditación de alta calidad, mediante un convenio de práctica docente, para que el anuncio del alcalde quede mediado por un referente de excelencia y no por la disputa territorial.",
            "Que el colegio privado con convenio absorba la planta oficial de la institución, de modo que el alcalde del municipio no certificado no nombre docentes y la cobertura quede a cargo del particular aliado.",
        ],
        "explanation": "La condición de calidad pregunta quién administra el servicio educativo en la jurisdicción del alcalde de un municipio no certificado. La administración corresponde a la entidad territorial certificada: en este caso el departamento, y no el municipio por el mero hecho de que el colegio esté en su territorio. Superar mil estudiantes no equivale a certificación ni autoriza al colegio a nombrar la planta que el alcalde anuncia. La universidad acreditada más cercana puede convenir prácticas, pero no administra el servicio oficial. El colegio privado con convenio no absorbe la planta oficial ni sustituye a la ETC en la cobertura.",
        "normativeJustification": "La Ley 715 y el Decreto 1075 reservan la administración del servicio a las entidades territoriales certificadas. Un municipio no certificado no nombra la planta porque el colegio esté en su territorio; el tamaño, la universidad o el privado con convenio no certifican.",
        "theoreticalJustification": "La certificación es un régimen de competencia territorial, no de matrícula, de acreditación universitaria ni de cobertura privada. El anuncio del alcalde se corrige identificando a la ETC, aquí el departamento.",
        "distractorAnalysis": {
            "0": "Trampa del tamaño como certificación: si el colegio supera mil estudiantes parece que ya administra y respalda al alcalde. El umbral de matrícula no certifica al municipio ni transfiere la planta al establecimiento.",
            "2": "Trampa de dominio cruzado de calidad: la universidad acreditada con convenio de práctica luce como referente de excelencia. No administra el servicio educativo oficial en un municipio no certificado ni sustituye a la ETC.",
            "3": "Trampa del convenio de cobertura: que el privado absorba la planta oficial parece resolver el anuncio del alcalde. El convenio no sustituye a la ETC ni habilita al particular a tomar la planta del colegio oficial.",
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
        if n_sent < 4 or n_sent > 7:
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
