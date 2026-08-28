const test = require("node:test");
const assert = require("node:assert/strict");
const pass = require("./mentor_pass_core");

test("pase nuevo dura 30 días desde ahora", () => {
  const now = new Date("2026-08-28T15:00:00.000Z");
  const next = pass.nextPassExpiry(null, now);
  assert.equal(next.getTime(), now.getTime() + pass.PASS_MS);
});

test("pase vigente se extiende desde el vencimiento, no desde hoy", () => {
  const now = new Date("2026-08-28T15:00:00.000Z");
  const current = new Date("2026-09-10T15:00:00.000Z");
  const next = pass.nextPassExpiry(current.toISOString(), now);
  assert.equal(next.getTime(), current.getTime() + pass.PASS_MS);
});

test("pase vencido arranca de nuevo desde hoy", () => {
  const now = new Date("2026-08-28T15:00:00.000Z");
  const expired = new Date("2026-08-01T15:00:00.000Z");
  const next = pass.nextPassExpiry(expired.toISOString(), now);
  assert.equal(next.getTime(), now.getTime() + pass.PASS_MS);
});

test("referencia MENTOR_ no se confunde con TPD_", () => {
  assert.equal(pass.isMentorReference("MENTOR_uid123_1710000"), true);
  assert.equal(pass.isMentorReference("TPD_uid123_1710000"), false);
  assert.equal(pass.isMentorReference(""), false);
});
