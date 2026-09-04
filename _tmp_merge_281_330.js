const fs = require("fs");

const srcPath = "assets/seed/questions_v1.json";
const data = JSON.parse(fs.readFileSync(srcPath, "utf8"));
const items = data.items;

const outs = [
  "_tmp_out_281_290.json",
  "_tmp_out_291_300.json",
  "_tmp_out_301_310.json",
  "_tmp_out_311_320.json",
  "_tmp_out_321_330.json",
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

const slice = items.slice(280, 330);
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
  if (
    item.correctIndex !== before.correctIndex ||
    item.difficulty !== before.difficulty ||
    item.dificultad !== before.dificultad ||
    item.stem !== before.stem ||
    item.caseContext !== before.caseContext
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

const pool = slice.map((_, i) => i);
let s = 281330;
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
    pos: 281 + i,
    id: x.id,
    caseContext: x.caseContext,
    stem: x.stem,
    options: x.options,
    correctIndex: x.correctIndex,
    explanation: x.explanation,
    distractorAnalysis: x.distractorAnalysis,
  };
});
fs.writeFileSync("_tmp_qc_sample_281_330.json", JSON.stringify(sample, null, 2) + "\n", "utf8");
console.log("QC", sample.map((x) => x.pos + " " + x.id).join(", "));
