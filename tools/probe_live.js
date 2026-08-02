const { chromium } = require("playwright");

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  const logs = [];
  page.on("console", (m) => logs.push(["console", m.type(), m.text()]));
  page.on("pageerror", (e) => logs.push(["pageerror", String(e.message)]));
  page.on("requestfailed", (r) =>
    logs.push(["fail", r.url(), r.failure()?.errorText || ""]),
  );

  await page.goto("https://www.tuplazadocente.com/", {
    waitUntil: "networkidle",
    timeout: 60000,
  });
  await page.waitForTimeout(12000);

  const boot = await page.$("#boot");
  const flutterView = await page.$("flutter-view, flt-glass-pane, canvas");
  const bodyText = (await page.locator("body").innerText()).slice(0, 800);

  console.log("bootPresent", !!boot);
  console.log("flutterPresent", !!flutterView);
  console.log("body", JSON.stringify(bodyText));
  console.log("LOGS");
  for (const l of logs.slice(0, 60)) console.log(JSON.stringify(l));

  await browser.close();
})().catch((e) => {
  console.error("ERR", e.message);
  process.exit(1);
});
