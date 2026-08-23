/**
 * Compone la portada de YouTube 2560×1440 con marca en la zona segura móvil.
 */
const fs = require('fs');
const path = require('path');
const { Resvg } = require('@resvg/resvg-js');

const root = path.resolve(__dirname, '..', '..');
const outDir = path.join(root, 'assets', 'brand', 'youtube');
const fontsDir = path.join(root, 'google_fonts');

const CANVAS_W = 2560;
const CANVAS_H = 1440;
const SAFE_W = 1546;
const SAFE_H = 423;
const SAFE_X = (CANVAS_W - SAFE_W) / 2;
const SAFE_Y = (CANVAS_H - SAFE_H) / 2;

const bgLocal = path.join(outDir, 'fondo-aula.png');
const bgCursor = path.join(
  process.env.USERPROFILE || '',
  '.cursor',
  'projects',
  'c-Users-MSI-Documents-Proyectos-TuPlazaDocente',
  'assets',
  'youtube-banner-fondo-tuplazadocente.png',
);
const bgSrc = fs.existsSync(bgLocal) ? bgLocal : bgCursor;
const logoPath = path.join(root, 'assets', 'brand', 'logo.png');

function dataUri(filePath) {
  const buf = fs.readFileSync(filePath);
  return `data:image/png;base64,${buf.toString('base64')}`;
}

function renderSvg(svg, outRel) {
  const resvg = new Resvg(Buffer.from(svg), {
    fitTo: { mode: 'width', value: CANVAS_W },
    font: {
      fontFiles: [
        path.join(fontsDir, 'Fraunces-Bold.ttf'),
        path.join(fontsDir, 'PlusJakartaSans-Bold.ttf'),
        path.join(fontsDir, 'PlusJakartaSans-SemiBold.ttf'),
        path.join(fontsDir, 'PlusJakartaSans-Regular.ttf'),
      ],
      defaultFontFamily: 'Plus Jakarta Sans',
      loadSystemFonts: false,
    },
  });
  const png = resvg.render().asPng();
  const out = path.join(root, outRel);
  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, png);
  console.log('OK', outRel, png.length, `${CANVAS_W}x${CANVAS_H}`);
}

function socialIconTikTok(x, y, size) {
  const s = size / 24;
  return `<g transform="translate(${x}, ${y}) scale(${s})">
    <circle cx="12" cy="12" r="11" fill="#E3A008"/>
    <path fill="#0C2F2B" d="M14.8 7.1c.55.86 1.35 1.55 2.3 1.94v1.72a5.4 5.4 0 0 1-2.3-.62v4.36a3.55 3.55 0 1 1-3.04-3.51v1.8a1.8 1.8 0 1 0 1.24 1.71V6.2h1.8v.9z"/>
  </g>`;
}

function socialIconFacebook(x, y, size) {
  const s = size / 24;
  return `<g transform="translate(${x}, ${y}) scale(${s})">
    <circle cx="12" cy="12" r="11" fill="#E3A008"/>
    <path fill="#0C2F2B" d="M13.4 12.7h1.85l.3-2.15H13.4V9.2c0-.62.2-1.05 1.12-1.05H15.7V6.22A15.4 15.4 0 0 0 13.7 6c-1.95 0-3.28 1.16-3.28 3.3v1.25H8.7v2.15h1.72V18h1.98v-5.3z"/>
  </g>`;
}

function bannerSvg({ guides }) {
  const bg = dataUri(bgSrc);
  const logo = dataUri(logoPath);
  // Lockup a casi todo el alto de 423 px, con margen de 22 px para el recorte de YouTube.
  const inset = 22;
  const logoSize = 378;
  const gap = 36;
  const groupH = logoSize;
  const groupW = SAFE_W - inset * 2;
  const groupX = SAFE_X + inset;
  const groupY = SAFE_Y + (SAFE_H - groupH) / 2;
  const textX = groupX + logoSize + gap;
  const textY = groupY + 18;
  const iconSize = 44;
  const socialY = textY + 292;
  const tiktokX = textX;
  const tiktokTextX = tiktokX + iconSize + 12;
  const facebookX = tiktokTextX + 320;
  const facebookTextX = facebookX + iconSize + 12;

  const guideLayer = guides
    ? `
    <rect x="0" y="0" width="${CANVAS_W}" height="${SAFE_Y}" fill="#000" opacity="0.42"/>
    <rect x="0" y="${SAFE_Y + SAFE_H}" width="${CANVAS_W}" height="${SAFE_Y}" fill="#000" opacity="0.42"/>
    <rect x="0" y="${SAFE_Y}" width="${CANVAS_W}" height="${SAFE_H}" fill="none" stroke="#FFFFFF" stroke-width="4"/>
    <rect x="${SAFE_X}" y="${SAFE_Y}" width="${SAFE_W}" height="${SAFE_H}" fill="none" stroke="#E3A008" stroke-width="6"/>
    <text x="48" y="64" fill="#FFFFFF" font-family="Plus Jakarta Sans" font-size="36" font-weight="700">TV 2560×1440</text>
    <text x="48" y="${SAFE_Y - 18}" fill="#FFFFFF" font-family="Plus Jakarta Sans" font-size="32" font-weight="600">PC 2560×423</text>
    <text x="${SAFE_X}" y="${SAFE_Y - 18}" fill="#E3A008" font-family="Plus Jakarta Sans" font-size="28" font-weight="700">Móvil (zona segura) 1546×423</text>
    `
    : '';

  return `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${CANVAS_W}" height="${CANVAS_H}" viewBox="0 0 ${CANVAS_W} ${CANVAS_H}">
  <image href="${bg}" x="0" y="0" width="${CANVAS_W}" height="${CANVAS_H}" preserveAspectRatio="xMidYMid slice"/>
  <defs>
    <clipPath id="logoRound">
      <rect x="${groupX}" y="${groupY}" width="${logoSize}" height="${logoSize}" rx="72"/>
    </clipPath>
  </defs>
  <image href="${logo}" x="${groupX}" y="${groupY}" width="${logoSize}" height="${logoSize}" clip-path="url(#logoRound)"/>
  <text x="${textX}" y="${textY + 78}" fill="#F5F8F6" font-family="Fraunces" font-size="92" font-weight="700">TuPlazaDocente</text>
  <rect x="${textX}" y="${textY + 96}" width="168" height="5" rx="2" fill="#E3A008"/>
  <text x="${textX}" y="${textY + 148}" fill="#E3A008" font-family="Plus Jakarta Sans" font-size="36" font-weight="700">Entrenador del concurso magisterio</text>
  <text x="${textX}" y="${textY + 198}" fill="#E8F2EE" font-family="Plus Jakarta Sans" font-size="32" font-weight="600">Entrena inteligente y asegura tu plaza</text>
  <text x="${textX}" y="${textY + 250}" fill="#E3A008" font-family="Plus Jakarta Sans" font-size="34" font-weight="700">www.tuplazadocente.com</text>
  ${socialIconTikTok(tiktokX, socialY, iconSize)}
  <text x="${tiktokTextX}" y="${socialY + 32}" fill="#F5F8F6" font-family="Plus Jakarta Sans" font-size="30" font-weight="700">@tu_plazadocente</text>
  ${socialIconFacebook(facebookX, socialY, iconSize)}
  <text x="${facebookTextX}" y="${socialY + 32}" fill="#F5F8F6" font-family="Plus Jakarta Sans" font-size="30" font-weight="700">TuPlazaDocente</text>
  ${guideLayer}
</svg>`;
}

if (!fs.existsSync(bgSrc)) {
  console.error('No está el fondo generado:', bgSrc);
  process.exit(1);
}

fs.mkdirSync(outDir, { recursive: true });
fs.copyFileSync(bgSrc, path.join(outDir, 'fondo-aula.png'));

renderSvg(bannerSvg({ guides: false }), 'assets/brand/youtube/portada-2560x1440.png');
renderSvg(bannerSvg({ guides: true }), 'assets/brand/youtube/portada-zonas-guia.png');
