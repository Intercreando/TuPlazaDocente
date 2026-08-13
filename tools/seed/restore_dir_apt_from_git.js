/**
 * Restaura ítems disciplinares/dir-apt corrompidos (distractores de aula
 * mezclados con respuestas de contenido) desde HEAD de git, y les pone caso.
 *
 *   node tools/seed/restore_dir_apt_from_git.js
 */
const {execSync} = require("child_process");
const fs = require("fs");
const path = require("path");

const SEED = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");
const KEEP_HAND = new Set([
  "dir-apt-dis-274",
  "dir-apt-dis-376",
  "dir-apt-ges-162",
  "dir-apt-ges-62",
  "dir-apt-ges-63",
  "dir-apt-ges-67",
  "dir-apt-ges-69",
  "dir-apt-ges-73",
  "dir-apt-ges-75",
  "dir-apt-ped-94",
  "dir-apt-ped-95",
  "dir-apt-ped-82",
  "dir-apt-ped-182",
  "dir-apt-ges-171",
  "oro-1290-01",
]);

const raw = execSync("git show HEAD:assets/seed/questions_v1.json", {
  encoding: "utf8",
  maxBuffer: 20 * 1024 * 1024,
});
const headItems = JSON.parse(raw).items || [];
const origById = new Map(headItems.map((i) => [i.id, i]));

const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
const MIX = /recurso viral|producto final memorístico|tratar a todos por igual|actividad recreativa/;
const BROKEN_STEM = /episodio descrito/;

let restored = 0;
payload.items = payload.items.map((item) => {
  const orig = origById.get(item.id);
  if (!orig || KEEP_HAND.has(item.id)) return item;

  const dis = String(item.id).startsWith("dir-apt-dis-");
  const broken =
    BROKEN_STEM.test(item.stem || "") &&
    (!item.caseContext || String(item.caseContext).length < 40);
  const mixed = (item.options || []).some((o) => MIX.test(String(o))) &&
    !(orig.options || []).some((o) => MIX.test(String(o)));

  if (!dis && !broken && !mixed) return item;

  restored += 1;
  return {
    ...item,
    stem: orig.stem,
    options: orig.options,
    correctIndex: orig.correctIndex,
    explanation: orig.explanation,
    normativeJustification: orig.normativeJustification || orig.explanation,
    theoreticalJustification: orig.theoreticalJustification || orig.explanation,
    distractorAnalysis: orig.distractorAnalysis || item.distractorAnalysis,
    caseContext:
      `En una IE oficial hay desacuerdo sobre este punto: ${orig.stem} ` +
      `Un actor propone resolverlo por costumbre o por circular, sin criterio público.`,
    isCaseStudy: true,
    qualityHardened: true,
  };
});

payload.generatedAt = new Date().toISOString();
fs.writeFileSync(SEED, JSON.stringify(payload, null, 2), "utf8");
console.log(`OK: restaurados ${restored} ítems desde git + caso de desacuerdo`);
