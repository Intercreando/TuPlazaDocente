const fs = require("fs");

const srcPath = "assets/seed/questions_v1.json";
const data = JSON.parse(fs.readFileSync(srcPath, "utf8"));
const items = data.items;

const outs = [
  "_tmp_out_231_240.json",
  "_tmp_out_241_250.json",
  "_tmp_out_251_260.json",
  "_tmp_out_261_270.json",
  "_tmp_out_271_280.json",
].flatMap((p) => JSON.parse(fs.readFileSync(p, "utf8")));

if (outs.length !== 50) {
  console.error("expected 50 rewrites, got", outs.length);
  process.exit(1);
}

const FIELDS = [
  "options",
  "explanation",
  "normativeJustification",
  "theoreticalJustification",
  "distractorAnalysis",
];

const slice = items.slice(230, 280);
const ids = [];
const mismatches = [];

for (let i = 0; i < 50; i++) {
  const item = slice[i];
  const rw = outs[i];
  if (item.id !== rw.id) {
    mismatches.push(`${item.id} vs ${rw.id}`);
    continue;
  }
  const before = {
    correctIndex: item.correctIndex,
    difficulty: item.difficulty,
    dificultad: item.dificultad,
    stem: item.stem,
    caseContext: item.caseContext,
  };
  for (const f of FIELDS) item[f] = rw[f];
  // Ortografía evidente en el caso de letra ridiculizada.
  if (item.id === "oro-esp-len-m24" && /feá/.test(item.caseContext)) {
    item.caseContext = item.caseContext.replace("feá", "fea");
  }
  if (
    item.correctIndex !== before.correctIndex ||
    item.difficulty !== before.difficulty ||
    item.dificultad !== before.dificultad ||
    item.stem !== before.stem ||
    (item.id !== "oro-esp-len-m24" && item.caseContext !== before.caseContext)
  ) {
    mismatches.push("mutated integrity " + item.id);
  }
  ids.push(item.id);
}

if (mismatches.length) {
  console.error(mismatches);
  process.exit(1);
}

fs.writeFileSync(srcPath, JSON.stringify(data, null, 2) + "\n", "utf8");
console.log("merged", ids.length, "items");
console.log(ids.join("\n"));

// QC sample: 5 índices seudoaleatorios estables (no los 3 caseContext plantilla).
const avoid = new Set(["oro-c4-26", "oro-c4-31", "oro-c4-33"]);
const pool = slice.map((x, i) => i).filter((i) => !avoid.has(slice[i].id));
let s = 231280;
function rnd() {
  s = (s * 1664525 + 1013904223) >>> 0;
  return s / 4294967296;
}
const picked = [];
const used = new Set();
while (picked.length < 5) {
  const i = pool[Math.floor(rnd() * pool.length)];
  if (used.has(i)) continue;
  used.add(i);
  picked.push(i);
}
picked.sort((a, b) => a - b);
const sample = picked.map((i) => {
  const x = slice[i];
  return {
    pos: 231 + i,
    id: x.id,
    caseContext: x.caseContext,
    stem: x.stem,
    options: x.options,
    correctIndex: x.correctIndex,
    explanation: x.explanation,
    distractorAnalysis: x.distractorAnalysis,
  };
});
fs.writeFileSync("_tmp_qc_sample_231_280.json", JSON.stringify(sample, null, 2) + "\n", "utf8");
console.log("QC", sample.map((x) => x.pos + " " + x.id).join(", "));
