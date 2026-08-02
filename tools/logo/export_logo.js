/**
 * Genera PNGs del logo SVG para marca Flutter y PWA web.
 */
const fs = require('fs');
const path = require('path');
const { Resvg } = require('@resvg/resvg-js');

const root = path.resolve(__dirname, '..', '..');
const svgPath = path.join(root, 'assets', 'brand', 'logo.svg');
const svg = fs.readFileSync(svgPath);

function render(size) {
  const resvg = new Resvg(svg, {
    fitTo: { mode: 'width', value: size },
    background: 'rgba(0,0,0,0)',
  });
  return resvg.render().asPng();
}

/** Icono maskable: logo centrado con margen seguro (~20%). */
function renderMaskable(size) {
  const inner = Math.round(size * 0.72);
  const logoPng = render(inner);
  // Compone sobre canvas verde marca (#0C2F2B) con el logo centrado.
  // Resvg no compone PNG sobre PNG fácilmente; renderizamos SVG envuelto.
  const pad = ((size - inner) / 2).toFixed(2);
  const wrapped = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${size}" height="${size}" viewBox="0 0 ${size} ${size}">
  <rect width="${size}" height="${size}" rx="${(size * 0.18).toFixed(2)}" fill="#0C2F2B"/>
  <image href="data:image/png;base64,${Buffer.from(logoPng).toString('base64')}"
    x="${pad}" y="${pad}" width="${inner}" height="${inner}" />
</svg>`;
  const resvg = new Resvg(Buffer.from(wrapped), {
    fitTo: { mode: 'width', value: size },
  });
  return resvg.render().asPng();
}

function write(rel, buf) {
  const out = path.join(root, rel);
  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, buf);
  console.log('OK', rel, buf.length);
}

write('assets/brand/logo.png', render(1024));
write('assets/brand/logo-mark.png', render(1024));
write('web/icons/Icon-192.png', render(192));
write('web/icons/Icon-512.png', render(512));
write('web/icons/Icon-maskable-192.png', renderMaskable(192));
write('web/icons/Icon-maskable-512.png', renderMaskable(512));
write('web/favicon.png', render(48));

console.log('Logo exportado.');
