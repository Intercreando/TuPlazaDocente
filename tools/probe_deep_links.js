/**
 * Comprueba en producción si las URLs sin "#" llegan a su pantalla.
 *
 * La app web usa la estrategia de hash, así que la ruta real vive después del
 * "#". Si Firebase reescribe /auth a index.html y el router arranca en "/", el
 * visitante cae en la portada y se pierden los parámetros de campaña.
 *
 * Uso: node tools/probe_deep_links.js [ruta]
 *   Sin argumentos revisa las tres rutas de referencia; con uno revisa solo esa.
 */
const {chromium} = require("playwright");

const base = "https://www.tuplazadocente.com";
const targets = [
  {label: "CTA de las landings", path: "/auth?register=1&src=probe"},
  {label: "Detalle de noticia", path: "/noticias/ejemplo"},
  {label: "Ruta con hash (control)", path: "/#/auth?register=1&src=probe"},
];

async function probe(page, target) {
  await page.goto(`${base}${target.path}`, {
    waitUntil: "networkidle",
    timeout: 90000,
  });
  // La primera ruta se reporta al historial unos segundos después del arranque.
  await page.waitForTimeout(12000);
  return page.evaluate(() => ({
    href: location.href,
    hash: location.hash,
    search: location.search,
  }));
}

(async () => {
  // Se usa el Chrome del sistema para no descargar el navegador de Playwright.
  const browser = await chromium.launch({headless: true, channel: "chrome"});
  const page = await browser.newPage({viewport: {width: 1280, height: 900}});
  const errors = [];
  page.on("pageerror", (e) => errors.push(String(e.message).slice(0, 200)));

  const custom = process.argv[2];
  const list = custom ? [{label: `Ruta ${custom}`, path: custom}] : targets;
  let index = 0;

  for (const target of list) {
    index += 1;
    try {
      const info = await probe(page, target);
      console.log(`\n${target.label}`);
      console.log(`  pedido : ${target.path}`);
      console.log(`  hash   : ${info.hash || "(vacío)"}`);
      console.log(`  search : ${info.search || "(vacío)"}`);
      console.log(`  final  : ${info.href}`);
      const slug = target.path.replace(/[^a-z0-9]+/gi, "-").slice(0, 32);
      await page.screenshot({path: `tools/probe_deep_link_${index}${slug}.png`});
    } catch (e) {
      console.log(`\n${target.label}: falló -> ${String(e.message).slice(0, 160)}`);
    }
  }

  if (errors.length) console.log("\nERRORES DE PÁGINA", JSON.stringify(errors));
  await browser.close();
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
