const core = require("./mentor_convo_core");

const PASS_MS = 30 * 24 * 60 * 60 * 1000;
const MENTOR_PRICE_COP = 19900;
const MENTOR_AMOUNT_CENTS = MENTOR_PRICE_COP * 100;

/**
 * Si el pase sigue vigente, suma 30 días al vencimiento; si no, desde ahora.
 * @param {unknown} existingExpiresAt
 * @param {Date=} now
 * @return {Date}
 */
function nextPassExpiry(existingExpiresAt, now = new Date()) {
  const current = core.toDate(existingExpiresAt);
  const baseMs = current && current.getTime() > now.getTime()
      ? current.getTime()
      : now.getTime();
  return new Date(baseMs + PASS_MS);
}

/**
 * @param {string} reference
 * @return {boolean}
 */
function isMentorReference(reference) {
  return String(reference || "").startsWith("MENTOR_");
}

module.exports = {
  PASS_MS,
  MENTOR_PRICE_COP,
  MENTOR_AMOUNT_CENTS,
  nextPassExpiry,
  isMentorReference,
};
