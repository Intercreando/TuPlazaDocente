/**
 * Tutor de texto con Vertex AI (facturación del proyecto Firebase).
 * No usa la API de AI Studio: esa va por créditos prepago y se agota.
 */
const {GoogleAuth} = require("google-auth-library");
const {HttpsError} = require("firebase-functions/v2/https");

/** 110 palabras + margen de thought. No subir: el thought se factura. */
const MAX_OUTPUT_TOKENS = 512;
const MAX_WORDS = 110;
/** Solo global: la región extra cobraba otra vez si el modelo existía. */
const VERTEX_LOCATION = "global";
/**
 * Un toque = una llamada de pago. El 404 no cobra; por eso hay un
 * modelo de respaldo. 400/429/vacío NO reintentan (sí se facturan).
 */
const MODELS = [
  "gemini-3.5-flash-lite",
  "gemini-3.1-flash-lite",
];
const MAX_VERTEX_ATTEMPTS = 2;

const SYSTEM_PROMPT =
  "Eres un tutor experto en pedagogía y normativa educativa colombiana " +
  "(Ley 115, Decreto 1075, estatutos docentes, evaluación por competencias). " +
  "Tu tarea es retroalimentar de forma constructiva a un docente que falló " +
  "una pregunta de opción múltiple.\n\n" +
  "Recibirás: [El Caso], [La Opción Correcta] y [La Opción Incorrecta que eligió].\n\n" +
  "Reglas estrictas:\n\n" +
  "Valida y contrasta: Inicia reconociendo brevemente por qué la opción " +
  "incorrecta podría parecer una buena idea en otro contexto (valida el " +
  "distractor), y luego explica por qué la opción correcta es la exigida " +
  "para este caso específico.\n\n" +
  "Lenguaje técnico: Utiliza terminología propia del Ministerio de " +
  "Educación Nacional (MEN) y enfoques pedagógicos modernos.\n\n" +
  "Formato visual: Utiliza negritas (texto) única y exclusivamente para " +
  "resaltar 2 o 3 conceptos pedagógicos clave.\n\n" +
  "Brevedad extrema: Máximo 110 palabras. Cero saludos, despedidas, ni " +
  "introducciones genéricas. Empieza directamente con el análisis.\n\n" +
  "Las negritas se escriben con markdown **concepto** (como máximo tres).";

const auth = new GoogleAuth({
  scopes: ["https://www.googleapis.com/auth/cloud-platform"],
});

/**
 * @return {string}
 */
function projectId() {
  if (process.env.GCLOUD_PROJECT) return process.env.GCLOUD_PROJECT;
  if (process.env.GOOGLE_CLOUD_PROJECT) {
    return process.env.GOOGLE_CLOUD_PROJECT;
  }
  try {
    const parsed = JSON.parse(process.env.FIREBASE_CONFIG || "{}");
    if (parsed.projectId) return String(parsed.projectId);
  } catch (err) {
    console.error("gemini_vertex FIREBASE_CONFIG", err);
  }
  return "tuplazadocente-9334d";
}

/**
 * @return {Promise<string>}
 */
async function accessToken() {
  const client = await auth.getClient();
  const tokenResponse = await client.getAccessToken();
  const token = typeof tokenResponse === "string" ?
    tokenResponse :
    tokenResponse?.token;
  if (!token) {
    throw new HttpsError("internal", "No pudimos autenticar el tutor.");
  }
  return token;
}

/**
 * @param {string} project
 * @param {string} location
 * @param {string} model
 * @return {string}
 */
function vertexUrl(project, location, model) {
  const host = location === "global" ?
    "https://aiplatform.googleapis.com" :
    `https://${location}-aiplatform.googleapis.com`;
  return `${host}/v1/projects/${project}/locations/${location}` +
    `/publishers/google/models/${model}:generateContent`;
}

/**
 * @param {string} text
 * @param {number} max
 * @return {string}
 */
function capWords(text, max) {
  const tokens = String(text || "").trim().split(/\s+/).filter(Boolean);
  if (tokens.length <= max) return tokens.join(" ");
  let cut = tokens.slice(0, max).join(" ");
  const marks = (cut.match(/\*\*/g) || []).length;
  if (marks % 2 === 1) cut += "**";
  return cut;
}

/**
 * @param {string} raw
 * @param {number} [maxWords]
 * @return {string}
 */
function sanitizeModelText(raw, maxWords = MAX_WORDS) {
  const text = String(raw || "")
      .replace(/```[\s\S]*?```/g, " ")
      .replace(/<[^>]+>/g, " ")
      .replace(/^#{1,6}\s+/gm, "")
      .replace(/\s+/g, " ")
      .trim();
  return capWords(text, maxWords);
}

/**
 * Extrae el texto visible (sin bloques de thought si hay otro).
 * @param {object} payload
 * @return {string}
 */
function extractModelText(payload) {
  const parts = payload?.candidates?.[0]?.content?.parts || [];
  const visible = parts
      .filter((part) => part && part.thought !== true)
      .map((part) => part.text || "")
      .join(" ")
      .trim();
  if (visible) return visible;
  return parts.map((part) => part.text || "").join(" ").trim();
}

/**
 * @param {number} status
 * @param {string} message
 * @return {boolean}
 */
function isApiDisabled(status, message) {
  if (status !== 403) return false;
  const msg = String(message || "").toLowerCase();
  return msg.includes("has not been used") ||
    msg.includes("it is disabled") ||
    msg.includes("api has not been enabled") ||
    msg.includes("service is disabled");
}

/**
 * Activa Vertex AI API (idempotente). Tarda ~1 min en propagarse.
 * @param {string} token
 * @param {string} project
 * @return {Promise<boolean>}
 */
async function enableVertexApi(token, project) {
  try {
    const response = await fetch(
        "https://serviceusage.googleapis.com/v1/" +
        `projects/${project}/services/aiplatform.googleapis.com:enable`,
        {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json",
            "x-goog-user-project": project,
          },
          body: "{}",
        },
    );
    const payload = await response.json().catch(() => ({}));
    console.error(
        "Vertex enable API",
        response.status,
        JSON.stringify(payload?.error || payload),
    );
    return response.ok || response.status === 409;
  } catch (err) {
    console.error("Vertex enable API exception", err);
    return false;
  }
}

/**
 * Una llamada de pago (404 no cobra). System prompt inyectado por el caller.
 * @param {string} systemPrompt
 * @param {string} userPrompt
 * @param {{maxOutputTokens?: number, maxWords?: number}=} options
 * @return {Promise<string>}
 */
async function generateText(systemPrompt, userPrompt, options = {}) {
  const maxOutputTokens = Number(options.maxOutputTokens) || MAX_OUTPUT_TOKENS;
  const maxWords = Number(options.maxWords) || MAX_WORDS;
  const project = projectId();
  const token = await accessToken();
  const body = {
    systemInstruction: {parts: [{text: systemPrompt}]},
    contents: [{role: "user", parts: [{text: userPrompt}]}],
    generationConfig: {
      temperature: 0.35,
      maxOutputTokens: maxOutputTokens,
    },
  };

  let lastStatus = 0;
  let lastPayload = {};
  let attempts = 0;
  for (const model of MODELS) {
    if (attempts >= MAX_VERTEX_ATTEMPTS) break;
    attempts += 1;
    const response = await fetch(
        vertexUrl(project, VERTEX_LOCATION, model),
        {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${token}`,
            "Content-Type": "application/json",
            "x-goog-user-project": project,
          },
          body: JSON.stringify(body),
        },
    );
    const payload = await response.json().catch(() => ({}));
    lastStatus = response.status;
    lastPayload = payload;
    const errMsg = payload?.error?.message || "";

    if (response.status === 404) {
      console.error("Vertex 404 (sin cobro)", model, errMsg);
      continue;
    }

    if (!response.ok) {
      console.error(
          "Vertex HTTP",
          response.status,
          VERTEX_LOCATION,
          model,
          JSON.stringify(payload?.error || payload),
      );
      if (isApiDisabled(response.status, errMsg)) {
        await enableVertexApi(token, project);
        throw new HttpsError(
            "unavailable",
            "Estamos activando el tutor. Vuelve a pulsar en un minuto.",
        );
      }
      throw new HttpsError(
          "unavailable",
          "No pudimos generar la ampliación. Intenta de nuevo en un momento.",
      );
    }

    const raw = extractModelText(payload);
    const finish = payload?.candidates?.[0]?.finishReason;
    if (!raw) {
      console.error(
          "Vertex sin texto (cobrado, no reintento)",
          model,
          finish,
          JSON.stringify(payload),
      );
      throw new HttpsError(
          "unavailable",
          "Gemini no devolvió texto. Intenta de nuevo.",
      );
    }
    return sanitizeModelText(raw, maxWords);
  }

  console.error(
      "Vertex ningún modelo disponible",
      lastStatus,
      JSON.stringify(lastPayload?.error || lastPayload),
  );
  throw new HttpsError(
      "unavailable",
      "No pudimos generar la ampliación. Intenta de nuevo en un momento.",
  );
}

/**
 * @param {string} userPrompt
 * @return {Promise<string>}
 */
async function generateExplanation(userPrompt) {
  return generateText(SYSTEM_PROMPT, userPrompt);
}

module.exports = {generateExplanation, generateText};
