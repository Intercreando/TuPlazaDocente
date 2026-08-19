/**
 * Panel admin de noticias / avisos de convocatoria.
 */
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {ADMIN_EMAILS} = require("./promo_admin");

const TAGS = new Set(["convocatoria", "fecha", "cambio", "aviso"]);

function assertAdmin(request) {
  if (!request.auth?.uid) {
    throw new HttpsError("unauthenticated", "Debes iniciar sesión.");
  }
  const email = String(request.auth.token?.email || "").trim().toLowerCase();
  if (!ADMIN_EMAILS.has(email)) {
    throw new HttpsError("permission-denied", "No autorizado.");
  }
  return email;
}

function clip(raw, max) {
  return String(raw || "").trim().slice(0, max);
}

/**
 * Slug para la URL pública (/noticias/<slug>/). Sin tildes, sin signos y de
 * pocas palabras: es lo que Google muestra y lo que la gente comparte.
 */
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

/** Evita que dos noticias compitan por la misma URL. */
async function uniqueSlug(db, wanted, ownId) {
  let candidate = wanted;
  for (let attempt = 2; attempt < 12; attempt += 1) {
    const clash = await db
        .collection("news")
        .where("slug", "==", candidate)
        .limit(2)
        .get();
    const taken = clash.docs.some((doc) => doc.id !== ownId);
    if (!taken) return candidate;
    candidate = `${wanted.slice(0, 66)}-${attempt}`;
  }
  return `${wanted.slice(0, 60)}-${Date.now().toString(36)}`;
}

/** Solo http(s); máximo 8 fuentes oficiales. */
function sanitizeLinks(raw) {
  if (!Array.isArray(raw)) return [];
  const out = [];
  for (const item of raw.slice(0, 8)) {
    const label = clip(item?.label, 80);
    let href = String(item?.url || "").trim();
    if (label.length < 2 || !href) continue;
    if (!/^https?:\/\//i.test(href)) href = `https://${href}`;
    let parsed;
    try {
      parsed = new URL(href);
    } catch (_) {
      continue;
    }
    if (parsed.protocol !== "https:" && parsed.protocol !== "http:") continue;
    out.push({
      label,
      url: parsed.toString().slice(0, 500),
    });
  }
  return out;
}

function mapDoc(doc) {
  const d = doc.data() || {};
  return {
    id: doc.id,
    slug: d.slug || "",
    title: d.title || "",
    summary: d.summary || "",
    body: d.body || "",
    tag: d.tag || "aviso",
    imageUrl: d.imageUrl || null,
    links: Array.isArray(d.links) ? d.links : [],
    published: d.published === true,
    pinned: d.pinned === true,
    publishedAtMs: d.publishedAt && typeof d.publishedAt.toMillis === "function" ?
      d.publishedAt.toMillis() :
      0,
    updatedAtMs: d.updatedAt && typeof d.updatedAt.toMillis === "function" ?
      d.updatedAt.toMillis() :
      0,
  };
}

exports.adminUpsertNews = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (request) => {
      const adminEmail = assertAdmin(request);
      const title = clip(request.data?.title, 160);
      const summary = clip(request.data?.summary, 280);
      const body = clip(request.data?.body, 8000);
      if (title.length < 4) {
        throw new HttpsError("invalid-argument", "El título es demasiado corto.");
      }
      if (summary.length < 8) {
        throw new HttpsError(
            "invalid-argument",
            "El resumen debe tener al menos 8 caracteres.",
        );
      }

      let tag = String(request.data?.tag || "aviso").toLowerCase();
      if (!TAGS.has(tag)) tag = "aviso";

      const db = getFirestore();
      let id = clip(request.data?.id, 64);
      const isNew = !id;
      const ref = isNew ? db.collection("news").doc() : db.collection("news").doc(id);
      if (isNew) id = ref.id;

      const published = request.data?.published === false ? false : true;
      const pinned = request.data?.pinned === true;
      const imageUrl = request.data?.imageUrl ?
        String(request.data.imageUrl).slice(0, 500) :
        null;
      const links = sanitizeLinks(request.data?.links);

      const snap = await ref.get();
      const previous = snap.exists ? snap.data() || {} : {};
      const slug = await uniqueSlug(
          db,
          slugify(request.data?.slug || previous.slug || title),
          id,
      );
      // Si la URL cambia, se recuerda la anterior para redirigirla y no perder
      // lo que Google ya indexó ni los enlaces compartidos.
      const history = Array.isArray(previous.slugHistory) ?
        previous.slugHistory.filter((s) => typeof s === "string") :
        [];
      const before = String(previous.slug || "");
      if (before && before !== slug && !history.includes(before)) {
        history.push(before);
      }

      const payload = {
        title,
        slug,
        slugHistory: history.filter((s) => s !== slug).slice(-10),
        summary,
        body,
        tag,
        imageUrl,
        links,
        published,
        pinned,
        updatedAt: FieldValue.serverTimestamp(),
        updatedBy: adminEmail,
      };
      if (published && (!snap.exists || snap.data()?.published !== true)) {
        payload.publishedAt = FieldValue.serverTimestamp();
      }
      if (!snap.exists) {
        payload.createdAt = FieldValue.serverTimestamp();
      }
      await ref.set(payload, {merge: true});
      return {ok: true, id, slug, created: isNew};
    },
);

exports.adminListNews = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (request) => {
      assertAdmin(request);
      const snap = await getFirestore().collection("news").limit(80).get();
      const items = snap.docs.map(mapDoc);
      items.sort((a, b) => {
        if (a.pinned !== b.pinned) return a.pinned ? -1 : 1;
        return (b.updatedAtMs || 0) - (a.updatedAtMs || 0);
      });
      return {ok: true, items};
    },
);

exports.adminDeleteNews = onCall(
    {
      region: "southamerica-east1",
      cors: true,
      timeoutSeconds: 20,
      memory: "256MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (request) => {
      assertAdmin(request);
      const id = clip(request.data?.id, 64);
      if (!id) {
        throw new HttpsError("invalid-argument", "Noticia inválida.");
      }
      const ref = getFirestore().collection("news").doc(id);
      const snap = await ref.get();
      if (!snap.exists) {
        throw new HttpsError("not-found", "Noticia no encontrada.");
      }
      await ref.delete();
      return {ok: true, id, deleted: true};
    },
);
