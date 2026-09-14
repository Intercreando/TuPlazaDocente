# -*- coding: utf-8 -*-
"""Reescribe dir-apt-blan-253..260 y dir-apt-dis-261..262 (posiciones 1001-1010)."""
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import dump_and_report  # noqa: E402

OUT = ROOT / "_tmp_out_1001_1010.json"
CI = {
    "dir-apt-blan-253": 0,
    "dir-apt-blan-254": 1,
    "dir-apt-blan-255": 2,
    "dir-apt-blan-256": 3,
    "dir-apt-blan-257": 0,
    "dir-apt-blan-258": 1,
    "dir-apt-blan-259": 2,
    "dir-apt-blan-260": 3,
    "dir-apt-dis-261": 0,
    "dir-apt-dis-262": 1,
}

ITEMS = [
    {
        "id": "dir-apt-blan-253",
        "options": [
            "Agendar un espacio conjunto entre el docente de aula y el de apoyo para alinear las estrategias del PIAR, de modo que el estudiante no reciba mensajes contradictorios en las actividades cotidianas.",
            "Mantener cada uno sus estrategias en nombre de la autonomía de cátedra, documentándolas por separado, para que el PIAR del estudiante quede cubierto sin negociar el método de cada docente.",
            "Dejar las actividades lectivas en el docente de aula y reservar al de apoyo los formatos 1421 de la visita de calidad, para cumplir el expediente del PIAR mientras el grupo no se detiene.",
            "Pausar los apoyos previstos hasta el próximo comité de PIAR, cuando haya un acta que unifique criterio, a fin de no improvisar ajustes cruzados que luego la familia cuestione.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando aula y apoyo no coordinan el PIAR. Un espacio conjunto alinea estrategias y evita mensajes contradictorios. La autonomía de cátedra fragmenta el plan. Reservar al de apoyo los formatos 1421 cumple la visita y vacía el aula. Pausar hasta el comité deja al estudiante sin el apoyo ya previsto.",
        "normativeJustification": "El Decreto 1421 exige coherencia entre aula y apoyo en el PIAR. La autonomía de cátedra, el expediente de visita y la espera al comité no autorizan a descoordinar o suspender los ajustes.",
        "theoreticalJustification": "El PIAR es un plan compartido. La fragmentación por cátedra, el papel de la visita o la pausa hasta el acta miden autonomía, calidad documental o dilación, no la ética pedida.",
        "distractorAnalysis": {
            "1": "Trampa de la autonomía de cátedra: documentar estrategias por separado parece profesionalismo. Deja al estudiante con mensajes contradictorios y niega la coordinación que el PIAR exige.",
            "2": "Trampa de dominio cruzado de la visita 1421: que el de apoyo llene formatos y el de aula siga con el grupo luce como cumplimiento de calidad. Separa el expediente del ajuste real y no alinea las estrategias cotidianas.",
            "3": "Trampa de esperar el comité: pausar los apoyos hasta un acta unificada parece orden institucional. Interrumpe lo ya previsto en el PIAR y deja al estudiante sin el ajuste mientras se coordina el papel.",
        },
    },
    {
        "id": "dir-apt-blan-254",
        "options": [
            "Convertir al estudiante de alto rendimiento en tutor permanente de quienes van más lento, como enriquecimiento, para que el aburrimiento se resuelva en apoyo a pares y el ritmo del grupo no se toque.",
            "Ofrecerle actividades de profundización o retos adicionales que enriquezcan su aprendizaje, sin desatender al resto del grupo ni convertirlo en auxiliar de la clase.",
            "Aplicarle quizzes extra de mayor dificultad como evidencia comparable de enriquecimiento en el SIEE, de modo que el aburrimiento quede registrado como desafío superado en el período.",
            "Pedirle que espere al ritmo del PEI, recordando que la planeación del grado es la misma para todos y que el aburrimiento se regula con más práctica del mismo nivel.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante de alto rendimiento se aburre por el ritmo lento. Profundización y retos, sin desatender al grupo, responden al DUA. Usarlo como tutor permanente lo instrumentaliza. Los quizzes extra convierten el enriquecimiento en SIEE. Esperar al ritmo del PEI niega la diferenciación.",
        "normativeJustification": "Los DBA y el DUA piden vías de profundización. El SIEE no obliga quizzes de enriquecimiento; el PEI no impide retos; tutorizar de forma permanente no es el ajuste del caso.",
        "theoreticalJustification": "El alto desempeño pide complejidad, no más de lo mismo ni rol de auxiliar. La tutoría permanente, el quiz o la espera al PEI miden clima, evidencia o homogeneidad, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa del tutor permanente: poner al de alto rendimiento a ayudar a los más lentos parece enriquecimiento y clima. Lo instrumentaliza y no le ofrece el reto cognitivo que pidió.",
            "2": "Trampa de dominio cruzado del SIEE: quizzes extra de mayor dificultad lucen como evidencia comparable de enriquecimiento. Convierten el aburrimiento en más prueba y no en profundización de aprendizaje.",
            "3": "Trampa del ritmo único del PEI: esperar y repetir el mismo nivel parece equidad de grado. Niega la diferenciación y deja intacto el aburrimiento que el estudiante ya manifestó.",
        },
    },
    {
        "id": "dir-apt-blan-255",
        "options": [
            "Completar registros y formatos con copias genéricas reutilizadas, para cumplir la visita de calidad en los plazos y recuperar horas de planeación pedagógica sin dejar casillas vacías.",
            "Absorber la carga administrativa extendiendo la jornada en silencio, para no tensionar a coordinación ni al rector y sostener a la vez los reportes y la planeación de clase.",
            "Comunicar de forma constructiva al coordinador o rector que los registros están comiendo tiempo de planeación y proponer, si es posible, un orden o un acople de formatos que libere horas lectivas de calidad.",
            "Pedir que la sobrecarga de reportes se compute como evidencia adicional de desempeño 1278, de modo que el tiempo administrativo quede reconocido en la evaluación de planta.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando lo administrativo reduce el tiempo de planeación. Comunicarlo con propuestas de acople es liderazgo responsable. Copiar formatos genéricos simula la visita. Extender la jornada en silencio naturaliza la sobrecarga. Pedir que cuente para el 1278 cambia el objeto: de tiempo pedagógico a puntaje de planta.",
        "normativeJustification": "El Decreto 1075 y la gestión escolar piden reportar cuellos de botella y cuidar la planeación. La simulación documental, el silencio heroico y el 1278 no resuelven el conflicto de tiempo.",
        "theoreticalJustification": "La planeación es el núcleo del trabajo docente. Simular formatos, aguantar en silencio o capitalizar el 1278 miden visita, sacrificio o evaluación de planta, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la visita cumplida: rellenar con copias genéricas parece no dejar vacíos. Simula calidad y sigue restando tiempo real a la planeación pedagógica que el caso pone en riesgo.",
            "1": "Trampa del silencio profesional: extender la jornada sin decirlo parece compromiso. Naturaliza la sobrecarga y evita el canal institucional que podría reordenar formatos.",
            "3": "Trampa de dominio cruzado del Decreto 1278: pedir que los reportes sumen a desempeño luce como reconocimiento laboral. El stem pide proteger la planeación, no convertir la carga en puntaje de planta.",
        },
    },
    {
        "id": "dir-apt-blan-256",
        "options": [
            "Responder en el acto con un llamado de atención público que restaure la autoridad ante el grupo, para que la falta de respeto verbal no quede como precedente de impunidad en la clase.",
            "Retirar al estudiante del aula de inmediato y enviarlo a casa el resto de la jornada, para proteger el clima y mostrar que faltar al respeto al docente tiene consecuencia visible.",
            "Rebajar la nota de período por actitud, consignando la falta verbal como evidencia de convivencia en el SIEE, de modo que el grupo vea el costo académico del irrespeto.",
            "Mantener la calma, marcar el límite con firmeza y respeto, y formalizar después la situación según el manual de convivencia, sin devolver el agravio ni resolverlo como espectáculo.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante falta al respeto verbalmente frente al grupo. Calma, límite claro y trámite posterior según el manual protegen dignidad y debido proceso. El llamado público escala el espectáculo. Enviar a casa es medida de hecho. Bajar la nota de actitud usa el SIEE como desquite.",
        "normativeJustification": "La Ley 1620 y el manual exigen proporcionalidad, reserva y debido proceso. La expulsión a casa, el escarnio y la nota de período no son el primer cauce de una falta verbal en clase.",
        "theoreticalJustification": "El irrespeto se contiene sin devolver violencia simbólica. El llamado público, el envío a casa o la nota miden autoridad visible, hecho o SIEE, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de restaurar autoridad: el llamado público parece poner el límite. Convierte la falta verbal en espectáculo y puede escalar el conflicto ante el mismo grupo.",
            "1": "Trampa de la consecuencia visible: enviarlo a casa parece proteger el clima. Es una medida de hecho que salta el manual y puede vulnerar el derecho a permanecer en la jornada.",
            "2": "Trampa de dominio cruzado del SIEE: bajar la nota de actitud luce como evidencia de convivencia. Mezcla evaluación del aprendizaje con sanción del irrespeto y no tramita el caso por el manual.",
        },
    },
    {
        "id": "dir-apt-blan-257",
        "options": [
            "Atender por separado a cada familia, escuchando su versión del conflicto entre los dos estudiantes, y recién entonces valorar un espacio conjunto si hay condiciones de calma y confidencialidad.",
            "Recibirlos juntos de inmediato en la misma sala, para que cada parte oiga a la otra y la transparencia del encuentro corte de raíz el enojo con el que llegaron a la IE.",
            "Facilitar que las dos familias resuelvan el conflicto en un espacio de la IE, con el docente como testigo, argumentando autonomía de los hogares y rapidez frente a la molestia simultánea.",
            "Remitir a ambas familias al Consejo Directivo esa misma tarde, para que el gobierno escolar reciba el enojo y el docente no quede como juez del conflicto entre los dos estudiantes.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando dos familias molestas llegan juntas tras un conflicto entre estudiantes. Escuchar por separado y, si cabe, unir después cuida calma, confidencialidad y debido proceso. El encuentro inmediato conjunto puede inflamar. Dejar que zanjéen solas delega la conducción. El Consejo Directivo no es la sala de urgencia de un conflicto entre pares.",
        "normativeJustification": "El manual y la reserva de la información de cada menor piden atención diferenciada. El gobierno escolar y la autonomía de familias no sustituyen la conducción del docente y de la IE.",
        "theoreticalJustification": "Dos versiones airadas se escuchan primero en privado. El cara a cara inmediato, el arreglo entre hogares o el Consejo miden transparencia, delegación o instancia, no la ética pedida.",
        "distractorAnalysis": {
            "1": "Trampa de la transparencia conjunta: recibirlos juntos de inmediato parece equidad. Cruza información de dos menores y puede escalar el enojo con el que llegaron.",
            "2": "Trampa de la autonomía de familias: que ellas resuelvan con el docente de testigo parece rapidez. Abdica la conducción institucional del conflicto entre los dos estudiantes.",
            "3": "Trampa de dominio cruzado del gobierno escolar: remitir al Consejo Directivo esa tarde luce como canal superior. Confunde una instancia de PEI con la atención urgente y reservada que el docente debe ordenar primero.",
        },
    },
    {
        "id": "dir-apt-blan-258",
        "options": [
            "Comunicar el resultado del período leyendo la escala del SIEE y los desempeños no logrados, sin detenerse en el esfuerzo visible, para no mezclar la noticia académica con un consuelo que diluya el juicio.",
            "Reconocer el esfuerzo visible, explicar con claridad las áreas por fortalecer y ofrecer un plan concreto de apoyo, de modo que la noticia del período no se reduzca a un número ni a una comparación con pares.",
            "Ajustar al alza el informe del período porque el esfuerzo fue evidente, para no desmotivar a quien sí trabajó y cuidar el vínculo con el estudiante que no alcanzó los objetivos.",
            "Registrar en el observador que el resultado se explica por falta de acompañamiento familiar, y comunicar esa lectura al estudiante, para que la responsabilidad del período quede situada fuera del aula.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente al informar que, pese al esfuerzo visible, no se lograron los objetivos del período. Reconocer el esfuerzo, explicar brechas y ofrecer apoyo sostiene motivación y SIEE. Leer solo la escala es rigor frío. Subir la nota por el esfuerzo altera el juicio. Cargar a la familia en el observador desplaza la responsabilidad pedagógica.",
        "normativeJustification": "El Decreto 1290 pide retroalimentación que oriente la mejora. El alza por esfuerzo y la culpa familiar no son el informe ético; la escala sin plan de apoyo tampoco agota el deber.",
        "theoreticalJustification": "Una noticia dura se sostiene con reconocimiento y siguiente paso. El rigor de la escala, el alza por clima o el observador a la familia miden SIEE seco, vínculo o 1278 de terceros, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa del rigor de la escala: leer el SIEE sin nombrar el esfuerzo parece objetividad. Omite el plan de apoyo y puede quebrar la motivación de quien sí trabajó.",
            "2": "Trampa del alza por esfuerzo: subir el informe parece cuidado del vínculo. Falsea el logro de los objetivos del período y enseña que el esfuerzo sustituye el aprendizaje.",
            "3": "Trampa de dominio cruzado de la familia: cargar el observador al acompañamiento del hogar luce como diagnóstico integral. Traslada la noticia a una culpa externa y no ofrece el plan de apoyo que el estudiante necesita.",
        },
    },
    {
        "id": "dir-apt-blan-259",
        "options": [
            "Compartir lo oído con el equipo de área, «para que todos puedan apoyar», sin acordarlo con el estudiante, de modo que la situación familiar difícil quede en el radar de varios adultos de la IE.",
            "Agradecer la confianza, seguir con la clase y programar una sesión de valores la semana siguiente, para no dramatizar lo confiado y devolver al grupo el hilo de la asignatura.",
            "Escuchar con respeto, cuidar la confidencialidad que el caso permita y orientar hacia orientación escolar u otro apoyo institucional si la situación familiar lo requiere, sin usurpar el rol de la familia.",
            "Abrir una actuación de convivencia que involucre a la familia, con base en lo confiado, para que el manual cubra el malestar del estudiante como un asunto de clima del hogar.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando un estudiante comparte en confianza una situación familiar difícil. Escuchar, reservar y canalizar a apoyo institucional es el deber de cuidado. Contarlo al área rompe la reserva. Seguir la clase y dejarlo para valores minimiza. Abrir convivencia contra la familia usa el 1620 fuera de lugar.",
        "normativeJustification": "La reserva de la información del menor y las rutas de apoyo (orientación, 1620 cuando hay riesgo) piden canal institucional, no chisme de área ni expediente de convivencia contra el hogar por el hecho de confiar.",
        "theoreticalJustification": "La confianza se honra con escucha y derivación pertinente. El radar del área, la clase de valores o el manual contra la familia miden coordinación, minimización o 1620, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa del apoyo colectivo: informar al área «para que todos apoyen» parece red de cuidado. Rompe la confidencialidad de lo que el estudiante confió de su familia.",
            "1": "Trampa de no dramatizar: seguir la clase y dejar una sesión de valores parece prudencia pedagógica. Minimiza lo confiado y retrasa el apoyo institucional que podría necesitar.",
            "3": "Trampa de dominio cruzado de la Ley 1620: abrir convivencia que involucre a la familia luce como ruta. Convierte una confidencia en expediente de clima y puede revictimizar al estudiante.",
        },
    },
    {
        "id": "dir-apt-blan-260",
        "options": [
            "Citar a la familia a una reunión presentando la baja de rendimiento y el cambio de comportamiento como falta de estudio, para que el hogar corrija de inmediato las últimas semanas.",
            "Activar el paquete de recuperación del SIEE por la baja académica, sin conversar aún con el estudiante, para no perder las evidencias de período mientras el comportamiento se observa aparte.",
            "Iniciar un proceso de convivencia por cambio de actitud, con registro en coordinación, de modo que el descenso académico y el nuevo comportamiento queden cubiertos por el manual.",
            "Acercarse con empatía al estudiante para indagar qué está ocurriendo en estas semanas y, si hace falta, activar orientación u otros apoyos institucionales, antes de asumir causas.",
        ],
        "explanation": "La condición de calidad pide la conducta más defendible ética e institucionalmente cuando bajan el rendimiento y cambia el comportamiento. Indagar con empatía y activar apoyos si cabe evita diagnósticos prematuros. Citar a la familia por «falta de estudio» culpa sin oír. La recuperación del SIEE trata el síntoma académico. El proceso de convivencia trata el síntoma actitudinal. Ninguna pregunta primero qué pasa.",
        "normativeJustification": "El cuidado y las rutas de apoyo piden escucha antes de medidas. El SIEE y el 1620 no son el primer paso ante un cambio reciente; la citación punitiva a la familia tampoco.",
        "theoreticalJustification": "Un cambio reciente es una señal, no aún una falta. La empatía abre la causa. La culpa familiar, la recuperación o el manual miden hogar, SIEE o 1620, no la ética pedida.",
        "distractorAnalysis": {
            "0": "Trampa de la falta de estudio: citar a la familia con esa lectura parece corresponsabilidad. Diagnostica sin oír al estudiante y puede cerrar el relato de las últimas semanas.",
            "1": "Trampa de la recuperación inmediata: abrir el SIEE parece no perder el período. Trata la baja como hueco de evidencias y deja el cambio de comportamiento sin indagación.",
            "2": "Trampa de dominio cruzado de la Ley 1620: el proceso por cambio de actitud luce como orden de convivencia. Convierte un posible malestar en falta al manual y salta la escucha empática.",
        },
    },
    {
        "id": "dir-apt-dis-261",
        "options": [
            "Validar 7/8, con 3/4 equivalente a 6/8 y 6/8 + 1/8, y reenseñar que sumar 3+1 y 4+8 (4/12) o usar 12 sin convertir 3/4 (7/12) no justifica equivalencia.",
            "Validar 4/12 como procedimiento regular de «sumar arriba y abajo», porque deja un algoritmo visible y comparable para la rúbrica de 4° aunque no conserve el entero de referencia.",
            "Validar 1/2 como estimación suficiente de 3/4 + 1/8, porque «casi es la mitad» agiliza la socialización y evita detenerse en fracciones equivalentes en el cuaderno.",
            "Validar 7/12 porque 12 es común a 4 y 8, y registrar esa fracción como evidencia de mínimo común en el SIEE, aunque 3/4 no se haya convertido a doceavos.",
        ],
        "explanation": "La condición de calidad pide qué producción evidencia el aprendizaje esencial de suma de fracciones y qué error reenseñar. 3/4 = 6/8 y 6/8 + 1/8 = 7/8 justifica equivalencia. 4/12 suma numeradores y denominadores. 1/2 estima sin equivalencia. 7/12 usa 12 sin convertir 3/4. La rúbrica pide la equivalencia, no un algoritmo suelto ni una evidencia de mcm en el SIEE.",
        "normativeJustification": "Los DBA de matemáticas de básica primaria piden justificar equivalencia al sumar fracciones. El SIEE no autoriza a validar 7/12 como mínimo común ni 4/12 como algoritmo regular.",
        "theoreticalJustification": "Sumar fracciones exige común denominador y conversión. 7/8 lo cumple. 4/12, 1/2 y 7/12 son errores de magnitud o de equivalencia incompleta.",
        "distractorAnalysis": {
            "1": "Trampa del algoritmo regular: 4/12 parece un procedimiento enseñable y comparable. Suma numeradores y denominadores por separado y no evidencia el aprendizaje esencial de equivalencia.",
            "2": "Trampa de la estimación cotidiana: 1/2 «casi la mitad» parece sentido numérico. Evita la equivalencia a octavos que la rúbrica de 4° pide justificar.",
            "3": "Trampa de dominio cruzado del SIEE: validar 7/12 porque 12 es común luce como evidencia de mínimo común. Deja 3/4 sin convertir y no es 6/8 + 1/8 = 7/8.",
        },
    },
    {
        "id": "dir-apt-dis-262",
        "options": [
            "Validar 26 cm² como área del rectángulo de 8 cm × 5 cm, porque recorrer los cuatro lados (8+5+8+5) parece medir el interior y cierra la socialización con un número del contorno.",
            "Validar 40 cm² (8 × 5) como superficie y reenseñar que 26 cm es el perímetro, de modo que área y contorno no se intercambien en la evidencia de geometría.",
            "Validar 35 cm² como «área aproximada», promedio de 8 y 5 más un ajuste, para no dejar sin respuesta a quien confundió las magnitudes en la socialización.",
            "Validar 45 cm², suma de lados más un ajuste de rúbrica, y reportarlo como evidencia comparable de medición en el SIEE de geometría del período.",
        ],
        "explanation": "La condición de calidad pide qué evidencia muestra el aprendizaje esencial de área y qué confusión reenseñar. El área del rectángulo es base × altura: 8 × 5 = 40 cm². 26 cm es el perímetro, no la superficie. 35 cm² promedia lados. 45 cm² inventa un ajuste para el SIEE. Área y perímetro no se intercambian aunque el número 26 aparezca en el recuento de lados.",
        "normativeJustification": "Los DBA de geometría distinguen superficie y contorno. El SIEE no puede homologar 26, 35 o 45 cm² como si midieran el interior del 8 × 5.",
        "theoreticalJustification": "Área = base × altura = 40 cm². Perímetro = 2×(8+5) = 26 cm. Promediar o sumar con ajuste produce otra magnitud.",
        "distractorAnalysis": {
            "0": "Trampa del contorno como interior: 26 cm² parece medir el rectángulo porque recorre los lados. Confunde perímetro con área y no es 8 × 5 = 40 cm².",
            "2": "Trampa del promedio de lados: 35 cm² parece una aproximación razonable. No es la superficie y deja sin reenseñar la distinción área/perímetro.",
            "3": "Trampa de dominio cruzado del SIEE: 45 cm² con ajuste de rúbrica luce como evidencia comparable de medición. Inventa una magnitud y no valida 40 cm² ni reenseña el 26 cm del perímetro.",
        },
    },
]

if __name__ == "__main__":
    sys.exit(dump_and_report(OUT, ITEMS, CI, {}))
