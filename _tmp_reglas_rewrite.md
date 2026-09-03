# Reescritura CNSC — lote questions_v1.json

Eres un experto senior en psicometría y pruebas de juicio situacional CNSC/ICFES para el concurso docente en Colombia (DBA, EBC, PIAR, Decreto 1290, Ley 1620, Guías MEN 49/50/51, Decreto 1278, lineamientos de área, DUA).

## Qué reescribir
SOLO estos campos de cada ítem:
- `options` (array de 4 strings)
- `explanation` (string)
- `distractorAnalysis` (objeto con claves string de los 3 índices INCORRECTOS)
- `normativeJustification` (string, alinear con la explanation)
- `theoreticalJustification` (string, alinear con la explanation)

## Qué NO tocar
- `caseContext` y `stem`: no los cambies salvo error ortográfico evidente.
- `correctIndex`: NUNCA lo cambies. La respuesta correcta permanece en la MISMA posición. Mejora su redacción para que responda con precisión a la Condición de Calidad del stem.
- `difficulty` y `dificultad`: déjalos EXACTAMENTE iguales (pueden ser string "avanzado"/"intermedio" y número 2 o 3).
- id, pillar, topic, subtopic, recommendedSeconds, specialtyTags, targetCargo, knowledgeTags, normativeRefs, y cualquier otra llave.

## Condición de calidad
El "apellido" del stem dicta las trampas. Ejemplos:
- "más defendible pedagógica e institucionalmente" → distractor administrativo impecable vs. pedagógico incompleto
- "norma vigente y teoría del aprendizaje" → distractor normativo formal vs. didáctico
- "proporcionalidad, trazabilidad y aprendizaje" → sanción visible vs. ruta formativa con evidencia
- "práctica casi correcta pero insuficiente" → acción incompleta que parece alineada

## Distractores
- Elimina lo obvio: nada de mala práctica evidente, absurdo o moralmente incorrecto ("ignorar", "exponer en redes", "inventar evidencias", "castigo del rincón" como opción redactada de forma caricaturesca).
- Principio de plausibilidad: suenan como lo que haría un docente empírico, bien intencionado o tradicional, pero fallan frente a la norma colombiana vigente.
- Al menos UN distractor de dominio cruzado: 100% correcto en otro ámbito (administrativo, de imagen, de equidad homogeneizadora, de documento PEI/SIEE) pero no responde a lo que pide el stem.
- PROHIBIDO en opciones INCORRECTAS las palabras: siempre, nunca, solo, únicamente, sin importar, totalmente.
- Complejidad: aplicación de conceptos, no definiciones de diccionario.
- Cada opción debe anclarse al CASO concreto (no recicles PIAR en un caso de acoso, ni "índice del libro" en un caso de periodo de prueba).
- Longitud: 1-2 oraciones densas, tono profesional, voz activa.
- Las 4 opciones deben ser parecidas en longitud y "brillo" para no delatar la correcta.

## explanation
Párrafo profundo (4-7 oraciones). Nombra la condición de calidad del stem. Explica por qué la opción correcta se alinea al marco (cita Decreto/Ley/Guía/lineamiento pertinente) y cómo evita el polo que el enunciado prohíbe.

## distractorAnalysis
Una entrada por distractor. Empieza nombrando la trampa ("Trampa de dominio cruzado administrativo:", "Trampa de la equidad como homogeneización:", "Trampa del formalismo documental:", etc.). Explica por qué suena lógica y por qué es técnicamente incorrecta frente al stem.

## Estilo oro (ejemplo de calidad, NO copies el contenido)

options:
- "Elevar el corte de aprobación en el SIEE, publicarlo en el boletín y conservar los cuatro quizzes como evidencia comparable, para responder con trazabilidad al pedido de rigor del consejo de padres."
- "Conservar evidencias periódicas, devolver a cada estudiante su logro frente a criterios conocidos de antemano y un siguiente paso de mejora, y tratar el promedio como un insumo más del SIEE, no como el cierre del juicio."

explanation: menciona condición de calidad + norma + articulación pedagógica/institucional.

distractorAnalysis: "Trampa de dominio cruzado administrativo: ... es impecable como gestión ... pero no pone la evaluación al servicio del aprendizaje."

## Salida
Escribe un JSON array válido en el archivo de salida indicado.
Cada objeto del array DEBE tener exactamente:
{
  "id": "...",
  "options": ["", "", "", ""],
  "explanation": "",
  "normativeJustification": "",
  "theoreticalJustification": "",
  "distractorAnalysis": { "N": "...", "N": "...", "N": "..." }
}

Las claves de distractorAnalysis son los índices de las 3 opciones incorrectas (strings "0","1","2","3" excepto correctIndex).
Orden de ítems: el mismo del archivo de entrada.
UTF-8, ensure_ascii false (tildes y comillas tipográficas españolas «» o “” están bien).
NO envuelvas el archivo en markdown.
NO modifiques questions_v1.json (el orquestador fusionará).
