/**
 * Sella el id del build antes de publicar (se ejecuta en el predeploy).
 *
 *  - build/web/sw.js: el id nombra la caché del service worker, así una
 *    publicación nueva estrena caché y borra la anterior.
 *  - build/web/build-id.json: index.html lo consulta al arrancar para
 *    detectar versiones nuevas y recargar una sola vez.
 *
 * El id es el hash del contenido de todo lo que se publica, no la versión del
 * pubspec: cambia ante cualquier cambio real (código, imágenes, banco de
 * ítems, HTML) aunque no se suba el número de versión, y no cambia si se
 * republica lo mismo.
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
/// Fuera del hash porque los genera este mismo script.
const EXCLUDED = new Set(["sw.js", "build-id.json"]);

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

/// Lista ordenada de los archivos publicables, en rutas relativas a build/web.
/// Se omiten los ocultos porque Hosting tampoco los sube (ignore: "**/.*").
function collectFiles(dir, base = "") {
  const found = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.name.startsWith(".")) continue;
    const relative = base ? `${base}/${entry.name}` : entry.name;
    if (EXCLUDED.has(relative)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      found.push(...collectFiles(full, relative));
    } else if (entry.isFile()) {
      found.push(relative);
    }
  }
  return found.sort();
}

/// Hash del contenido publicado: cualquier archivo nuevo, borrado, renombrado
/// o modificado produce un id distinto.
function contentHash() {
  const files = collectFiles(webDir);
  if (files.length === 0) {
    // Nada que hashear: sello por fecha para no reutilizar una caché vieja.
    return `ts${Date.now()}`;
  }
  const hash = crypto.createHash("sha1");
  for (const relative of files) {
    hash.update(relative);
    hash.update(fs.readFileSync(path.join(webDir, relative)));
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

  const id = `${appVersion()}-${contentHash()}`;
  fs.writeFileSync(swPath, source.split(PLACEHOLDER).join(id), "utf8");
  fs.writeFileSync(
      buildIdPath, `${JSON.stringify({ id, at: new Date().toISOString() })}\n`,
      "utf8");
  console.log(`[sw] Build id: ${id}`);
}

main();
