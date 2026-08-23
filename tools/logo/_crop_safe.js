const fs = require('fs');
const path = require('path');
const { Resvg } = require('@resvg/resvg-js');

const src = path.resolve(__dirname, '../../assets/brand/youtube/portada-2560x1440.png');
const uri = `data:image/png;base64,${fs.readFileSync(src).toString('base64')}`;
const svg = `<?xml version="1.0"?>
<svg xmlns="http://www.w3.org/2000/svg" width="1546" height="423">
  <image href="${uri}" x="-507" y="-508.5" width="2560" height="1440"/>
</svg>`;
const png = new Resvg(Buffer.from(svg), {
  fitTo: { mode: 'width', value: 1546 },
}).render().asPng();
const out = path.resolve(__dirname, '../../assets/brand/youtube/_crop-movil.png');
fs.writeFileSync(out, png);
console.log('OK', out, png.length);
