/**
 * Genera HTML estático de landings SEO (Google lee texto, no el canvas de Flutter).
 * Uso: node tools/generate_seo_landings.js
 */
const fs = require("fs");
const path = require("path");

const {
  SITE,
  esc,
  canonicalPath,
  head,
  siteHeader,
  ctaSection,
  disclaimer,
  foot,
} = require("./lib/html_partials");

const root = path.join(__dirname, "..");
const jsonPath = path.join(root, "assets", "seo", "landings.json");
const letters = ["A", "B", "C", "D", "E", "F"];

function itemHtml(item, kind) {
  const ctx = String(item.context || "").trim();
  const opts = (item.options || []).map((opt, i) => `
        <button type="button" class="opt">
          <span class="ltr">${letters[i] || ""}</span>
          <span>${esc(opt)}</span>
        </button>`).join("");
  const distractors = (item.distractors || [])
      .map((d, i) => {
        if (d == null || d === "" || i === item.correctIndex) return "";
        return `<p><strong>Por qué no ${letters[i]}.</strong> ${esc(d)}</p>`;
      })
      .join("");
  return `
    <article class="item" data-correct="${Number(item.correctIndex)}">
      <p class="eyebrow">${esc(item.eyebrow || "")}</p>
      ${ctx ? `<p class="context">${esc(ctx)}</p>` : ""}
      <p class="stem">${esc(item.stem || "")}</p>
      <div class="opts">${opts}</div>
      <div class="criterio">
        <h3>Criterio del ítem</h3>
        <p>${esc(item.theory || "")}</p>
        <p>${esc(item.normative || "")}</p>
        ${distractors}
      </div>
    </article>`;
}

function faqHtml(faq) {
  if (!faq || !faq.length) return "";
  const blocks = faq.map((f) => `
      <details>
        <summary>${esc(f.q)}</summary>
        <p>${esc(f.a)}</p>
      </details>`).join("");
  return `<section class="faq"><h2>Preguntas frecuentes</h2>${blocks}</section>`;
}

function relatedHtml(related) {
  if (!related || !related.length) return "";
  // Con barra final se evita el 301 que añade Hosting a las carpetas.
  const links = related.map((r) =>
    `<a href="${esc(canonicalPath(r.href))}">${esc(r.label)}</a>`,
  ).join("");
  return `<nav class="related" aria-label="Otras guías">${links}</nav>`;
}

function jsonLd(page) {
  const url = `${SITE}${page.path}/`.replace(/\/+$/, "/");
  const faq = (page.faq || []).map((f) => ({
    "@type": "Question",
    name: f.q,
    acceptedAnswer: {"@type": "Answer", text: f.a},
  }));
  const graph = {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Article",
        headline: page.h1,
        description: page.description,
        inLanguage: "es-CO",
        mainEntityOfPage: url,
        author: {"@type": "Organization", name: "TuPlazaDocente"},
      },
      {
        "@type": "FAQPage",
        mainEntity: faq,
      },
    ],
  };
  return JSON.stringify(graph);
}

function pageHtml(page) {
  const kind = page.kind === "quiz" ? "quiz" : "worked";
  const items = (page.items || []).map((it) => itemHtml(it, kind)).join("\n");
  const score = kind === "quiz"
    ? `<div class="score">Tu puntaje en esta muestra: <strong class="score-value">—</strong>. Abajo está el criterio de cada ítem.</div>`
    : "";
  return `<!DOCTYPE html>
<html lang="es-CO">
${head({
    title: page.title,
    description: page.description,
    path: page.path,
    ogType: "article",
    jsonLd: jsonLd(page),
  })}
<body>
${siteHeader()}
  <main class="${kind}" data-landing="${esc(page.id)}">
    <div class="wrap">
      <header class="hero">
        <p class="kicker">${esc(page.kicker || "")}</p>
        <h1>${esc(page.h1)}</h1>
        <p class="lead">${esc(page.lead || "")}</p>
      </header>
      ${score}
      ${items}
${ctaSection({
    title: page.ctaTitle || "",
    body: page.ctaBody || "",
    label: page.ctaLabel || "Registrarme gratis",
    source: page.source || page.id,
  })}
      ${relatedHtml(page.related)}
      ${faqHtml(page.faq)}
${disclaimer()}
${foot()}
    </div>
  </main>
  <script src="/seo/landing.js"></script>
</body>
</html>
`;
}

function writeRoots(pages) {
  const roots = [path.join(root, "web")];
  const built = path.join(root, "build", "web");
  if (fs.existsSync(built)) roots.push(built);
  for (const base of roots) {
    for (const page of pages) {
      const slug = String(page.path || "").replace(/^\//, "");
      const dir = path.join(base, slug);
      fs.mkdirSync(dir, {recursive: true});
      fs.writeFileSync(path.join(dir, "index.html"), pageHtml(page), "utf8");
    }
  }
  return roots;
}

function main() {
  const data = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
  const pages = data.pages || [];
  if (!pages.length) {
    console.error("landings.json no tiene páginas");
    process.exit(1);
  }
  const roots = writeRoots(pages);
  console.log(`OK: ${pages.length} landings SEO en ${roots.join(" y ")}`);
}

main();
