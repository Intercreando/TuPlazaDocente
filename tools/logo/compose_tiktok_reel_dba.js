/**
 * Reel 9:16 (1080×1920) del caso DBA/EBC: respuesta C + argumento + CTA.
 */
const fs = require('fs');
const path = require('path');
const { Resvg } = require('@resvg/resvg-js');

const root = path.resolve(__dirname, '..', '..');
const fontsDir = path.join(root, 'google_fonts');
const logoPath = path.join(root, 'assets', 'brand', 'logo.png');
const outDir = path.join(root, 'assets', 'brand', 'tiktok');

const W = 1080;
const H = 1920;

function wrap(text, maxChars) {
  const words = text.split(/\s+/);
  const lines = [];
  let cur = '';
  for (const word of words) {
    const next = cur ? `${cur} ${word}` : word;
    if (next.length > maxChars && cur) {
      lines.push(cur);
      cur = word;
    } else {
      cur = next;
    }
  }
  if (cur) lines.push(cur);
  return lines;
}

function textBlock(lines, { x, y, size, fill, family, weight, height = 1.2 }) {
  return lines
    .map(
      (line, i) =>
        `<text x="${x}" y="${y + i * size * height}" fill="${fill}" font-family="${family}" font-size="${size}" font-weight="${weight}">${escapeXml(line)}</text>`,
    )
    .join('\n');
}

function escapeXml(s) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function optionRow(letter, text, { x, y, w, highlight }) {
  const h = highlight ? 118 : 96;
  const bg = highlight ? '#0C2F2B' : '#FFFFFF';
  const border = highlight ? '#E3A008' : '#D5E3DE';
  const letterBg = highlight ? '#E3A008' : '#E8F2EE';
  const letterFill = highlight ? '#0C2F2B' : '#1F6B5C';
  const textFill = highlight ? '#F5F8F6' : '#12201E';
  const lines = wrap(text, highlight ? 32 : 36);
  return `
  <rect x="${x}" y="${y}" width="${w}" height="${h}" rx="22" fill="${bg}" stroke="${border}" stroke-width="${highlight ? 5 : 2}"/>
  <rect x="${x + 16}" y="${y + (h - 52) / 2}" width="52" height="52" rx="12" fill="${letterBg}"/>
  <text x="${x + 42}" y="${y + h / 2 + 12}" text-anchor="middle" fill="${letterFill}" font-family="Plus Jakarta Sans" font-size="28" font-weight="700">${letter}</text>
  ${textBlock(lines, {
    x: x + 84,
    y: y + (highlight ? 42 : 38),
    size: highlight ? 26 : 24,
    fill: textFill,
    family: 'Plus Jakarta Sans',
    weight: '700',
    height: 1.22,
  })}
  ${highlight ? `<text x="${x + w - 28}" y="${y + 38}" text-anchor="end" fill="#E3A008" font-family="Plus Jakarta Sans" font-size="22" font-weight="800">CORRECTA</text>` : ''}`;
}

const logoUri = `data:image/png;base64,${fs.readFileSync(logoPath).toString('base64')}`;

const hookLines = wrap('¿Plan de 1998? Así se cae el ítem.', 22);
const caseLines = wrap(
  'El plan cita lineamientos de 1998 e ignora DBA vigentes. La comunidad pide un arreglo visible; un colega dice “tratar a todos igual”.',
  42,
);
const whyLines = wrap(
  'C articula norma vigente y mediación: lineamientos + EBC/DBA en planeación y evaluación, con criterio trazable. A salta el grado. B niega otra vía de comprensión. D improvisa sin formalizar la competencia.',
  40,
);

const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}">
  <rect width="${W}" height="${H}" fill="#F5F8F6"/>
  <rect width="${W}" height="14" fill="#E3A008"/>
  <image href="${logoUri}" x="48" y="36" width="72" height="72"/>
  <text x="136" y="68" fill="#0C2F2B" font-family="Fraunces" font-size="30" font-weight="700">TuPlazaDocente</text>
  <text x="136" y="100" fill="#C48400" font-family="Plus Jakarta Sans" font-size="20" font-weight="700" letter-spacing="1.4">CONCURSO DOCENTE 2026</text>

  ${textBlock(hookLines, {
    x: 48,
    y: 168,
    size: 52,
    fill: '#0C2F2B',
    family: 'Fraunces',
    weight: '700',
    height: 1.1,
  })}

  <rect x="48" y="292" width="984" height="168" rx="24" fill="#E8F2EE"/>
  ${textBlock(caseLines, {
    x: 72,
    y: 338,
    size: 26,
    fill: '#12201E',
    family: 'Plus Jakarta Sans',
    weight: '600',
    height: 1.28,
  })}

  ${textBlock(
    wrap('¿Qué decisión articula mejor norma vigente y mediación pedagógica?', 28),
    {
      x: 48,
      y: 500,
      size: 34,
      fill: '#0C2F2B',
      family: 'Fraunces',
      weight: '700',
      height: 1.14,
    },
  )}

  ${optionRow('A', 'Adelantar grado superior “por el concurso”, sin DBA del grado actual.', { x: 48, y: 600, w: 984, highlight: false })}
  ${optionRow('B', 'Una sola representación, aunque el estudiante evidencie otra vía.', { x: 48, y: 712, w: 984, highlight: false })}
  ${optionRow('C', 'Articular lineamientos + EBC/DBA en planeación y evaluación.', { x: 48, y: 824, w: 984, highlight: true })}
  ${optionRow('D', 'Actividades locales sueltas, sin formalizar la competencia del referente.', { x: 48, y: 958, w: 984, highlight: false })}

  <rect x="48" y="1080" width="984" height="300" rx="24" fill="#0C2F2B"/>
  <text x="72" y="1132" fill="#E3A008" font-family="Plus Jakarta Sans" font-size="22" font-weight="800" letter-spacing="1.6">POR QUÉ GANA C</text>
  ${textBlock(whyLines, {
    x: 72,
    y: 1178,
    size: 28,
    fill: '#F5F8F6',
    family: 'Plus Jakarta Sans',
    weight: '600',
    height: 1.28,
  })}

  <rect x="48" y="1412" width="984" height="196" rx="28" fill="#E3A008"/>
  <text x="540" y="1480" text-anchor="middle" fill="#0C2F2B" font-family="Fraunces" font-size="40" font-weight="700">Entrena el caso completo</text>
  <text x="540" y="1538" text-anchor="middle" fill="#0C2F2B" font-family="Plus Jakarta Sans" font-size="36" font-weight="800">tuplazadocente.com</text>
  <text x="540" y="1584" text-anchor="middle" fill="#163F3A" font-family="Plus Jakarta Sans" font-size="22" font-weight="700">Simulacros con explicación · gratis para empezar</text>

  <text x="540" y="1688" text-anchor="middle" fill="#6E807C" font-family="Plus Jakarta Sans" font-size="18" font-weight="600">Entrenamiento. No es un ítem oficial de la CNSC.</text>
  <text x="540" y="1728" text-anchor="middle" fill="#1F6B5C" font-family="Plus Jakarta Sans" font-size="20" font-weight="700">@tu_plazadocente</text>
</svg>`;

const resvg = new Resvg(Buffer.from(svg), {
  fitTo: { mode: 'width', value: W },
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
fs.mkdirSync(outDir, { recursive: true });
const png = resvg.render().asPng();
const out = path.join(outDir, 'reel-dba-ebc-respuesta-c.png');
fs.writeFileSync(out, png);
console.log('OK', out, png.length, `${W}x${H}`);
