/**
 * Genera HTML estático de landings SEO (Google lee texto, no el canvas de Flutter).
 * Uso: node tools/generate_seo_landings.js
 */
const fs = require("fs");
const path = require("path");

const root = path.join(__dirname, "..");
const jsonPath = path.join(root, "assets", "seo", "landings.json");
const letters = ["A", "B", "C", "D", "E", "F"];

function esc(raw) {
  return String(raw ?? "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
}

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
  const links = related.map((r) =>
    `<a href="${esc(r.href)}">${esc(r.label)}</a>`,
  ).join("");
  return `<nav class="related" aria-label="Otras guías">${links}</nav>`;
}

function jsonLd(page) {
  const url = `https://www.tuplazadocente.com${page.path}`;
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
  const url = `https://www.tuplazadocente.com${page.path}`;
  const auth = `/auth?register=1&src=${encodeURIComponent(page.source || page.id)}`;
  const kind = page.kind === "quiz" ? "quiz" : "worked";
  const items = (page.items || []).map((it) => itemHtml(it, kind)).join("\n");
  const score = kind === "quiz"
    ? `<div class="score">Tu puntaje en esta muestra: <strong class="score-value">—</strong>. Abajo está el criterio de cada ítem.</div>`
    : "";
  return `<!DOCTYPE html>
<html lang="es-CO">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${esc(page.title)}</title>
  <meta name="description" content="${esc(page.description)}">
  <meta name="robots" content="index, follow, max-image-preview:large">
  <link rel="canonical" href="${url}">
  <link rel="alternate" hreflang="es-CO" href="${url}">
  <meta property="og:title" content="${esc(page.title)}">
  <meta property="og:description" content="${esc(page.description)}">
  <meta property="og:type" content="article">
  <meta property="og:locale" content="es_CO">
  <meta property="og:url" content="${url}">
  <meta property="og:image" content="https://www.tuplazadocente.com/icons/Icon-512.png?v=2">
  <meta name="theme-color" content="#0C2F2B">
  <link rel="icon" type="image/png" href="/favicon.png?v=2">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@600;700&family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/seo/landing.css">
  <script type="application/ld+json">${jsonLd(page)}</script>
  <script async src="https://www.googletagmanager.com/gtag/js?id=AW-17037005824"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'AW-17037005824');
  </script>
  <script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
  n.queue=[];t=b.createElement(e);t.async=!0;
  t.src=v;s=b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t,s)}(window, document,'script',
  'https://connect.facebook.net/en_US/fbevents.js');
  fbq('init', '1565041928197797');
  fbq('track', 'PageView');
  </script>
  <script>
    (function () {
      try {
        var q = new URLSearchParams(location.search);
        var src = (q.get('utm_source') || '').toLowerCase();
        var med = (q.get('utm_medium') || '').toLowerCase();
        var paid = q.has('fbclid') || q.has('gclid') || q.has('gbraid') ||
          q.has('wbraid') || q.has('ttclid') ||
          src === 'facebook' || src === 'instagram' || src === 'fb' ||
          src === 'ig' || src === 'meta' || src === 'anuncios' ||
          src === 'google' || src === 'googleads' || src === 'adwords' ||
          med === 'cpc' || med === 'ppc' || med === 'paid' ||
          med === 'paid_social' || med === 'display' || med === 'cpm' ||
          med === 'paid_search';
        if (paid) {
          sessionStorage.setItem('tpd_paid_traffic', '1');
          try { localStorage.setItem('tpd_paid_claim_at', String(Date.now())); } catch (e2) {}
        }
      } catch (e) {}
    })();
  </script>
</head>
<body>
  <header class="top">
    <div class="wrap">
      <a class="brand" href="/">
        <img src="/icons/Icon-192.png?v=2" alt="">
        <div>
          <strong>TuPlazaDocente</strong>
          <span>Entrenador del Concurso Docente</span>
        </div>
      </a>
    </div>
  </header>
  <main class="${kind}" data-landing="${esc(page.id)}">
    <div class="wrap">
      <header class="hero">
        <p class="kicker">${esc(page.kicker || "")}</p>
        <h1>${esc(page.h1)}</h1>
        <p class="lead">${esc(page.lead || "")}</p>
      </header>
      ${score}
      ${items}
      <section class="cta">
        <h2>${esc(page.ctaTitle || "")}</h2>
        <p>${esc(page.ctaBody || "")}</p>
        <a class="btn-gold" href="${auth}">${esc(page.ctaLabel || "Registrarme gratis")}</a>
      </section>
      ${relatedHtml(page.related)}
      ${faqHtml(page.faq)}
      <p class="disclaimer">
        TuPlazaDocente es un entrenador independiente. No somos la CNSC, el ICFES
        ni el Ministerio de Educación. Verifica siempre el acuerdo oficial de tu convocatoria.
      </p>
      <p class="foot">
        <a href="/">Inicio</a> ·
        <a href="/legal/terms">Términos</a> ·
        <a href="/legal/privacy">Privacidad</a>
      </p>
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
