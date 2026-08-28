const test = require("node:test");
const assert = require("node:assert/strict");
const core = require("./mentor_convo_core");

test("pase activo: 4 sesiones al día", () => {
  assert.equal(core.DAILY_SESSIONS, 4);
});

test("clipUserInput corta a 250", () => {
  const long = "a".repeat(300);
  assert.equal(core.clipUserInput(long).length, 250);
});

test("sin pase y sin prueba usada, entra a trial", () => {
  const access = core.resolveAccess({isPremium: true});
  assert.deepEqual(access, {ok: true, kind: "trial"});
});

test("prueba ya usada, pide pase", () => {
  const access = core.resolveAccess({
    isPremium: true,
    mentorTrialUsed: true,
  });
  assert.equal(access.ok, false);
  assert.equal(access.code, "paywall");
});

test("pase vigente gana sobre la prueba usada", () => {
  const now = new Date("2026-08-28T15:00:00Z");
  const access = core.resolveAccess({
    isPremium: true,
    mentorTrialUsed: true,
    mentorPassExpiresAt: "2026-09-10T00:00:00.000Z",
  }, now);
  assert.deepEqual(access, {ok: true, kind: "pass"});
});

test("pase vencido sin prueba pide paywall", () => {
  const now = new Date("2026-08-28T15:00:00Z");
  const access = core.resolveAccess({
    isPremium: true,
    mentorTrialUsed: true,
    mentorPassExpiresAt: "2026-08-01T00:00:00.000Z",
  }, now);
  assert.equal(access.code, "paywall");
});

test("no Premium no entra", () => {
  assert.equal(core.resolveAccess({isPremium: false}).code, "not_premium");
});

test("al turno 8 de trial cierra con paywall", () => {
  const state = core.nextTurnState(8, "trial");
  assert.equal(state.status, "closed");
  assert.equal(state.closeReason, "trial_done");
  assert.equal(state.paywall, true);
});

test("al turno 8 con pase cierra sin paywall", () => {
  const state = core.nextTurnState(8, "pass");
  assert.equal(state.closeReason, "completed");
  assert.equal(state.paywall, false);
});

test("ventana deslizante manda solo el último intercambio", () => {
  const contents = core.slidingContents("antes", "mentor", "ahora", 3);
  assert.equal(contents.length, 3);
  assert.equal(contents[0].role, "user");
  assert.equal(contents[1].role, "model");
  assert.ok(String(contents[2].parts[0].text).includes("ahora"));
});

test("tope Vertex por sesión: 8 toques, el fallo también cuenta", () => {
  assert.equal(core.canAttemptVertex(0), true);
  assert.equal(core.canAttemptVertex(7), true);
  assert.equal(core.canAttemptVertex(8), false);
  assert.equal(core.MAX_VERTEX_PER_SESSION, core.MAX_TURNS);
});

test("thinking fresco no es huérfano; sin fecha o viejo sí", () => {
  const now = new Date("2026-08-28T15:00:00.000Z");
  assert.equal(core.isThinkingStale({status: "active"}, now), false);
  assert.equal(core.isThinkingStale({status: "thinking"}, now), true);
  assert.equal(core.isThinkingStale({
    status: "thinking",
    thinkingAt: new Date(now.getTime() - 10 * 1000),
  }, now), false);
  assert.equal(core.isThinkingStale({
    status: "thinking",
    thinkingAt: new Date(now.getTime() - 91 * 1000),
  }, now), true);
});
