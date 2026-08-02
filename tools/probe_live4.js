const { chromium } = require("playwright");

(async () => {
  const browser = await chromium.launch({
    headless: true,
    args: ["--enable-webgl", "--ignore-gpu-blocklist"],
  });
  const page = await browser.newPage({ viewport: { width: 1280, height: 800 } });
  const logs = [];
  page.on("console", (m) => logs.push([m.type(), m.text().slice(0, 250)]));
  page.on("pageerror", (e) => logs.push(["pageerror", String(e.message).slice(0, 300)]));

  await page.goto("https://www.tuplazadocente.com/?v=11b", {
    waitUntil: "networkidle",
    timeout: 90000,
  });
  await page.waitForTimeout(18000);

  const info = await page.evaluate(() => {
    function countCanvases(root) {
      let n = root.querySelectorAll ? root.querySelectorAll("canvas").length : 0;
      const all = root.querySelectorAll ? root.querySelectorAll("*") : [];
      for (const el of all) {
        if (el.shadowRoot) n += countCanvases(el.shadowRoot);
      }
      return n;
    }
    const glass = document.querySelector("flt-glass-pane, flutter-view");
    return {
      canvasesLight: document.querySelectorAll("canvas").length,
      canvasesDeep: countCanvases(document),
      glassHTML: glass ? glass.outerHTML.slice(0, 300) : null,
      children: [...document.body.children].map((c) => c.tagName + (c.id ? "#" + c.id : "")),
    };
  });

  console.log(JSON.stringify(info, null, 2));
  console.log("LOGS", JSON.stringify(logs.filter((l) => l[0] !== "warning")));
  await page.screenshot({ path: "tools/live_probe4.png" });
  await browser.close();
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
