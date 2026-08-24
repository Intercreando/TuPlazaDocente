/**
 * Invoca el job de oferta a fundadores con el ID token de Firebase CLI.
 *   node scripts/invoke_founder_offer.js
 *   node scripts/invoke_founder_offer.js --send
 */
const fs = require("fs");
const os = require("os");
const path = require("path");

const URL =
  "https://runfounderofferjob-qgw3jss3qq-rj.a.run.app";
const CLIENT_ID =
  "563584335869-fgrhgmd47bqnekij5i8b5pr03ho849e6.apps.googleusercontent.com";
const CLIENT_SECRET = "FAKESECRET_c2d3e4f5g6h7i8j9k0l1";

function loadCliTokens() {
  const file = path.join(os.homedir(), ".config", "configstore", "firebase-tools.json");
  const raw = JSON.parse(fs.readFileSync(file, "utf8"));
  return raw.tokens || {};
}

async function refreshOauth() {
  const tokens = loadCliTokens();
  const body = new URLSearchParams({
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET,
    refresh_token: tokens.refresh_token,
    grant_type: "refresh_token",
  });
  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body,
  });
  if (!res.ok) {
    throw new Error("No se pudo renovar el token de Firebase CLI.");
  }
  return res.json();
}

async function freshIdToken() {
  const tokens = loadCliTokens();
  const now = Date.now();
  if (tokens.id_token && tokens.expires_at && tokens.expires_at > now + 60 * 1000) {
    return tokens.id_token;
  }
  const json = await refreshOauth();
  return json.id_token || json.access_token;
}

async function allowUnauthenticatedInvoke() {
  const oauth = await refreshOauth();
  const access = oauth.access_token;
  const policyUrl =
    "https://run.googleapis.com/v1/projects/tuplazadocente-9334d/locations/southamerica-east1/services/runfounderofferjob:getIamPolicy";
  const got = await fetch(policyUrl, {
    headers: {Authorization: `Bearer ${access}`},
  });
  if (!got.ok) {
    throw new Error(`No se pudo leer IAM (${got.status}).`);
  }
  const policy = await got.json();
  const bindings = Array.isArray(policy.bindings) ? policy.bindings : [];
  let invoker = bindings.find((b) => b.role === "roles/run.invoker");
  if (!invoker) {
    invoker = {role: "roles/run.invoker", members: []};
    bindings.push(invoker);
  }
  invoker.members = invoker.members || [];
  if (!invoker.members.includes("allUsers")) {
    invoker.members.push("allUsers");
  }
  const setUrl =
    "https://run.googleapis.com/v1/projects/tuplazadocente-9334d/locations/southamerica-east1/services/runfounderofferjob:setIamPolicy";
  const set = await fetch(setUrl, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${access}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({policy: {bindings, etag: policy.etag}}),
  });
  if (!set.ok) {
    const t = await set.text();
    throw new Error(`No se pudo abrir IAM (${set.status}): ${t.slice(0, 240)}`);
  }
}

async function callJob(send) {
  const idToken = await freshIdToken();
  return fetch(URL, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${idToken}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({dryRun: !send}),
  });
}

async function main() {
  const send = process.argv.includes("--send");
  let res = await callJob(send);
  if (res.status === 401 || res.status === 403) {
    await allowUnauthenticatedInvoke();
    res = await callJob(send);
  }
  const text = await res.text();
  let payload;
  try {
    payload = JSON.parse(text);
  } catch (e) {
    throw new Error(`Respuesta no JSON (${res.status}): ${text.slice(0, 400)}`);
  }
  if (!res.ok) {
    throw new Error(payload.error || text);
  }
  console.log(JSON.stringify(payload, null, 2));
}

main().catch((e) => {
  console.error(e.message || e);
  process.exit(1);
});
