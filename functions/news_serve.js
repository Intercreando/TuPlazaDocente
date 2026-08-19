/**
 * Sirve /noticias y /noticias/<slug>/ en HTML, leyendo Firestore.
 *
 * Así una noticia publicada está en su URL al instante, sin esperar un
 * despliegue de Hosting. Las plantillas son las mismas del generador estático.
 */
const {onRequest} = require("firebase-functions/v2/https");
const {getApps, initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {
  articlePage,
  hubPage,
  redirectPage,
  HUB_PATH,
} = require("./lib/news_html");

const PROJECT_ID =
    process.env.GCLOUD_PROJECT ||
    process.env.GOOGLE_CLOUD_PROJECT ||
    "tuplazadocente-9334d";

function firestore() {
  if (getApps().length === 0) {
    initializeApp({projectId: PROJECT_ID});
  }
  return getFirestore();
}

const MAX_RELATED = 4;
/** Una lectura a Firestore por minuto y por instancia, no por cada visita. */
const CACHE_MS = 60 * 1000;
let publishedCache = {at: 0, items: null};

/** Misma regla que news_admin.js y tools/lib/news_source.js. */
function slugify(raw) {
  const base = String(raw || "")
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "")
      .split("-")
      .filter(Boolean)
      .slice(0, 9)
      .join("-");
  return base.slice(0, 70) || "aviso";
}

function toMillis(value) {
  if (!value) return 0;
  if (typeof value === "number") return value;
  if (typeof value.toMillis === "function") return value.toMillis();
  const parsed = Date.parse(String(value));
  return Number.isFinite(parsed) ? parsed : 0;
}

function normalize(id, data) {
  const links = Array.isArray(data.links) ? data.links : [];
  return {
    id,
    slug: String(data.slug || "").trim() || slugify(data.title),
    slugHistory: (Array.isArray(data.slugHistory) ? data.slugHistory : [])
        .map((s) => String(s || "").trim())
        .filter(Boolean),
    title: String(data.title || "").trim(),
    summary: String(data.summary || "").trim(),
    body: String(data.body || "").trim(),
    tag: String(data.tag || "aviso"),
    imageUrl: data.imageUrl ? String(data.imageUrl) : null,
    pinned: data.pinned === true,
    links: links
        .map((l) => ({
          label: String(l?.label || "").trim(),
          url: String(l?.url || "").trim(),
        }))
        .filter((l) => l.label && l.url),
    publishedAtMs: toMillis(
        data.publishedAtMs || data.publishedAt || data.updatedAt,
    ),
    updatedAtMs: toMillis(
        data.updatedAtMs || data.updatedAt || data.publishedAt,
    ),
  };
}

async function loadPublished() {
  const now = Date.now();
  if (publishedCache.items && now - publishedCache.at < CACHE_MS) {
    return publishedCache.items;
  }
  const snap = await firestore()
      .collection("news")
      .where("published", "==", true)
      .limit(200)
      .get();
  const items = snap.docs
      .map((doc) => normalize(doc.id, doc.data() || {}))
      .filter((item) => item.title.length > 3);
  items.sort((a, b) => {
    if (a.pinned !== b.pinned) return a.pinned ? -1 : 1;
    return (b.publishedAtMs || 0) - (a.publishedAtMs || 0);
  });
  publishedCache = {at: now, items};
  return items;
}

function requestPath(req) {
  const candidates = [
    req.headers["x-forwarded-uri"],
    req.headers["x-original-url"],
    req.originalUrl,
    req.url,
    req.path,
  ];
  let best = "";
  for (const raw of candidates) {
    const path = extractNoticiasPath(raw);
    if (path.length > best.length) best = path;
  }
  return best || "/noticias/";
}

/** Quédate con /noticias/... aunque el header traiga la URL completa. */
function extractNoticiasPath(raw) {
  if (typeof raw !== "string" || !raw.includes("noticias")) return "";
  let path = raw.split("?")[0];
  try {
    if (path.includes("://")) path = new URL(path).pathname;
  } catch (_) {}
  const idx = path.indexOf("/noticias");
  if (idx === -1) return "";
  return path.slice(idx);
}

function slugFromPath(rawPath) {
  const path = String(rawPath || "")
      .split("?")[0]
      .replace(/\/+$/, "");
  const parts = path.split("/").filter(Boolean);
  if (parts[0] !== "noticias") return "";
  try {
    return decodeURIComponent(parts[1] || "").trim();
  } catch (_) {
    return String(parts[1] || "").trim();
  }
}

function findArticle(items, key) {
  if (!key) return null;
  return items.find((item) => item.slug === key) ||
    items.find((item) => item.id === key) ||
    items.find((item) => item.slugHistory.includes(key)) ||
    null;
}

function htmlResponse(res, status, html, {cache = true, canonical} = {}) {
  res.set("Content-Type", "text/html; charset=utf-8");
  res.set(
      "Cache-Control",
      cache ?
        "public, max-age=60, s-maxage=300, stale-while-revalidate=600" :
        "no-store",
  );
  if (!cache) res.set("CDN-Cache-Control", "no-store");
  if (canonical) res.set("Link", `<${canonical}>; rel="canonical"`);
  res.status(status).send(html);
}

function notFoundPage() {
  return `<!DOCTYPE html>
<html lang="es-CO">
<head>
  <meta charset="UTF-8">
  <title>Noticia no encontrada | TuPlazaDocente</title>
  <meta name="robots" content="noindex">
  <link rel="canonical" href="https://www.tuplazadocente.com/noticias/">
</head>
<body>
  <p>Ese aviso ya no está publicado. <a href="/noticias/">Ver todas las noticias</a>.</p>
</body>
</html>`;
}

exports.serveNewsPage = onRequest(
    {
      region: "southamerica-east1",
      cors: false,
      invoker: "public",
      timeoutSeconds: 20,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (req, res) => {
      try {
        if (req.method !== "GET" && req.method !== "HEAD") {
          res.status(405).send("Method Not Allowed");
          return;
        }

        const items = await loadPublished();
        const slug = slugFromPath(requestPath(req));

        if (!slug) {
          htmlResponse(res, 200, hubPage(items));
          return;
        }

        const current = findArticle(items, slug);
        if (current) {
          if (current.slug && current.slug !== slug) {
            const target = `${HUB_PATH}${current.slug}/`;
            res.set("Cache-Control", "public, max-age=300");
            res.set("Location", target);
            res.set("Content-Type", "text/html; charset=utf-8");
            res.status(301).send(redirectPage(current));
            return;
          }
          const others = items
              .filter((other) => other.slug !== current.slug)
              .slice(0, MAX_RELATED);
          htmlResponse(res, 200, articlePage(current, others));
          return;
        }

        htmlResponse(res, 404, notFoundPage(), {cache: false});
      } catch (e) {
        console.error("serveNewsPage", e);
        res.status(500).send("No se pudo cargar la noticia.");
      }
    },
);
