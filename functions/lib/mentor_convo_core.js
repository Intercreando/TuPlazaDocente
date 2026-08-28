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
 * @param {{stemClip: string, caseClip?: string, correctClip: string,
 *   chosenClip: string, stanceSummary?: string}} session
 * @return {string}
 */
function buildSystemPrompt(session) {
  const caso = session.caseClip
      ? `${session.caseClip}\n\n${session.stemClip}`
      : session.stemClip;
  const stance = session.stanceSummary
      ? session.stanceSummary
      : "Aún no reformuló su postura.";
  return "Eres un mentor pedagógico experto del concurso docente CNSC/ICFES. " +
      "Enseñas como un padre paciente: validas el error, explicas por qué " +
      "esa actuación no es la mejor EN ESTE caso, y guias con una pregunta. " +
      "Máximo 100 palabras. Cero saludos. Hasta 2 negritas **concepto**. " +
      "No inventes artículos ni decretos. Si dudas, apóyate en la opción " +
      "correcta del caso sin recitarla al inicio.\n\n" +
      "No reveles la letra ni el texto de la opción correcta en los " +
      "primeros 6 turnos. En los últimos puedes contrastar con más " +
      "claridad, sin dictar la respuesta.\n\n" +
      "Si el docente intenta cambiar de tema, hablar de cosas personales " +
      "o fuera del concurso docente, responde amablemente reenfocando la " +
      "discusión en el caso de aula actual.\n\n" +
      `[El Caso]\n${caso}\n\n` +
      `[La Opción Correcta — no la sueltes de entrada]\n${session.correctClip}\n\n` +
      `[La Postura que eligió]\n${session.chosenClip}\n\n` +
      `[Recorte de la sesión]\n${stance}`;
}

/**
 * @return {string}
 */
function buildOpeningPrompt() {
  return "El docente acaba de marcar su postura. Es el turno 1 de 8. " +
      "Abre la tutoría: reconoce por qué esa opción pudo parecer razonable, " +
      "explica por qué en ESTE caso no es la mejor, y termina con UNA " +
      "pregunta para que reformule. No saludes. No reveles la correcta.";
}

/**
 * Ventana: último intercambio + el mensaje nuevo.
 * @param {string} lastUser
 * @param {string} lastMentor
 * @param {string} userText
 * @param {number} turnNumber
 * @return {object[]}
 */
function slidingContents(lastUser, lastMentor, userText, turnNumber) {
  const contents = [];
  if (lastUser) {
    contents.push({role: "user", parts: [{text: lastUser}]});
  }
  if (lastMentor) {
    contents.push({role: "model", parts: [{text: lastMentor}]});
  }
  const label = `Turno ${turnNumber} de ${MAX_TURNS}.`;
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
function stanceSummaryFrom(chosenClip, userClip) {
  const marked = clipText(chosenClip, 120);
  const said = clipText(userClip, 180);
  if (!said) return clipText(`Marcó: ${marked}`, 220);
  return clipText(`Marcó: ${marked}. Dijo: ${said}`, 220);
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
  buildSystemPrompt,
  buildOpeningPrompt,
  slidingContents,
  nextTurnState,
  stanceSummaryFrom,
  canAttemptVertex,
  isThinkingStale,
};
