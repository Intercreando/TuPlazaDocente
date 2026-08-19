/**
 * Lee las noticias publicadas de Firestore para generar HTML estático.
 *
 * Se usa la API REST con la clave web (la misma que viaja en el bundle, no es
 * un secreto) porque las reglas ya permiten leer los documentos publicados.
 * Así el predeploy no necesita una cuenta de servicio.
 */
const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..", "..");
const optionsPath = path.join(root, "lib", "firebase_options.dart");

/** Toma la configuración de firebase_options.dart para no duplicarla. */
function firebaseConfig() {
  const fromEnv = {
    apiKey: process.env.TPD_FIREBASE_API_KEY,
    projectId: process.env.TPD_FIREBASE_PROJECT_ID,
  };
  if (fromEnv.apiKey && fromEnv.projectId) return fromEnv;

  const source = fs.readFileSync(optionsPath, "utf8");
  const apiKey = /apiKey:\s*'([^']+)'/.exec(source);
  const projectId = /projectId:\s*'([^']+)'/.exec(source);
  if (!apiKey || !projectId) {
    throw new Error("No se pudo leer apiKey/projectId de firebase_options.dart");
  }
  return {apiKey: apiKey[1], projectId: projectId[1]};
}

/** Convierte un valor de la API REST en un valor plano de JavaScript. */
function plainValue(value) {
  if (!value || typeof value !== "object") return null;
  if ("stringValue" in value) return value.stringValue;
  if ("booleanValue" in value) return value.booleanValue;
  if ("integerValue" in value) return Number(value.integerValue);
  if ("doubleValue" in value) return Number(value.doubleValue);
  if ("timestampValue" in value) return new Date(value.timestampValue).getTime();
  if ("nullValue" in value) return null;
  if ("arrayValue" in value) {
    return (value.arrayValue.values || []).map(plainValue);
  }
  if ("mapValue" in value) return plainFields(value.mapValue.fields || {});
  return null;
}

function plainFields(fields) {
  const out = {};
  for (const [key, value] of Object.entries(fields)) {
    out[key] = plainValue(value);
  }
  return out;
}

/** Slug legible a partir del título, para las noticias que aún no lo tienen. */
function slugify(raw) {
  return String(raw || "")
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-+|-+$/g, "")
      .split("-")
      .slice(0, 9)
      .join("-")
      .slice(0, 70) || "aviso";
}

function normalize(doc) {
  const id = String(doc.name || "").split("/").pop();
  const data = plainFields(doc.fields || {});
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
    publishedAtMs: Number(data.publishedAt || data.updatedAt || 0) || 0,
    updatedAtMs: Number(data.updatedAt || data.publishedAt || 0) || 0,
  };
}

/** Noticias publicadas, de la más reciente a la más antigua. */
async function fetchPublishedNews({limit = 200} = {}) {
  const {apiKey, projectId} = firebaseConfig();
  const url = `https://firestore.googleapis.com/v1/projects/${projectId}` +
    `/databases/(default)/documents:runQuery?key=${apiKey}`;
  const body = {
    structuredQuery: {
      from: [{collectionId: "news"}],
      where: {
        fieldFilter: {
          field: {fieldPath: "published"},
          op: "EQUAL",
          value: {booleanValue: true},
        },
      },
      limit,
    },
  };

  const response = await fetch(url, {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify(body),
  });
  if (!response.ok) {
    const detail = await response.text();
    throw new Error(`Firestore respondió ${response.status}: ${detail.slice(0, 200)}`);
  }

  const rows = await response.json();
  const items = (Array.isArray(rows) ? rows : [])
      .filter((row) => row && row.document)
      .map((row) => normalize(row.document))
      .filter((item) => item.title.length > 3);

  items.sort((a, b) => (b.publishedAtMs || 0) - (a.publishedAtMs || 0));
  return items;
}

module.exports = {fetchPublishedNews, slugify};
