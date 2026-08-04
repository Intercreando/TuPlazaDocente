/**
 * Directivo aptitudes — Ola 4 (301–400) · Ciencias Sociales (secundaria/media).
 * Elaboración propia. Eje 4 disciplinar = solo Ciencias Sociales.
 * Eje 5 = didáctica específica de ciencias sociales.
 */
const {raw, push} = require("./directivo_aptitudes_part7");

// ——— Lectura crítica (301–320): texto + 2 preguntas ———
const lectura = [
  {
    caso: "La independencia de las provincias que hoy conforman Colombia no fue un hecho aislado ocurrido en un único día, sino un proceso que se extendió por más de una década, con avances y retrocesos. Tras el llamado Grito de Independencia del 20 de julio de 1810, se vivió un período de luchas internas entre distintas facciones criollas, conocido como la Patria Boba, que debilitó la capacidad de resistencia frente a la reconquista española liderada por Pablo Morillo. Solo después de la campaña libertadora de Simón Bolívar, que culminó con la Batalla de Boyacá en 1819, se consolidó de manera más definitiva el proceso de independencia.",
    qs: [
      {
        n: 301,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La independencia de Colombia fue un proceso extendido en el tiempo, con avances y retrocesos, y no un hecho ocurrido en un solo día.",
          "La independencia de Colombia se logró únicamente el 20 de julio de 1810.",
          "La Patria Boba fortaleció la resistencia frente a la reconquista española.",
          "Simón Bolívar lideró la reconquista española en el territorio colombiano.",
        ],
        correct: "A",
        expl: "El texto plantea la independencia como un proceso extendido, señalando distintas etapas hasta su consolidación.",
      },
      {
        n: 302,
        stem: "Según el texto, ¿qué caracterizó al período conocido como la Patria Boba?",
        options: [
          "Una alianza sólida entre todas las facciones criollas.",
          "Luchas internas entre distintas facciones criollas que debilitaron la resistencia frente a la reconquista.",
          "La consolidación definitiva de la independencia.",
          "La ausencia total de conflictos políticos internos.",
        ],
        correct: "B",
        expl: "El texto lo describe explícitamente como un período de luchas internas que debilitó la resistencia.",
      }
    ],
  },
  {
    caso: "Colombia se caracteriza por una notable diversidad geográfica, resultado en buena parte de la presencia de la cordillera de los Andes, que se divide en tres ramales al ingresar al territorio nacional. Esta configuración da origen a regiones naturales tan distintas entre sí como la Andina, la Caribe, la Pacífica, la Orinoquía y la Amazonía, cada una con climas, ecosistemas y formas de poblamiento propias. Esta diversidad geográfica ha influido históricamente en la manera desigual en que se han desarrollado las vías de comunicación y las actividades económicas en las distintas zonas del país.",
    qs: [
      {
        n: 303,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Colombia tiene una geografía completamente homogénea en todo su territorio.",
          "La cordillera de los Andes no influye en la diversidad geográfica de Colombia.",
          "La diversidad geográfica de Colombia, marcada por la cordillera de los Andes, ha influido en el desarrollo desigual de sus regiones.",
          "Las cinco regiones naturales de Colombia tienen exactamente el mismo clima.",
        ],
        correct: "C",
        expl: "El texto vincula la diversidad geográfica con el desarrollo desigual de las regiones del país.",
      },
      {
        n: 304,
        stem: "Según el texto, ¿qué origina la división de la cordillera de los Andes en tres ramales?",
        options: [
          "La eliminación de las regiones naturales del país.",
          "Una reducción en la diversidad de ecosistemas.",
          "La homogeneización del clima en todo el territorio.",
          "El origen de regiones naturales distintas, como la Andina, la Caribe, la Pacífica, la Orinoquía y la Amazonía.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente como consecuencia de esta configuración geográfica.",
      }
    ],
  },
  {
    caso: "Uno de los conceptos fundamentales de la economía es la relación entre la oferta y la demanda de un bien o servicio: cuando la cantidad demandada por los consumidores supera la cantidad ofrecida por los productores, suele producirse una tendencia al aumento del precio, mientras que una oferta que supera ampliamente la demanda tiende a generar una reducción de precios. Sin embargo, esta relación no opera de manera igualmente libre en todos los mercados, ya que factores como la intervención estatal, los monopolios o la información imperfecta pueden alterar este comportamiento esperado.",
    qs: [
      {
        n: 305,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La relación entre oferta y demanda influye en los precios, aunque distintos factores pueden alterar su comportamiento esperado.",
          "Los precios nunca se ven afectados por la relación entre oferta y demanda.",
          "La intervención estatal es el único factor que determina los precios en cualquier mercado.",
          "La oferta y la demanda son conceptos que no tienen ninguna relación con los precios.",
        ],
        correct: "A",
        expl: "El texto plantea la relación general entre oferta, demanda y precios, matizada por factores que pueden alterarla.",
      },
      {
        n: 306,
        stem: "Según el texto, ¿qué tiende a ocurrir cuando la demanda de un bien supera ampliamente su oferta?",
        options: [
          "Una tendencia a la reducción del precio.",
          "Una tendencia al aumento del precio.",
          "La desaparición completa del bien del mercado.",
          "Ninguna variación en el precio del bien.",
        ],
        correct: "B",
        expl: "El texto lo señala explícitamente como la tendencia esperada en esa situación.",
      }
    ],
  },
  {
    caso: "La democracia representativa, en la que los ciudadanos eligen a sus gobernantes mediante el voto, ha sido complementada en muchos países, incluido Colombia, con mecanismos de participación directa como el referendo, la consulta popular o el plebiscito. Estos mecanismos permiten que la ciudadanía se pronuncie directamente sobre decisiones específicas, más allá de la elección periódica de representantes, aunque su uso efectivo depende de condiciones como el acceso a información clara y la existencia de garantías para una participación libre e informada.",
    qs: [
      {
        n: 307,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La democracia representativa ha sido eliminada por completo en Colombia.",
          "Los mecanismos de participación directa reemplazan por completo la elección de representantes.",
          "Los mecanismos de participación directa complementan la democracia representativa, aunque su efectividad depende de ciertas condiciones.",
          "El plebiscito es el único mecanismo de participación ciudadana existente en Colombia.",
        ],
        correct: "C",
        expl: "El texto plantea estos mecanismos como un complemento a la democracia representativa, condicionado a ciertos factores.",
      },
      {
        n: 308,
        stem: "Según el texto, ¿de qué depende el uso efectivo de estos mecanismos de participación directa?",
        options: [
          "Exclusivamente de la voluntad del gobierno de turno.",
          "De la eliminación de la democracia representativa.",
          "De que se apliquen únicamente en elecciones presidenciales.",
          "Del acceso a información clara y de garantías para una participación libre e informada.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente como condiciones necesarias para su uso efectivo.",
      }
    ],
  },
  {
    caso: "Colombia reconoce constitucionalmente su carácter pluriétnico y multicultural, lo que incluye el reconocimiento de más de un centenar de pueblos indígenas con lenguas, cosmovisiones y formas de organización propias. Este reconocimiento no se limita a un enunciado simbólico: implica, entre otros aspectos, el derecho de estos pueblos a la consulta previa frente a decisiones que puedan afectar sus territorios, así como a la jurisdicción especial indígena para resolver ciertos conflictos según sus propias normas y procedimientos.",
    qs: [
      {
        n: 309,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "El reconocimiento constitucional de la diversidad étnica de Colombia implica derechos concretos, como la consulta previa y la jurisdicción especial indígena.",
          "Colombia no reconoce constitucionalmente ningún tipo de diversidad étnica.",
          "Los pueblos indígenas de Colombia carecen de cualquier forma de organización propia.",
          "La consulta previa es un mecanismo que no tiene ninguna relación con los pueblos indígenas.",
        ],
        correct: "A",
        expl: "El texto plantea que este reconocimiento constitucional se traduce en derechos concretos, más allá de lo simbólico.",
      },
      {
        n: 310,
        stem: "Según el texto, ¿qué le permite a los pueblos indígenas la jurisdicción especial indígena?",
        options: [
          "Estar exentos de cualquier tipo de normatividad.",
          "Resolver ciertos conflictos según sus propias normas y procedimientos.",
          "Eliminar la consulta previa en la toma de decisiones.",
          "Participar exclusivamente en elecciones locales.",
        ],
        correct: "B",
        expl: "El texto lo señala explícitamente como una de las implicaciones del reconocimiento constitucional.",
      }
    ],
  },
  {
    caso: "Los movimientos migratorios rara vez responden a una sola causa: factores económicos, como la búsqueda de mejores oportunidades laborales, suelen combinarse con motivos como la violencia, los desastres naturales o la persecución política. Comprender esta multicausalidad es importante para evitar explicaciones simplistas sobre los procesos migratorios, así como para diseñar políticas públicas que respondan de manera integral a las distintas necesidades de la población migrante.",
    qs: [
      {
        n: 311,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Los movimientos migratorios siempre responden a una única causa económica.",
          "La violencia y los desastres naturales nunca influyen en los procesos migratorios.",
          "Los procesos migratorios suelen tener múltiples causas combinadas, lo que es importante para evitar explicaciones simplistas.",
          "Las políticas públicas no deben considerar las causas de la migración.",
        ],
        correct: "C",
        expl: "El texto plantea la multicausalidad como una idea central para comprender los procesos migratorios.",
      },
      {
        n: 312,
        stem: "Según el texto, ¿para qué es importante comprender la multicausalidad de la migración?",
        options: [
          "Para justificar el cierre total de fronteras.",
          "Para culpar exclusivamente a los migrantes de su situación.",
          "Para reducir la migración a un problema exclusivamente económico.",
          "Para evitar explicaciones simplistas y diseñar políticas públicas más integrales.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente como propósito de comprender esta multicausalidad.",
      }
    ],
  },
  {
    caso: "El cambio climático no es solo un fenómeno atmosférico: sus efectos, como el aumento del nivel del mar o la alteración de los patrones de lluvia, tienen consecuencias directas sobre la geografía humana, alterando patrones de asentamiento, actividades agrícolas y, en algunos casos, generando desplazamientos de población. Estudiar el cambio climático desde las ciencias sociales implica, entonces, analizar no solo sus causas físicas, sino también sus efectos sobre las dinámicas sociales, económicas y territoriales de las comunidades afectadas.",
    qs: [
      {
        n: 313,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "El cambio climático tiene efectos sobre la geografía humana que deben analizarse también desde las ciencias sociales.",
          "El cambio climático es un fenómeno que no tiene ninguna relación con las ciencias sociales.",
          "El cambio climático solo debe estudiarse desde una perspectiva estrictamente atmosférica.",
          "Los patrones de asentamiento humano no se ven afectados por el cambio climático.",
        ],
        correct: "A",
        expl: "El texto plantea la necesidad de estudiar el cambio climático también desde sus efectos sociales y territoriales.",
      },
      {
        n: 314,
        stem: "Según el texto, ¿qué tipo de consecuencias puede generar el cambio climático sobre la población?",
        options: [
          "Ninguna consecuencia relevante sobre los patrones de asentamiento.",
          "Alteraciones en los patrones de asentamiento, las actividades agrícolas y, en algunos casos, desplazamientos de población.",
          "Un aumento generalizado y uniforme de la población en todas las regiones.",
          "La eliminación completa de las actividades agrícolas en todo el mundo.",
        ],
        correct: "B",
        expl: "El texto los menciona explícitamente como consecuencias del cambio climático sobre la geografía humana.",
      }
    ],
  },
  {
    caso: "La Constitución Política de 1991 significó una transformación importante frente a la Constitución de 1886 que la precedió: entre otros cambios, amplió el catálogo de derechos fundamentales, creó mecanismos como la acción de tutela para proteger esos derechos de manera ágil, y estableció nuevas instituciones como la Corte Constitucional. Aunque han pasado más de tres décadas desde su promulgación, algunos de sus principios, como el reconocimiento del Estado Social de Derecho, continúan siendo un referente central en el debate político y jurídico del país.",
    qs: [
      {
        n: 315,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "La Constitución de 1991 no introdujo ningún cambio respecto a la de 1886.",
          "La acción de tutela fue eliminada por la Constitución de 1991.",
          "La Constitución de 1991 amplió los derechos fundamentales y creó nuevos mecanismos e instituciones, cuyos principios siguen vigentes en el debate actual.",
          "La Corte Constitucional fue creada antes de la Constitución de 1991.",
        ],
        correct: "C",
        expl: "El texto describe estos cambios y señala la vigencia de sus principios en el debate actual.",
      },
      {
        n: 316,
        stem: "Según el texto, ¿qué mecanismo se creó en la Constitución de 1991 para proteger de manera ágil los derechos fundamentales?",
        options: [
          "El referendo.",
          "La consulta popular.",
          "El plebiscito.",
          "La acción de tutela.",
        ],
        correct: "D",
        expl: "El texto lo menciona explícitamente como uno de los mecanismos creados por la Constitución de 1991.",
      }
    ],
  },
  {
    caso: "El crecimiento acelerado de las ciudades latinoamericanas durante el siglo XX, impulsado en buena parte por la migración desde zonas rurales, no siempre estuvo acompañado de una planeación urbana adecuada. Esto se tradujo, en muchos casos, en la expansión de asentamientos informales en las periferias urbanas, con acceso limitado a servicios públicos, transporte y equipamientos educativos, lo que generó patrones de desigualdad territorial que persisten hasta la actualidad en varias ciudades de la región.",
    qs: [
      {
        n: 317,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "El crecimiento acelerado de las ciudades latinoamericanas, sin una planeación adecuada, generó desigualdades territoriales que persisten hasta hoy.",
          "El crecimiento de las ciudades latinoamericanas estuvo siempre acompañado de una planeación urbana adecuada.",
          "La migración rural-urbana no tuvo ninguna influencia en el crecimiento de las ciudades.",
          "Los asentamientos informales desaparecieron completamente durante el siglo XX.",
        ],
        correct: "A",
        expl: "El texto vincula el crecimiento urbano sin planeación adecuada con la persistencia de desigualdades territoriales.",
      },
      {
        n: 318,
        stem: "Según el texto, ¿qué caracterizó a muchos de los asentamientos informales surgidos en las periferias urbanas?",
        options: [
          "Un acceso amplio y garantizado a todos los servicios públicos.",
          "Un acceso limitado a servicios públicos, transporte y equipamientos educativos.",
          "Una planeación urbana ejemplar desde su origen.",
          "La ausencia total de población migrante.",
        ],
        correct: "B",
        expl: "El texto lo señala explícitamente como característica de estos asentamientos.",
      }
    ],
  },
  {
    caso: "La noción de derechos humanos, tal como se conoce hoy, ha sido el resultado de un proceso histórico de ampliación progresiva: de un enfoque inicial centrado en los derechos civiles y políticos (como la libertad de expresión o el derecho al voto), se pasó gradualmente a reconocer también los derechos económicos, sociales y culturales (como la educación o la salud), y más recientemente, derechos colectivos como el derecho a un ambiente sano. Esta evolución refleja cambios en la manera en que las sociedades han entendido la dignidad humana a lo largo del tiempo.",
    qs: [
      {
        n: 319,
        stem: "¿Cuál es la idea principal del texto?",
        options: [
          "Los derechos humanos han tenido siempre exactamente el mismo alcance a lo largo de la historia.",
          "Los derechos económicos, sociales y culturales fueron los primeros en reconocerse históricamente.",
          "La noción de derechos humanos ha evolucionado históricamente, ampliándose de los derechos civiles y políticos a otros como los sociales y colectivos.",
          "El derecho a un ambiente sano fue el primer derecho humano reconocido en la historia.",
        ],
        correct: "C",
        expl: "El texto describe esta evolución progresiva en el reconocimiento de distintas categorías de derechos.",
      },
      {
        n: 320,
        stem: "Según el texto, ¿qué tipo de derechos se reconocieron más recientemente, según lo descrito?",
        options: [
          "Los derechos civiles y políticos.",
          "Exclusivamente el derecho al voto.",
          "Los derechos económicos y sociales únicamente.",
          "Derechos colectivos, como el derecho a un ambiente sano.",
        ],
        correct: "D",
        expl: "El texto lo señala explícitamente como el reconocimiento más reciente en esta evolución histórica.",
      }
    ],
  }
];

for (const block of lectura) {
  for (const q of block.qs) {
    push({
      id: `dir-apt-lec-${String(q.n).padStart(3, "0")}`,
      pillar: "lecturaCritica",
      module: "Lectura crítica",
      topic: "Lectura crítica · Ciencias Sociales (ola 4)",
      caso: block.caso,
      stem: q.stem,
      options: q.options,
      correct: q.correct,
      expl: q.expl,
      tags: q.tags || [],
      dif: 2,
      caseStudy: true,
    });
  }
}

// ——— Razonamiento cuantitativo (321–340) ———
const cuant = [
  {
    n: 321,
    stem: "Un mapa tiene una escala 1:50.000. Si la distancia entre dos ciudades en el mapa es de 6 cm, ¿cuál es la distancia real aproximada entre ellas?",
    options: [
      "3 km",
      "2.5 km",
      "3.5 km",
      "4 km",
    ],
    correct: "A",
    expl: "6 cm x 50.000 = 300.000 cm = 3.000 m = 3 km.",
  },
  {
    n: 322,
    stem: "Un país tiene una población de 48 millones de habitantes. Si el 76% vive en zonas urbanas, ¿cuántos millones de habitantes viven en zonas rurales, aproximadamente?",
    options: [
      "10.5",
      "11.5",
      "12.5",
      "13.5",
    ],
    correct: "B",
    expl: "Población urbana: 48 × 0.76 = 36.48 millones. Población rural: 48 − 36.48 = 11.5 millones.",
  },
  {
    n: 323,
    stem: "Entre el año 1810 y el año 1819 (Batalla de Boyacá), ¿cuántos años transcurrieron?",
    options: [
      "7",
      "8",
      "9",
      "10",
    ],
    correct: "C",
    expl: "1819 - 1810 = 9 años.",
  },
  {
    n: 324,
    stem: "En un curso de ciencias sociales, un docente pide a sus 40 estudiantes ubicar en un mapa 5 países cada uno. ¿Cuántas ubicaciones en total deberá revisar el docente?",
    options: [
      "150",
      "180",
      "190",
      "200",
    ],
    correct: "D",
    expl: "40 × 5 = 200 ubicaciones.",
  },
  {
    n: 325,
    stem: "Si la inflación anual de un país fue del 4.5% y el salario mínimo se ajustó en un 6%, ¿cuál fue el incremento real aproximado del salario mínimo por encima de la inflación?",
    options: [
      "1.5%",
      "1.0%",
      "2.0%",
      "2.5%",
    ],
    correct: "A",
    expl: "El incremento real aproximado se calcula restando la inflación al ajuste salarial: 6% - 4.5% = 1.5%.",
  },
  {
    n: 326,
    stem: "Un docente de ciencias sociales organiza una línea del tiempo con 24 eventos históricos distribuidos equitativamente en 4 períodos. ¿Cuántos eventos corresponden a cada período?",
    options: [
      "5",
      "6",
      "7",
      "8",
    ],
    correct: "B",
    expl: "24 ÷ 4 = 6 eventos por período.",
  },
  {
    n: 327,
    stem: "En una encuesta aplicada a 200 estudiantes sobre participación en el gobierno escolar, el 35% afirmó haber votado en la última elección de personero. ¿Cuántos estudiantes fue eso?",
    options: [
      "60",
      "65",
      "70",
      "75",
    ],
    correct: "C",
    expl: "200 × 0.35 = 70 estudiantes.",
  },
  {
    n: 328,
    stem: "Si la superficie de un país es de 1.140.000 km2 y el 12% corresponde a áreas protegidas, ¿cuántos km2 son áreas protegidas, aproximadamente?",
    options: [
      "108.000 km2",
      "120.000 km2",
      "128.000 km2",
      "136.800 km2",
    ],
    correct: "D",
    expl: "1.140.000 × 0.12 = 136.800 km².",
  },
  {
    n: 329,
    stem: "Un docente revisa 36 mapas conceptuales sobre la Constitución de 1991, a un ritmo de 4 minutos cada uno. ¿Cuánto tiempo total le toma la revisión?",
    options: [
      "2h 24min",
      "2h 12min",
      "2h 36min",
      "2h 48min",
    ],
    correct: "A",
    expl: "36 x 4 = 144 minutos = 2 horas con 24 minutos.",
  },
  {
    n: 330,
    stem: "En una gráfica de crecimiento poblacional, una ciudad pasó de 1.200.000 a 1.500.000 habitantes en 10 años. ¿Cuál fue el porcentaje de crecimiento en ese período?",
    options: [
      "20%",
      "25%",
      "30%",
      "35%",
    ],
    correct: "B",
    expl: "Incremento: 1.500.000 - 1.200.000 = 300.000. Porcentaje: 300.000 / 1.200.000 = 0.25 = 25%.",
  },
  {
    n: 331,
    stem: "Un docente asigna un taller de análisis de fuentes históricas con 15 preguntas. Si un estudiante responde correctamente el 60%, ¿cuántas preguntas respondió correctamente?",
    options: [
      "7",
      "8",
      "9",
      "10",
    ],
    correct: "C",
    expl: "15 × 0.60 = 9 preguntas.",
  },
  {
    n: 332,
    stem: "Si el Producto Interno Bruto (PIB) de un país fue de $280 billones de pesos, y el sector agropecuario representó el 7% de ese total, ¿a cuánto equivale aproximadamente el PIB agropecuario?",
    options: [
      "$14 billones",
      "$16.8 billones",
      "$18.2 billones",
      "$19.6 billones",
    ],
    correct: "D",
    expl: "280 × 0.07 = $19.6 billones de pesos.",
  },
  {
    n: 333,
    stem: "Un docente organiza un debate en el que participan 28 estudiantes, divididos en 2 equipos con igual número de integrantes. ¿Cuántos estudiantes hay en cada equipo?",
    options: [
      "14",
      "12",
      "16",
      "10",
    ],
    correct: "A",
    expl: "28 ÷ 2 = 14 estudiantes por equipo.",
  },
  {
    n: 334,
    stem: "En un curso, el 40% de los estudiantes eligió investigar sobre la Independencia y el 25% sobre la Constitución de 1991, del total de 32 estudiantes. ¿Cuántos estudiantes eligieron otro tema?",
    options: [
      "9",
      "11",
      "13",
      "15",
    ],
    correct: "B",
    expl: "40% + 25% = 65%. El 35% restante corresponde a otro tema: 32 × 0.35 = 11 estudiantes.",
  },
  {
    n: 335,
    stem: "Si en 1991 la Asamblea Nacional Constituyente estuvo compuesta por 70 miembros, y el 20% pertenecía a partidos distintos a los tradicionales, ¿cuántos miembros representaba ese porcentaje, aproximadamente?",
    options: [
      "10",
      "12",
      "14",
      "16",
    ],
    correct: "C",
    expl: "70 × 0.20 = 14 miembros.",
  },
  {
    n: 336,
    stem: "Un docente de ciencias sociales dedica 3 de las 5 clases semanales al estudio de la historia y el resto a geografía. ¿Qué porcentaje del tiempo semanal se dedica a geografía?",
    options: [
      "20%",
      "30%",
      "35%",
      "40%",
    ],
    correct: "D",
    expl: "2 de las 5 clases se dedican a geografía: 2/5 = 0.40 = 40%.",
  },
  {
    n: 337,
    stem: "Si la tasa de desempleo de una ciudad es del 11.5% sobre una población económicamente activa de 800.000 personas, ¿cuántas personas estarían desempleadas, aproximadamente?",
    options: [
      "92.000",
      "84.000",
      "98.000",
      "104.000",
    ],
    correct: "A",
    expl: "800.000 x 0.115 = 92.000 personas.",
  },
  {
    n: 338,
    stem: "Un docente elabora un cuestionario sobre los órganos del poder público con 24 preguntas, distribuidas equitativamente entre las 3 ramas del poder. ¿Cuántas preguntas corresponden a cada rama?",
    options: [
      "6",
      "8",
      "10",
      "12",
    ],
    correct: "B",
    expl: "24 ÷ 3 = 8 preguntas por cada rama del poder público.",
  },
  {
    n: 339,
    stem: "Entre la Constitución de 1886 y la Constitución de 1991, ¿cuántos años transcurrieron?",
    options: [
      "95",
      "100",
      "105",
      "110",
    ],
    correct: "C",
    expl: "1991 - 1886 = 105 años.",
  },
  {
    n: 340,
    stem: "En una gráfica de distribución del territorio nacional, el 6% corresponde a áreas urbanas, sobre una superficie total de 1.140.000 km2. ¿Cuántos km2 corresponden aproximadamente a áreas urbanas?",
    options: [
      "54.000 km2",
      "60.000 km2",
      "64.200 km2",
      "68.400 km2",
    ],
    correct: "D",
    expl: "1.140.000 x 0.06 = 68.400 km².",
  }
];

for (const q of cuant) {
  push({
    id: `dir-apt-num-${String(q.n).padStart(3, "0")}`,
    pillar: "aptitudNumerica",
    module: "Aptitud numérica",
    topic: "Razonamiento cuantitativo · Ciencias Sociales (ola 4)",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: [],
    dif: 1,
  });
}

// ——— Competencias blandas (341–360) ———
const blandas = [
  {
    n: 341,
    stem: "Un debate en clase sobre un tema político genera posiciones muy polarizadas entre los estudiantes, con un tono cada vez más acalorado. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Recordar y reforzar las normas de escucha y respeto acordadas previamente, y redirigir el debate hacia el análisis de argumentos en lugar de posiciones personales.",
      "Suspender permanentemente cualquier discusión sobre temas políticos en el aula.",
      "Tomar partido abiertamente por una de las posiciones para orientar la discusión.",
      "Dejar que el debate continúe sin ninguna intervención, sin importar el tono que tome.",
    ],
    correct: "A",
    expl: "Reforzar las normas de respeto y reorientar hacia el análisis de argumentos permite mantener el valor pedagógico del debate sin perder el control del ambiente.",
  },
  {
    n: 342,
    stem: "Un estudiante presenta una noticia falsa (desinformación) como fuente confiable en un trabajo sobre un tema de actualidad. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Calificar el trabajo sin hacer ninguna observación sobre la fuente utilizada.",
      "Aprovechar la situación como oportunidad pedagógica para trabajar con el grupo criterios de verificación y evaluación de fuentes.",
      "Ridiculizar públicamente al estudiante por usar una fuente poco confiable.",
      "Prohibir el uso de cualquier fuente digital en futuros trabajos.",
    ],
    correct: "B",
    expl: "Convertir el error en una oportunidad de enseñanza sobre alfabetización mediática fortalece una competencia clave del área.",
  },
  {
    n: 343,
    stem: "Un padre de familia cuestiona que se aborde en clase un tema que considera políticamente sensible, como los derechos humanos. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Eliminar el tema del currículo de inmediato para evitar el conflicto.",
      "Ignorar la inquietud del padre sin ofrecer ninguna explicación.",
      "Explicar con respeto el sustento curricular y pedagógico del tema, y aclarar que se aborda desde una perspectiva plural y no partidista.",
      "Decirle al padre que no tiene ningún derecho a opinar sobre el contenido de la clase.",
    ],
    correct: "C",
    expl: "Explicar el sustento curricular y el enfoque plural del tema responde a la inquietud sin renunciar a contenidos formativos legítimos.",
  },
  {
    n: 344,
    stem: "Al hablar sobre el conflicto armado colombiano, un estudiante revela espontáneamente que su familia fue víctima de desplazamiento forzado. ¿Cuál sería la actuación más adecuada del docente en ese momento?",
    options: [
      "Ignorar el comentario y continuar la clase como si no hubiera pasado nada.",
      "Pedirle al estudiante que dé más detalles frente a todo el curso.",
      "Cambiar de tema de inmediato para evitar cualquier incomodidad.",
      "Reconocer con sensibilidad lo compartido, sin exponerlo más de lo que él mismo decidió compartir, y ofrecer un espacio de conversación posterior si lo desea.",
    ],
    correct: "D",
    expl: "Reconocer con sensibilidad lo compartido, sin forzar mayor exposición, respeta la experiencia del estudiante y abre la puerta a un acompañamiento posterior si es necesario.",
  },
  {
    n: 345,
    stem: "Dos estudiantes con posturas políticas opuestas, que reflejan las de sus familias, discuten de forma acalorada durante una actividad de clase. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Mediar el intercambio, orientándolo hacia la argumentación basada en evidencia y el respeto mutuo, sin descalificar ninguna de las posturas familiares.",
      "Prohibirles definitivamente participar juntos en cualquier actividad futura.",
      "Tomar partido por la postura que el docente considera más acertada.",
      "Ignorar la discusión mientras no se torne físicamente agresiva.",
    ],
    correct: "A",
    expl: "Mediar hacia la argumentación basada en evidencia, sin descalificar ninguna postura familiar, preserva el pluralismo propio de la formación ciudadana.",
  },
  {
    n: 346,
    stem: "Durante una clase sobre diversidad cultural, un estudiante hace un comentario discriminatorio hacia un grupo étnico. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Ignorar el comentario para no interrumpir el desarrollo de la clase.",
      "Abordar el comentario en el momento, explicando por qué resulta problemático, y retomarlo como contenido formativo sobre el respeto a la diversidad.",
      "Sancionar de inmediato al estudiante sin ninguna conversación formativa.",
      "Reírse del comentario para aliviar la tensión del momento.",
    ],
    correct: "B",
    expl: "Abordar el comentario en el momento, con un enfoque formativo, convierte la situación en una oportunidad de aprendizaje sobre el respeto a la diversidad.",
  },
  {
    n: 347,
    stem: "Se acerca un período electoral y un estudiante pregunta directamente por quién debería votar su familia. ¿Cuál sería la respuesta más adecuada del docente?",
    options: [
      "Recomendar abiertamente un candidato o partido específico.",
      "Evitar por completo cualquier conversación relacionada con las elecciones.",
      "Explicar que esa es una decisión personal y familiar, y en su lugar orientar al estudiante sobre cómo analizar propuestas y fuentes de información para formar su propio criterio.",
      "Pedirle que le pregunte directamente al docente de otra área.",
    ],
    correct: "C",
    expl: "Orientar hacia el desarrollo del criterio propio del estudiante, sin emitir recomendaciones partidistas, es coherente con el rol formativo del docente en un tema electoral.",
  },
  {
    n: 348,
    stem: "Un estudiante presenta, como parte de una investigación, una fuente histórica con contenido gráfico de violencia relacionado con un período como La Violencia en Colombia. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Prohibir cualquier uso de fuentes históricas relacionadas con la violencia en el país.",
      "Proyectar el contenido sin ninguna preparación previa al resto del curso.",
      "Ignorar el contenido gráfico y evaluar solo el análisis escrito del estudiante.",
      "Revisar previamente el material, contextualizarlo pedagógicamente y decidir con criterio qué parte es pertinente compartir con el grupo, considerando su edad y sensibilidad.",
    ],
    correct: "D",
    expl: "Revisar y contextualizar previamente el material permite un manejo pedagógicamente responsable de fuentes históricas sensibles.",
  },
  {
    n: 349,
    stem: "Durante un proyecto de árbol genealógico, un estudiante muestra reticencia a compartir información sobre su familia. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Respetar su decisión, ofrecer alternativas flexibles para desarrollar la actividad sin exponer información que el estudiante prefiera no compartir.",
      "Insistir en que debe compartir toda la información solicitada sin ninguna excepción.",
      "Calificar con una nota baja al estudiante por no completar la actividad como se solicitó originalmente.",
      "Pedirle a otro familiar que complete la información directamente con el docente.",
    ],
    correct: "A",
    expl: "Respetar la reticencia del estudiante y ofrecer alternativas flexibles reconoce que las situaciones familiares pueden ser sensibles y diversas.",
  },
  {
    n: 350,
    stem: "Durante una actividad sobre tradiciones religiosas mayoritarias, un estudiante de una religión minoritaria se muestra incómodo. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Ignorar la incomodidad, ya que la actividad está relacionada con el contenido curricular.",
      "Abordar el tema desde una perspectiva plural que incluya distintas tradiciones religiosas, y conversar en privado con el estudiante si es necesario.",
      "Eliminar por completo cualquier contenido relacionado con tradiciones religiosas del currículo.",
      "Pedirle al estudiante que exponga su propia religión frente a todo el curso sin previo aviso.",
    ],
    correct: "B",
    expl: "Abordar el tema desde una perspectiva plural, y ofrecer un espacio de conversación individual, respeta la diversidad religiosa presente en el aula.",
  },
  {
    n: 351,
    stem: "Durante una discusión sobre desigualdad económica, un grupo de estudiantes de bajos recursos parece sentirse señalado por los ejemplos utilizados. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Continuar la clase exactamente igual, sin ningún ajuste.",
      "Suspender por completo el tema de desigualdad económica del currículo.",
      "Ajustar los ejemplos utilizados, abordar el tema con sensibilidad y enfocarlo en el análisis estructural más que en situaciones personales de los estudiantes.",
      "Pedir a los estudiantes que compartan públicamente su situación económica familiar.",
    ],
    correct: "C",
    expl: "Ajustar los ejemplos y enfocar el análisis en lo estructural, con sensibilidad, evita exponer innecesariamente la situación personal de los estudiantes.",
  },
  {
    n: 352,
    stem: "Un colega de otra área cuestiona que el docente dedique tiempo de clase a analizar la coyuntura política actual. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Ignorar por completo la opinión del colega sin ninguna conversación.",
      "Eliminar de inmediato cualquier análisis de coyuntura del currículo.",
      "Responder de forma confrontativa al colega frente a otros docentes.",
      "Explicar con respeto el sustento pedagógico de analizar la coyuntura para desarrollar competencias ciudadanas y de pensamiento crítico.",
    ],
    correct: "D",
    expl: "Explicar el sustento pedagógico del análisis de coyuntura, con respeto, defiende la pertinencia curricular del área de ciencias sociales.",
  },
  {
    n: 353,
    stem: "Estudiantes de estratos socioeconómicos distintos expresan opiniones muy diferentes sobre un tema de política pública, generando cierta tensión en el grupo. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Facilitar que las distintas perspectivas se expresen con respeto, y usar la diversidad de opiniones como insumo para analizar el tema desde múltiples ángulos.",
      "Descalificar las opiniones que no coincidan con la posición mayoritaria del grupo.",
      "Evitar cualquier tema de política pública para no generar tensión en el aula.",
      "Pedir a los estudiantes que oculten su origen socioeconómico durante la discusión.",
    ],
    correct: "A",
    expl: "Facilitar la expresión respetuosa de las distintas perspectivas enriquece el análisis del tema desde múltiples ángulos, en lugar de evitarlo.",
  },
  {
    n: 354,
    stem: "Un estudiante manifiesta desinterés total por la clase de ciencias sociales, calificándola como 'poco útil'. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Ignorar el comentario sin ningún tipo de conversación con el estudiante.",
      "Conversar con el estudiante para entender su percepción, y explorar formas de conectar los contenidos con situaciones o intereses relevantes para él.",
      "Bajarle la calificación por expresar una opinión negativa sobre la asignatura.",
      "Confirmarle que tiene razón y reducir las exigencias de la asignatura para él.",
    ],
    correct: "B",
    expl: "Indagar la percepción del estudiante y buscar conexiones significativas con sus intereses es más constructivo que ignorar o sancionar su comentario.",
  },
  {
    n: 355,
    stem: "Durante un simulacro de las Naciones Unidas (Modelo ONU), un estudiante debe representar una postura con la que está personalmente en desacuerdo. Manifiesta incomodidad con esto al docente. ¿Cuál sería la respuesta más adecuada?",
    options: [
      "Eximirlo de la actividad sin ninguna explicación pedagógica.",
      "Obligarlo a participar sin reconocer su incomodidad.",
      "Explicarle el valor pedagógico de representar posturas distintas a la propia para desarrollar empatía y comprensión de otras perspectivas, ofreciendo acompañamiento en el proceso.",
      "Cambiarle la postura asignada a la que él personalmente prefiere, sin ningún propósito pedagógico adicional.",
    ],
    correct: "C",
    expl: "Explicar el valor formativo de representar posturas distintas, ofreciendo acompañamiento, ayuda a resignificar la incomodidad inicial como parte del aprendizaje.",
  },
  {
    n: 356,
    stem: "Un estudiante llega visiblemente alterado a clase tras haber visto noticias recientes sobre un hecho de violencia ocurrido en el país. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Ignorar su estado emocional y continuar la clase según lo planeado.",
      "Pedirle que explique en detalle frente al curso lo que vio en las noticias.",
      "Prohibir cualquier mención a las noticias durante toda la clase.",
      "Permitir un breve espacio para que el estudiante exprese cómo se siente, y evaluar si es pertinente ajustar la actividad planeada o remitirlo a apoyo institucional si es necesario.",
    ],
    correct: "D",
    expl: "Ofrecer un espacio breve de expresión emocional, con flexibilidad en la actividad planeada, atiende la situación del estudiante de forma sensible y oportuna.",
  },
  {
    n: 357,
    stem: "Se presenta un desacuerdo entre estudiantes sobre la interpretación de un hecho histórico controvertido, cada uno defendiendo una versión distinta. ¿Cuál sería la actuación más adecuada del docente?",
    options: [
      "Guiar el análisis hacia el contraste de distintas fuentes e interpretaciones históricas, mostrando que la historia admite más de una lectura fundamentada.",
      "Imponer una única interpretación como la correcta, sin ningún análisis adicional.",
      "Evitar cualquier tema histórico que pueda generar interpretaciones distintas.",
      "Pedir a los estudiantes que voten cuál interpretación es la correcta.",
    ],
    correct: "A",
    expl: "Guiar el contraste de fuentes e interpretaciones desarrolla el pensamiento histórico crítico, más que imponer una única versión.",
  },
  {
    n: 358,
    stem: "Un estudiante cuestiona por qué debe estudiar la historia de otros países y no solo la de Colombia. ¿Cuál sería la respuesta más adecuada del docente?",
    options: [
      "Decirle que no tiene por qué cuestionar el currículo establecido.",
      "Explicarle, con ejemplos concretos, cómo los procesos históricos de otros países ayudan a comprender mejor los propios y el mundo interconectado en el que vivimos.",
      "Eliminar de inmediato cualquier contenido de historia mundial del curso.",
      "Ignorar la pregunta y continuar con la clase planeada.",
    ],
    correct: "B",
    expl: "Explicar con ejemplos concretos el valor comparativo de la historia mundial responde a la inquietud del estudiante de forma pedagógicamente sólida.",
  },
  {
    n: 359,
    stem: "Al calificar un ensayo argumentativo sobre un tema social, el docente identifica una opinión con la que está personalmente en desacuerdo, aunque bien argumentada. ¿Cuál sería la actuación más adecuada?",
    options: [
      "Bajar la calificación por no compartir la opinión expresada.",
      "Pedirle al estudiante que cambie su opinión antes de calificar el trabajo.",
      "Evaluar el ensayo según la calidad de la argumentación y el uso de evidencia, independientemente de si el docente comparte o no la opinión expresada.",
      "Anular el trabajo por considerarlo inapropiado.",
    ],
    correct: "C",
    expl: "Evaluar según la calidad argumentativa, sin que la opinión personal del docente influya en la calificación, es esencial para la objetividad del proceso evaluativo.",
  },
  {
    n: 360,
    stem: "Un estudiante pregunta directamente al docente cuál es su opinión política personal sobre un tema controvertido que se está discutiendo en clase. ¿Cuál sería la respuesta más adecuada?",
    options: [
      "Compartir abiertamente su opinión personal y defenderla frente al grupo como la posición correcta.",
      "Reprender al estudiante por hacer una pregunta de este tipo.",
      "Mentir sobre su opinión para evitar cualquier tipo de conflicto.",
      "Explicar con respeto que su rol como docente es presentar distintas perspectivas de manera equilibrada, más que imponer su opinión personal sobre el grupo.",
    ],
    correct: "D",
    expl: "Mantener un rol equilibrado, sin imponer la opinión personal, es coherente con la función formativa del docente frente a temas controvertidos.",
  }
];

for (const q of blandas) {
  push({
    id: `dir-apt-blan-${String(q.n).padStart(3, "0")}`,
    pillar: "comportamental",
    module: "Competencias comportamentales",
    topic: "Competencias blandas · Ciencias Sociales (ola 4)",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: [],
    dif: 2,
  });
}

// ——— Conocimientos disciplinares (361–380) · Ciencias Sociales ———
const disciplinares = [
  {
    n: 361,
    stem: "¿En qué fecha se conmemora el llamado 'Grito de Independencia' en Colombia, hito considerado el inicio del proceso independentista?",
    options: [
      "20 de julio de 1810.",
      "7 de agosto de 1819.",
      "20 de julio de 1819.",
      "5 de agosto de 1810.",
    ],
    correct: "A",
    expl: "El 20 de julio de 1810 se conmemora el hito conocido como el 'Grito de Independencia' en Santafé de Bogotá.",
  },
  {
    n: 362,
    stem: "La Batalla de Boyacá, ocurrida el 7 de agosto de 1819, es considerada un hito decisivo porque:",
    options: [
      "Marcó el inicio del proceso independentista en el territorio neogranadino.",
      "Permitió consolidar la independencia al derrotar a las fuerzas realistas y abrir el camino hacia la liberación de Bogotá.",
      "Fue el momento en que se promulgó la primera Constitución del país.",
      "Puso fin definitivamente a cualquier conflicto interno entre las facciones criollas.",
    ],
    correct: "B",
    expl: "La victoria en Boyacá permitió a las fuerzas patriotas avanzar hacia Bogotá y consolidar de manera decisiva el proceso de independencia.",
  },
  {
    n: 363,
    stem: "La Constitución de 1886, impulsada durante el período conocido como la Regeneración liderado por Rafael Núñez, se caracterizó principalmente por:",
    options: [
      "Establecer un modelo federal con amplia autonomía para los estados soberanos.",
      "Eliminar por completo la figura del presidente de la República.",
      "Establecer un modelo centralista y de mayor duración en la historia constitucional del país, vigente hasta 1991.",
      "Ser reemplazada inmediatamente por la Constitución de 1991 al año siguiente de su promulgación.",
    ],
    correct: "C",
    expl: "La Constitución de 1886 estableció un modelo centralista que, con reformas, rigió al país hasta la promulgación de la Constitución de 1991.",
  },
  {
    n: 364,
    stem: "La Guerra de los Mil Días (1899-1902) en Colombia fue principalmente un conflicto entre:",
    options: [
      "Colombia y un país vecino por un conflicto territorial.",
      "Las fuerzas realistas españolas y los ejércitos patriotas.",
      "Los pueblos indígenas y el gobierno central.",
      "El Partido Liberal y el Partido Conservador, en el marco de las tensiones políticas de finales del siglo XIX.",
    ],
    correct: "D",
    expl: "La Guerra de los Mil Días fue un conflicto civil entre liberales y conservadores, uno de los más sangrientos de la historia del país.",
  },
  {
    n: 365,
    stem: "El 'Bogotazo', ocurrido el 9 de abril de 1948, se relaciona directamente con:",
    options: [
      "El asesinato del líder político Jorge Eliécer Gaitán y los disturbios que se desataron posteriormente en Bogotá.",
      "La firma del Acuerdo de paz de 2016 con las FARC.",
      "La promulgación de la Constitución de 1991.",
      "El inicio del Frente Nacional entre liberales y conservadores.",
    ],
    correct: "A",
    expl: "El Bogotazo se refiere a los disturbios desatados tras el asesinato de Jorge Eliécer Gaitán el 9 de abril de 1948.",
  },
  {
    n: 366,
    stem: "El Frente Nacional (1958-1974) en Colombia fue un acuerdo político que consistió principalmente en:",
    options: [
      "La unificación de todos los partidos políticos en uno solo de carácter único.",
      "La alternancia en la presidencia y la repartición paritaria de cargos públicos entre liberales y conservadores.",
      "El establecimiento de un gobierno militar permanente.",
      "La eliminación completa de las elecciones presidenciales durante ese período.",
    ],
    correct: "B",
    expl: "El Frente Nacional estableció la alternancia presidencial y la repartición paritaria de cargos entre los partidos Liberal y Conservador, buscando poner fin a la violencia bipartidista.",
  },
  {
    n: 367,
    stem: "El Acuerdo de Paz firmado en 2016 entre el Gobierno de Colombia y las FARC-EP incluyó, entre sus puntos principales:",
    options: [
      "La eliminación total del sistema judicial ordinario del país.",
      "La disolución completa de todos los partidos políticos existentes.",
      "La reforma rural integral, la participación política, el fin del conflicto (dejación de armas) y la justicia transicional (Jurisdicción Especial para la Paz).",
      "La anexión de nuevos territorios al país.",
    ],
    correct: "C",
    expl: "Estos son algunos de los puntos centrales del Acuerdo Final de Paz de 2016, entre otros como la solución al problema de drogas ilícitas.",
  },
  {
    n: 368,
    stem: "Según la Constitución Política de Colombia, ¿cuáles son las tres ramas del poder público?",
    options: [
      "Nacional, departamental y municipal.",
      "Civil, militar y eclesiástica.",
      "Central, territorial y descentralizada.",
      "Legislativa, ejecutiva y judicial.",
    ],
    correct: "D",
    expl: "La Constitución de 1991 organiza el poder público en estas tres ramas clásicas.",
  },
  {
    n: 369,
    stem: "¿Cuál de los siguientes organismos de control en Colombia tiene como función principal vigilar el manejo de los recursos y fondos públicos?",
    options: [
      "La Contraloría General de la República.",
      "La Procuraduría General de la Nación.",
      "La Defensoría del Pueblo.",
      "La Registraduría Nacional del Estado Civil.",
    ],
    correct: "A",
    expl: "La Contraloría General de la República es la entidad encargada de vigilar la gestión fiscal y el manejo de los recursos públicos.",
  },
  {
    n: 370,
    stem: "¿Cuál es el río más largo de Colombia y uno de los más importantes para la actividad económica y el transporte del país?",
    options: [
      "El río Cauca.",
      "El río Magdalena.",
      "El río Atrato.",
      "El río Meta.",
    ],
    correct: "B",
    expl: "El río Magdalena es el más largo de Colombia y ha sido históricamente clave para el transporte y la actividad económica del país.",
  },
  {
    n: 371,
    stem: "¿Cuáles son los países que limitan directamente con Colombia?",
    options: [
      "México, Guatemala, Costa Rica, Panamá y Venezuela.",
      "Chile, Argentina, Bolivia, Perú y Ecuador.",
      "Panamá, Venezuela, Brasil, Perú y Ecuador.",
      "Perú, Bolivia, Paraguay, Brasil y Venezuela.",
    ],
    correct: "C",
    expl: "Colombia limita con estos cinco países: Panamá, Venezuela, Brasil, Perú y Ecuador.",
  },
  {
    n: 372,
    stem: "¿Cuál de los siguientes océanos NO tiene costas en el continente americano?",
    options: [
      "Océano Pacífico",
      "Océano Atlántico",
      "Océano Ártico",
      "Océano Índico",
    ],
    correct: "D",
    expl: "El océano Índico no tiene costas en el continente americano, a diferencia del Pacífico, el Atlántico y el Ártico.",
  },
  {
    n: 373,
    stem: "La Revolución Francesa, iniciada en 1789, es considerada un hito histórico fundamental principalmente porque:",
    options: [
      "Impulsó ideales como la libertad, la igualdad y la fraternidad, influyendo posteriormente en procesos independentistas como los de América Latina.",
      "Consolidó de manera definitiva la monarquía absoluta en Francia.",
      "No tuvo ninguna influencia en los procesos políticos de otros países.",
      "Marcó el inicio del feudalismo en Europa.",
    ],
    correct: "A",
    expl: "La Revolución Francesa difundió ideales que influyeron en numerosos procesos políticos posteriores, incluidos los movimientos independentistas americanos.",
  },
  {
    n: 374,
    stem: "¿Cuál de las siguientes fue una de las causas comúnmente señaladas del estallido de la Primera Guerra Mundial (1914-1918)?",
    options: [
      "La caída del Muro de Berlín.",
      "El sistema de alianzas militares entre las potencias europeas, sumado a tensiones nacionalistas y coloniales.",
      "La firma del Tratado de Versalles.",
      "La independencia de las colonias africanas.",
    ],
    correct: "B",
    expl: "El complejo sistema de alianzas, junto con tensiones nacionalistas, coloniales y el asesinato del archiduque Francisco Fernando, desencadenó el conflicto.",
  },
  {
    n: 375,
    stem: "La Guerra Fría, que se extendió aproximadamente entre 1947 y 1991, se caracterizó principalmente por:",
    options: [
      "Un enfrentamiento militar directo y continuo entre Estados Unidos y la Unión Soviética en territorio europeo.",
      "La unificación política y económica de todos los países del mundo bajo un mismo sistema.",
      "Una tensión política, ideológica y militar entre el bloque liderado por Estados Unidos y el liderado por la Unión Soviética, sin un enfrentamiento militar directo entre ambas potencias.",
      "El fin de cualquier forma de conflicto internacional tras la Segunda Guerra Mundial.",
    ],
    correct: "C",
    expl: "La Guerra Fría se caracterizó por la tensión entre ambos bloques, expresada en conflictos indirectos, la carrera armamentista y la competencia ideológica, sin guerra directa entre las dos potencias.",
  },
  {
    n: 376,
    stem: "El Producto Interno Bruto (PIB) de un país se define principalmente como:",
    options: [
      "El total de la deuda externa acumulada por ese país.",
      "El número total de empresas registradas en el país.",
      "El ingreso personal promedio de cada habitante del país.",
      "El valor total de los bienes y servicios finales producidos en un país durante un período determinado, generalmente un año.",
    ],
    correct: "D",
    expl: "El PIB es un indicador que mide el valor de la producción total de bienes y servicios finales de una economía en un período determinado.",
  },
  {
    n: 377,
    stem: "En un sistema económico de mercado, a diferencia de uno de planificación centralizada, las decisiones sobre qué, cómo y para quién producir se determinan principalmente a través de:",
    options: [
      "La interacción entre la oferta y la demanda, con un rol limitado del Estado en la asignación directa de recursos.",
      "Un organismo estatal central que planifica y asigna todos los recursos de la economía.",
      "Un sorteo aleatorio realizado periódicamente por el gobierno.",
      "La decisión exclusiva de un único gran monopolio estatal en cada sector.",
    ],
    correct: "A",
    expl: "En una economía de mercado, la interacción libre entre oferentes y demandantes orienta principalmente las decisiones económicas, a diferencia del control estatal centralizado.",
  },
  {
    n: 378,
    stem: "Desde una perspectiva antropológica, el concepto de 'cultura' se refiere principalmente a:",
    options: [
      "Únicamente las manifestaciones artísticas de una sociedad, como la música o la pintura.",
      "El conjunto de conocimientos, creencias, valores, costumbres y formas de vida compartidas y transmitidas por un grupo humano.",
      "Exclusivamente el nivel educativo formal alcanzado por los integrantes de una sociedad.",
      "Un concepto aplicable únicamente a sociedades consideradas 'antiguas' o 'tradicionales'.",
    ],
    correct: "B",
    expl: "Desde la antropología, la cultura abarca el conjunto amplio de conocimientos, creencias, valores y prácticas compartidas por un grupo humano, no solo sus expresiones artísticas.",
  },
  {
    n: 379,
    stem: "El proceso de urbanización, entendido como el crecimiento de la población y la actividad económica en las ciudades en relación con las zonas rurales, ha estado históricamente asociado principalmente a:",
    options: [
      "Una disminución generalizada de la población mundial.",
      "El abandono total de cualquier actividad agrícola en el mundo.",
      "Procesos como la industrialización y la migración desde el campo hacia las ciudades en busca de oportunidades.",
      "La desaparición completa de las zonas rurales en todos los países.",
    ],
    correct: "C",
    expl: "La urbanización ha estado históricamente ligada a procesos de industrialización y a la migración campo-ciudad en busca de oportunidades laborales.",
  },
  {
    n: 380,
    stem: "Los procesos de independencia de la mayoría de los países de América Latina frente a las coronas española y portuguesa se desarrollaron principalmente durante:",
    options: [
      "La segunda mitad del siglo XX.",
      "El siglo XVI, inmediatamente después de la llegada europea al continente.",
      "El siglo XVIII, antes de cualquier influencia de ideas ilustradas.",
      "Las primeras décadas del siglo XIX, en un contexto influenciado por ideas ilustradas y por acontecimientos como la invasión napoleónica a España.",
    ],
    correct: "D",
    expl: "La mayoría de los procesos independentistas latinoamericanos se concentraron en las primeras décadas del siglo XIX, en un contexto de crisis de las coronas ibéricas e influencia de ideas ilustradas.",
  }
];

for (const q of disciplinares) {
  push({
    id: `dir-apt-dis-${String(q.n).padStart(3, "0")}`,
    pillar: "pedagogico",
    module: "Conocimientos disciplinares",
    topic: "Ciencias Sociales · conocimientos disciplinares",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: [],
    specialtyTags: ["sociales"],
    targetCargo: "sociales",
    dif: 2,
  });
}

// ——— Competencias pedagógicas (381–400) · Didáctica de Ciencias Sociales ———
const pedago = [
  {
    n: 381,
    stem: "El 'pensamiento histórico', como habilidad a desarrollar en la enseñanza de la historia, implica principalmente que el estudiante:",
    options: [
      "Comprenda relaciones de causalidad, cambio y continuidad entre distintos momentos históricos, más allá de memorizar fechas y datos aislados.",
      "Memorice la mayor cantidad posible de fechas históricas exactas.",
      "Repita de memoria los nombres de los personajes históricos más importantes.",
      "Evite establecer cualquier relación entre distintos períodos históricos.",
    ],
    correct: "A",
    expl: "El pensamiento histórico se centra en comprender relaciones de causalidad, cambio y continuidad, no solo en la memorización de datos aislados.",
  },
  {
    n: 382,
    stem: "En la enseñanza de la historia, ¿cuál es una diferencia clave entre una fuente primaria y una fuente secundaria?",
    options: [
      "Las fuentes primarias siempre son más confiables que las secundarias, sin ninguna excepción.",
      "La fuente primaria proviene directamente de la época o el hecho estudiado, mientras que la secundaria es una interpretación o análisis posterior elaborado por otro autor.",
      "Las fuentes secundarias siempre son documentos oficiales del gobierno.",
      "No existe ninguna diferencia relevante entre ambos tipos de fuentes para efectos didácticos.",
    ],
    correct: "B",
    expl: "La fuente primaria es un testimonio directo de la época estudiada, mientras que la secundaria interpreta o analiza esos testimonios posteriormente.",
  },
  {
    n: 383,
    stem: "Desarrollar 'empatía histórica' en los estudiantes implica principalmente ayudarlos a:",
    options: [
      "Juzgar los hechos del pasado exclusivamente con los valores y estándares actuales.",
      "Sentir simpatía emocional automática por todos los personajes históricos estudiados.",
      "Comprender las decisiones y acciones de las personas del pasado dentro del contexto y las circunstancias propias de su época.",
      "Evitar cualquier análisis crítico de las acciones de personajes históricos.",
    ],
    correct: "C",
    expl: "La empatía histórica busca comprender el pasado desde su propio contexto, evitando el anacronismo de juzgarlo únicamente con estándares actuales.",
  },
  {
    n: 384,
    stem: "La alfabetización cartográfica, como habilidad a desarrollar en la clase de ciencias sociales, implica principalmente que el estudiante:",
    options: [
      "Memorice de forma exacta las coordenadas geográficas de todos los países del mundo.",
      "Evite el uso de cualquier tipo de mapa durante el proceso de aprendizaje.",
      "Dibuje mapas exclusivamente a mano alzada, sin ningún tipo de referencia.",
      "Pueda leer, interpretar y elaborar mapas, comprendiendo elementos como la escala, la simbología y los sistemas de coordenadas.",
    ],
    correct: "D",
    expl: "La alfabetización cartográfica implica el desarrollo de habilidades para leer, interpretar y elaborar representaciones cartográficas de manera comprensiva.",
  },
  {
    n: 385,
    stem: "El desarrollo del 'pensamiento espacial' en la enseñanza de la geografía busca principalmente que el estudiante:",
    options: [
      "Comprenda las relaciones entre los fenómenos y su distribución en el espacio geográfico, así como sus escalas de análisis.",
      "Memorice de forma aislada los nombres de accidentes geográficos, sin ningún análisis adicional.",
      "Evite cualquier relación entre la geografía física y la geografía humana.",
      "Se limite a copiar mapas ya elaborados sin ningún análisis propio.",
    ],
    correct: "A",
    expl: "El pensamiento espacial busca comprender las relaciones y distribuciones espaciales de los fenómenos estudiados, no solo memorizar datos geográficos aislados.",
  },
  {
    n: 386,
    stem: "Las competencias ciudadanas, promovidas por el Ministerio de Educación Nacional, buscan principalmente desarrollar en los estudiantes:",
    options: [
      "Exclusivamente conocimientos teóricos sobre las instituciones del Estado, sin ninguna aplicación práctica.",
      "Habilidades cognitivas, emocionales y comunicativas que permitan a los estudiantes participar de manera constructiva en una sociedad democrática.",
      "Una postura política específica que deben adoptar todos los estudiantes.",
      "Únicamente el conocimiento memorístico de la Constitución Política.",
    ],
    correct: "B",
    expl: "Las competencias ciudadanas buscan integrar conocimientos, habilidades cognitivas, emocionales y comunicativas para la participación democrática.",
  },
  {
    n: 387,
    stem: "Al enseñar un tema controvertido (como un conflicto social o político actual), una recomendación didáctica generalmente aceptada es que el docente:",
    options: [
      "Evite por completo cualquier tema que pueda generar controversia en el aula.",
      "Imponga su propia opinión como la única válida sobre el tema.",
      "Presente distintas perspectivas fundamentadas sobre el tema, fomentando el análisis crítico sin imponer una única postura.",
      "Permita que el estudiante con la opinión más fuerte imponga su postura al resto del grupo.",
    ],
    correct: "C",
    expl: "La enseñanza de temas controvertidos recomienda presentar distintas perspectivas fundamentadas, promoviendo el análisis crítico sin imposición de una única postura.",
  },
  {
    n: 388,
    stem: "El método de estudio de caso, aplicado en la clase de ciencias sociales, consiste principalmente en:",
    options: [
      "Memorizar de forma teórica los conceptos de una unidad, sin ningún ejemplo concreto.",
      "Aplicar exclusivamente pruebas estandarizadas de selección múltiple.",
      "Evitar cualquier análisis de situaciones o problemáticas reales o realistas.",
      "Analizar en profundidad una situación real o realista, relacionada con los contenidos estudiados, para desarrollar habilidades de análisis y toma de decisiones.",
    ],
    correct: "D",
    expl: "El estudio de caso permite analizar situaciones reales o realistas en profundidad, desarrollando habilidades de análisis aplicadas a los contenidos del área.",
  },
  {
    n: 389,
    stem: "Un proyecto de aula en el que los estudiantes investigan y proponen soluciones a una problemática social real de su comunidad es un ejemplo de:",
    options: [
      "Aprendizaje basado en problemas aplicado a las ciencias sociales.",
      "Evaluación exclusivamente memorística de contenidos teóricos.",
      "Un enfoque pedagógico que evita cualquier vínculo con la realidad social del estudiante.",
      "Una actividad sin ninguna relación con las competencias ciudadanas.",
    ],
    correct: "A",
    expl: "Este tipo de proyecto es un ejemplo de aprendizaje basado en problemas, aplicado a una problemática social real y cercana a los estudiantes.",
  },
  {
    n: 390,
    stem: "El debate estructurado, como estrategia didáctica en ciencias sociales, se caracteriza principalmente por:",
    options: [
      "Permitir que los estudiantes hablen sin ningún orden ni tiempo definido.",
      "Establecer roles, tiempos y reglas claras de participación, exigiendo que los estudiantes argumenten sus posturas con evidencia.",
      "Evaluar únicamente la capacidad de los estudiantes para hablar más fuerte que sus compañeros.",
      "Prescindir por completo de cualquier preparación previa por parte de los estudiantes.",
    ],
    correct: "B",
    expl: "El debate estructurado organiza la participación mediante roles, tiempos y reglas claras, exigiendo argumentación basada en evidencia.",
  },
  {
    n: 391,
    stem: "La simulación de un juicio o de una sesión legislativa (role-playing histórico o político) en la clase de ciencias sociales busca principalmente que los estudiantes:",
    options: [
      "Memoricen un guion sin ninguna comprensión del contenido representado.",
      "Eviten cualquier tipo de análisis crítico sobre el proceso representado.",
      "Comprendan de manera vivencial el funcionamiento de instituciones o procesos históricos, asumiendo distintos roles y perspectivas.",
      "Reemplacen por completo cualquier otro tipo de evaluación durante el período académico.",
    ],
    correct: "C",
    expl: "Este tipo de simulación busca una comprensión vivencial de instituciones o procesos, a través de la asunción de distintos roles y perspectivas.",
  },
  {
    n: 392,
    stem: "El uso de caricaturas políticas como recurso didáctico en ciencias sociales permite principalmente que los estudiantes:",
    options: [
      "Memoricen la biografía completa del caricaturista.",
      "Eviten cualquier análisis del contexto histórico o político representado.",
      "Se limiten a describir los elementos visuales sin ningún análisis adicional.",
      "Desarrollen habilidades de análisis crítico al interpretar mensajes, símbolos y posturas políticas expresadas de manera sintética en la imagen.",
    ],
    correct: "D",
    expl: "Las caricaturas políticas son un recurso valioso para desarrollar habilidades de análisis crítico e interpretación de mensajes y posturas de forma sintética.",
  },
  {
    n: 393,
    stem: "Abordar la memoria histórica del conflicto armado colombiano en el aula, desde un enfoque pedagógico responsable, implica principalmente:",
    options: [
      "Reconocer la pluralidad de voces y experiencias, incluidas las de las víctimas, evitando relatos únicos o simplificados del conflicto.",
      "Presentar una única versión oficial del conflicto, sin ningún matiz.",
      "Evitar por completo cualquier mención al conflicto armado en el currículo.",
      "Limitar el tema exclusivamente a la memorización de fechas de hechos violentos.",
    ],
    correct: "A",
    expl: "Un abordaje pedagógico responsable de la memoria histórica reconoce la pluralidad de voces y experiencias, evitando relatos únicos o simplificados.",
  },
  {
    n: 394,
    stem: "La educación intercultural, aplicada en la enseñanza de las ciencias sociales, busca principalmente:",
    options: [
      "Imponer una única cultura como referente válido para todo el grupo.",
      "Promover el reconocimiento, el diálogo y el respeto entre distintas culturas presentes en el aula y en la sociedad.",
      "Eliminar cualquier mención a la diversidad cultural del currículo.",
      "Limitar el estudio de la cultura exclusivamente a la propia cultura de cada estudiante.",
    ],
    correct: "B",
    expl: "La educación intercultural promueve el reconocimiento, el diálogo y el respeto entre las distintas culturas presentes en la sociedad.",
  },
  {
    n: 395,
    stem: "Desarrollar alfabetización mediática en la clase de ciencias sociales implica principalmente enseñar a los estudiantes a:",
    options: [
      "Aceptar sin ningún cuestionamiento toda la información que reciben de los medios de comunicación.",
      "Evitar por completo el uso de cualquier medio de comunicación como fuente de información.",
      "Analizar críticamente el origen, la intención y la confiabilidad de la información que circula en los medios de comunicación y redes sociales.",
      "Memorizar los nombres de todos los medios de comunicación existentes en el país.",
    ],
    correct: "C",
    expl: "La alfabetización mediática busca desarrollar un análisis crítico sobre el origen, la intención y la confiabilidad de la información recibida.",
  },
  {
    n: 396,
    stem: "Las salidas pedagógicas o el trabajo de campo, como estrategia en la enseñanza de las ciencias sociales, permiten principalmente:",
    options: [
      "Reemplazar por completo cualquier forma de trabajo en el aula durante el año escolar.",
      "Evaluar exclusivamente el comportamiento disciplinario de los estudiantes fuera del aula.",
      "Evitar cualquier tipo de planeación previa por parte del docente.",
      "Que los estudiantes observen y analicen directamente fenómenos sociales o geográficos en su contexto real, más allá de lo trabajado teóricamente en clase.",
    ],
    correct: "D",
    expl: "El trabajo de campo permite una observación y análisis directo de fenómenos sociales o geográficos en su contexto real, complementando el trabajo teórico.",
  },
  {
    n: 397,
    stem: "El uso de herramientas básicas de Sistemas de Información Geográfica (SIG) en el aula permite principalmente que los estudiantes:",
    options: [
      "Analicen y visualicen información geográfica en capas superpuestas, relacionando distintas variables sobre un mismo territorio.",
      "Memoricen de forma teórica el funcionamiento técnico de los satélites.",
      "Eviten cualquier análisis espacial de la información geográfica.",
      "Reemplacen por completo el uso de mapas físicos en cualquier actividad de aula.",
    ],
    correct: "A",
    expl: "Las herramientas SIG permiten visualizar y analizar información geográfica en capas, relacionando distintas variables sobre un territorio.",
  },
  {
    n: 398,
    stem: "Incorporar un enfoque de derechos humanos en la enseñanza de las ciencias sociales implica principalmente:",
    options: [
      "Limitar la enseñanza de derechos humanos a una única clase aislada durante el año escolar.",
      "Analizar los contenidos históricos, políticos y sociales considerando su relación con la dignidad humana y los derechos fundamentales.",
      "Evitar cualquier relación entre los contenidos curriculares y los derechos humanos.",
      "Reducir el enfoque de derechos humanos exclusivamente a la memorización de tratados internacionales.",
    ],
    correct: "B",
    expl: "Este enfoque implica analizar los contenidos considerando su relación con la dignidad humana y los derechos fundamentales, de manera transversal.",
  },
  {
    n: 399,
    stem: "Al evaluar un ensayo argumentativo sobre un tema social, un criterio pedagógicamente adecuado sería principalmente valorar:",
    options: [
      "Únicamente la extensión del texto, sin ningún otro criterio.",
      "Que el estudiante coincida con la opinión personal del docente sobre el tema.",
      "La claridad de la tesis, la solidez de los argumentos y el uso de evidencia para sustentarlos.",
      "Exclusivamente la ortografía, sin considerar el contenido argumentativo.",
    ],
    correct: "C",
    expl: "Evaluar la claridad de la tesis, la solidez argumentativa y el uso de evidencia son criterios centrales para valorar un ensayo argumentativo.",
  },
  {
    n: 400,
    stem: "La educación económica y financiera básica, incorporada de manera transversal en ciencias sociales, busca principalmente que los estudiantes:",
    options: [
      "Memoricen de forma teórica los indicadores macroeconómicos de todos los países del mundo.",
      "Se conviertan en expertos en inversión bursátil desde la educación básica.",
      "Eviten cualquier relación entre los contenidos económicos y su vida cotidiana.",
      "Desarrollen conocimientos y habilidades básicas para la toma de decisiones económicas informadas en su vida cotidiana, como el ahorro o el consumo responsable.",
    ],
    correct: "D",
    expl: "La educación económica y financiera busca desarrollar habilidades prácticas para la toma de decisiones informadas en la vida cotidiana de los estudiantes. </user_query>",
  }
];

for (const q of pedago) {
  push({
    id: `dir-apt-ped-${String(q.n).padStart(3, "0")}`,
    pillar: "pedagogico",
    module: "Competencias pedagógicas",
    topic: "Didáctica de Ciencias Sociales (ola 4)",
    stem: q.stem,
    options: q.options,
    correct: q.correct,
    expl: q.expl,
    tags: q.tags || [],
    specialtyTags: ["sociales"],
    targetCargo: "sociales",
    dif: 2,
  });
}

module.exports = {raw};
