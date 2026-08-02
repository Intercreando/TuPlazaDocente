const { chromium } = require("playwright");

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  const logs = [];
  page.on("console", (m) => logs.push([m.type(), m.text()]));
  page.on("pageerror", (e) => logs.push(["pageerror", String(e.message)]));

  await page.goto("https://www.tuplazadocente.com/", {
    waitUntil: "domcontentloaded",
    timeout: 60000,
  });
  await page.waitForTimeout(15000);

  const info = await page.evaluate(() => {
    const boot = document.getElementById("boot");
    const canvases = document.querySelectorAll("canvas").length;
    const flt = document.querySelectorAll("flt-scene-host, flutter-view, flt-glass-pane").length;
    const text = document.body && document.body.innerText
      ? document.body.innerText.replace(/\s+/g, " ").trim().slice(0, 1000)
      : "";
    const html = document.body ? document.body.innerHTML.slice(0, 500) : "";
    return {
      boot: !!boot,
      canvases,
      flt,
      text,
      html,
      title: document.title,
    };
  });

  console.log(JSON.stringify(info, null, 2));
  console.log("ERRORS:");
  for (const l of logs.filter((x) => x[0] === "error" || x[0] === "pageerror" || (x[1] || "").includes("no-app") || (x[1] || "").includes("Firebase") || (x[1] || "").includes("Exception"))) {
    console.log(JSON.stringify(l));
  }

  await page.screenshot({ path: "tools/live_probe.png", fullPage: true });
  await browser.close();
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
