const { chromium } = require("playwright");

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  const logs = [];
  page.on("console", (m) => logs.push([m.type(), m.text().slice(0, 250)]));
  page.on("pageerror", (e) => logs.push(["pageerror", String(e.message).slice(0, 300)]));

  await page.goto("https://www.tuplazadocente.com/?v=12", {
    waitUntil: "networkidle",
    timeout: 90000,
  });
  await page.waitForTimeout(12000);

  const interesting = logs.filter(
    (l) =>
      /Firebase|channel-error|Firestore|Auth|listo|asset seed/i.test(l[1] || ""),
  );
  console.log(JSON.stringify(interesting, null, 2));
  console.log(
    "version",
    await page.evaluate(async () =>
      (await fetch("/version.json?t=" + Date.now()).then((r) => r.json())),
    ),
  );
  await browser.close();
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
