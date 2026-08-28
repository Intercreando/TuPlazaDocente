/**
 * Contrato del Mentor IA: cupo, recortes y cierre. Sin I/O de red.
 */
const MAX_USER_CHARS = 250;
const MAX_TURNS = 8;
const DAILY_SESSIONS = 4;
const MAX_WORDS = 100;
const MAX_OUTPUT_TOKENS = 350;
const GLOBAL_START_CAP = 400;
const GLOBAL_GEMINI_CAP = 2000;
/** Un toque Vertex por turno. El fallo también cuenta: reintentar infla la factura. */
const MAX_VERTEX_PER_SESSION = MAX_TURNS;
/** Candado thinking huérfano (timeout de Function 45 s). */
const THINKING_STALE_MS = 90 * 1000;

/**
 * @param {unknown} raw
 * @param {number} max
 * @return {string}
 */
function clipText(raw, max) {
  const text = String(raw || "").replace(/\s+/g, " ").trim();
  if (!text) return "";
  return text.length > max ? text.slice(0, max) : text;
}

/**
 * @param {unknown} raw
 * @return {string}
 */
function clipUserInput(raw) {
  return clipText(raw, MAX_USER_CHARS);
}

/**
 * @param {unknown} raw
 * @return {Date|null}
 */
function toDate(raw) {
  if (!raw) return null;
  if (typeof raw.toDate === "function") {
    try {
      return raw.toDate();
    } catch (_) {
      return null;
    }
  }
  if (raw instanceof Date) {
    return Number.isNaN(raw.getTime()) ? null : raw;
  }
  const parsed = new Date(raw);
  return Number.isNaN(parsed.getTime()) ? null : parsed;
}

/**
 * @param {unknown} expiresAt
 * @param {Date=} now
 * @return {boolean}
 */
function isPassActive(expiresAt, now = new Date()) {
  const date = toDate(expiresAt);
  return date != null && date.getTime() > now.getTime();
}

/**
 * @param {object|null|undefined} userData
 * @param {Date=} now
 * @return {{ok: true, kind: "pass"|"trial"}|{ok: false, code: string}}
 */
function resolveAccess(userData, now = new Date()) {
  if (!userData || userData.isPremium !== true) {
    return {ok: false, code: "not_premium"};
  }
  if (isPassActive(userData.mentorPassExpiresAt, now)) {
    return {ok: true, kind: "pass"};
  }
  if (userData.mentorTrialUsed === true) {
    return {ok: false, code: "paywall"};
  }
  return {ok: true, kind: "trial"};
}

/**
 * Acierto si coincide el índice o el texto de las dos opciones.
 * @param {{chosenIndex?: unknown, correctIndex?: unknown,
 *   chosenClip?: unknown, correctClip?: unknown}} input
 * @return {boolean}
 */
function resolveChoseCorrect(input = {}) {
  const chosen = Number(input.chosenIndex);
  const correct = Number(input.correctIndex);
  if (Number.isInteger(chosen) && Number.isInteger(correct) &&
      chosen === correct) {
    return true;
  }
  const marked = clipText(input.chosenClip, 4000);
  const expected = clipText(input.correctClip, 4000);
  return Boolean(marked && expected && marked === expected);
}

/**
 * @param {object|null|undefined} session
 * @return {boolean}
 */
function sessionChoseCorrect(session) {
  if (!session) return false;
  if (typeof session.choseCorrect === "boolean") return session.choseCorrect;
  return resolveChoseCorrect(session);
}

/**
 * @param {boolean} hit
 * @return {string}
 */
function outcomeRules(hit) {
  if (hit) {
    return "DESENLACE: el docente MARCÓ LA POSTURA EXIGIDA. " +
        "Trátalo como acierto. Nunca digas que se equivocó, que su " +
        "actuación no es la mejor, ni le pidas reformular como si " +
        "estuviera mal. Profundiza: por qué el concurso premia ESA " +
        "actuación en ESTE caso, qué distractor evitó, y un giro " +
        "(rector, familia, SIEE/PIAR). Si más adelante duda o se desvía, " +
        "reenfoca sin invalidar el acierto.";
  }
  return "DESENLACE: el docente marcó una postura que NO es la exigida. " +
      "Ya vio la clave del banco: no finjas que no existe. Valida por " +
      "qué su opción pudo parecer razonable y contrasta con el criterio " +
      "de ESTE caso. Guía a que reformule CON SUS PALABRAS. Si en un " +
      "turno posterior formula la postura exigida, reconócelo y pasa a " +
      "profundizar: deja de decir que está mal.";
}

/**
 * @param {{stemClip: string, caseClip?: string, correctClip: string,
 *   chosenClip: string, stanceSummary?: string, choseCorrect?: boolean}} session
 * @return {string}
 */
function buildSystemPrompt(session) {
  const hit = sessionChoseCorrect(session);
  const caso = session.caseClip
      ? `${session.caseClip}\n\n${session.stemClip}`
      : session.stemClip;
  const stance = session.stanceSummary
      ? session.stanceSummary
      : (hit ? "Acertó de entrada." : "Aún no reformuló su postura.");
  return "Eres un mentor pedagógico experto del concurso docente CNSC/ICFES. " +
      "Enseñas como un padre paciente. Máximo 100 palabras. Cero saludos. " +
      "Hasta 2 negritas **concepto**. No inventes artículos ni decretos. " +
      "Si dudas, apóyate en la opción correcta del caso.\n\n" +
      outcomeRules(hit) + "\n\n" +
      "El docente ya vio la clave del banco. No recites la letra (A/B/C) " +
      "como spoiler; habla del criterio.\n\n" +
      "Si cambia de tema o habla de cosas personales, reenfoca con " +
      "amabilidad al caso de aula actual.\n\n" +
      `[El Caso]\n${caso}\n\n` +
      `[La opción exigida]\n${session.correctClip}\n\n` +
      `[La postura que eligió]\n${session.chosenClip}\n\n` +
      `[Desenlace]\n${hit ? "Acertó de entrada." : "No acertó de entrada."}\n\n` +
      `[Recorte de la sesión]\n${stance}`;
}

/**
 * @param {boolean=} choseCorrect
 * @return {string}
 */
function buildOpeningPrompt(choseCorrect = false) {
  if (choseCorrect) {
    return "El docente marcó la postura exigida. Es el turno 1 de 8. " +
        "Confirma el acierto sin fanfarria. En una o dos frases, por qué " +
        "ESA es la exigida en ESTE caso. Termina con UNA pregunta de " +
        "anclaje (qué haría si un directivo insiste en otra vía). No " +
        "saludes. No digas que se equivocó ni que su opción no es la mejor.";
  }
  return "El docente marcó una postura que NO es la exigida; ya vio la " +
      "clave del banco. Es el turno 1 de 8. Reconoce por qué su opción " +
      "pudo parecer razonable, explica por qué en ESTE caso no es la " +
      "mejor, y termina con UNA pregunta para que reformule con sus " +
      "palabras. No saludes. No recites la letra de la correcta.";
}

/**
 * Ventana: último intercambio + el mensaje nuevo.
 * @param {string} lastUser
 * @param {string} lastMentor
 * @param {string} userText
 * @param {number} turnNumber
 * @param {boolean=} choseCorrect
 * @return {object[]}
 */
function slidingContents(
    lastUser, lastMentor, userText, turnNumber, choseCorrect = false,
) {
  const contents = [];
  if (lastUser) {
    contents.push({role: "user", parts: [{text: lastUser}]});
  }
  if (lastMentor) {
    contents.push({role: "model", parts: [{text: lastMentor}]});
  }
  const hint = choseCorrect
      ? " El docente acertó de entrada; no lo corrijas."
      : " Si ya reformuló hacia la exigida, reconócelo y profundiza.";
  const label = `Turno ${turnNumber} de ${MAX_TURNS}.${hint}`;
  contents.push({
    role: "user",
    parts: [{text: `${label} ${userText}`}],
  });
  return contents;
}

/**
 * @param {number} turnCountAfter
 * @param {string} kind
 * @return {{status: string, closeReason: string|null, paywall: boolean}}
 */
function nextTurnState(turnCountAfter, kind) {
  if (turnCountAfter < MAX_TURNS) {
    return {status: "active", closeReason: null, paywall: false};
  }
  const trial = kind === "trial";
  return {
    status: "closed",
    closeReason: trial ? "trial_done" : "completed",
    paywall: trial,
  };
}

/**
 * @param {string} chosenClip
 * @param {string} userClip
 * @return {string}
 */
function stanceSummaryFrom(chosenClip, userClip, choseCorrect = false) {
  const marked = clipText(chosenClip, 120);
  const said = clipText(userClip, 180);
  const prefix = choseCorrect ? "Acertó." : "No acertó de entrada.";
  if (!said) return clipText(`${prefix} Marcó: ${marked}`, 220);
  return clipText(`${prefix} Marcó: ${marked}. Dijo: ${said}`, 220);
}

/**
 * @param {number} vertexCalls
 * @return {boolean}
 */
function canAttemptVertex(vertexCalls) {
  return Number(vertexCalls || 0) < MAX_VERTEX_PER_SESSION;
}

/**
 * @param {object} session
 * @param {Date=} now
 * @return {boolean}
 */
function isThinkingStale(session, now = new Date()) {
  if (!session || session.status !== "thinking") return false;
  const at = toDate(session.thinkingAt);
  if (!at) return true;
  return now.getTime() - at.getTime() > THINKING_STALE_MS;
}

module.exports = {
  MAX_USER_CHARS,
  MAX_TURNS,
  DAILY_SESSIONS,
  MAX_WORDS,
  MAX_OUTPUT_TOKENS,
  GLOBAL_START_CAP,
  GLOBAL_GEMINI_CAP,
  MAX_VERTEX_PER_SESSION,
  THINKING_STALE_MS,
  clipText,
  clipUserInput,
  toDate,
  isPassActive,
  resolveAccess,
  resolveChoseCorrect,
  sessionChoseCorrect,
  outcomeRules,
  buildSystemPrompt,
  buildOpeningPrompt,
  slidingContents,
  nextTurnState,
  stanceSummaryFrom,
  canAttemptVertex,
  isThinkingStale,
};
