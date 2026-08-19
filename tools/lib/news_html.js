/**
 * Plantillas de las páginas estáticas de noticias: el índice y cada artículo.
 *
 * El texto del panel llega como texto plano. Aquí se convierte en HTML con
 * jerarquía real (h2, listas, párrafos) porque es lo que Google usa para
 * entender de qué trata la página.
 */
const {
  SITE,
  BRAND,
  DEFAULT_IMAGE,
  esc,
  clip,
  pageTitle,
  appLink,
  head,
  siteHeader,
  ctaSection,
  disclaimer,
  foot,
} = require("./html_partials");

const HUB_PATH = "/noticias/";
const TAG_LABELS = {
  convocatoria: "Convocatoria",
  fecha: "Fechas",
  cambio: "Cambio",
  aviso: "Aviso",
};

/** Guías de entrenamiento a las que enlaza cada noticia (enlazado interno). */
const GUIDES = [
  {href: "/simulacro-concurso-docente-gratis/", label: "Simulacro gratis"},
  {href: "/casos-de-aula-resueltos/", label: "Casos de aula resueltos"},
  {
    href: "/prueba-psicotecnica-docente-ejemplos/",
    label: "Prueba psicotécnica: ejemplos",
  },
];

function articlePath(item) {
  return `${HUB_PATH}${item.slug}/`;
}

function tagLabel(tag) {
  return TAG_LABELS[tag] || TAG_LABELS.aviso;
}

/** "12 de agosto de 2026" en hora de Colombia. */
function longDate(ms) {
  if (!ms) return "";
  try {
    return new Intl.DateTimeFormat("es-CO", {
      day: "numeric",
      month: "long",
      year: "numeric",
      timeZone: "America/Bogota",
    }).format(new Date(ms));
  } catch (e) {
    return "";
  }
}

function isoDate(ms) {
  if (!ms) return "";
  try {
    return new Date(ms).toISOString();
  } catch (e) {
    return "";
  }
}

/**
 * Se reconocen dos marcas opcionales para dar estructura sin editor visual:
 * "## " para subtítulo y "- " para viñetas. Además, una línea corta numerada
 * ("2. Inspección y vigilancia") se toma como subtítulo, que es como ya
 * vienen escritos los comunicados.
 */
function looksLikeHeading(line) {
  if (line.length > 95) return false;
  if (/[.:;]$/.test(line)) return false;
  return /^\d+\.\s+\S/.test(line);
}

function blockHtml(block) {
  const lines = block.split("\n").map((l) => l.trim()).filter(Boolean);
  if (!lines.length) return "";

  const marked = /^#{2,3}\s+/.exec(lines[0]);
  if (marked && lines.length === 1) {
    const level = marked[0].trim().length === 2 ? "h2" : "h3";
    return `<${level}>${esc(lines[0].replace(/^#{2,3}\s+/, ""))}</${level}>`;
  }

  if (lines.every((l) => /^[-*•]\s+/.test(l))) {
    const items = lines
        .map((l) => `<li>${esc(l.replace(/^[-*•]\s+/, ""))}</li>`)
        .join("");
    return `<ul>${items}</ul>`;
  }

  if (lines.length === 1 && looksLikeHeading(lines[0])) {
    return `<h2>${esc(lines[0].replace(/^\d+\.\s+/, ""))}</h2>`;
  }

  return `<p>${esc(lines.join(" "))}</p>`;
}

function bodyHtml(body) {
  return String(body || "")
      .split(/\n{2,}/)
      .map(blockHtml)
      .filter(Boolean)
      .join("\n        ");
}

function sourcesHtml(links) {
  if (!links.length) return "";
  const items = links
      .map((l) => `<li><a href="${esc(l.url)}" target="_blank" rel="noopener">` +
        `${esc(l.label)}</a></li>`)
      .join("");
  return `      <section class="sources">
        <h2>Fuentes oficiales</h2>
        <ul>${items}</ul>
      </section>`;
}

function guidesHtml() {
  const links = GUIDES
      .map((g) => `<a href="${g.href}">${esc(g.label)}</a>`)
      .join("");
  return `      <nav class="related" aria-label="Guías de entrenamiento">${links}</nav>`;
}

function moreNewsHtml(items) {
  if (!items.length) return "";
  const rows = items
      .map((it) => `        <li>
          <a href="${articlePath(it)}">${esc(it.title)}</a>
          <span>${esc(longDate(it.publishedAtMs))}</span>
        </li>`)
      .join("\n");
  return `      <section class="more-news">
        <h2>Otras noticias</h2>
        <ul>
${rows}
        </ul>
        <p><a href="${HUB_PATH}">Ver todas las noticias</a></p>
      </section>`;
}

function crumbsHtml(title) {
  return `      <nav class="crumbs" aria-label="Ruta">
        <a href="/">Inicio</a> › <a href="${HUB_PATH}">Noticias</a> › <span>${esc(clip(title, 60))}</span>
      </nav>`;
}

function breadcrumbLd(item) {
  return {
    "@type": "BreadcrumbList",
    itemListElement: [
      {"@type": "ListItem", position: 1, name: "Inicio", item: `${SITE}/`},
      {
        "@type": "ListItem",
        position: 2,
        name: "Noticias",
        item: `${SITE}${HUB_PATH}`,
      },
      ...(item ?
        [{
          "@type": "ListItem",
          position: 3,
          name: clip(item.title, 90),
          item: `${SITE}${articlePath(item)}`,
        }] :
        []),
    ],
  };
}

function publisherLd() {
  return {
    "@type": "Organization",
    name: BRAND,
    url: `${SITE}/`,
    logo: {"@type": "ImageObject", url: `${SITE}/icons/Icon-512.png?v=2`},
  };
}

function articleLd(item) {
  const url = `${SITE}${articlePath(item)}`;
  return JSON.stringify({
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "NewsArticle",
        headline: clip(item.title, 110),
        description: clip(item.summary, 260),
        image: [item.imageUrl || DEFAULT_IMAGE],
        datePublished: isoDate(item.publishedAtMs),
        dateModified: isoDate(item.updatedAtMs || item.publishedAtMs),
        inLanguage: "es-CO",
        mainEntityOfPage: {"@type": "WebPage", "@id": url},
        author: publisherLd(),
        publisher: publisherLd(),
      },
      breadcrumbLd(item),
    ],
  });
}

function hubLd(items) {
  return JSON.stringify({
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "CollectionPage",
        name: "Noticias del Concurso Docente",
        description: "Seguimiento del proceso de selección de docentes y " +
          "directivos docentes de la CNSC.",
        inLanguage: "es-CO",
        url: `${SITE}${HUB_PATH}`,
        publisher: publisherLd(),
      },
      {
        "@type": "ItemList",
        itemListElement: items.map((it, i) => ({
          "@type": "ListItem",
          position: i + 1,
          url: `${SITE}${articlePath(it)}`,
          name: clip(it.title, 110),
        })),
      },
      breadcrumbLd(null),
    ],
  });
}

/** Página de un artículo. `others` son las noticias que se enlazan al final. */
function articlePage(item, others) {
  const date = longDate(item.publishedAtMs);
  const updated = item.updatedAtMs && item.updatedAtMs - item.publishedAtMs >
    36e5 ?
    longDate(item.updatedAtMs) :
    "";
  const cover = item.imageUrl ?
    `      <figure class="cover">
        <img src="${esc(item.imageUrl)}" alt="${esc(clip(item.title, 90))}" loading="eager">
      </figure>` :
    "";

  return `<!DOCTYPE html>
<html lang="es-CO">
${head({
    title: pageTitle(item.title),
    description: clip(item.summary || item.body, 155),
    path: articlePath(item),
    image: item.imageUrl || DEFAULT_IMAGE,
    ogType: "article",
    styles: ["/seo/news.css"],
    jsonLd: articleLd(item),
  })}
<body>
${siteHeader()}
  <main class="news-article">
    <div class="wrap">
${crumbsHtml(item.title)}
      <article>
        <header class="hero">
          <p class="kicker">${esc(tagLabel(item.tag))}${date ? ` · ${esc(date)}` : ""}</p>
          <h1>${esc(item.title)}</h1>
          <p class="lead">${esc(item.summary)}</p>${updated ?
            `\n          <p class="updated">Actualizado el ${esc(updated)}</p>` :
            ""}
        </header>
${cover}
        <div class="prose">
        ${bodyHtml(item.body || item.summary)}
        </div>
      </article>
${sourcesHtml(item.links)}
${ctaSection({
    title: "Las fechas llegan; la preparación no se improvisa",
    body: "Entrena con casos de aula reales y simulacros con el criterio de " +
      "la CNSC. Diez minutos al día, gratis para empezar.",
    label: "Empezar a entrenar gratis",
    source: `noticia-${item.slug}`.slice(0, 60),
  })}
${moreNewsHtml(others)}
${guidesHtml()}
${disclaimer()}
${foot()}
    </div>
  </main>
</body>
</html>
`;
}

/** Índice de noticias: la página que concentra las búsquedas del tema. */
function hubPage(items) {
  const cards = items
      .map((it) => `        <article class="news-card">
          <p class="eyebrow">${esc(tagLabel(it.tag))}${it.publishedAtMs ? ` · ${esc(longDate(it.publishedAtMs))}` : ""}</p>
          <h2><a href="${articlePath(it)}">${esc(it.title)}</a></h2>
          <p>${esc(clip(it.summary, 220))}</p>
          <a class="more" href="${articlePath(it)}">Leer la noticia completa</a>
        </article>`)
      .join("\n");

  return `<!DOCTYPE html>
<html lang="es-CO">
${head({
    title: `Noticias del Concurso Docente 2026 (CNSC) | ${BRAND}`,
    description: "Fechas, acuerdos y cambios del proceso de selección de " +
      "docentes y directivos docentes de la CNSC, explicados para el aspirante.",
    path: HUB_PATH,
    ogType: "website",
    styles: ["/seo/news.css"],
    jsonLd: hubLd(items),
  })}
<body>
${siteHeader()}
  <main class="news-hub">
    <div class="wrap">
      <header class="hero">
        <p class="kicker">Concurso Docente · CNSC</p>
        <h1>Noticias del Concurso Docente</h1>
        <p class="lead">
          Cada aviso oficial, resumido y con lo que significa para tu
          preparación. Citamos siempre la fuente de la CNSC o del Ministerio.
        </p>
      </header>
      <section class="news-list">
${cards || "        <p>Aún no hay noticias publicadas.</p>"}
      </section>
${ctaSection({
    title: "Enterarte es el primer paso; pasar la prueba es el segundo",
    body: "Practica con casos de aula reales y simulacros con el criterio de " +
      "evaluación de la CNSC. Empieza gratis en diez minutos.",
    label: "Crear mi cuenta gratis",
    source: "noticias-indice",
  })}
${guidesHtml()}
${disclaimer()}
${foot()}
    </div>
  </main>
</body>
</html>
`;
}

/**
 * Si el slug cambia, la URL vieja queda en pie apuntando a la nueva para no
 * perder lo que Google ya indexó ni los enlaces compartidos.
 */
function redirectPage(item) {
  const target = articlePath(item);
  return `<!DOCTYPE html>
<html lang="es-CO">
<head>
  <meta charset="UTF-8">
  <title>${esc(pageTitle(item.title))}</title>
  <meta name="robots" content="noindex, follow">
  <link rel="canonical" href="${SITE}${target}">
  <meta http-equiv="refresh" content="0; url=${target}">
</head>
<body>
  <p>Esta noticia se movió a <a href="${target}">${esc(clip(item.title, 90))}</a>.</p>
</body>
</html>
`;
}

module.exports = {
  HUB_PATH,
  articlePath,
  articlePage,
  hubPage,
  redirectPage,
  longDate,
  appLink,
};
