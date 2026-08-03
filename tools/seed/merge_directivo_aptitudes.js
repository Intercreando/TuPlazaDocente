/**
 * Fusiona los 100 ítems Directivo (Aptitudes) en questions_v1.json
 * y genera el banco Dart local (extras).
 *
 * Uso: node tools/seed/merge_directivo_aptitudes.js
 */
const fs = require("fs");
const path = require("path");
const {letterIndex} = require("./gold_handcrafted_core");
const {raw} = require("./directivo_aptitudes_part6");

const SEED_PATH = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");
const DART_DIR = path.join(__dirname, "..", "..", "lib", "data");

const KNOWN_CODES = new Set([
  "decreto1278",
  "decreto1860",
  "decreto1290",
  "decreto1421",
  "ley115",
  "ley1620",
  "guiaMen49",
  "guiaMen50",
  "guiaMen51",
  "piaget",
  "vygotsky",
  "ausubel",
  "bruner",
  "ebc",
  "dba",
  "lineamientos",
]);

/** Alias de tags del documento hacia códigos canónicos. */
const TAG_ALIAS = {
  guiaMen34: "ley115",
  ley715: "ley115",
  decreto1075: "decreto1860",
};

function moduleFor(item) {
  switch (item.pillar) {
    case "lecturaCritica":
      return "Lectura crítica";
    case "aptitudNumerica":
      return "Aptitud numérica";
    case "comportamental":
      return "Competencias comportamentales";
    default:
      if (item.module === "Gestión escolar") {
        return "Gestión institucional y PEI";
      }
      return "Pedagogía y evaluación formativa";
  }
}

function knowledgeTags(tags) {
  const out = [];
  for (const t of tags || []) {
    const code = TAG_ALIAS[t] || t;
    if (!KNOWN_CODES.has(code)) continue;
    out.push({code, focus: "Directivo · práctica"});
  }
  return out;
}

function distractors(options, correctLetter) {
  const correct = letterIndex(correctLetter);
  const map = {};
  options.forEach((_, i) => {
    if (i === correct) return;
    map[i] = "No se sostiene con el texto, la norma o el criterio de actuación adecuado.";
  });
  return map;
}

function toSeedItem(item) {
  const correctIndex = letterIndex(item.correct);
  const dif = item.dif ?? 2;
  return {
    id: item.id,
    pillar: item.pillar,
    topic: item.topic,
    module: moduleFor(item),
    subtopic: item.topic,
    targetCargo: "directivos",
    specialtyTags: ["directivos"],
    caseContext: item.caso || null,
    stem: item.stem,
    options: item.options,
    correctIndex,
    explanation: item.expl,
    normativeJustification: item.expl,
    theoreticalJustification: item.expl,
    distractorAnalysis: distractors(item.options, item.correct),
    knowledgeTags: knowledgeTags(item.tags),
    normativeRefs: knowledgeTags(item.tags).map((t) => t.code),
    difficulty: dif === 1 ? "basico" : dif === 3 ? "avanzado" : "intermedio",
    dificultad: dif,
    recommendedSeconds: dif === 1 ? 60 : dif === 3 ? 120 : 90,
    isCaseStudy: Boolean(item.caseStudy || item.caso),
    published: true,
    schemaVersion: 1,
  };
}

function normText(s) {
  return (s || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/\s+/g, " ")
      .trim();
}

function escapeDart(s) {
  return s
      .replace(/\\/g, "\\\\")
      .replace(/\$/g, "\\$")
      .replace(/'/g, "\\'")
      .replace(/\r?\n/g, "\\n");
}

function dartPillar(p) {
  return {
    lecturaCritica: "CompetencyPillar.lecturaCritica",
    aptitudNumerica: "CompetencyPillar.aptitudNumerica",
    comportamental: "CompetencyPillar.comportamental",
    pedagogico: "CompetencyPillar.pedagogico",
  }[p] || "CompetencyPillar.pedagogico";
}

function dartModule(item) {
  switch (item.pillar) {
    case "lecturaCritica":
      return "ContentModule.lecturaCritica";
    case "aptitudNumerica":
      return "ContentModule.aptitudNumerica";
    case "comportamental":
      return "ContentModule.comportamental";
    default:
      if (item.module === "Gestión escolar") {
        return "ContentModule.gestionInstitucional";
      }
      return "ContentModule.pedagogiaEvaluacion";
  }
}

function dartKnowledge(tags) {
  const codes = [];
  for (const t of tags || []) {
    const code = TAG_ALIAS[t] || t;
    if (!KNOWN_CODES.has(code)) continue;
    codes.push(
        `        KnowledgeTag(code: KnowledgeCode.${code}, articleOrFocus: 'Directivo'),`,
    );
  }
  if (codes.length === 0) return "";
  return `\n      knowledgeTags: [\n${codes.join("\n")}\n      ],`;
}

function toDartQuestion(item) {
  const correctIndex = letterIndex(item.correct);
  const dif = item.dif ?? 2;
  const diffEnum =
      dif === 1
          ? "QuestionDifficulty.basico"
          : dif === 3
              ? "QuestionDifficulty.avanzado"
              : "QuestionDifficulty.intermedio";
  const caso = item.caso
      ? `\n      caseContext: '${escapeDart(item.caso)}',`
      : "";
  const isCase = item.caseStudy || item.caso ? "true" : "false";
  const opts = item.options
      .map((o) => `        '${escapeDart(o)}',`)
      .join("\n");
  return `    Question(
      id: '${item.id}',
      pillar: ${dartPillar(item.pillar)},
      topic: '${escapeDart(item.topic)}',
      module: ${dartModule(item)},
      subtopic: '${escapeDart(item.module)}',
      targetCargo: Especialidad.directivos,
      specialtyTags: [Especialidad.directivos],${caso}
      stem: '${escapeDart(item.stem)}',
      options: [
${opts}
      ],
      correctIndex: ${correctIndex},
      explanation: '${escapeDart(item.expl)}',
      normativeJustification: '${escapeDart(item.expl)}',
      theoreticalJustification: '${escapeDart(item.expl)}',${dartKnowledge(item.tags)}
      difficulty: ${diffEnum},
      isCaseStudy: ${isCase},
    )`;
}

function itemNum(item) {
  const m = String(item.id).match(/(\d+)$/);
  return m ? Number(m[1]) : 0;
}

function writeDartBanks(items) {
  const groups = [
    {
      name: "lectura",
      className: "DirectivoAptitudesLecturaBank",
      filter: (i) => i.pillar === "lecturaCritica",
    },
    {
      name: "numerica",
      className: "DirectivoAptitudesNumericaBank",
      filter: (i) => i.pillar === "aptitudNumerica",
    },
    {
      name: "blandas",
      className: "DirectivoAptitudesBlandasBank",
      filter: (i) => i.pillar === "comportamental",
    },
    {
      name: "gestion",
      className: "DirectivoAptitudesGestionBank",
      filter: (i) => i.module === "Gestión escolar",
    },
    {
      name: "pedagogicas",
      className: "DirectivoAptitudesPedagogicasBank",
      filter: (i) => i.module === "Competencias pedagógicas",
    },
  ];

  const paths = [];
  const facadeImports = [];
  const facadeSpreads = [];

  for (const g of groups) {
    const subset = items.filter(g.filter);
    const waves = [
      {suffix: "", label: "ola 1", className: g.className, items: subset.filter((i) => itemNum(i) < 101)},
      {
        suffix: "_ola2",
        label: "ola 2",
        className: `${g.className}Ola2`,
        items: subset.filter((i) => itemNum(i) >= 101),
      },
    ];

    for (const w of waves) {
      if (w.items.length === 0) continue;
      const body = w.items.map(toDartQuestion).join(",\n");
      const content = `import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Directivo · ${g.name} · ${w.label} (${w.items.length} ítems). Elaboración propia estilo CNSC/ICFES.
abstract final class ${w.className} {
  static const List<Question> items = [
${body},
  ];
}
`;
      const fileName = `directivo_aptitudes_${g.name}${w.suffix}_bank.dart`;
      const out = path.join(DART_DIR, fileName);
      fs.writeFileSync(out, content, "utf8");
      paths.push(out);
      facadeImports.push(`import '${fileName}';`);
      facadeSpreads.push(`        ...${w.className}.items,`);
    }
  }

  const facade = `import '../models/question.dart';
${facadeImports.join("\n")}

/// Banco Directivo Docente — Aptitudes y Competencias Básicas (olas 1 y 2).
abstract final class DirectivoAptitudesBank {
  static List<Question> get items => [
${facadeSpreads.join("\n")}
      ];
}
`;
  const facadePath = path.join(DART_DIR, "directivo_aptitudes_bank.dart");
  fs.writeFileSync(facadePath, facade, "utf8");
  paths.push(facadePath);
  return paths;
}

function main() {
  if (raw.length !== 200) {
    console.error(`Se esperaban 200 ítems, hay ${raw.length}`);
    process.exit(1);
  }

  const ids = new Set(raw.map((r) => r.id));
  if (ids.size !== 200) {
    console.error("IDs duplicados en el lote Directivo");
    process.exit(1);
  }

  // Validar claves (muestra olas 1 y 2)
  const expected = {
    "dir-apt-num-21": 1,
    "dir-apt-num-23": 2,
    "dir-apt-num-121": 0,
    "dir-apt-num-124": 3,
    "dir-apt-num-139": 2,
    "dir-apt-lec-101": 0,
    "dir-apt-ges-161": 0,
    "dir-apt-ped-200": 3,
  };
  for (const [id, idx] of Object.entries(expected)) {
    const q = raw.find((r) => r.id === id);
    if (!q || letterIndex(q.correct) !== idx) {
      console.error(`Clave incorrecta en ${id}: got ${q && q.correct}`);
      process.exit(1);
    }
  }

  const seed = JSON.parse(fs.readFileSync(SEED_PATH, "utf8"));
  const existing = seed.items || [];

  // Rebuild limpio: quitar dir-apt-* previos y agregar lote actual
  const withoutPrev = existing.filter((i) => !String(i.id).startsWith("dir-apt-"));
  const finalItems = [...withoutPrev];
  let added = 0;
  let skippedDup = 0;
  for (const item of raw) {
    const stemN = normText(item.stem);
    const clash = withoutPrev.some((e) => normText(e.stem) === stemN);
    if (clash) {
      console.warn(`Duplicado por stem vs banco: ${item.id}`);
      skippedDup++;
      continue;
    }
    finalItems.push(toSeedItem(item));
    added++;
  }

  seed.items = finalItems;
  seed.count = finalItems.length;
  seed.version = (seed.version || 3) + 0.1;
  seed.directivoAptitudes = {
    added,
    skippedDup,
    generatedAt: new Date().toISOString(),
  };
  seed.generatedAt = new Date().toISOString();

  fs.writeFileSync(SEED_PATH, JSON.stringify(seed, null, 2), "utf8");

  const standalone = {
    version: 1,
    title: "Directivo Docente — Aptitudes y Competencias Básicas",
    count: added,
    items: finalItems.filter((i) => String(i.id).startsWith("dir-apt-")),
  };
  const standalonePath = path.join(
      path.dirname(SEED_PATH),
      "directivo_aptitudes_v1.json",
  );
  fs.writeFileSync(standalonePath, JSON.stringify(standalone, null, 2), "utf8");

  const dartPaths = writeDartBanks(raw);

  console.log(`OK: +${added} ítems Directivo → seed (${finalItems.length} total)`);
  console.log(`Omitidos/duplicados: ${skippedDup}`);
  console.log(`Standalone: ${standalonePath}`);
  console.log(`Dart:\n  ${dartPaths.join("\n  ")}`);
}

main();
