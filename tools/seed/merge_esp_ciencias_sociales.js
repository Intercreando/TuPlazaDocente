/**
 * Fusiona ola 6 (Ciencias + Sociales) en questions_v1.json y genera bancos Dart.
 * Uso: node tools/seed/merge_esp_ciencias_sociales.js
 */
const fs = require("fs");
const path = require("path");
const {ciencias} = require("./gold_wave6_ciencias");
const {sociales} = require("./gold_wave6_sociales");

const SEED_PATH = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");
const DART_DIR = path.join(__dirname, "..", "..", "lib", "data");

const wave6 = [...ciencias, ...sociales];

function normText(s) {
  return (s || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/\s+/g, " ")
      .trim();
}

function escapeDart(s) {
  return (s || "")
      .replace(/\\/g, "\\\\")
      .replace(/\$/g, "\\$")
      .replace(/'/g, "\\'")
      .replace(/\r?\n/g, "\\n");
}

function knowledgeCode(code) {
  const known = new Set([
    "decreto1278", "decreto1860", "decreto1290", "decreto1421",
    "ley115", "ley1620", "guiaMen49", "guiaMen50", "guiaMen51",
    "piaget", "vygotsky", "ausubel", "bruner", "ebc", "dba", "lineamientos",
  ]);
  return known.has(code) ? code : null;
}

function toDartQuestion(item) {
  const difficulty =
      item.dificultad === 1
          ? "QuestionDifficulty.basico"
          : item.dificultad === 3
              ? "QuestionDifficulty.avanzado"
              : "QuestionDifficulty.intermedio";
  const cargo = item.targetCargo || (item.specialtyTags || [])[0] || "primaria";
  const tags = (item.specialtyTags || [cargo])
      .map((t) => `Especialidad.${t}`)
      .join(", ");
  const caso = item.caseContext
      ? `\n      caseContext: '${escapeDart(item.caseContext)}',`
      : "";
  const opts = (item.options || [])
      .map((o) => `        '${escapeDart(o)}',`)
      .join("\n");
  const kTags = (item.knowledgeTags || [])
      .map((t) => {
        const code = knowledgeCode(t.code);
        if (!code) return null;
        return `        KnowledgeTag(code: KnowledgeCode.${code}, articleOrFocus: '${escapeDart(t.focus || "")}'),`;
      })
      .filter(Boolean);
  const kBlock = kTags.length
      ? `\n      knowledgeTags: [\n${kTags.join("\n")}\n      ],`
      : "";
  const norma = item.normativeJustification || item.explanation || "";
  const theory = item.theoreticalJustification || item.explanation || "";
  return `    Question(
      id: '${item.id}',
      pillar: CompetencyPillar.pedagogico,
      topic: '${escapeDart(item.topic || item.subtopic || "")}',
      module: ContentModule.curriculumReferentes,
      subtopic: '${escapeDart(item.subtopic || "")}',
      targetCargo: Especialidad.${cargo},
      specialtyTags: [${tags}],${caso}
      stem: '${escapeDart(item.stem)}',
      options: [
${opts}
      ],
      correctIndex: ${item.correctIndex},
      explanation: '${escapeDart(item.explanation || norma)}',
      normativeJustification: '${escapeDart(norma)}',
      theoreticalJustification: '${escapeDart(theory)}',${kBlock}
      difficulty: ${difficulty},
      isCaseStudy: ${item.isCaseStudy ? "true" : "false"},
    )`;
}

function writeDartBank(items, fileName, className, label) {
  const body = items.map(toDartQuestion).join(",\n");
  const content = `import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// ${label} (${items.length} ítems oro). Elaboración propia estilo CNSC/ICFES.
abstract final class ${className} {
  static const List<Question> items = [
${body},
  ];
}
`;
  const out = path.join(DART_DIR, fileName);
  fs.writeFileSync(out, content, "utf8");
  return out;
}

function main() {
  if (wave6.length !== 64) {
    console.error(`Se esperaban 64 ítems, hay ${wave6.length}`);
    process.exit(1);
  }
  const ids = new Set(wave6.map((q) => q.id));
  if (ids.size !== 64) {
    console.error("IDs duplicados en ola 6");
    process.exit(1);
  }

  const seed = JSON.parse(fs.readFileSync(SEED_PATH, "utf8"));
  const existing = seed.items || [];
  const withoutPrev = existing.filter(
      (i) => !String(i.id).startsWith("oro-cie-") && !String(i.id).startsWith("oro-soc-"),
  );
  const existingStems = new Set(withoutPrev.map((i) => normText(i.stem)));

  let added = 0;
  let skipped = 0;
  const finalItems = [...withoutPrev];
  for (const item of wave6) {
    if (existingStems.has(normText(item.stem))) {
      console.warn(`Stem duplicado, se omite: ${item.id}`);
      skipped++;
      continue;
    }
    finalItems.push(item);
    added++;
  }

  seed.items = finalItems;
  seed.count = finalItems.length;
  seed.generatedAt = new Date().toISOString();
  seed.wave6CienciasSociales = {
    added,
    skipped,
    ciencias: ciencias.length,
    sociales: sociales.length,
    generatedAt: seed.generatedAt,
  };
  fs.writeFileSync(SEED_PATH, JSON.stringify(seed, null, 2), "utf8");

  const ciePath = writeDartBank(
      ciencias,
      "ciencias_brain_bank.dart",
      "CienciasBrainBank",
      "Ciencias Naturales",
  );
  const socPath = writeDartBank(
      sociales,
      "sociales_brain_bank.dart",
      "SocialesBrainBank",
      "Ciencias Sociales",
  );

  console.log(`OK: +${added} (omitidos ${skipped}) → seed ${finalItems.length}`);
  console.log(`Dart: ${ciePath}`);
  console.log(`Dart: ${socPath}`);
  console.log(`Ciencias tag ahora: ${finalItems.filter((i) => (i.specialtyTags || []).includes("ciencias")).length}`);
  console.log(`Sociales tag ahora: ${finalItems.filter((i) => (i.specialtyTags || []).includes("sociales")).length}`);
}

main();
