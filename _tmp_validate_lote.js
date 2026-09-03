const fs = require("fs");

const FORBIDDEN = /\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b/i;

const chunks = [
  ["_tmp_in_181_190.json", "_tmp_out_181_190.json"],
  ["_tmp_in_191_200.json", "_tmp_out_191_200.json"],
  ["_tmp_in_201_210.json", "_tmp_out_201_210.json"],
  ["_tmp_in_211_220.json", "_tmp_out_211_220.json"],
  ["_tmp_in_221_230.json", "_tmp_out_221_230.json"],
];

const keysOk = [
  "id",
  "options",
  "explanation",
  "normativeJustification",
  "theoreticalJustification",
  "distractorAnalysis",
];

let errors = 0;
const allOut = [];

for (const [inPath, outPath] of chunks) {
  if (!fs.existsSync(outPath)) {
    console.log("MISSING", outPath);
    errors++;
    continue;
  }
  const input = JSON.parse(fs.readFileSync(inPath, "utf8"));
  let output;
  try {
    output = JSON.parse(fs.readFileSync(outPath, "utf8"));
  } catch (e) {
    console.log("JSON ERROR", outPath, e.message);
    errors++;
    continue;
  }
  if (!Array.isArray(output) || output.length !== input.length) {
    console.log("COUNT", outPath, output && output.length, "expected", input.length);
    errors++;
  }
  input.forEach((src, i) => {
    const dst = output[i];
    const tag = `${outPath}[${i}] ${src.id}`;
    if (!dst) {
      console.log("NO ITEM", tag);
      errors++;
      return;
    }
    if (dst.id !== src.id) {
      console.log("ID MISMATCH", tag, "got", dst.id);
      errors++;
    }
    const extra = Object.keys(dst).filter((k) => !keysOk.includes(k));
    if (extra.length) {
      console.log("EXTRA KEYS", tag, extra.join(","));
      errors++;
    }
    for (const k of keysOk) {
      if (!(k in dst)) {
        console.log("MISSING KEY", tag, k);
        errors++;
      }
    }
    if (!Array.isArray(dst.options) || dst.options.length !== 4) {
      console.log("OPTIONS LEN", tag, dst.options && dst.options.length);
      errors++;
    } else {
      dst.options.forEach((opt, oi) => {
        if (typeof opt !== "string" || opt.trim().length < 40) {
          console.log("SHORT OPTION", tag, "idx", oi, (opt || "").length);
          errors++;
        }
        if (oi !== src.correctIndex && FORBIDDEN.test(opt)) {
          console.log("FORBIDDEN WORD", tag, "idx", oi, opt.match(FORBIDDEN)[0]);
          errors++;
        }
      });
    }
    const da = dst.distractorAnalysis || {};
    const daKeys = Object.keys(da).sort();
    const expected = [0, 1, 2, 3].filter((n) => n !== src.correctIndex).map(String).sort();
    if (daKeys.join(",") !== expected.join(",")) {
      console.log("DA KEYS", tag, daKeys.join(","), "expected", expected.join(","), "correctIndex", src.correctIndex);
      errors++;
    }
    if (typeof dst.explanation !== "string" || dst.explanation.length < 200) {
      console.log("SHORT EXPLANATION", tag, (dst.explanation || "").length);
      errors++;
    }
    allOut.push({ src, dst });
  });
}

console.log("---");
console.log("items validated", allOut.length);
console.log("errors", errors);
process.exit(errors ? 1 : 0);
