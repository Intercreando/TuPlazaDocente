/**
 * Conversions API (Meta): el cliente genera event_id, el Pixel lo envía
 * y esta función reenvía el MISMO id al servidor para deduplicar.
 */
const crypto = require("crypto");
const {onRequest} = require("firebase-functions/v2/https");
const {defineSecret} = require("firebase-functions/params");

const metaCapiToken = defineSecret("META_CAPI_ACCESS_TOKEN");
const PIXEL_ID = "1565041928197797";
const GRAPH_URL = `https://graph.facebook.com/v21.0/${PIXEL_ID}/events`;

const ALLOWED_EVENTS = new Set([
  "PageView",
  "CompleteRegistration",
  "InitiateCheckout",
  "Purchase",
]);

const ALLOWED_ORIGINS = [
  "https://www.tuplazadocente.com",
  "https://tuplazadocente.com",
  "https://tuplazadocente-9334d.web.app",
];

/** Tope barato por IP: evita abuso de la URL pública, no reintenta ni se llama a sí misma. */
const RATE_WINDOW_MS = 60 * 1000;
const RATE_MAX_PER_IP = 40;
/** @type {Map<string, {t: number, n: number}>} */
const rateHits = new Map();

/**
 * @param {string} ip
 * @return {boolean} true si hay que rechazar
 */
function isRateLimited(ip) {
  const key = ip || "unknown";
  const now = Date.now();
  if (rateHits.size > 4000) rateHits.clear();
  const rec = rateHits.get(key);
  if (!rec || now - rec.t > RATE_WINDOW_MS) {
    rateHits.set(key, {t: now, n: 1});
    return false;
  }
  rec.n += 1;
  return rec.n > RATE_MAX_PER_IP;
}

/**
 * @param {string} raw
 * @return {string}
 */
function sha256(raw) {
  return crypto.createHash("sha256").update(raw).digest("hex");
}

/**
 * @param {import("firebase-functions/v2/https").Request} req
 * @return {boolean}
 */
function originOk(req) {
  const origin = String(req.get("origin") || "").trim();
  return ALLOWED_ORIGINS.includes(origin);
}

/**
 * @param {unknown} raw
 * @return {object}
 */
function sanitizeCustomData(raw) {
  if (!raw || typeof raw !== "object") return {};
  const src = /** @type {Record<string, unknown>} */ (raw);
  const out = {};
  if (typeof src.value === "number" && Number.isFinite(src.value)) {
    out.value = src.value;
  }
  if (typeof src.currency === "string" && src.currency.length <= 8) {
    out.currency = src.currency.toUpperCase();
  }
  if (typeof src.content_name === "string" && src.content_name.length <= 80) {
    out.content_name = src.content_name;
  }
  if (typeof src.num_items === "number" && Number.isFinite(src.num_items)) {
    out.num_items = src.num_items;
  }
  if (src.status === true || src.status === false) {
    out.status = src.status;
  }
  return out;
}

exports.trackMetaCapi = onRequest(
    {
      region: "southamerica-east1",
      secrets: [metaCapiToken],
      cors: ALLOWED_ORIGINS,
      invoker: "public",
      timeoutSeconds: 10,
      memory: "128MiB",
      minInstances: 0,
      maxInstances: 5,
    },
    async (req, res) => {
      try {
        if (req.method === "OPTIONS") {
          res.status(204).send("");
          return;
        }
        if (req.method !== "POST") {
          res.status(405).json({ok: false});
          return;
        }
        if (!originOk(req)) {
          res.status(403).json({ok: false});
          return;
        }

        const forwarded = String(req.get("x-forwarded-for") || "");
        const clientIp = forwarded.split(",")[0].trim() ||
          String(req.ip || "").trim();
        if (isRateLimited(clientIp)) {
          res.status(204).json({ok: false, reason: "rate"});
          return;
        }

        const token = String(metaCapiToken.value() || "").trim();
        if (!token) {
          console.error("META_CAPI_ACCESS_TOKEN vacío");
          res.status(204).json({ok: false, reason: "unconfigured"});
          return;
        }

        let body = req.body || {};
        if (typeof body === "string") {
          try {
            body = JSON.parse(body);
          } catch (_) {
            res.status(400).json({ok: false});
            return;
          }
        }
        const eventName = String(body.event_name || "").trim();
        const eventId = String(body.event_id || "").trim();
        const idOk = eventId.length >= 8 && eventId.length <= 128;
        if (!ALLOWED_EVENTS.has(eventName) || !idOk) {
          res.status(400).json({ok: false});
          return;
        }

        const userAgent = String(req.get("user-agent") || "").slice(0, 512);

        const userData = {};
        if (clientIp) userData.client_ip_address = clientIp;
        if (userAgent) userData.client_user_agent = userAgent;

        const fbp = String(body.fbp || "").trim();
        const fbc = String(body.fbc || "").trim();
        if (fbp.startsWith("fb.")) {
          userData.fbp = fbp.slice(0, 120);
        }
        if (fbc.startsWith("fb.")) {
          userData.fbc = fbc.slice(0, 240);
        }

        const email = String(body.email || "").trim().toLowerCase();
        if (email.includes("@") && email.length <= 120) {
          userData.em = [sha256(email)];
        }

        const eventSourceUrl = String(body.event_source_url || "").trim();
        const payload = {
          data: [
            {
              event_name: eventName,
              event_time: Math.floor(Date.now() / 1000),
              event_id: eventId,
              action_source: "website",
              event_source_url: eventSourceUrl.startsWith("https://") ?
                eventSourceUrl.slice(0, 500) :
                "https://www.tuplazadocente.com/",
              user_data: userData,
              custom_data: sanitizeCustomData(body.custom_data),
            },
          ],
        };

        const ac = new AbortController();
        const kill = setTimeout(() => ac.abort(), 8000);
        let graphRes;
        try {
          graphRes = await fetch(GRAPH_URL, {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
              ...payload,
              access_token: token,
            }),
            signal: ac.signal,
          });
        } finally {
          clearTimeout(kill);
        }
        if (!graphRes || !graphRes.ok) {
          if (graphRes) {
            const errText = await graphRes.text();
            console.error("Meta CAPI", graphRes.status, errText.slice(0, 400));
          }
          res.status(204).json({ok: false});
          return;
        }
        res.status(204).json({ok: true});
      } catch (e) {
        console.error("trackMetaCapi", e);
        res.status(204).json({ok: false});
      }
    },
);
