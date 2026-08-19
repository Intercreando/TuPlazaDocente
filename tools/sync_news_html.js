/**
 * Copia las plantillas HTML de noticias a Cloud Functions.
 * Las funciones no pueden importar archivos fuera de su carpeta al desplegar.
 */
const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..");
const from = path.join(root, "tools", "lib");
const to = path.join(root, "functions", "lib");
const files = ["html_partials.js", "news_html.js"];

fs.mkdirSync(to, {recursive: true});
for (const file of files) {
  fs.copyFileSync(path.join(from, file), path.join(to, file));
}
console.log("OK: plantillas de noticias copiadas a functions/lib");
