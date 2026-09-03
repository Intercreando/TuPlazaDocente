const fs = require("fs");

const srcPath = "assets/seed/questions_v1.json";
const data = JSON.parse(fs.readFileSync(srcPath, "utf8"));
const items = data.items;

const outs = [
  "_tmp_out_181_190.json",
  "_tmp_out_191_200.json",
  "_tmp_out_201_210.json",
  "_tmp_out_211_220.json",
  "_tmp_out_221_230.json",
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

const slice = items.slice(180, 230);
const ids = [];
const mismatches = [];

for (let i = 0; i < 50; i++) {
  const item = slice[i];
  const rw = outs[i];
  if (item.id !== rw.id) {
    mismatches.push(`${item.id} vs ${rw.id}`);
    continue;
  }
  // integrity: do not touch correctIndex / difficulty
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
console.log(ids.join(", "));
