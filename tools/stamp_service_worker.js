/**
 * Sella el id del build antes de publicar (se ejecuta en el predeploy).
 *
 *  - build/web/sw.js: el id nombra la caché del service worker, así una
 *    publicación nueva estrena caché y borra la anterior.
 *  - build/web/build-id.json: index.html lo consulta al arrancar para
 *    detectar versiones nuevas y recargar una sola vez.
 *
 * El id es el hash del motor compilado (main.dart.js + flutter_bootstrap.js),
 * no la versión del pubspec: cambia en cada publicación real aunque no se
 * suba el número de versión, y no cambia si el código es idéntico.
 *
 * Uso: node tools/stamp_service_worker.js
 */
const crypto = require("crypto");
const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..");
const webDir = path.join(root, "build", "web");
const swPath = path.join(webDir, "sw.js");
const buildIdPath = path.join(webDir, "build-id.json");
const versionPath = path.join(webDir, "version.json");
const PLACEHOLDER = "__TPD_BUILD_ID__";
const HASHED = ["main.dart.js", "flutter_bootstrap.js", "index.html"];

/// Versión del pubspec: sirve para reconocer el build a simple vista.
function appVersion() {
  try {
    const info = JSON.parse(fs.readFileSync(versionPath, "utf8"));
    const version = String(info.version || "0").trim();
    const number = String(info.build_number || "0").trim();
    return `${version}+${number}`.replace(/[^\w.+\-]/g, "");
  } catch (e) {
    return "0";
  }
}

function engineHash() {
  const hash = crypto.createHash("sha1");
  let hashedAny = false;
  for (const name of HASHED) {
    const file = path.join(webDir, name);
    if (!fs.existsSync(file)) continue;
    hash.update(fs.readFileSync(file));
    hashedAny = true;
  }
  if (!hashedAny) {
    // Sin motor que hashear: sello por fecha para no reutilizar caché vieja.
    return `ts${Date.now()}`;
  }
  return hash.digest("hex").slice(0, 12);
}

function main() {
  if (!fs.existsSync(swPath)) {
    console.error(
        "[sw] Falta build/web/sw.js. Ejecuta primero: flutter build web --release");
    process.exit(1);
  }

  const source = fs.readFileSync(swPath, "utf8");
  if (!source.includes(PLACEHOLDER)) {
    const current = /const BUILD_ID = '([^']*)'/.exec(source);
    console.log(
        `[sw] Ya estaba sellado (${current ? current[1] : "desconocido"}); sin cambios.`);
    return;
  }

  const id = `${appVersion()}-${engineHash()}`;
  fs.writeFileSync(swPath, source.split(PLACEHOLDER).join(id), "utf8");
  fs.writeFileSync(
      buildIdPath, `${JSON.stringify({ id, at: new Date().toISOString() })}\n`,
      "utf8");
  console.log(`[sw] Build id: ${id}`);
}

main();
