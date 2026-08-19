/**
 * Publica cada noticia como una página HTML con su propia URL.
 *
 * Por qué existe: la app usa rutas con "#", así que /#/noticias/xxx no es una
 * página para Google. Estas páginas estáticas sí lo son, igual que las landings.
 *
 * Uso: node tools/generate_news_pages.js
 * El HTML de web/noticias es una copia en el repo. Hosting las sirve con
 * la Cloud Function, para que al publicar un aviso la URL exista al instante.
 */
const fs = require("fs");
const path = require("path");

const {fetchPublishedNews} = require("./lib/news_source");
const {articlePage, hubPage, redirectPage} = require("./lib/news_html");

const root = path.join(__dirname, "..");
const MAX_RELATED = 4;

function write(dir, html) {
  fs.mkdirSync(dir, {recursive: true});
  fs.writeFileSync(path.join(dir, "index.html"), html, "utf8");
}

/** Las noticias que se enlazan al final de un artículo. */
function relatedFor(item, items) {
  return items.filter((other) => other.slug !== item.slug).slice(0, MAX_RELATED);
}

/**
 * Borra carpetas de noticias que ya no existen o se despublicaron, para que no
 * queden páginas huérfanas indexadas.
 */
function prune(base, expected) {
  const dir = path.join(base, "noticias");
  if (!fs.existsSync(dir)) return 0;
  let removed = 0;
  for (const entry of fs.readdirSync(dir, {withFileTypes: true})) {
    if (!entry.isDirectory() || expected.has(entry.name)) continue;
    fs.rmSync(path.join(dir, entry.name), {recursive: true, force: true});
    removed += 1;
  }
  return removed;
}

function generate(items) {
  const expected = new Set();
  for (const item of items) {
    expected.add(item.slug);
    for (const old of item.slugHistory) {
      if (old && old !== item.slug) expected.add(old);
    }
  }

  let removed = 0;
  const repoWeb = path.join(root, "web");
  const newsDir = path.join(repoWeb, "noticias");
  write(newsDir, hubPage(items));
  for (const item of items) {
    write(path.join(newsDir, item.slug), articlePage(item, relatedFor(item, items)));
    for (const old of item.slugHistory) {
      if (!old || old === item.slug) continue;
      if (items.some((other) => other.slug === old)) continue;
      write(path.join(newsDir, old), redirectPage(item));
    }
  }
  removed += prune(repoWeb, expected);
  return removed;
}

/** Hosting debe usar la función, no el HTML estático (si el archivo existe, gana). */
function dropHostedSnapshot() {
  const built = path.join(root, "build", "web", "noticias");
  if (!fs.existsSync(built)) return;
  fs.rmSync(built, {recursive: true, force: true});
  console.log("Hosting servirá /noticias con la función (al publicar, sin esperar deploy).");
}

async function main() {
  let items;
  try {
    items = await fetchPublishedNews();
    const removed = generate(items);
    console.log(
        `OK: ${items.length} noticias + índice en /noticias/` +
      (removed ? ` (${removed} carpetas obsoletas eliminadas)` : ""),
    );
  } catch (e) {
    console.warn(`AVISO: no se pudieron leer las noticias (${e.message}).`);
  }
  dropHostedSnapshot();
}

main().catch((e) => {
  console.error(`ERROR generando noticias: ${e.message}`);
  process.exit(1);
});
