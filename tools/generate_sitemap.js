/**
 * Arma el sitemap con las páginas fijas, las landings SEO y cada noticia.
 *
 * Antes era un archivo a mano, así que las noticias nuevas nunca llegaban a
 * Google. Ahora se regenera en cada despliegue con la fecha real de cada aviso.
 *
 * Uso: node tools/generate_sitemap.js
 */
const fs = require("fs");
const path = require("path");

const {fetchPublishedNews} = require("./lib/news_source");
const {SITE} = require("./lib/html_partials");
const {HUB_PATH, articlePath} = require("./lib/news_html");

const root = path.join(__dirname, "..");
const landingsPath = path.join(root, "assets", "seo", "landings.json");

/** Páginas que no dependen de datos. */
const STATIC_PAGES = [
  {path: "/", changefreq: "weekly", priority: "1.0"},
  {path: "/premium", changefreq: "monthly", priority: "0.8"},
  {path: "/legal/terms", changefreq: "yearly", priority: "0.3"},
  {path: "/legal/privacy", changefreq: "yearly", priority: "0.3"},
];

/** AAAA-MM-DD, que es lo que espera <lastmod>. */
function day(ms) {
  const date = ms ? new Date(ms) : new Date();
  return date.toISOString().slice(0, 10);
}

function landingUrls() {
  try {
    const data = JSON.parse(fs.readFileSync(landingsPath, "utf8"));
    return (data.pages || []).map((page) => ({
      path: page.path,
      changefreq: "weekly",
      priority: "0.9",
    }));
  } catch (e) {
    console.warn(`AVISO: no se leyeron las landings (${e.message}).`);
    return [];
  }
}

async function newsUrls() {
  try {
    const items = await fetchPublishedNews();
    const newest = items.length ? items[0].updatedAtMs || items[0].publishedAtMs : 0;
    return [
      {path: HUB_PATH, changefreq: "daily", priority: "0.9", lastmod: day(newest)},
      ...items.map((item) => ({
        path: articlePath(item),
        changefreq: "weekly",
        priority: "0.8",
        lastmod: day(item.updatedAtMs || item.publishedAtMs),
      })),
    ];
  } catch (e) {
    console.warn(`AVISO: no se leyeron las noticias (${e.message}).`);
    return [{path: HUB_PATH, changefreq: "daily", priority: "0.9"}];
  }
}

function urlXml(entry) {
  const lines = [
    "  <url>",
    `    <loc>${SITE}${entry.path}</loc>`,
    `    <lastmod>${entry.lastmod || day(0)}</lastmod>`,
  ];
  if (entry.changefreq) lines.push(`    <changefreq>${entry.changefreq}</changefreq>`);
  if (entry.priority) lines.push(`    <priority>${entry.priority}</priority>`);
  lines.push("  </url>");
  return lines.join("\n");
}

async function main() {
  const entries = [
    STATIC_PAGES[0],
    ...landingUrls(),
    ...(await newsUrls()),
    ...STATIC_PAGES.slice(1),
  ];

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${entries.map(urlXml).join("\n")}
</urlset>
`;

  const roots = [path.join(root, "web")];
  const built = path.join(root, "build", "web");
  if (fs.existsSync(built)) roots.push(built);
  for (const base of roots) {
    fs.writeFileSync(path.join(base, "sitemap.xml"), xml, "utf8");
  }
  console.log(`OK: sitemap con ${entries.length} URLs`);
}

main().catch((e) => {
  console.error(`ERROR generando el sitemap: ${e.message}`);
  process.exit(1);
});
