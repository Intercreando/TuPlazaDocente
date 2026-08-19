/**
 * Piezas de HTML compartidas por las páginas estáticas (landings y noticias).
 *
 * Google no lee el lienzo de Flutter, así que estas páginas se publican como
 * HTML plano. Al vivir en un solo módulo, la cabecera, la analítica y las
 * llamadas a la acción son idénticas en todas ellas.
 */
const SITE = "https://www.tuplazadocente.com";
const BRAND = "TuPlazaDocente";
const DEFAULT_IMAGE = `${SITE}/icons/Icon-512.png?v=2`;

function esc(raw) {
  return String(raw ?? "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
}

/** Recorta sin cortar palabras (para <title> y meta description). */
function clip(raw, max) {
  const text = String(raw ?? "").replace(/\s+/g, " ").trim();
  if (text.length <= max) return text;
  const cut = text.slice(0, max);
  const space = cut.lastIndexOf(" ");
  return `${(space > max * 0.6 ? cut.slice(0, space) : cut).trim()}…`;
}

/**
 * Título de la pestaña: la marca solo se añade si cabe, porque Google corta
 * alrededor de los 60 caracteres y un título cortado a mitad se ve peor.
 */
function pageTitle(raw) {
  const title = String(raw ?? "").replace(/\s+/g, " ").trim();
  if (title.length <= 44) return `${title} | ${BRAND}`;
  return clip(title, 66);
}

/**
 * Hosting redirige /ruta a /ruta/ con un 301, así que la forma canónica de una
 * página que vive en su propia carpeta lleva barra final.
 */
function canonicalPath(raw) {
  const path = String(raw || "/");
  if (path.endsWith("/")) return path;
  const last = path.split("/").pop();
  return last.includes(".") ? path : `${path}/`;
}

/**
 * La app web usa la estrategia de hash: sin "#" el router no ve la ruta y el
 * visitante cae en la portada. Todo enlace hacia la app pasa por aquí para que
 * el día que se migre a rutas sin "#" se cambie en un solo sitio.
 */
function appLink(route) {
  const clean = String(route || "/").replace(/^\/+/, "");
  return `/#/${clean}`;
}

/** Registro forzado: dispara CompleteRegistration, no entra como invitado. */
function authCta(source) {
  return appLink(`auth?register=1&src=${encodeURIComponent(source || "seo")}`);
}

/** Google Ads, Meta Pixel y marca de tráfico pagado (igual que en la app). */
function trackingScripts() {
  return `
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
  </script>`;
}

/**
 * Cabecera completa del documento.
 * @param {object} page título, descripción, ruta canónica, imagen y extras.
 */
function head(page) {
  const url = `${SITE}${canonicalPath(page.path)}`;
  const image = page.image || DEFAULT_IMAGE;
  const css = ["/seo/landing.css", ...(page.styles || [])];
  const links = css
      .map((href) => `  <link rel="stylesheet" href="${href}">`)
      .join("\n");
  return `<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${esc(page.title)}</title>
  <meta name="description" content="${esc(page.description)}">
  <meta name="robots" content="index, follow, max-image-preview:large">
  <link rel="canonical" href="${url}">
  <link rel="alternate" hreflang="es-CO" href="${url}">
  <meta property="og:title" content="${esc(page.title)}">
  <meta property="og:description" content="${esc(page.description)}">
  <meta property="og:type" content="${page.ogType || "article"}">
  <meta property="og:locale" content="es_CO">
  <meta property="og:url" content="${url}">
  <meta property="og:image" content="${esc(image)}">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="theme-color" content="#0C2F2B">
  <link rel="icon" type="image/png" href="/favicon.png?v=2">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@600;700&family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
${links}
  <script type="application/ld+json">${page.jsonLd}</script>${trackingScripts()}
</head>`;
}

function siteHeader() {
  return `  <header class="top">
    <div class="wrap">
      <a class="brand" href="/">
        <img src="/icons/Icon-192.png?v=2" alt="">
        <div>
          <strong>${BRAND}</strong>
          <span>Entrenador del Concurso Docente</span>
        </div>
      </a>
    </div>
  </header>`;
}

function ctaSection({title, body, label, source}) {
  return `      <section class="cta">
        <h2>${esc(title)}</h2>
        <p>${esc(body)}</p>
        <a class="btn-gold" href="${esc(authCta(source))}">${esc(label)}</a>
      </section>`;
}

function disclaimer() {
  return `      <p class="disclaimer">
        ${BRAND} es un entrenador independiente. No somos la CNSC, el ICFES
        ni el Ministerio de Educación. Verifica siempre el acuerdo oficial de tu convocatoria.
      </p>`;
}

function foot() {
  return `      <p class="foot">
        <a href="/">Inicio</a> ·
        <a href="/noticias/">Noticias</a> ·
        <a href="${appLink("legal/terms")}">Términos</a> ·
        <a href="${appLink("legal/privacy")}">Privacidad</a>
      </p>`;
}

module.exports = {
  SITE,
  BRAND,
  DEFAULT_IMAGE,
  esc,
  clip,
  pageTitle,
  canonicalPath,
  appLink,
  authCta,
  head,
  siteHeader,
  ctaSection,
  disclaimer,
  foot,
};
