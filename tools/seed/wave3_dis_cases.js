/**
 * Casos disciplinares (primaria/básica) convertidos a evaluación de
 * concepciones: producciones de estudiantes y error a reenseñar.
 * Conserva el hecho disciplinar; no mezcla distractores de gestión de aula.
 *
 * Usado por upgrade_contest_wave3.js
 */

const HAND_DIS = {
  "dir-apt-dis-261": {
    caseContext:
      "En 4.º, tres cuadernos resuelven 3/4 + 1/8: uno suma 3+1 y 4+8 (4/12); otro deja 7/12 “porque el común es 12”; otro convierte 3/4 a 6/8 y obtiene 7/8. La rúbrica pide justificar equivalencia, no el algoritmo suelto.",
    stem:
      "¿Qué producción evidencia el aprendizaje esencial de suma de fracciones y qué error hay que reenseñar?",
    options: [
      "Validar 7/8 (equivalencia a octavos) y reenseñar no sumar numeradores y denominadores por separado.",
      "Validar 4/12, porque “sumar arriba y abajo” parece un procedimiento regular.",
      "Validar 1/2, porque “casi es la mitad” basta como estimación sin equivalencia.",
      "Validar 7/12, porque 12 es común, aunque 3/4 no se haya convertido.",
    ],
    correctIndex: 0,
    explanation:
      "3/4 = 6/8; 6/8 + 1/8 = 7/8. Sumar numeradores y denominadores (4/12) o usar 12 sin convertir 3/4 (7/12) son errores de equivalencia.",
  },
  "dir-apt-dis-262": {
    caseContext:
      "En geometría, un equipo calcula el “área” de un rectángulo de 8 cm × 5 cm como 26 cm² (sumó los cuatro lados). Otro multiplica 8 × 5 = 40 cm² y nombra el resultado como superficie. Hay confusión área/perímetro en la socialización.",
    stem:
      "¿Qué evidencia muestra el aprendizaje esencial de área y qué confusión hay que reenseñar?",
    options: [
      "Validar 26 cm² como área, porque recorre el contorno del rectángulo.",
      "Validar 40 cm² (base × altura) y reenseñar que el perímetro (26 cm) no mide superficie.",
      "Validar 35 cm², promedio de lados, como “área aproximada”.",
      "Validar 45 cm², suma de lados más un “ajuste”, como área.",
    ],
    correctIndex: 1,
    explanation:
      "El área del rectángulo es base × altura: 8 × 5 = 40 cm². 26 cm es el perímetro (8+5+8+5), no la superficie.",
  },
  "dir-apt-dis-263": {
    caseContext:
      "En una secuencia 2, 5, 8, 11, 14, … un estudiante dice que sigue 15 “porque va de uno en uno al final”; otro dice 16 “sumando 2”; otro identifica la diferencia constante +3 y propone 17. Se pide argumentar la regularidad, no adivinar.",
    stem:
      "¿Qué término y justificación evidencian el patrón y qué error hay que reenseñar?",
    options: [
      "Validar 15, porque el último salto “se ve de 1”.",
      "Validar 16, interpolando +2 entre 14 y un número par.",
      "Validar 17 (diferencia constante +3) y reenseñar no cambiar la razón a mitad de la sucesión.",
      "Validar 18, duplicando el primer término.",
    ],
    correctIndex: 2,
    explanation:
      "La sucesión es aritmética de razón 3. El siguiente término es 14 + 3 = 17. Cambiar la razón ( +1 o +2) rompe el patrón.",
  },
  "dir-apt-dis-264": {
    caseContext:
      "Al leer 305,7, un estudiante dice “trescientos cinco mil setecientos”; otro “trescientos cinco con siete centésimas”; otro “trescientos cinco con siete décimas”, señalando el primer lugar decimal. La evaluación pide valor posicional, no deletreo.",
    stem:
      "¿Qué lectura evidencia el valor posicional decimal y qué error hay que reenseñar?",
    options: [
      "Validar “trescientos cinco mil setecientos”, leyendo la coma como millar.",
      "Validar “treinta mil quinientos setenta”, desplazando las cifras.",
      "Validar “siete centésimas”, porque todo decimal “es centésima”.",
      "Validar “siete décimas” (primer lugar tras la coma) y reenseñar décima ≠ centésima ni millar.",
    ],
    correctIndex: 3,
    explanation:
      "En 305,7 el 7 ocupa el lugar de las décimas. No son centésimas ni se lee la parte entera como millar.",
  },
  "dir-apt-dis-265": {
    caseContext:
      "Un problema: un tren recorre 240 km en 3 horas a velocidad constante. Un equipo resta 240 − 3; otro divide 240 ÷ 3 = 80 km/h y explica distancia/tiempo. Otro suma 240 + 3. La rúbrica pide magnitud (km/h), no un número suelto.",
    stem:
      "¿Qué procedimiento evidencia velocidad media y qué error hay que reenseñar?",
    options: [
      "Validar 80 km/h (distancia ÷ tiempo) y reenseñar que restar o sumar horas no produce velocidad.",
      "Validar 70 km/h, “descontando paradas” no mencionadas.",
      "Validar 90 km/h, redondeando hacia arriba “por seguridad”.",
      "Validar 60 km/h, usando 4 horas “por si acaso”.",
    ],
    correctIndex: 0,
    explanation:
      "Velocidad media = distancia ÷ tiempo = 240 ÷ 3 = 80 km/h. Restar o cambiar el tiempo sin dato inventa otra magnitud.",
  },
  "dir-apt-dis-266": {
    caseContext:
      "En clase se pide identificar un sustantivo. Un estudiante marca “correr” porque “nombra una acción”; otro marca “amabilidad” (cualidad); otros marcan “rápidamente” o “muy”. Se pide criterio de clase de palabra, no “lo que suena a nombre”.",
    stem:
      "¿Qué identificación evidencia el aprendizaje esencial de sustantivo y qué error hay que reenseñar?",
    options: [
      "Validar “correr”: el infinitivo “nombra” y por eso sería sustantivo en cualquier uso.",
      "Validar “amabilidad” (nombra una cualidad) y reenseñar que infinitivos y adverbios no son sustantivos por defecto.",
      "Validar “rápidamente”, porque modifica y “parece importante”.",
      "Validar “muy”, porque intensifica y “acompaña al nombre”.",
    ],
    correctIndex: 1,
    explanation:
      "“Amabilidad” nombra una cualidad (sustantivo). “Correr” es verbo en infinitivo; “rápidamente” y “muy” son adverbios.",
  },
  "dir-apt-dis-267": {
    caseContext:
      "Oración: “El perro de mi vecino ladra fuertemente”. Un estudiante dice que el sujeto es “mi vecino” (quien “tiene” el perro); otro dice “ladra fuertemente”; otro identifica “el perro de mi vecino” como quien realiza la acción de ladrar.",
    stem:
      "¿Qué análisis evidencia el sujeto y qué confusión hay que reenseñar?",
    options: [
      "Validar “ladra fuertemente” como sujeto, por ser “lo más importante”.",
      "Validar “mi vecino”, porque el complemento posesivo “manda” en la oración.",
      "Validar “el perro de mi vecino” (quien ladra) y reenseñar no confundir complemento con núcleo del sujeto.",
      "Validar “fuertemente”, porque el adverbio “completa” al sujeto.",
    ],
    correctIndex: 2,
    explanation:
      "El sujeto es quien realiza la acción de “ladra”: “el perro de mi vecino”. “Mi vecino” es complemento del nombre, no el sujeto.",
  },
  "dir-apt-dis-268": {
    caseContext:
      "Se evalúa la coma tras una subordinada adverbial inicial. Producciones: “Cuando, llegue a casa…”; “Cuando llegue a casa prepararé, la cena…”; “Cuando llegue a casa, prepararé la cena para toda la familia.” La rúbrica pide pausa de la prótasis, no “coma donde se respira”.",
    stem:
      "¿Qué puntuación evidencia el criterio y qué error hay que reenseñar?",
    options: [
      "Validar la coma entre verbo y complemento (“prepararé, la cena”).",
      "Validar la coma que parte la subordinada (“Cuando, llegue”).",
      "Validar una coma entre “cena” y el complemento (“cena, para toda”).",
      "Validar la coma tras la subordinada inicial y reenseñar no separar el verbo de su complemento directo.",
    ],
    correctIndex: 3,
    explanation:
      "Tras la subordinada inicial (“Cuando llegue a casa”) va coma. No se separa el verbo de su complemento ni se parte la prótasis.",
  },
  "dir-apt-dis-269": {
    caseContext:
      "Se piden textos para un taller. Un equipo entrega una receta (pasos para hacer algo) y la llama “narrativa porque tiene secuencia”. Otro entrega un cuento con personajes y hechos en el tiempo. Otro un artículo que explica un fenómeno sin relato.",
    stem:
      "¿Qué tipo textual corresponde a narrar hechos en el tiempo y qué confusión hay que reenseñar?",
    options: [
      "El texto narrativo (secuencia de hechos con personajes/tiempo) y reenseñar que no toda secuencia (instructivo) es narración.",
      "El argumentativo, porque “convence” al contar.",
      "El expositivo, porque “informa” cualquier secuencia.",
      "El instructivo, porque los pasos ya son una historia.",
    ],
    correctIndex: 0,
    explanation:
      "El texto narrativo presenta hechos organizados en el tiempo, con personajes. Un instructivo tiene secuencia, pero su propósito es orientar un procedimiento, no relatar.",
  },
  "dir-apt-dis-270": {
    caseContext:
      "En vocabulario, se pide el antónimo de “generoso”. Varias respuestas: “amable”, “solidario”, “bondadoso” (cercanos o sinónimos) y “tacaño”. Un estudiante defiende “amable” porque “suena contrario en el recreo”.",
    stem:
      "¿Qué relación semántica evidencia antónimo y qué error hay que reenseñar?",
    options: [
      "Validar “amable” como opuesto, por contraste coloquial.",
      "Validar “tacaño” (sentido opuesto) y reenseñar no tomar sinónimos o cercanos como antónimos.",
      "Validar “solidario”, por parentesco afectivo.",
      "Validar “bondadoso”, por vecindad de significado.",
    ],
    correctIndex: 1,
    explanation:
      "“Tacaño” se opone a “generoso”. “Amable”, “solidario” y “bondadoso” son cercanos o sinónimos, no antónimos.",
  },
  "dir-apt-dis-271": {
    caseContext:
      "En un dibujo de planta, un equipo escribe que las raíces “hacen la fotosíntesis porque están vivas”; otro que “producen flores”; otro que absorben agua y sales y anclan la planta. La rúbrica pide función, no “todo el órgano sirve para todo”.",
    stem:
      "¿Qué función hay que orientar como aprendizaje esencial y qué error conceptual hay que reenseñar?",
    options: [
      "Validar la fotosíntesis en la raíz, porque “también es verde a veces”.",
      "Validar que la raíz produce flores y frutos, por continuidad de la planta.",
      "Validar absorción y anclaje, y reenseñar que la fotosíntesis ocurre principalmente en hojas con clorofila.",
      "Validar que la raíz solo guarda polen.",
    ],
    correctIndex: 2,
    explanation:
      "Las raíces absorben agua y nutrientes y fijan la planta. La fotosíntesis ocurre sobre todo en las hojas, no en la raíz.",
  },
  "dir-apt-dis-272": {
    caseContext:
      "Se clasifican hielo, agua en un vaso y aire en un globo. Un estudiante dice que el líquido tiene forma y volumen fijos “porque el vaso no se deforma”; otro identifica el sólido (hielo) con forma y volumen definidos. Otro atribuye ambos al gas.",
    stem:
      "¿Qué estado evidencia forma y volumen definidos y qué error hay que reenseñar?",
    options: [
      "Validar el gas, porque el globo “tiene forma”.",
      "Validar el plasma, por ser “el más energético”.",
      "Validar el líquido, confundiendo la forma del recipiente con la de la sustancia.",
      "Validar el sólido y reenseñar que el líquido tiene volumen definido pero forma del recipiente.",
    ],
    correctIndex: 3,
    explanation:
      "El sólido mantiene forma y volumen. El líquido tiene volumen definido y forma del recipiente; el gas no conserva ni forma ni volumen propios.",
  },
  "dir-apt-dis-273": {
    caseContext:
      "Tras un esquema del tubo digestivo, un estudiante afirma que el estómago “absorbe todo porque muele”; otro señala el intestino delgado como principal sitio de absorción de nutrientes; otro el intestino grueso “porque es más largo en el dibujo”.",
    stem:
      "¿Qué órgano hay que orientar como aprendizaje esencial de absorción y qué error hay que reenseñar?",
    options: [
      "El intestino delgado (absorción de nutrientes) y reenseñar que el estómago principalmente digiere, no absorbe lo esencial.",
      "El estómago, porque la trituración “ya es absorción”.",
      "El esófago, porque “baja el alimento”.",
      "El intestino grueso, porque “absorbe todo lo que queda”, sin distinguir agua de nutrientes.",
    ],
    correctIndex: 0,
    explanation:
      "El intestino delgado es el principal sitio de absorción de nutrientes. El estómago digiere; el intestino grueso absorbe sobre todo agua.",
  },
  "dir-apt-dis-275": {
    caseContext:
      "En una cadena de pasto–conejo–zorro, un equipo llama “productores” al zorro “porque produce crías”; otro a los descomponedores; otro a las plantas, que elaboran su alimento por fotosíntesis. La rúbrica pide rol trófico, no la palabra “producir” en sentido cotidiano.",
    stem:
      "¿Qué rol evidencia el concepto de productor y qué error hay que reenseñar?",
    options: [
      "Validar a los carnívoros como productores, porque “producen energía al cazar”.",
      "Validar a los descomponedores como productores, porque “producen tierra”.",
      "Validar a las plantas (fotosíntesis) y reenseñar que “productor” no significa “el que cría” ni “el que caza”.",
      "Validar solo a los consumidores primarios, porque “comen productores”.",
    ],
    correctIndex: 2,
    explanation:
      "Los productores (p. ej. plantas) elaboran su alimento por fotosíntesis y son la base de la cadena. No son los depredadores ni los descomponedores.",
  },
  "dir-apt-dis-276": {
    caseContext:
      "En un mapa, un estudiante marca Medellín como capital “porque es la industrial”; otro Cali “del Pacífico”; otro Cartagena “histórica”. Otro señala Bogotá como capital político-administrativa del país. Se pide el criterio constitucional, no el prestigio regional.",
    stem:
      "¿Qué identificación evidencia el aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "Validar Medellín como capital, por peso económico.",
      "Validar Cali, por ser referente del Pacífico.",
      "Validar Cartagena, por hitos coloniales.",
      "Validar Bogotá como capital de la República y reenseñar no confundir capital política con “capitales” simbólicas regionales.",
    ],
    correctIndex: 3,
    explanation:
      "Bogotá es la capital de la República de Colombia. El peso económico o histórico de otras ciudades no las convierte en capital del Estado.",
  },
  "dir-apt-dis-277": {
    caseContext:
      "Al ubicar la región Pacífica, un estudiante escribe “Mar Caribe / Atlántico” porque “Colombia tiene mar al norte y eso es lo mismo”. Otro nombra el océano Pacífico en el litoral occidental. Otro el Índico “porque también es océano”.",
    stem:
      "¿Qué océano corresponde a la región Pacífica y qué confusión hay que reenseñar?",
    options: [
      "El océano Pacífico, y reenseñar que el Caribe/Atlántico baña otra fachada, no la región Pacífica.",
      "El Atlántico, unificando ambos litorales en un solo mar.",
      "El Mar Caribe, por ser “el mar de Colombia” en el lenguaje cotidiano.",
      "El Índico, por ser océano y “quedar al otro lado”.",
    ],
    correctIndex: 0,
    explanation:
      "La región Pacífica colombiana limita con el océano Pacífico. El Caribe/Atlántico corresponde a otra fachada del país.",
  },
  "dir-apt-dis-278": {
    caseContext:
      "En un eje cronológico, un estudiante coloca la Constitución vigente en 1886 “porque duró mucho”; otro en 1991, con la Asamblea Nacional Constituyente. Otro en 1994 “por el primer gobierno de esa carta”. Se pide el año de promulgación vigente, no el de una carta anterior.",
    stem:
      "¿Qué datación evidencia el aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "Validar 1986, por cercanía a la Regeneración.",
      "Validar 1991 (promulgación vigente) y reenseñar no atribuir vigencia actual a la Constitución de 1886.",
      "Validar 1994, confundiendo primer gobierno con promulgación.",
      "Validar 1998, por un hito electoral posterior.",
    ],
    correctIndex: 1,
    explanation:
      "La Constitución Política vigente se promulgó en 1991. La de 1886 rigió antes, pero no es la carta actual.",
  },
  "dir-apt-dis-279": {
    caseContext:
      "Un esquema de ramas del poder: un estudiante asigna al Congreso “administrar justicia” y a los jueces “hacer las leyes”. Otro identifica la función legislativa del Congreso (hacer, reformar y derogar leyes). Otro le atribuye el mando de las Fuerzas Militares.",
    stem:
      "¿Qué función del Congreso hay que orientar como aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "Administrar justicia penal, confundiendo Congreso con rama judicial.",
      "Dirigir las fuerzas militares, confundiendo con el Ejecutivo.",
      "Hacer, reformar y derogar leyes, y reenseñar no mezclar función legislativa con judicial o militar.",
      "Nombrar gobernadores, como si el Congreso sustituyera la elección territorial.",
    ],
    correctIndex: 2,
    explanation:
      "Al Congreso le corresponde principalmente la función legislativa. Administrar justicia y dirigir la fuerza pública no son su función principal.",
  },
  "dir-apt-dis-280": {
    caseContext:
      "Para ordenar hitos, un equipo usa un mapa político y lo llama “línea del tiempo”. Otro usa una gráfica cronológica de hechos. Otro una tabla de PIB por país. Se pide la herramienta que organiza el tiempo histórico, no el espacio ni la estadística.",
    stem:
      "¿Qué herramienta evidencia el aprendizaje esencial de cronología y qué confusión hay que reenseñar?",
    options: [
      "El mapa político, porque “también tiene fechas en la leyenda”.",
      "El cronómetro, porque mide segundos de un acto cívico.",
      "La tabla comparativa de países, porque “ordena datos”.",
      "La representación gráfica cronológica de hechos y reenseñar que mapa y tabla no sustituyen el eje temporal.",
    ],
    correctIndex: 3,
    explanation:
      "La línea del tiempo organiza cronológicamente hechos históricos. Un mapa representa el espacio; una tabla estadística no es, por sí, ese eje temporal.",
  },
  "dir-apt-dis-361": {
    caseContext:
      "Dos fechas circulan en el aula: 20 de julio de 1810 (Grito de Independencia en Santafé) y 7 de agosto de 1819 (Boyacá). Un estudiante las fusiona como “20 de julio de 1819”. Se pide distinguir inicio del proceso y hito militar decisivo.",
    stem:
      "¿Qué datación del Grito hay que orientar como aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "20 de julio de 1810, y reenseñar no confundirlo con la Batalla de Boyacá (7 de agosto de 1819).",
      "7 de agosto de 1819 como “Grito”, fusionando ambos hitos.",
      "20 de julio de 1819, mezclando día del Grito con año de Boyacá.",
      "5 de agosto de 1810, por cercanía al calendario escolar.",
    ],
    correctIndex: 0,
    explanation:
      "El Grito de Independencia se conmemora el 20 de julio de 1810. El 7 de agosto de 1819 es la Batalla de Boyacá, otro hito.",
  },
  "dir-apt-dis-362": {
    caseContext:
      "Sobre Boyacá (7 de agosto de 1819), un texto estudiantil dice que “ahí empezó la independencia” (omitendo 1810). Otro explica que la victoria patriota abrió el camino a Bogotá y consolidó el proceso. Otro la presenta como “la primera Constitución”.",
    stem:
      "¿Qué interpretación del hito es la más defendible y qué error hay que reenseñar?",
    options: [
      "Que Boyacá inicia el proceso, borrando el Grito de 1810.",
      "Que consolidó la independencia al derrotar realistas y abrir el avance a Bogotá, y reenseñar no confundir inicio con desenlace militar.",
      "Que allí se promulgó la primera Constitución.",
      "Que cerró para siempre todo conflicto interno criollo.",
    ],
    correctIndex: 1,
    explanation:
      "Boyacá fue decisiva para consolidar la independencia y avanzar sobre Bogotá. No es el inicio del proceso (1810) ni un acto constitucional.",
  },
  "dir-apt-dis-363": {
    caseContext:
      "Al caracterizar la Constitución de 1886 (Regeneración, Núñez), un equipo la describe como federal y de estados soberanos (confusión con el federalismo previo). Otro como centralista y de larga vigencia hasta 1991. Otro dice que “al año siguiente llegó 1991”.",
    stem:
      "¿Qué caracterización evidencia el aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "Validar el modelo federal de 1886, proyectando el siglo XIX federal sobre esa carta.",
      "Validar la eliminación de la presidencia, sin base en el texto.",
      "Validar el centralismo y su vigencia hasta 1991, y reenseñar no atribuirle federalismo ni un reemplazo inmediato.",
      "Validar que 1991 la sustituyó al año siguiente de 1886.",
    ],
    correctIndex: 2,
    explanation:
      "La Constitución de 1886 estableció un modelo centralista y, con reformas, rigió hasta 1991. No es federal ni fue reemplazada al año siguiente.",
  },
  "dir-apt-dis-364": {
    caseContext:
      "Sobre la Guerra de los Mil Días (1899-1902), un estudiante la narra como guerra con un vecino; otro como patriotas vs. realistas españoles; otro como conflicto civil entre Partido Liberal y Partido Conservador. Se pide el carácter interno y partidista del hecho.",
    stem:
      "¿Qué lectura del conflicto es la más precisa y qué anacronismo hay que reenseñar?",
    options: [
      "Guerra internacional por límites, sin el clivaje partidista interno.",
      "Guerra de independencia vs. España, desplazada 80 años.",
      "Guerra indígena vs. Estado central, como única clave.",
      "Conflicto civil liberal–conservador de fin de siglo, y reenseñar no confundirlo con independencias o guerras vecinales.",
    ],
    correctIndex: 3,
    explanation:
      "La Guerra de los Mil Días fue un conflicto civil entre liberales y conservadores (1899-1902), no una guerra de independencia ni un conflicto internacional.",
  },
  "dir-apt-dis-365": {
    caseContext:
      "Un eje del siglo XX mezcla el 9 de abril de 1948 con el Acuerdo de 2016 y con 1991. Un estudiante atribuye el Bogotazo al asesinato de Jorge Eliécer Gaitán y a los disturbios en Bogotá. Otro lo identifica con el Frente Nacional o con la Constituyente.",
    stem:
      "¿Qué relación evidencia el aprendizaje esencial del Bogotazo y qué error hay que reenseñar?",
    options: [
      "Asesinato de Gaitán (9 de abril de 1948) y disturbios posteriores; reenseñar no desplazarlo a 1991 ni a 2016.",
      "Firma del Acuerdo de paz de 2016 con las FARC-EP.",
      "Promulgación de la Constitución de 1991.",
      "Inicio formal del Frente Nacional en esa misma fecha.",
    ],
    correctIndex: 0,
    explanation:
      "El Bogotazo se relaciona con el asesinato de Jorge Eliécer Gaitán el 9 de abril de 1948 y los disturbios en Bogotá. No es 1991 ni el Acuerdo de 2016.",
  },
  "dir-apt-dis-366": {
    caseContext:
      "Sobre el Frente Nacional (1958-1974), un texto dice que “unificó todos los partidos en uno solo”; otro describe alternancia presidencial y reparto paritario de cargos entre liberal y conservador. Otro habla de “gobierno militar permanente”.",
    stem:
      "¿Qué caracterización del pacto es la más precisa y qué error hay que reenseñar?",
    options: [
      "Partido único obligatorio, confundiendo pacto bipolar con unipartidismo.",
      "Alternancia y paridad liberal–conservador, y reenseñar que no eliminó elecciones ni instauró un gobierno militar permanente.",
      "Gobierno militar permanente como definición del período.",
      "Supresión completa de elecciones presidenciales.",
    ],
    correctIndex: 1,
    explanation:
      "El Frente Nacional pactó alternancia presidencial y reparto paritario entre liberal y conservador. No fue partido único ni dictadura militar permanente.",
  },
  "dir-apt-dis-367": {
    caseContext:
      "Al resumir el Acuerdo de 2016 (Gobierno–FARC-EP), un equipo escribe “se acabó el Congreso y los partidos”. Otro menciona reforma rural, participación política, dejación de armas y justicia transicional (JEP). Se pide contenidos del acuerdo, no caricatura institucional.",
    stem:
      "¿Qué síntesis evidencia el aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "La eliminación del sistema judicial ordinario como punto central.",
      "La disolución de todos los partidos existentes.",
      "Reforma rural, participación, fin del conflicto y JEP, y reenseñar que el acuerdo no disuelve el Estado de derecho.",
      "La anexión de nuevos territorios al país.",
    ],
    correctIndex: 2,
    explanation:
      "El Acuerdo de 2016 incluye, entre otros, reforma rural integral, participación política, fin del conflicto (dejación de armas) y justicia transicional (JEP). No elimina el Congreso ni los partidos.",
  },
  "dir-apt-dis-368": {
    caseContext:
      "Un esquema pide las tres ramas del poder público según la Constitución. Aparecen: “nacional, departamental y municipal”; “civil, militar y eclesiástica”; y “legislativa, ejecutiva y judicial”. Se pide el criterio de separación de poderes, no el de organización territorial.",
    stem:
      "¿Qué tríada evidencia el aprendizaje esencial y qué confusión hay que reenseñar?",
    options: [
      "Nacional–departamental–municipal (niveles territoriales, no ramas).",
      "Civil–militar–eclesiástica (órdenes sociales, no ramas constitucionales).",
      "Central–territorial–descentralizada (formas de administración).",
      "Legislativa, ejecutiva y judicial, y reenseñar no confundir ramas con niveles territoriales.",
    ],
    correctIndex: 3,
    explanation:
      "La Constitución de 1991 organiza el poder público en ramas legislativa, ejecutiva y judicial. Los niveles territorial o las órdenes social-religiosas no son esas ramas.",
  },
  "dir-apt-dis-369": {
    caseContext:
      "En un caso de vigilancia de recursos públicos, un estudiante asigna la función a la Procuraduría (disciplina de servidores); otro a la Defensoría (derechos humanos); otro a la Contraloría (gestión fiscal). Se pide el organismo de control fiscal, no el disciplinario.",
    stem:
      "¿Qué organismo corresponde a la vigilancia de fondos públicos y qué error hay que reenseñar?",
    options: [
      "La Contraloría General de la República (control fiscal) y reenseñar no confundirla con Procuraduría, Defensoría o Registraduría.",
      "La Procuraduría, porque “vigila a todo funcionario” en cualquier materia.",
      "La Defensoría del Pueblo, porque “defiende el presupuesto de la gente”.",
      "La Registraduría, porque “registra el gasto”.",
    ],
    correctIndex: 0,
    explanation:
      "La Contraloría vigila la gestión fiscal y el manejo de recursos públicos. La Procuraduría es disciplinaria; la Defensoría, derechos humanos; la Registraduría, identidad y procesos electorales.",
  },
  "dir-apt-dis-370": {
    caseContext:
      "En geografía de Colombia, un equipo nombra el Cauca como “el más largo”; otro el Magdalena, articulando transporte e historia económica; otro el Atrato “porque es el más caudaloso en su relato”. Se pide el río más largo y su papel histórico, no fama local.",
    stem:
      "¿Qué identificación es la más precisa y qué error hay que reenseñar?",
    options: [
      "El Cauca como el más largo, por ser afluente conocido.",
      "El Magdalena (el más largo y eje histórico de transporte) y reenseñar no sustituirlo por afluentes o ríos regionales.",
      "El Atrato, por relatos de caudal.",
      "El Meta, por la Orinoquía en el mapa escolar.",
    ],
    correctIndex: 1,
    explanation:
      "El Magdalena es el río más largo de Colombia y ha sido clave para el transporte y la actividad económica. Cauca, Atrato y Meta no desplazan ese hecho.",
  },
  "dir-apt-dis-371": {
    caseContext:
      "Un mapa de límites: un estudiante incluye México y Guatemala; otro Chile y Argentina; otro Panamá, Venezuela, Brasil, Perú y Ecuador. Se pide vecinos con frontera directa, no “América Latina” como bloque.",
    stem:
      "¿Qué conjunto de países evidencia el aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "México–Guatemala–Costa Rica–Panamá–Venezuela, ampliando Centroamérica sin frontera colombiana.",
      "Chile–Argentina–Bolivia–Perú–Ecuador, mezclando Cono Sur.",
      "Panamá, Venezuela, Brasil, Perú y Ecuador, y reenseñar no incluir países sin frontera terrestre con Colombia.",
      "Perú–Bolivia–Paraguay–Brasil–Venezuela, colando Bolivia y Paraguay.",
    ],
    correctIndex: 2,
    explanation:
      "Colombia limita con Panamá, Venezuela, Brasil, Perú y Ecuador. México, Chile, Argentina, Bolivia o Paraguay no tienen frontera terrestre con Colombia.",
  },
  "dir-apt-dis-372": {
    caseContext:
      "Se pregunta qué océano no baña América. Un estudiante descarta el Pacífico y el Atlántico (correcto que sí bañan) pero duda entre Ártico e Índico. Otro marca el Índico. Otro el Ártico “porque queda lejos”.",
    stem:
      "¿Qué océano no tiene costas en América y qué error hay que reenseñar?",
    options: [
      "El Pacífico, pese a la costa occidental americana.",
      "El Atlántico, pese a la costa oriental.",
      "El Ártico, omitiendo costas en el extremo norte americano.",
      "El Índico, y reenseñar que Pacífico, Atlántico y Ártico sí tocan el continente americano.",
    ],
    correctIndex: 3,
    explanation:
      "El océano Índico no tiene costas en América. Pacífico, Atlántico y Ártico sí alcanzan el continente americano.",
  },
  "dir-apt-dis-373": {
    caseContext:
      "Sobre 1789, un texto dice que la Revolución Francesa “consolidó la monarquía absoluta”; otro que impulsó libertad, igualdad y fraternidad e influyó en independencias americanas; otro que “no salió de Francia”. Se pide impacto de ideas, no el desenlace caricaturesco.",
    stem:
      "¿Qué lectura del hito es la más defendible y qué error hay que reenseñar?",
    options: [
      "Que impulsó esos ideales e influyó en procesos independentistas, y reenseñar que no consolidó el absolutismo ni el feudalismo.",
      "Que consolidó de modo definitivo la monarquía absoluta.",
      "Que no influyó fuera de Francia.",
      "Que marcó el inicio del feudalismo europeo.",
    ],
    correctIndex: 0,
    explanation:
      "La Revolución Francesa difundió ideales de libertad, igualdad y fraternidad e influyó en procesos posteriores, incluidos los independentistas americanos. No restauró el absolutismo ni inauguró el feudalismo.",
  },
  "dir-apt-dis-374": {
    caseContext:
      "Causas de 1914: un estudiante cita la caída del Muro de Berlín (1989); otro el sistema de alianzas, tensiones nacionalistas y coloniales (y el atentado de Sarajevo); otro el Tratado de Versalles (que es consecuencia). Se pide causa, no anacronismo.",
    stem:
      "¿Qué explicación de las causas es la más precisa y qué error hay que reenseñar?",
    options: [
      "La caída del Muro de Berlín, desplazada setenta años.",
      "Alianzas, nacionalismos y tensiones coloniales, y reenseñar no tomar Versalles (posguerra) ni 1989 como causa de 1914.",
      "El Tratado de Versalles como detonante de 1914.",
      "La independencia africana de mediados del siglo XX.",
    ],
    correctIndex: 1,
    explanation:
      "Entre las causas de la Primera Guerra Mundial están el sistema de alianzas y las tensiones nacionalistas y coloniales. Versalles es posterior; el Muro de Berlín, de 1989.",
  },
  "dir-apt-dis-375": {
    caseContext:
      "Sobre la Guerra Fría (aprox. 1947-1991), un ensayo afirma que EE. UU. y la URSS se combatieron de forma directa y continua en Europa. Otro describe tensión bipolar, carrera armamentista y conflictos indirectos, sin guerra directa entre ambas potencias.",
    stem:
      "¿Qué caracterización es la más precisa y qué error hay que reenseñar?",
    options: [
      "Guerra directa y continua EE. UU.–URSS en territorio europeo.",
      "Unificación política mundial bajo un solo sistema.",
      "Tensión bipolar sin enfrentamiento militar directo entre las dos potencias, y reenseñar no igualarla a una guerra europea continua entre ambas.",
      "El fin de todo conflicto internacional tras 1945.",
    ],
    correctIndex: 2,
    explanation:
      "La Guerra Fría fue una tensión política, ideológica y militar entre bloques, sin guerra directa continua entre EE. UU. y la URSS. Hubo conflictos indirectos y carrera armamentista.",
  },
  "dir-apt-dis-377": {
    caseContext:
      "Se contrastan economía de mercado y planificación central. Un estudiante dice que en el mercado “un ministerio asigna cupos a cada fábrica”; otro que las decisiones de qué, cómo y para quién producir pasan sobre todo por oferta y demanda, con rol limitado del Estado en la asignación directa.",
    stem:
      "¿Qué mecanismo evidencia el sistema de mercado y qué error hay que reenseñar?",
    options: [
      "La interacción oferta–demanda, y reenseñar que la asignación central de todos los recursos describe otro sistema.",
      "Un organismo estatal que planifica y asigna todos los recursos (planificación central, no mercado).",
      "Un sorteo periódico del gobierno como regla de mercado.",
      "Un monopolio estatal único por sector como definición de mercado.",
    ],
    correctIndex: 0,
    explanation:
      "En una economía de mercado, oferta y demanda orientan en lo principal qué, cómo y para quién producir. La asignación centralizada describe un sistema planificado, no de mercado.",
  },
  "dir-apt-dis-378": {
    caseContext:
      "En antropología escolar, un estudiante reduce “cultura” a pintura y música; otro al puntaje de pruebas; otro la entiende como conocimientos, creencias, valores y prácticas compartidas y transmitidas. Se pide el concepto amplio, no el uso coloquial de “culto”.",
    stem:
      "¿Qué concepción de cultura es la más precisa y qué reducción hay que reenseñar?",
    options: [
      "Solo artes (música, pintura) como sinónimo exhaustivo de cultura.",
      "El conjunto de conocimientos, creencias, valores y formas de vida compartidas y transmitidas, y reenseñar no reducirla a arte, título escolar o “sociedades antiguas”.",
      "Solo el nivel educativo formal alcanzado.",
      "Un concepto aplicable únicamente a sociedades “tradicionales”.",
    ],
    correctIndex: 1,
    explanation:
      "En antropología, cultura abarca conocimientos, creencias, valores, costumbres y formas de vida compartidas y transmitidas. No se reduce al arte ni al diploma.",
  },
  "dir-apt-dis-379": {
    caseContext:
      "Sobre urbanización, un texto dice que “el campo desapareció en todo el mundo”; otro la asocia a industrialización y migración campo–ciudad. Otro a “caída de la población mundial”. Se pide el proceso histórico, no el extremo retórico.",
    stem:
      "¿Qué asociación evidencia el aprendizaje esencial y qué error hay que reenseñar?",
    options: [
      "La urbanización como disminución general de la población mundial.",
      "El abandono total de la agricultura en el planeta.",
      "Industrialización y migración campo–ciudad, y reenseñar que lo rural no desaparece por el hecho de urbanizar.",
      "La desaparición completa de las zonas rurales en todos los países.",
    ],
    correctIndex: 2,
    explanation:
      "La urbanización se ha ligado históricamente a industrialización y migración campo–ciudad. No implica el fin de lo rural ni una caída demográfica mundial.",
  },
  "dir-apt-dis-380": {
    caseContext:
      "Periodización de independencias hispanoamericanas y brasileña: un estudiante las sitúa en el siglo XVI (conquista); otro en la segunda mitad del XX (descolonización africana); otro en las primeras décadas del XIX, con ideas ilustradas e invasión napoleónica a España.",
    stem:
      "¿Qué periodización es la más precisa y qué anacronismo hay que reenseñar?",
    options: [
      "Segunda mitad del siglo XX, confundiendo con otras descolonizaciones.",
      "Siglo XVI, identificando conquista con independencia.",
      "Siglo XVIII “antes de la Ilustración”, omitiendo el contexto de las ideas y de 1808.",
      "Primeras décadas del XIX, con Ilustración e invasión napoleónica, y reenseñar no desplazar el proceso a la Conquista ni al siglo XX.",
    ],
    correctIndex: 3,
    explanation:
      "Las independencias de la mayoría de países latinoamericanos se concentraron en las primeras décadas del siglo XIX, en un contexto ilustrado y de crisis de la monarquía española (invasión napoleónica).",
  },
};

module.exports = {HAND_DIS};
