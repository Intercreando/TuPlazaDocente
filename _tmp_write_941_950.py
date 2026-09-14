# -*- coding: utf-8 -*-
"""Reescribe dir-apt-ped-193..200 y dir-apt-lec-201..202 (posiciones 941-950)."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
OUT = ROOT / "_tmp_out_941_950.json"

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
    "dir-apt-ped-193": 0,
    "dir-apt-ped-194": 1,
    "dir-apt-ped-195": 2,
    "dir-apt-ped-196": 3,
    "dir-apt-ped-197": 0,
    "dir-apt-ped-198": 1,
    "dir-apt-ped-199": 2,
    "dir-apt-ped-200": 3,
    "dir-apt-lec-201": 0,
    "dir-apt-lec-202": 1,
}

ITEMS = [
    {
        "id": "dir-apt-ped-193",
        "options": [
            "Estructurar, como mínimo, un inicio que active saberes previos, un desarrollo de construcción y aplicación, y un cierre de síntesis y evaluación, frente a la clase que hoy se reduce a exposición continua o a examen.",
            "Destinar la secuencia a actividades de evaluación sumativa comparable para el boletín y el SIEE, de modo que cada momento produzca evidencia homologable y se evite duplicar instrumentos ante la visita de calidad.",
            "Conservar la hora como exposición continua del docente, de modo que el contenido se cubra con rigor discursivo y la actividad de los estudiantes quede reservada para el examen de cierre, como ocurre hoy en esa clase.",
            "Organizar la hora como un flujo continuo y flexible, sin momentos internos de inicio, desarrollo y cierre, para que la exposición o el examen ocupen el tiempo según el ritmo que vaya tomando la clase.",
        ],
        "explanation": "La condición de calidad pregunta qué momentos debe contemplar, como mínimo, una secuencia didáctica bien estructurada. El docente del caso articula inicio con activación de saberes previos, desarrollo de construcción y aplicación, y cierre de síntesis y evaluación. Destinar la secuencia a sumativas comparables del SIEE parece rigor de boletín, pero reduce los momentos a instrumento de cierre. Conservar la exposición continua, como ocurre hoy, deja a los estudiantes fuera de la construcción. Un flujo sin estructura interna disfraza de flexibilidad la ausencia de momentos. Lo mínimo defendible es inicio, desarrollo y cierre.",
        "normativeJustification": "Los lineamientos curriculares y el Decreto 1290 exigen planeación que organice el aprendizaje, no apenas evidencia de cierre. Una secuencia bien estructurada contempla inicio, desarrollo y cierre; el SIEE no convierte esos momentos en meras sumativas comparables.",
        "theoreticalJustification": "La secuencia didáctica organiza el tiempo de enseñanza en momentos con función distinta: activar, construir y sintetizar. Exposición continua, flujo indiferenciado o batería sumativa miden discurso, flexibilidad o boletín, no esa estructura mínima.",
        "distractorAnalysis": {
            "1": "Trampa de dominio cruzado del SIEE: destinar cada momento a sumativa comparable parece rigor de boletín y de visita. Convierte la secuencia en instrumento de cierre y no responde a los momentos mínimos de inicio, desarrollo y cierre.",
            "2": "Trampa de la exposición continua: cubrir el contenido con el discurso docente parece rigor de la hora que hoy es clase o examen. Deja a los estudiantes fuera de la construcción y niega el desarrollo como aplicación.",
            "3": "Trampa del flujo flexible: un momento continuo sin estructura interna parece adaptarse al ritmo de la clase. Omite la activación de saberes, la construcción y la síntesis que una secuencia bien estructurada exige como mínimo.",
        },
    },
    {
        "id": "dir-apt-ped-194",
        "options": [
            "Aceptar que los estudiantes se pongan la nota y el docente deje de evaluar, de modo que la autoevaluación y la coevaluación sustituyan la heteroevaluación y cierren el período con el criterio del grupo.",
            "Que los estudiantes desarrollen criterio sobre su desempeño y el de pares, con rúbricas compartidas, fortaleciendo la reflexión y complementando la heteroevaluación, sin que el docente deje de evaluar.",
            "Reducir la responsabilidad del docente en el proceso evaluativo, argumentando que si hay autoevaluación y coevaluación con criterios, la heteroevaluación ya no exige juicio profesional ni seguimiento del período.",
            "Reservar la coevaluación y la autoevaluación a la educación superior o a la carpeta de evidencias de la visita de calidad, porque en básica y media el SIEE exige calificación docente comparable en el boletín.",
        ],
        "explanation": "La condición de calidad pregunta qué permiten principalmente la coevaluación y la autoevaluación junto a la heteroevaluación. Permiten que los estudiantes desarrollen criterio sobre su desempeño y el de pares, con rúbricas, fortaleciendo la reflexión y complementando el juicio docente. Que se pongan la nota y el docente deje de evaluar, como quieren en el caso, reemplaza la heteroevaluación. Reducir la responsabilidad docente confunde participación estudiantil con retiro profesional. Reservarlas a la educación superior o a la carpeta de la visita es un requisito de otro ámbito. Lo que permiten es complementar, no sustituir.",
        "normativeJustification": "El Decreto 1290 reconoce la autoevaluación y otras formas de participación estudiantil como parte del SIEE, sin relevar al docente de valorar. Complementan la heteroevaluación; no la sustituyen ni se reservan a la educación superior o a la visita de calidad.",
        "theoreticalJustification": "Coevaluar y autoevaluar forman criterio y reflexión cuando hay rúbricas y heteroevaluación. Ponerse la nota, aligerar al docente o archivarlas para acreditación miden empoderamiento, carga o carpeta, no esa función complementaria.",
        "distractorAnalysis": {
            "0": "Trampa de reemplazar al docente: que los estudiantes se pongan la nota parece empoderar la autoevaluación y la coevaluación. El caso pide complementar la heteroevaluación, no que el docente deje de evaluar.",
            "2": "Trampa de reducir la responsabilidad docente: si hay criterios de pares, parece que la heteroevaluación ya no exige juicio profesional. La coevaluación y la autoevaluación fortalecen la reflexión; no aligeran el deber de evaluar.",
            "3": "Trampa de dominio cruzado de la visita y la educación superior: reservarlas a la carpeta de calidad o al pregrado parece requisito de acreditación. En básica y media complementan la heteroevaluación con criterio estudiantil.",
        },
    },
    {
        "id": "dir-apt-ped-195",
        "options": [
            "Utilizar presentaciones digitales en reemplazo del tablero, de modo que pasar diapositivas acredite el uso de TIC y se actualice la exposición sin cambiar la lógica de transmitir el contenido de la clase.",
            "Evaluar el uso de dispositivos como fin en sí mismo, calificando que el estudiante traiga o maneje el aparato, y reportar esa evidencia como integración pedagógica de las TIC en el aula del caso.",
            "Integrar herramientas digitales de forma intencionada para simular, contrastar fuentes y producir, de modo que fortalezcan pensamiento y aprendizaje, y no se reduzcan a transmitir ni a prescindir de lo analógico cuando aporta.",
            "Prescindir de materiales físicos o análogos y reportar aula digital en el tablero de calidad y en el PMI de conectividad, para que el indicador de TIC quede cubierto ante la visita de la entidad.",
        ],
        "explanation": "La condición de calidad pregunta, más allá del uso instrumental, qué implica el uso pedagógico de las TIC. Implica integrar herramientas con intención para simular, contrastar fuentes y producir, fortaleciendo pensamiento y aprendizaje. Pasar diapositivas en reemplazo del tablero actualiza la exposición y sigue siendo transmitir. Calificar el dispositivo como fin convierte el aparato en evidencia. Prescindir de lo analógico para el PMI de conectividad cubre un indicador de visita, no la pedagogía. El uso defendible piensa con la herramienta, no la exhibe.",
        "normativeJustification": "Los lineamientos de competencias digitales del MEN orientan las TIC al aprendizaje, no al inventario de aparatos. El PMI puede registrar conectividad; ese tablero no define el uso pedagógico ni autoriza a prescindir de lo analógico cuando aporta.",
        "theoreticalJustification": "Pedagógico no es instrumental: la herramienta media procesos cognitivos. Diapositivas, nota al dispositivo o aula cien por ciento digital miden modernización, posesión o indicador, no pensamiento ni producción.",
        "distractorAnalysis": {
            "0": "Trampa del reemplazo del tablero: pasar diapositivas parece actualizar la clase y acreditar TIC. Conserva la lógica de transmitir contenido; es el uso instrumental que el caso contrapone al pedagógico.",
            "1": "Trampa del dispositivo como fin: calificar que el estudiante traiga o maneje el aparato parece evidencia de integración. Evalúa la posesión o el manejo, no el pensamiento ni la producción con la herramienta.",
            "3": "Trampa de dominio cruzado del PMI de conectividad: prescindir de materiales físicos y reportar aula digital cubre el indicador de TIC ante la visita. El stem pide uso pedagógico, no el tablero de calidad.",
        },
    },
    {
        "id": "dir-apt-ped-196",
        "options": [
            "El aprendizaje basado en problemas no requiere investigación por parte del estudiante, de modo que el tiempo de clase se destine a resolver el enunciado acotado y se gane ritmo frente al proyecto de mayor duración.",
            "El aprendizaje basado en proyectos no admite trabajo en equipo, para que cada evidencia sea individual y comparable en el boletín, a diferencia del problema acotado que sí se resolvería en grupo.",
            "Tratar ambos enfoques como el mismo indicador de aprendizaje activo para la visita de calidad, iguales en estructura y duración, de modo que el PMI los reporte sin distinguir el problema acotado del producto amplio.",
            "El aprendizaje basado en problemas se centra en un problema específico y acotado; el basado en proyectos suele derivar en un producto más amplio y de mayor duración, y ninguno excluye investigación ni trabajo en equipo.",
        ],
        "explanation": "La condición de calidad pregunta en qué se diferencia principalmente el aprendizaje basado en problemas del basado en proyectos. El primero se centra en un problema específico y acotado; el segundo suele derivar en un producto más amplio y de mayor duración. Afirmar que el problema no exige investigación vacía el ABPr para ganar ritmo de clase. Negar el trabajo en equipo en el proyecto sirve al boletín individual, no al enfoque. Tratarlos como el mismo indicador de aprendizaje activo del PMI borra la diferencia de alcance. Ambos son activos; difieren en objeto y duración.",
        "normativeJustification": "Las orientaciones de metodologías activas del MEN distinguen el problema acotado del proyecto con producto y mayor duración. El PMI puede registrar aprendizaje activo; ese indicador no homologa estructura ni excluye investigación o trabajo en equipo.",
        "theoreticalJustification": "ABPr y ABP comparten indagación y colaboración, y se separan por alcance: problema acotado versus producto amplio. Omitir investigación, prohibir el equipo o igualarlos en el tablero de calidad cambia el objeto de la diferencia.",
        "distractorAnalysis": {
            "0": "Trampa de omitir la investigación: resolver el enunciado acotado sin indagar parece ganar ritmo frente al proyecto. El ABPr exige investigación del estudiante; no se diferencia del ABP por ahorrar pesquisa.",
            "1": "Trampa de la evidencia individual: negar el equipo en el proyecto parece rigor de boletín comparable. El ABP admite trabajo colaborativo; la diferencia con el ABPr no es la imposibilidad de agrupar.",
            "2": "Trampa de dominio cruzado del PMI: tratarlos como el mismo indicador de aprendizaje activo, iguales en estructura y duración, parece eficiencia ante la visita. Borra el problema acotado frente al producto amplio.",
        },
    },
    {
        "id": "dir-apt-ped-197",
        "options": [
            "Usar variedad de estrategias y recursos para todos los estudiantes, sin limitar la enseñanza a un estilo visual, auditivo o kinestésico supuesto como canal dominante del resto del año.",
            "Diagnosticar un estilo visual, auditivo o kinestésico y orientar el resto del año a ese canal, como personalización rigurosa del diagnóstico que ya hicieron y como atención a la diversidad del grupo.",
            "Evaluar en el formato visual, auditivo o kinestésico declarado como preferido, aun cuando esa evidencia no muestre el aprendizaje esencial del período ni el desempeño que el área exige.",
            "Separar el grupo de forma permanente por estilo declarado y registrarlo como ajuste razonable del Decreto 1421, sin PIAR, para que la inclusión quede documentada en la carpeta de la sede.",
        ],
        "explanation": "La condición de calidad pregunta qué recomienda principalmente la evidencia pedagógica actual respecto a los llamados estilos de aprendizaje. Recomienda variedad de estrategias y recursos para todos, sin limitar la enseñanza a un estilo visual, auditivo o kinestésico supuesto. Diagnosticar un canal y orientar el año a ese canal, como quieren en el caso, etiqueta y reduce la oferta. Evaluar en el formato preferido puede omitir el aprendizaje esencial. Separar el grupo y cargarlo al Decreto 1421 sin PIAR convierte un estilo declarado en ajuste de inclusión. La evidencia pide diversificar para todos, no fijar un canal.",
        "normativeJustification": "El DUA y el Decreto 1421 orientan múltiples medios de representación y de acción, con PIAR cuando hay barreras de aprendizaje. Un estilo VAK declarado no es ajuste razonable ni autoriza a segregar el grupo ni a evaluar fuera del aprendizaje esencial.",
        "theoreticalJustification": "La hipótesis de emparejar enseñanza y estilo visual, auditivo o kinestésico carece de respaldo robusto. Variedad para todos supera el canal fijo, el examen en formato preferido y la separación permanente disfrazada de inclusión.",
        "distractorAnalysis": {
            "1": "Trampa del canal dominante: orientar el año al estilo diagnosticado parece personalización y atención a la diversidad. Fija un perfil VAK y niega la variedad de estrategias que la evidencia recomienda para todos.",
            "2": "Trampa del formato preferido: evaluar en visual, auditivo o kinestésico declarado parece respeto a la diversidad. Puede no evidenciar el aprendizaje esencial del período ni el desempeño que el área exige.",
            "3": "Trampa de dominio cruzado del Decreto 1421: separar por estilo y registrarlo como ajuste razonable, sin PIAR, parece inclusión documentada. Un canal VAK no es barrera que autorice segregación permanente.",
        },
    },
    {
        "id": "dir-apt-ped-198",
        "options": [
            "Consignar en la planeación el tema a desarrollar, sin propósito explícito de aprendizaje, como propone el primer actor, para que el formato quede listo y el docente sepa de qué hablará en la hora.",
            "Articular los propósitos de aprendizaje, las actividades o desempeños esperados y las evidencias que permitirán valorar el logro, de modo que la planeación de aula no se agote en el tema, la bibliografía o la duración.",
            "Registrar la bibliografía que el docente usará en la clase, como insiste el segundo actor, de modo que la planeación acredite fuentes y el acta de calidad muestre soporte académico del tema tratado.",
            "Consignar el tiempo de duración de la clase como evidencia de cumplimiento horario para el calendario y la visita de calidad, como sugiere el tercero, y dar por formulada la planeación con ese dato.",
        ],
        "explanation": "La condición de calidad pregunta qué decisión es la más defendible pedagógica e institucionalmente ante las propuestas en conflicto. Una planeación de aula bien formulada articula propósitos de aprendizaje, actividades o desempeños esperados y evidencias de logro. Consignar el tema sin propósito, como propone el primer actor, deja la hora sin rumbo evaluable. Registrar la bibliografía, como insiste el segundo, acredita fuentes y no el aprendizaje. Consignar la duración para el calendario y la visita parece cumplimiento horario, no planeación. Lo defendible es propósito, desempeño y evidencia.",
        "normativeJustification": "El Decreto 1290 y los lineamientos de planeación del MEN exigen propósitos, desempeños y evidencias, no un tema suelto. La bibliografía documenta fuentes; el calendario documenta minutos; ninguno sustituye la formulación pedagógica del aula.",
        "theoreticalJustification": "Planear es declarar qué se espera aprender, cómo se trabajará y con qué se valorará. Tema, listado de libros o duración de la hora miden enunciado, soporte o reloj, no esa articulación.",
        "distractorAnalysis": {
            "0": "Trampa del tema sin propósito: consignar de qué se hablará parece dejar el formato listo, como propone el primer actor. Sin propósito explícito no hay rumbo ni criterio para valorar el logro.",
            "2": "Trampa de la bibliografía: registrar las fuentes que usará el docente parece rigor académico, como insiste el segundo actor. Acredita lecturas, no propósitos, desempeños ni evidencias de aprendizaje.",
            "3": "Trampa de dominio cruzado del calendario y la visita: consignar la duración como cumplimiento horario parece evidencia de jornada. El stem pide planeación pedagógica, no el reloj de la clase.",
        },
    },
    {
        "id": "dir-apt-ped-199",
        "options": [
            "Entregar a todo el grupo la misma devolución genérica de «bien», sin distinción de evidencia, de modo que el cierre del trabajo quede registrado y el clima se conserve con un comentario homogéneo.",
            "Entregar la retroalimentación al finalizar el año escolar, cuando ya está el boletín, de modo que el comentario acompañe la nota de cierre y no interrumpa el desarrollo de las unidades del período.",
            "Caracterizarse como oportuna, específica y orientada a acciones concretas de mejora, más que como una valoración general de «bien» o como el mero señalamiento de errores al cierre del año.",
            "Centrarla en señalar errores y dejar la nota comparable en el SIEE, sin un siguiente paso de mejora, para que el boletín documente el desacierto y la evidencia quede homologable ante la visita.",
        ],
        "explanation": "La condición de calidad pregunta cómo debe caracterizarse principalmente la retroalimentación docente para que sea efectiva. Debe ser oportuna, específica y orientada a acciones concretas de mejora, más que una valoración general. El «bien» idéntico para todos, como en el caso, registra cierre y no orienta. Entregarla al finalizar el año llega cuando ya no hay tiempo de ajustar. Señalar errores y dejar la nota del SIEE produce comparabilidad de boletín, no siguiente paso. Lo efectivo es devolver a tiempo, con evidencia y con una acción de mejora.",
        "normativeJustification": "El Decreto 1290 orienta una evaluación formativa que informe al estudiante y permita mejorar durante el proceso. Una devolución genérica, tardía o reducida a la nota comparable no cumple esa función; la retroalimentación efectiva anticipa el cierre del año.",
        "theoreticalJustification": "Retroalimentar es devolver información usable: a tiempo, anclada a la evidencia y con un paso siguiente. El «bien» homogéneo, el comentario de fin de año o el recuento de errores del SIEE miden clima, cierre o desacierto, no mejora.",
        "distractorAnalysis": {
            "0": "Trampa del «bien» genérico: la misma devolución para todos parece conservar el clima y registrar el cierre del trabajo. No distingue evidencia ni orienta una acción concreta de mejora.",
            "1": "Trampa del comentario de fin de año: entregar la retroalimentación cuando ya está el boletín parece no interrumpir las unidades. Llega tarde para ajustar el aprendizaje durante el proceso.",
            "3": "Trampa de dominio cruzado del SIEE: señalar errores y dejar la nota comparable parece rigor de boletín ante la visita. Omite el siguiente paso de mejora que caracteriza a la retroalimentación efectiva.",
        },
    },
    {
        "id": "dir-apt-ped-200",
        "options": [
            "Adoptar la propuesta del primer actor y entender la transposición didáctica como la traducción literal de un libro de texto a otro idioma, para disponer el material en la lengua de la sede.",
            "Adoptar la propuesta del segundo actor y entenderla como el traslado físico de estudiantes entre distintas sedes educativas, registrando el movimiento en SIMAT como si ese cambio de establecimiento fuera la transposición.",
            "Adoptar la propuesta del tercero y sustituir al docente por materiales autodidácticos, de modo que el saber disciplinar llegue al estudiante sin mediación y la transposición quede resuelta en el paquete de recursos.",
            "Entenderla como el proceso mediante el cual un saber científico o disciplinar se transforma en un saber enseñable y adaptado al contexto escolar, frente a las lecturas de traducción, traslado de sede o sustitución del docente.",
        ],
        "explanation": "La condición de calidad pregunta qué decisión es la más defendible pedagógica e institucionalmente sobre la transposición didáctica. Chevallard la define como el paso del saber científico o disciplinar a un saber enseñable y adaptado al contexto escolar. La traducción literal de un libro a otro idioma, como propone el primer actor, es un cambio lingüístico, no didáctico. El traslado entre sedes, como insiste el segundo, es un movimiento de matrícula. Sustituir al docente por materiales autodidácticos, como sugiere el tercero, elimina la mediación. Lo defendible es transformar el saber, no traducirlo, trasladarlo ni reemplazar al maestro.",
        "normativeJustification": "El saber escolar del PEI y de los lineamientos curriculares se construye al adaptar el conocimiento disciplinar al contexto de la institución. SIMAT registra traslados; la traducción de un texto y el paquete autodidáctico no sustituyen esa transformación didáctica.",
        "theoreticalJustification": "La transposición didáctica de Chevallard convierte un saber sabio en saber a enseñar. Traducir un libro, mover cupos entre sedes o retirar al docente miden lengua, matrícula o autosuficiencia, no esa conversión.",
        "distractorAnalysis": {
            "0": "Trampa de la traducción literal: pasar un libro de texto a otro idioma parece disponer el material para la lengua de la sede, como propone el primer actor. Es un cambio lingüístico, no la transformación del saber disciplinar en saber enseñable.",
            "1": "Trampa de dominio cruzado del SIMAT: el traslado físico entre sedes parece una transposición de estudiantes, como insiste el segundo actor. Es un movimiento de matrícula; no convierte un saber científico en saber escolar.",
            "2": "Trampa de los materiales autodidácticos: sustituir al docente por un paquete parece hacer llegar el saber sin mediación, como sugiere el tercero. Elimina la adaptación al contexto escolar que define la transposición.",
        },
    },
    {
        "id": "dir-apt-lec-201",
        "options": [
            "La idea principal es que modelar en voz alta preguntas metacognitivas antes, durante y después de la lectura ayuda a que los estudiantes interioricen estrategias de comprensión y las apliquen de manera autónoma.",
            "La idea principal es que enseñar a comprender un texto se agota en verificar si el estudiante reconoce las palabras, de modo que esa comprobación de léxico constituye el acompañamiento lector descrito.",
            "La idea principal es que los estudiantes interiorizan por sí mismos las estrategias de preguntarse qué esperan encontrar, si tiene sentido y qué aprendieron, de modo que el modelado en voz alta resulta prescindible.",
            "La idea principal es que leer en voz alta frente al grupo constituye evidencia comparable de fluidez para el boletín y el SIEE, de modo que esa lectura pública certifica la comprensión según el Decreto 1290.",
        ],
        "explanation": "La condición de calidad pregunta cuál es la idea principal del texto. El relato sostiene que comprender no se agota en reconocer palabras y que modelar en voz alta preguntas antes, durante y después ayuda a interiorizar estrategias autónomas. Tomar la verificación de palabras como idea central invierte el primer rechazo del texto. Afirmar que los estudiantes interiorizan esas estrategias sin el modelado omite la mediación que el relato describe. Convertir la lectura en voz alta en evidencia de fluidez del SIEE aplica un saber del Decreto 1290 que el texto no enuncia. La idea principal es el modelado metacognitivo en los tres momentos.",
        "normativeJustification": "El ítem evalúa la idea principal del relato, no la aplicación autónoma del Decreto 1290 ni del SIEE. El texto afirma modelado en voz alta e interiorización de estrategias; no afirma que la lectura pública certifique fluidez en el boletín.",
        "theoreticalJustification": "La idea principal sintetiza propósito, mediación y efecto: modelar preguntas en tres momentos para interiorizar comprensión. Un detalle invertido, una autonomía sin modelo y un saber calificativo externo no agotan esa síntesis.",
        "distractorAnalysis": {
            "1": "Trampa del detalle invertido: tomar la verificación de palabras como idea central parece el acompañamiento lector del primer párrafo. El texto afirma que comprender no se agota en reconocer el léxico.",
            "2": "Trampa de la sobregeneralización: si el fin es la autonomía, el modelado en voz alta parece prescindible. El relato sostiene que interiorizar las estrategias depende de ese modelado docente frente al grupo.",
            "3": "Trampa de dominio cruzado del Decreto 1290 y el SIEE: leer en voz alta como evidencia comparable de fluidez parece certificación de comprensión. El texto no habla de calificación ni de boletín.",
        },
    },
    {
        "id": "dir-apt-lec-202",
        "options": [
            "El texto recomienda que el estudiante se haga preguntas después de terminar la lectura, cuando ya puede decir qué aprendió al finalizar, y ese cierre concentra el acompañamiento metacognitivo descrito.",
            "El texto recomienda que el estudiante se haga preguntas antes, durante y después de la lectura: qué espera encontrar, si lo que está leyendo tiene sentido y qué aprendió al finalizar, como momentos de la estrategia.",
            "El texto recomienda que el estudiante se haga preguntas antes de comenzar a leer, cuando anticipa qué espera encontrar, y esa anticipación agota los momentos de la estrategia de comprensión descrita.",
            "El texto recomienda que el estudiante se haga las preguntas cuando el docente lo indique por escrito como evidencia de proceso para el SIEE, de modo que quede registro comparable de la metacognición.",
        ],
        "explanation": "La condición de calidad pregunta en qué momentos se recomienda que el estudiante se haga preguntas sobre el texto. El relato nombra de forma expresa antes, durante y después: qué espera encontrar, si lo que lee tiene sentido y qué aprendió al finalizar. Quedarse en el cierre toma un detalle y lo vuelve el momento que agota el acompañamiento. Quedarse en la anticipación hace lo mismo con el inicio. Pedir las preguntas por escrito como evidencia de proceso del SIEE introduce un requisito de registro que el texto no formula: habla de modelado en voz alta. Los tres momentos son los que el texto recomienda.",
        "normativeJustification": "El ítem evalúa los momentos que el texto enuncia, no un protocolo de evidencia escrita del SIEE. El relato articula antes, durante y después; no condiciona las preguntas a una indicación por escrito del docente.",
        "theoreticalJustification": "Una estrategia metacognitiva lectora cubre anticipación, monitoreo y recapitulación. Tomar un momento, o sustituirlo por un registro comparable, fragmenta o desplaza lo que el texto nombra en tres tiempos.",
        "distractorAnalysis": {
            "0": "Trampa del detalle de cierre: concentrar las preguntas en qué aprendió al finalizar parece el momento más completo del acompañamiento. El texto nombra también el antes y el durante, no apenas el término de la lectura.",
            "2": "Trampa del detalle de anticipación: preguntar qué espera encontrar antes de leer parece agotar la estrategia. El relato añade el monitoreo durante la lectura y la recapitulación al finalizar.",
            "3": "Trampa de dominio cruzado del SIEE: indicar las preguntas por escrito como evidencia de proceso parece registro comparable de metacognición. El texto habla de modelado en voz alta, no de indicación escrita.",
        },
    },
]


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {
        k: it[k]
        for k in (
            "id",
            "options",
            "explanation",
            "normativeJustification",
            "theoreticalJustification",
            "distractorAnalysis",
        )
    }


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
            blob = f"{opt} {it.get('explanation')} {it.get('normativeJustification')} {it.get('theoreticalJustification')}"
            if "p. ej." in blob.lower() or "p.ej." in blob.lower():
                errors.append(f"P EJ {tag}")
            if oi != ci:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                low = opt.lower()
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
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
                if not str(v).startswith("Trampa"):
                    errors.append(f"DA PREFIX {tag} {k}")
                if "p. ej." in (v or "").lower():
                    errors.append(f"P EJ DA {tag} {k}")
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
            "sent",
            it["explanation"].count("."),
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
