/**
 * Ola 4b — más densidad del cerebro (casos únicos, distractores casi correctos).
 */
const {gold} = require("./gold_handcrafted_core");

const stems = [
  "A partir del caso, ¿qué decisión sostiene el derecho a aprender, la trazabilidad y la mediación pedagógica?",
  "Dadas las tensiones del escenario (comunidad, equidad formal y marco vigente), ¿cuál intervención es la más defendible?",
  "Si debieras argumentar tu elección ante un jurado del concurso, ¿qué opción cierra el problema de fondo?",
  "¿Qué decisión evita tanto tratar a todos igual por “equidad” como una flexibilidad que elimina la meta esencial?",
  "Evaluando criterios, evidencia e instancias, ¿cuál acción es la más coherente con el caso?",
];

/**
 * Filas: [modulo, cargo, tagsCSV, norma, theory, caso, good, near1, near2, near3, dif]
 * tagsCSV usa codes separados por |
 */
const rows = [
  // —— Evaluación / 1290 ——
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|ausubel", "El 1290 orienta evaluación formativa con criterios.", "Ausubel: anclar lo nuevo en saberes previos.", "Se inicia 'fracción' con algoritmo y quiz el mismo día, sin explorar ideas de parte-todo.", "Diagnosticar previos con material y conectar el algoritmo a la comprensión", "Evaluar de inmediato para clasificar al grupo", "Seguir el libro aunque no haya comprensión", "Castigar a quienes no memorizaron el procedimiento", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|vygotsky", "1290: evaluación al servicio del aprendizaje.", "Vygotsky: mediación en ZDP.", "Un estudiante resuelve con pistas del docente y luego se le evalúa solo en aislamiento extremo sin transición.", "Diseñar retirada gradual del andamiaje y evaluar el progreso hacia la autonomía", "Prohibir cualquier ayuda para siempre", "Bajar la meta esencial", "Evaluar solo el producto final sin proceso", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290", "1290 exige claridad de criterios y carácter formativo.", "La autorregulación mejora con metas visibles.", "La rúbrica tiene 12 indicadores confusos y nadie la entiende.", "Simplificar criterios esenciales, socializarlos y usarlos en la devolución", "Mantener la rúbrica opaca", "Evaluar por impresión", "Entregar criterios después de calificar", 2],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|ebc", "1290 + EBC: coherencia enseñanza-evaluación.", "Evaluar desempeños, no solo datos aislados.", "Se enseñó argumentar con evidencia y se evaluó solo ortografía.", "Incluir criterios de argumentación alineados a lo enseñado", "Mantener solo ortografía", "Eliminar la escritura", "Improvisar nota global", 2],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290", "La promoción se rige por el SIEE y evidencias.", "Sin evidencia, la decisión es arbitraria.", "Promueven a un estudiante 'porque es bueno' sin evidencias del periodo.", "Revisar evidencias y criterios del SIEE antes de decidir", "Promover por simpatía", "Reprobar sin revisar el proceso formativo", "Cambiar la escala en la misma sesión", 3],
  ["Pedagogía y evaluación formativa", "directivos", "decreto1290|ley115", "SIEE institucional (1290) debe ser conocido y coherente.", "La gestión asegura aplicación equitativa.", "Cada área inventa su escala y las familias no entienden el boletín.", "Unificar/socializar el SIEE y monitorear su aplicación", "Permitir escalas secretas", "Ocultar el SIEE", "Cambiar criterios cada mes sin proceso", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290", "Evaluación integral y flexible.", "Triangular reduce error de medición.", "El periodo se decide con un único examen acumulativo sorpresa.", "Usar evidencias diversas con función formativa a lo largo del periodo", "Mantener el examen sorpresa como único insumo", "Evaluar solo asistencia", "Subir notas sin evidencia", 2],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|piaget", "1290 reconoce ritmos; inicial/primaria respetan desarrollo.", "Piaget: no forzar operaciones sin base.", "En 1° se exige demostraciones abstractas prematuras y se reprueba por 'falta de lógica'.", "Ajustar demandas al nivel de desarrollo y mediar con representaciones concretas", "Insistir en lo abstracto sin mediación", "Etiquetar como 'sin capacidad'", "Eximir de toda evidencia", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290", "Retroalimentación oportuna.", "Feedback accionable cambia la práctica del estudiante.", "El docente corrige 40 cuadernos con solo 'visto bueno'.", "Devolver comentarios ligados a criterios y un próximo paso", "Seguir con 'visto bueno' masivo", "Solo señalar errores en rojo sin orientación", "Posponer toda devolución al boletín", 2],
  ["Pedagogía y evaluación formativa", "matematicas", "decreto1290|dba", "Criterios al servicio del aprendizaje.", "DBA orientan esenciales del grado.", "La recuperación de matemáticas es copiar el taller resuelto del tablero.", "Diagnosticar errores y reenseñar con nueva representación hacia el DBA", "Copiar del tablero como evidencia", "Poner más ejercicios idénticos", "Promover sin cierre", 3],

  // —— Inclusión 1421 ——
  ["Inclusión y convivencia escolar", "primaria", "decreto1421|decreto1290", "1421: PIAR y ajustes; 1290: evaluación formativa.", "Equidad ≠ igualdad formal.", "En una prueba oral, se niega tiempo extra acordado en el PIAR.", "Aplicar el ajuste de tiempo y evaluar el aprendizaje esencial", "Negar el ajuste 'para que sea igual'", "Eximir de la prueba", "Cambiar la meta esencial sin PIAR", 3],
  ["Inclusión y convivencia escolar", "directivos", "decreto1421", "Deber institucional de inclusión.", "La preparación se construye, no es pretexto de exclusión.", "Coordinación dice 'no tenemos aula de apoyo, mejor otra IE'.", "Garantizar atención con PIAR, ajustes y trabajo de equipo", "Negar el cupo", "Aceptar sin ajustes", "Eximir de toda evaluación", 3],
  ["Inclusión y convivencia escolar", "preescolar", "decreto1421|guiaMen50", "Inclusión también en inicial.", "Ambientes y rutinas son ajustes posibles.", "Un niño con TEA se desregula en transiciones; solo se sanciona.", "Anticipar transiciones con apoyos visuales/rutinas y documentar", "Aumentar castigos", "Excluirlo del grupo", "Ignorar el patrón", 3],
  ["Inclusión y convivencia escolar", "primaria", "decreto1421", "Ajuste razonable mantiene esenciales.", "No es eliminar la competencia.", "Proponen que un estudiante 'no presente' ciencias 'por inclusión'.", "Mantener esenciales de ciencias con ajustes de acceso/demostración", "Eximir del área", "Bajar meta sin PIAR", "Evaluar solo asistencia", 2],
  ["Inclusión y convivencia escolar", "primaria", "decreto1421|vygotsky", "Ajustes + mediación.", "Andamiaje temporal hacia autonomía.", "El apoyo de un par se retira el mismo día 'para que aprenda solo'.", "Planear retirada gradual del andamiaje según evidencia", "Retirar apoyo de golpe", "Mantener dependencia sin meta", "Prohibir pares", 2],
  ["Inclusión y convivencia escolar", "lenguaje", "decreto1421|lineamientos", "Acceso a prácticas de lenguaje.", "Diversificar medios de lectura/escritura.", "Estudiante con baja visión recibe fotocopias densas ilegibles.", "Ajustar tamaño/contraste/formato digital y evaluar comprensión esencial", "Mantener la fotocopia", "Eximir de lectura", "Evaluar solo dictado oral improvisado", 3],
  ["Inclusión y convivencia escolar", "matematicas", "decreto1421|ebc", "Ajustes en evidencias matemáticas.", "Procesos > único formato.", "Se prohíbe base 10 en la evaluación aunque el PIAR lo prevé.", "Permitir la representación acordada y valorar el aprendizaje esencial", "Prohibir el material", "Eximir de matemáticas", "Bajar DBA del grado sin proceso", 3],
  ["Inclusión y convivencia escolar", "directivos", "decreto1421|ley115", "Inclusión en el PEI y la gestión.", "Política institucional, no voluntad aislada.", "La inclusión depende de un solo docente 'sensibilizado'.", "Protocolizar roles, tiempos PIAR y seguimiento institucional", "Dejarlo en voluntad individual", "Hacer solo una jornada simbólica", "Negar ingresos nuevos", 2],
  ["Inclusión y convivencia escolar", "primaria", "decreto1421", "Participación y aprendizaje.", "Barreras se transforman.", "En laboratorio, el estudiante queda mirando porque 'es peligroso'.", "Rediseñar participación segura con ajustes y meta de aprendizaje", "Exclusión permanente del lab", "Eximir del área", "Evaluar solo por informe copiado", 2],
  ["Inclusión y convivencia escolar", "primaria", "decreto1421|decreto1290", "Familia corresponsable con PIAR.", "Acuerdos documentados.", "La familia pide nota mínima automática; el docente acepta solo.", "Llevar la solicitud al equipo PIAR y acordar evidencias accesibles", "Poner nota mínima sin evidencia", "Ignorar a la familia", "Eximir de evidencias", 3],

  // —— Convivencia ——
  ["Inclusión y convivencia escolar", "primaria", "ley1620|guiaMen49", "Ruta integral y tipificación.", "Prevención temprana.", "Burlas reiteradas por un apodo; se espera la pelea física.", "Intervenir con mediación, tipificación y seguimiento del clima", "Esperar la agresión física", "Exponer en el patio", "Archivar sin registro", 3],
  ["Inclusión y convivencia escolar", "directivos", "ley1620|guiaMen51", "Tipo III: remisión y protección.", "Escuela no sustituye autoridades.", "Hay indicios de delito y solo hay amonestación verbal.", "Activar remisión competente + protección + seguimiento escolar", "Solo amonestar", "Ocultar el caso", "Publicar en redes", 3],
  ["Inclusión y convivencia escolar", "primaria", "guiaMen49|ley1620", "Confidencialidad.", "Evitar revictimización.", "Se lee el caso completo en orientación de grupo.", "Proteger identidad y manejar el caso por la ruta con quienes deben saber", "Exponer detalles al curso", "Publicar circular con nombres", "Ignorar el reporte", 2],
  ["Inclusión y convivencia escolar", "directivos", "guiaMen49", "Manual participativo.", "Lectura de contexto.", "Actualizan el manual copiando otro colegio la noche anterior a la visita.", "Actualizar con comité, contexto local y tipologías vigentes", "Mantener la copia ajena", "Imponer sin participación", "Eliminar el manual", 2],
  ["Inclusión y convivencia escolar", "primaria", "ley1620|guiaMen51", "Enfoque restaurativo proporcional.", "Reparar vínculos.", "Tipo I: suspensión inmediata sin diálogo.", "Acuerdos formativos/restaurativos con seguimiento", "Suspender siempre primero", "Humillar", "Ignorar", 2],
  ["Inclusión y convivencia escolar", "directivos", "guiaMen49|ley1620", "Promoción de convivencia.", "Cultura de paz intencional.", "El año solo tiene sanciones; cero proyectos de promoción.", "Programar promoción con el comité a lo largo del año", "Más suspensiones", "Una charla anual simbólica", "Delegar solo a externos", 2],
  ["Inclusión y convivencia escolar", "primaria", "ley1620", "Canales formales.", "WhatsApp no es la ruta.", "El conflicto se 'resuelve' en el grupo de padres.", "Conducirlo a la ruta institucional y proteger intimidad", "Seguir en WhatsApp", "Publicar capturas", "Dejar que insulten hasta cansarse", 3],
  ["Inclusión y convivencia escolar", "directivos", "guiaMen51", "Roles claros.", "Protocolo operable.", "Nadie sabe quién activa la ruta en un recreo crítico.", "Definir roles, formar al equipo y ensayar el protocolo", "Improvisar cada vez", "Solo afiche sin práctica", "Esperar a orientación al día siguiente siempre", 2],
  ["Inclusión y convivencia escolar", "primaria", "guiaMen49|ley1620", "No discriminación.", "Escuela segura.", "Hostigan a un estudiante por su procedencia étnica y se minimiza.", "Activar protección, educación en derechos y ruta", "Minimizar", "Culpar a la víctima", "Ignorar porque 'son bromas'", 3],
  ["Inclusión y convivencia escolar", "directivos", "guiaMen49|ley1620", "Ley 1620 / Guía 49: la Ruta incluye seguimiento tras la atención.", "La mediación sin monitoreo deja el conflicto en riesgo de reaparecer.", "En una IE, un conflicto Tipo I entre dos estudiantes de 7° se resolvió con mediación y acuerdos firmados. Han pasado dos semanas y nadie verifica cumplimiento ni clima entre las partes.", "Programar y registrar el seguimiento del cumplimiento de los acuerdos y del clima escolar entre las partes", "Archivar el caso el mismo día de la mediación, porque el acuerdo verbal ya basta", "Imponer una sanción disciplinaria inmediata, aunque no se haya evaluado el cumplimiento de los acuerdos", "Cambiar solo de grupo a la víctima para evitar que el conflicto se repita", 2, "Según la Ruta de Atención Integral para la Convivencia Escolar (Ley 1620 y Guía MEN 49), la decisión más coherente es:"],

  // —— PEI / 1860 / 1278 ——
  ["Gestión institucional y PEI", "directivos", "ley115|decreto1860", "PEI orientador.", "Gobierno escolar real.", "Decisiones de calendario y evaluación se toman sin consejo académico.", "Reactivar instancias con actas y participación docente", "Seguir por WhatsApp unilateral", "Simular actas", "Eliminar consejos", 3],
  ["Gestión institucional y PEI", "directivos", "decreto1278", "Evaluación de desempeño formativa.", "Mejoramiento profesional.", "La evaluación docente se usa para ranking y vergüenza pública.", "Usarla con criterios, devolución y plan de mejora", "Ranking público", "Sin criterios", "Sin devolución", 3],
  ["Gestión institucional y PEI", "directivos", "decreto1278|decreto1290", "Marcos distintos.", "Claridad institucional.", "Unifican en un formato SIEE estudiantil y evaluación docente.", "Separar SIEE (1290) de desempeño docente (1278)", "Mantener el formato único confuso", "Eliminar ambas", "Solo evaluar estudiantes", 2],
  ["Gestión institucional y PEI", "directivos", "ley115", "PEI vivo.", "Alineación curricular.", "El PEI habla de inclusión, pero no hay tiempos ni roles PIAR.", "Traducir el PEI a rutinas, roles y recursos de inclusión", "Dejar el PEI como discurso", "Solo jornada simbólica", "Negar cupos", 3],
  ["Gestión institucional y PEI", "directivos", "decreto1860", "Participación.", "Instancias con calendario.", "El gobierno escolar no se reunió en el año.", "Reactivar calendarios y participación efectiva", "Sustituir por redes", "Reuniones solo cosméticas", "Centralizar todo en rectoría", 2],
  ["Gestión institucional y PEI", "directivos", "decreto1278", "Inducción y mentoría.", "Profesionalización desde el ingreso.", "Docente nuevo sin inducción de rutas ni SIEE comete errores graves.", "Inducción obligatoria + mentoría pedagógica", "Dejarlo solo", "Solo PDF", "Sancionar sin formar", 2],
  ["Gestión institucional y PEI", "directivos", "ley115|decreto1290", "Gestión del SIEE.", "Equidad evaluativa.", "Reclamos masivos por criterios opacos entre áreas.", "Auditar aplicación del SIEE y formar al equipo en criterios", "Culpar a las familias", "Cambiar notas sin proceso", "Ocultar criterios", 2],
  ["Gestión institucional y PEI", "directivos", "decreto1278", "Ética y datos.", "Confidencialidad profesional.", "Se publican fotos de evaluaciones en el Instagram institucional.", "Retirar la publicación y usar canales que protejan datos", "Seguir publicando", "Etiquetar estudiantes", "Ignorar quejas", 3],
  ["Gestión institucional y PEI", "directivos", "ley115", "PMI con trazabilidad.", "Mejora basada en evidencia.", "El PMI no tiene indicadores ni responsables.", "Definir metas, indicadores, responsables y fechas", "PMI genérico", "Solo para la visita", "Culpar solo al contexto", 2],
  ["Gestión institucional y PEI", "directivos", "decreto1860|ley1620", "Convivencia en la gestión.", "Comité activo.", "Rectoría atiende convivencia sola, sin comité.", "Activar el comité y operar rutas con roles", "Centralizar todo", "Solo sanción", "Delegar a WhatsApp de padres", 2],

  // —— Currículo ——
  ["Currículo y referentes MEN", "primaria", "ebc|dba|lineamientos", "Referentes complementarios.", "Coherencia de metas.", "El plan cita lineamientos de 1998 e ignora DBA vigentes en tareas.", "Articular lineamientos + EBC/DBA en planeación y evaluación", "Seguir solo el libro", "Ignorar DBA", "Copiar actividades virales", 3],
  ["Currículo y referentes MEN", "ciencias", "lineamientos|ebc", "Indagación científica.", "Evidencia y explicación.", "Laboratorio: copiar el procedimiento sin hipótesis ni registro.", "Diseñar indagación con pregunta, evidencia y explicación", "Solo copia", "Omitir registro", "Video sin mediación", 2],
  ["Currículo y referentes MEN", "sociales", "ebc|lineamientos|ley1620", "Ciudadanía crítica.", "Convivencia y pensamiento social.", "Evitan hablar de discriminación local 'para no polarizar'.", "Trabajar el problema con respeto, evidencia y formación ciudadana", "Evitar el tema", "Adoctrinar", "Solo fechas", 3],
  ["Currículo y referentes MEN", "matematicas", "ebc|bruner", "Procesos matemáticos.", "Representaciones múltiples.", "Se pasa de concreto a ecuación en un solo paso.", "Transitar enactivo→icónico→simbólico con conexiones", "Símbolo inmediato", "Solo concreto eterno", "Memorizar reglas", 2],
  ["Currículo y referentes MEN", "lenguaje", "lineamientos|ebc", "Prácticas sociales del lenguaje.", "Propósito y audiencia.", "Escriben 'para el docente' sin audiencia real nunca.", "Diseñar producciones con audiencia y propósito auténticos", "Solo para nota", "Solo ortografía", "Prohibir publicación escolar", 2],
  ["Currículo y referentes MEN", "primaria", "dba", "Progresión por grado.", "Bases antes de adelantar.", "En 2° trabajan ecuaciones de 7° 'por el concurso'.", "Focalizar DBA del grado y asegurar bases", "Adelantar sin bases", "Omitir comprensión", "Solo tipologías de prueba", 3],
  ["Currículo y referentes MEN", "primaria", "ebc|ausubel", "Saberes previos.", "Aprendizaje significativo.", "Proyecto de huerta sin explorar lo que ya saben del entorno.", "Activar previos y conectar metas EBC al contexto", "Empezar por definición abstracta", "Activismo sin meta", "Evaluar solo la foto final", 2],
  ["Currículo y referentes MEN", "matematicas", "lineamientos|decreto1290", "Evaluación de procesos.", "Criterios visibles.", "Problema calificado solo por respuesta final.", "Valorar proceso, representación y argumentación", "Solo respuesta", "Solo limpieza", "Rúbrica secreta", 2],
  ["Currículo y referentes MEN", "lenguaje", "ebc|dba", "Comprensión crítica.", "Inferencia y evaluación.", "Lectura solo con preguntas literales de detalle.", "Incluir inferencia, propósito y evaluación del texto", "Solo literal", "Solo velocidad", "Solo copia", 2],
  ["Currículo y referentes MEN", "primaria", "lineamientos|ley115", "Contextualización PEI.", "Significatividad.", "Ejemplos urbanos ajenos en IE rural sin adaptación.", "Contextualizar referentes al territorio manteniendo la meta", "Libro sin adaptación", "Abandonar referente", "Solo folklore sin competencias", 2],

  // —— Preescolar ——
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50|piaget", "Juego y desarrollo.", "Acción y representación.", "Castigan el juego simbólico por 'perder tiempo'.", "Mediar el juego como espacio de lenguaje y aprendizaje", "Cortar el juego", "Solo planas", "Examen escrito", 2],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50", "Cuidado educativo.", "Rutinas significativas.", "Lavado de manos en silencio total; se prohíbe hablar.", "Usar la rutina para lenguaje, autonomía y cuidado", "Silencio punitivo", "Eliminar la rutina", "Solo higiene sin mediación", 1],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50|decreto1290", "Evaluación cualitativa.", "Documentación pedagógica.", "Exigen promedio numérico semanal en transición.", "Observar y documentar procesos con devolución a familias", "Promedios de primaria", "Sin registro", "Ranking de niños", 3],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50|vygotsky", "Lenguaje oral.", "Andamiaje lingüístico.", "Corrigen cada error oral y piden callar.", "Ampliar y reformular el habla en situaciones auténticas", "Silenciar", "Solo silabeo", "Examen escrito de oralidad", 2],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50|decreto1421", "Inclusión en inicial.", "Ajustes de ambiente.", "Niño con hipersensibilidad: sanción por taparse los oídos.", "Ajustes sensoriales y acompañamiento; no sanción como única vía", "Más sanción", "Exclusión", "Ignorar", 3],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50", "Familias.", "Corresponsabilidad.", "Solo citan familias para quejas.", "Diálogo periódico sobre desarrollo con evidencias y acuerdos", "Solo quejas", "Amenazas de cupo", "Cero comunicación", 2],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50|bruner", "Matemáticas tempranas.", "Enactivo primero.", "Sumas formales en hoja a los 4 años.", "Conteo, clasificación y comparación en juego/rutinas", "Algoritmos prematuros", "Cero experiencia numérica", "Tablas", 2],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50", "Ambientes.", "Tercer educador.", "Filas fijas y cero rincones.", "Espacios de juego e interacción con materiales", "Filas todo el día", "Sin materiales", "Aula-oficina", 1],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50|ley1620", "Convivencia temprana.", "Mediación adulta.", "Pelea por juguete: solo 'no peleen'.", "Nombrar emociones, modelar turnos y acuerdos simples", "Ignorar", "Castigar sin escuchar", "Dar al más fuerte", 2],
  ["Pedagogía y evaluación formativa", "preescolar", "guiaMen50", "Presión escolarizante.", "Diálogo informado.", "Familia exige paquete diario de planas; docente satura.", "Explicar enfoque con evidencias y acordar apoyos coherentes", "Ceder a la saturación", "Descalificar familia", "Cortar vínculo", 2],

  // —— Comportamental / ética ——
  ["Competencias comportamentales", "primaria", "decreto1278", "Integridad profesional.", "Verdad institucional.", "Te piden marcar presente a un docente ausente.", "Negarte y corregir el registro con la verdad", "Marcar por compañerismo", "Exponer en redes", "Ignorar", 3],
  ["Competencias comportamentales", "primaria", "decreto1278|ley1620", "Protección y rutas.", "No secreto absoluto ante riesgo.", "Estudiante revela riesgo grave y pide secreto total.", "Proteger y activar ruta protocolizada", "Secreto absoluto", "Chisme en recreo", "Minimizar", 3],
  ["Competencias comportamentales", "directivos", "decreto1278", "Liderazgo ético.", "No simulación.", "Piden maquillar evidencias ante visita.", "Documentar lo real y rechazar la simulación", "Maquillar", "Sabotear", "Culpar estudiantes", 3],
  ["Competencias comportamentales", "primaria", "decreto1278", "Trabajo en equipo.", "Diálogo con evidencia.", "Reunión de área tóxica por criterios.", "Facilitar acuerdo con SIEE y evidencias documentadas", "Imponer", "Abandonar", "Ataque personal", 2],
  ["Competencias comportamentales", "primaria", "ley1620|decreto1278", "Dignidad del estudiante.", "Interrumpir vulneración.", "Colega ridiculiza a un niño en la sala.", "Interrumpir con respeto y activar ruta si aplica", "Reírte", "Publicar en redes", "Silencio total", 3],
  ["Competencias comportamentales", "primaria", "decreto1278", "Confidencialidad.", "Datos sensibles.", "Padre pide notas de otro estudiante.", "Proteger intimidad y redirigir a canales debidos", "Compartir 'en confianza'", "Publicar en WhatsApp", "Inventar datos", 2],
  ["Competencias comportamentales", "primaria", "decreto1290|decreto1278", "Integridad evaluativa.", "SIEE > favores.", "Ofrecen favor a cambio de subir nota.", "Rechazar y mantener criterios; reportar si corresponde", "Aceptar", "Subir 'un poquito'", "Amenazar sin proceso", 3],
  ["Competencias comportamentales", "directivos", "decreto1278|ley115", "Clima profesional.", "Mejora sin humillación.", "Quieren exponer en cartelera al 'peor docente' por resultados.", "Acompañar con evidencia y plan de mejora privado/profesional", "Cartelera pública", "Memorando masivo humillante", "Ignorar resultados", 2],
  ["Competencias comportamentales", "primaria", "decreto1278", "Autoregulación profesional.", "Estudiantes primero.", "Te asignan grado difícil sin recursos; hay rabia.", "Priorizar aprendizaje con lo disponible y pedir apoyo con propuestas", "Suspender clase", "Descargar rabia en estudiantes", "Abandonar planeación", 2],
  ["Competencias comportamentales", "directivos", "ley1620|guiaMen51", "Manejo de crisis.", "Espacio seguro.", "Padre grita en recepción con niños presentes.", "Proteger el espacio, bajar tensión y reunión privada protocolizada", "Gritar de vuelta", "Discutir frente a todos", "Publicar el altercado", 2],

  // —— Más densidad pedagógica ——
  ["Pedagogía y evaluación formativa", "primaria", "vygotsky|decreto1290", "Andamiaje y evaluación.", "De lo asistido a lo autónomo.", "Todo el año el docente da las respuestas 'para no frustrar'.", "Mediar con pistas decrecientes y evaluar autonomía creciente", "Dar siempre la respuesta", "Frustrar sin apoyo", "Eximir de retos", 3],
  ["Pedagogía y evaluación formativa", "primaria", "ausubel|ebc", "Organizadores previos.", "Significatividad.", "Unidad de ecosistemas sin mapa conceptual ni anclaje local.", "Usar organizador previo y ejemplos del entorno", "Definiciones aisladas", "Solo video", "Examen de glosario", 2],
  ["Pedagogía y evaluación formativa", "primaria", "bruner|lineamientos", "Descubrimiento guiado.", "Representaciones.", "Descubrimiento libre sin meta ni cierre.", "Diseñar descubrimiento guiado con meta y socialización", "Activismo sin cierre", "Solo exposición magistral", "Solo memorización", 2],
  ["Pedagogía y evaluación formativa", "primaria", "piaget|dba", "Desarrollo y demanda.", "Ajuste de tarea.", "Tarea exige clasificación múltiple prematura sin mediación.", "Ajustar demanda y mediar con material hacia el DBA", "Insistir sin mediación", "Etiquetar", "Eximir", 2],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290", "Metacognición.", "Autorregulación.", "Nunca piden al estudiante explicar cómo resolvió.", "Incluir verbalización de estrategias y criterios de éxito", "Solo respuesta final", "Solo nota", "Prohibir explicación", 2],
  ["Pedagogía y evaluación formativa", "directivos", "decreto1290|ley115", "Consejo de evaluación.", "Debido proceso evaluativo.", "Deciden promoción en 5 minutos sin revisar carpetas.", "Revisar evidencias y SIEE con trazabilidad", "Decisión exprés", "Promedio único", "Presión de cupos sin criterios", 3],
  ["Currículo y referentes MEN", "ciencias", "lineamientos|ausubel", "Modelos científicos escolares.", "Anclaje previo.", "Enseñan 'átomo' solo con definición a 4° sin modelos concretos.", "Usar modelos/analogías adecuadas al grado y evidencias observables", "Solo definición", "Saltar al simbolismo avanzado", "Omitir el tema", 2],
  ["Currículo y referentes MEN", "sociales", "ebc|lineamientos", "Pensamiento temporal/espacial.", "No solo fechas.", "Historia = lista de fechas para dictado.", "Comprender procesos, causas y evidencias en contexto", "Solo fechas", "Solo biografías memorísticas", "Evitar fuentes", 2],
  ["Currículo y referentes MEN", "lenguaje", "lineamientos|vygotsky", "Escritura mediada.", "ZDP textual.", "Piden ensayo argumentativo sin andamiaje de estructura.", "Andamiar planificación, modelos y revisión colaborativa", "Sin apoyo", "Solo ortografía", "Prohibir borrador", 3],
  ["Currículo y referentes MEN", "matematicas", "ebc|decreto1290", "Discusión matemática.", "Lenguaje de la disciplina.", "Se prohíbe hablar en la clase de problemas 'para concentrarse'.", "Diseñar diálogo matemático con normas de argumentación", "Silencio total permanente", "Solo exposición", "Solo respuestas corales", 2],
  ["Inclusión y convivencia escolar", "primaria", "ley1620|decreto1290", "Convivencia y aprendizaje.", "Clima habilita aprender.", "Tras un conflicto, se pierde una semana de clase sin plan de retorno.", "Restaurar clima con ruta y retomar aprendizajes con criterios", "Perder semanas sin plan", "Solo sanción", "Ignorar el aprendizaje perdido", 2],
  ["Gestión institucional y PEI", "directivos", "decreto1278|ebc", "Liderazgo pedagógico.", "Foco en aprendizaje.", "Supervisión revisa solo planillas, nunca evidencias de aula.", "Observar aprendizaje, devolver feedback y acordar mejora", "Solo planillas", "Ranking", "Memorandos sin aula", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|guiaMen50", "Transición inicial-primaria.", "Continuidad sin ruptura.", "1° elimina juego y observación de golpe en semana 1.", "Transición gradual con mediación y evaluación formativa", "Ruptura abrupta", "Solo exámenes", "Castigar el juego", 3],
  ["Inclusión y convivencia escolar", "directivos", "decreto1421|guiaMen49", "Inclusión y convivencia juntas.", "Barreras también son relacionales.", "Estudiante con discapacidad es objeto de burlas y solo se ajusta material.", "Ajustes + ruta de convivencia ante discriminación", "Solo material", "Solo sanción a la víctima por 'reaccionar'", "Ignorar burlas", 3],
  ["Currículo y referentes MEN", "primaria", "dba|decreto1290", "Esenciales y tiempo.", "Priorizar.", "Hay 40 temas; no alcanzan esenciales del DBA.", "Priorizar aprendizajes esenciales con evidencias de cierre", "Cobertura superficial de todo", "Omitir evaluación", "Solo actividades atractivas", 2],
  ["Competencias comportamentales", "primaria", "decreto1278", "Uso del tiempo.", "Profesionalidad cotidiana.", "Llegas tarde reiterado y pides a un estudiante que 'cubra' la clase.", "Corregir la puntualidad y no delegar la tarea docente al estudiante", "Seguir llegando tarde", "Dejar al grupo solo", "Pedir favor al estudiante regularmente", 2],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|vygotsky", "Evaluación colaborativa bien diseñada.", "Roles y criterios.", "Trabajo en grupo: un solo estudiante hace todo y todos tienen la misma nota.", "Diseñar roles, evidencias individuales/grupales y criterios claros", "Nota grupal ciega siempre", "Prohibir grupos", "Castigar al que lidera", 2],
  ["Gestión institucional y PEI", "directivos", "ley115|ebc", "Proyectos transversales.", "Intencionalidad.", "Proyecto institucional sin metas de aprendizaje ni evaluación.", "Definir metas EBC/DBA, evidencias y responsables", "Evento sin meta", "Solo logística", "Notas arbitrarias", 2],
  ["Inclusión y convivencia escolar", "primaria", "guiaMen51|ley1620", "Post-remisión.", "Deber de cuidado continua.", "Tras remisión externa, la IE abandona al estudiante.", "Mantener acompañamiento escolar de bienestar y aprendizajes", "Abandonar", "Estigmatizar", "Negar el reingreso sin proceso", 3],
  ["Currículo y referentes MEN", "lenguaje", "ebc|lineamientos", "Multimodalidad ética.", "Fuentes y audiencia.", "Estudiantes usan IA para entregar el texto sin mediación ni criterios.", "Enseñar uso ético de herramientas con propósito, criterios y autoría", "Prohibir toda herramienta sin pedagogía", "Aceptar entregas sin criterios", "Castigar sin enseñar", 3],
  ["Pedagogía y evaluación formativa", "matematicas", "bruner|decreto1290", "Error productivo.", "Representar el pensamiento.", "Estudiante explica mal en voz alta y se le calla 'para no confundir al grupo'.", "Usar la explicación errónea como objeto de análisis colectivo respetuoso", "Callar y avergonzar", "Ignorar el error", "Dar solo la respuesta correcta sin diálogo", 3],
  ["Gestión institucional y PEI", "directivos", "decreto1860|decreto1290", "Participación estudiantil en evaluación.", "Gobierno escolar y SIEE.", "Estudiantes nunca conocen ni dialogan criterios del SIEE.", "Espacios de socialización y mejora del SIEE con representación estudiantil", "SIEE secreto", "Solo imponer", "Cambiar sin consulta nunca", 2],
  ["Inclusión y convivencia escolar", "preescolar", "guiaMen50|guiaMen49", "Convivencia en inicial.", "Mediación adulta temprana.", "Muerde reiterado; solo suspensión del cupo sin plan.", "Observar desencadenantes, mediar, cuidar y acordar con familia; ruta proporcional", "Expulsar de inmediato", "Ignorar", "Castigo físico simbólico (rincón largo)", 3],
  ["Currículo y referentes MEN", "ciencias", "lineamientos|ebc|decreto1290", "Evaluar indagación.", "Proceso científico escolar.", "Nota de ciencias = memorizar 20 definiciones del quiz.", "Evaluar pregunta, evidencia, explicación y comunicación", "Solo definiciones", "Solo prolijidad", "Solo participación", 2],
  ["Competencias comportamentales", "directivos", "decreto1278|ley1620", "Imparcialidad.", "Debido proceso.", "Hijo de un docente involucrado en conflicto; quieren 'suavizar'.", "Aplicar la misma ruta y debido proceso, sin privilegios", "Suavizar por vínculo", "Endurecer por resentimiento", "Ocultar", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290|ebc", "Autoevaluación rigurosa.", "Metacognición con evidencia.", "Autoevaluación infla notas sin contraste con el trabajo.", "Contrastar autoevaluación con evidencias y criterios compartidos", "Dejar que reemplace la evaluación docente", "Eliminar autoevaluación", "Usarla solo punitivamente", 2],
  ["Gestión institucional y PEI", "directivos", "decreto1278", "Comunidades de aprendizaje.", "Liderazgo horizontal.", "Docentes excelentes no tienen espacio de mentoría a pares.", "Abrir mentoría y comunidades de práctica con tiempo protegido", "Ignorar talento interno", "Solo cursos externos desconectados", "Competencia tóxica entre docentes", 2],
  ["Currículo y referentes MEN", "primaria", "dba|lineamientos|ausubel", "Secuencia didáctica.", "De lo cercano a lo formal.", "Arrancan la unidad por el lenguaje más abstracto del referente.", "Partir de experiencia/previos y subir hacia formalización", "Abstracto primero siempre", "Activismo sin formalización", "Solo examen", 2],
  ["Inclusión y convivencia escolar", "primaria", "decreto1421|ley1620", "Acoso a estudiante con discapacidad.", "Doble vía: PIAR + ruta.", "Burlas por apoyos del PIAR; solo refuerzan el material.", "Ruta de convivencia + sostener ajustes sin estigmatizar", "Solo más material", "Quitar ajustes para 'que no se burlen'", "Culpar a la víctima", 3],
  ["Pedagogía y evaluación formativa", "primaria", "decreto1290", "Tiempo de evaluación.", "Calidad > cantidad de notas.", "Docente pone 15 notas/semana de baja calidad.", "Menos evidencias, más profundas, con devolución útil", "Más notas aún", "Solo una nota anual", "Notas sin criterios", 2],
  ["Currículo y referentes MEN", "matematicas", "ebc|dba", "Modelación.", "Problemas con sentido.", "Problemas 'trampa' diseñados para confundir, no para enseñar.", "Diseñar desafíos en ZDP con andamiaje y propósito formativo", "Trampas humillantes", "Solo ejercicios mecánicos", "Dar siempre la respuesta", 3],
];

function tagsFrom(csv) {
  return String(csv)
      .split("|")
      .filter(Boolean)
      .map((code) => ({code, focus: "aplicación situada"}));
}

/** @type {ReturnType<typeof gold>[]} */
const wave4b = rows.map((r, i) => {
  const [module, cargo, tagsCsv, norma, theory, caso, good, n1, n2, n3, dif, customStem] = r;
  const tagsCargo =
    cargo === "directivos"
      ? ["directivos"]
      : cargo === "preescolar"
        ? ["preescolar"]
        : cargo === "matematicas"
          ? ["matematicas", "primaria"]
          : cargo === "lenguaje"
            ? ["lenguaje", "primaria"]
            : cargo === "ciencias"
              ? ["ciencias", "primaria"]
              : cargo === "sociales"
                ? ["sociales", "primaria"]
                : ["primaria"];
  const primaryTag = String(tagsCsv).split("|")[0];
  return gold({
    id: `oro-c4b-${i + 1}`,
    module,
    subtema: `${primaryTag}`,
    cargo,
    tagsCargo,
    caso,
    stem: customStem || stems[i % stems.length],
    options: [n1, good, n2, n3],
    correct: "B",
    norma,
    theory,
    wrong: {
      A: "Parece habitual o parcial, pero no resuelve el núcleo normativo/pedagógico.",
      C: "Omite mediación, evidencia o proporcionalidad.",
      D: "Debilita derechos, criterios o aprendizaje esencial.",
    },
    tags: tagsFrom(tagsCsv),
    dif: Number(dif) || 2,
    secs: Number(dif) === 3 ? 120 : Number(dif) === 1 ? 70 : 100,
  });
});

module.exports = {wave4b};
