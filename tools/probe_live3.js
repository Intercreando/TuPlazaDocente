const { chromium } = require("playwright");

(async () => {
  const browser = await chromium.launch({
    headless: true,
    args: ["--enable-webgl", "--ignore-gpu-blocklist"],
  });
  const page = await browser.newPage();
  const logs = [];
  page.on("console", (m) => logs.push([m.type(), m.text().slice(0, 300)]));
  page.on("pageerror", (e) => logs.push(["pageerror", String(e.message).slice(0, 400)]));
  page.on("requestfailed", (r) =>
    logs.push(["fail", r.url().slice(0, 120), r.failure()?.errorText || ""]),
  );

  await page.goto("https://www.tuplazadocente.com/?v=11", {
    waitUntil: "networkidle",
    timeout: 90000,
  });
  await page.waitForTimeout(20000);

  const info = await page.evaluate(() => {
    const canvas = document.querySelectorAll("canvas");
    return {
      boot: !!document.getElementById("boot"),
      canvases: canvas.length,
      flutterViews: document.querySelectorAll("flutter-view, flt-glass-pane, flt-scene-host").length,
      text: (document.body?.innerText || "").replace(/\s+/g, " ").trim().slice(0, 500),
      hasFlutter: typeof window._flutter !== "undefined",
      buildConfig: window._flutter?.buildConfig || null,
    };
  });

  console.log("INFO", JSON.stringify(info, null, 2));
  console.log("ALL_LOGS");
  for (const l of logs) console.log(JSON.stringify(l));
  await page.screenshot({ path: "tools/live_probe3.png", fullPage: true });
  await browser.close();
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
