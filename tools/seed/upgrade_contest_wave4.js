/**
 * Ola 4: casos reales para dir-apt-ges/ped sin caso; destapar envoltorios
 * genéricos (oro/fs/lectura/comportamental) sin reescribir ítems invertidos.
 *
 *   node tools/seed/upgrade_contest_wave4.js
 */
const {execSync} = require("child_process");
const fs = require("fs");
const path = require("path");
const {HAND_GES} = require("./wave4_ges_cases");
const {HAND_PED_A} = require("./wave4_ped_cases_a");
const {HAND_PED_B} = require("./wave4_ped_cases_b");
const {repairFsPed} = require("./fs_ped_cases");
const {isInvertedStem, uniqueOptions} = require("./cns_c_near_miss");

const SEED = path.join(__dirname, "..", "..", "assets", "seed", "questions_v1.json");
const HAND = {
  ...HAND_GES,
  ...HAND_PED_A,
  ...HAND_PED_B,
  "oro-1290-01": {
    caseContext:
      "Una docente de 5° cierra el periodo con el promedio de cuatro quizzes cronometrados. No hubo rúbricas previas ni devolución durante las semanas. El consejo de padres pide “más rigor” y un colega sugiere no cambiar nada “para que sea igual para todos”. El SIEE institucional habla de evaluación formativa.",
    stem:
      "¿Qué decisión articula una evaluación al servicio del aprendizaje, sin caer en rigor vacío ni en flexibilidad sin evidencia?",
  },
};

const META_STEM_RE =
  /ítem CNSC|Si debieras argumentar|episodio descrito|Cuál respuesta evita|Si debieras intervenir|evaluando proporcionalidad, trazabilidad/i;

function loadGitOrig() {
  try {
    const raw = execSync("git show HEAD:assets/seed/questions_v1.json", {
      encoding: "utf8",
      maxBuffer: 20 * 1024 * 1024,
    });
    const items = JSON.parse(raw).items || [];
    return new Map(items.map((i) => [i.id, i]));
  } catch (_) {
    return new Map();
  }
}

function isGenericCase(ctx) {
  return /desacuerdo sobre este punto|desacuerdo sobre competencias/i.test(
      String(ctx || ""),
  );
}

function isRealCase(ctx) {
  const s = String(ctx || "").trim();
  return s.length >= 70 && !isGenericCase(s);
}

function distFor(item, message) {
  const dist = {};
  const ci = Number(item.correctIndex);
  (item.options || []).forEach((_, i) => {
    if (i === ci) return;
    dist[String(i)] = message;
  });
  return dist;
}

function applyHand(item) {
  const hand = HAND[item.id];
  if (!hand) return item;
  const next = {
    ...item,
    ...hand,
    isCaseStudy: true,
    qualityHardened: true,
    difficulty: "avanzado",
    dificultad: 3,
  };
  if (hand.explanation) {
    next.explanation = hand.explanation;
    next.normativeJustification = hand.explanation;
    next.theoreticalJustification = hand.explanation;
  }
  next.options = uniqueOptions(next.options || item.options);
  next.distractorAnalysis = distFor(
      next,
      "Propuesta plausible (instancia vecina, rigor vacío o flexibilidad sin evidencia) que no corresponde al marco del caso.",
  );
  return next;
}

function restoreInvertedStem(item, orig) {
  if (!orig) return item;
  if (!isInvertedStem(orig.stem)) return item;
  if (isInvertedStem(item.stem)) return item;
  const correct = String((item.options || [])[Number(item.correctIndex)] || "");
  const claveEsBuenaPractica =
    /conservar evidencia|ajustes razonables|PIAR|andamiaje|criterios conocidos|devolver a cada/i.test(
        correct,
    );
  if (claveEsBuenaPractica) return item;
  return {
    ...item,
    stem: orig.stem,
    correctIndex: orig.correctIndex,
    caseContext: isRealCase(orig.caseContext)
      ? orig.caseContext
      : item.caseContext,
    qualityHardened: true,
  };
}

function unstackWithGit(item, orig) {
  if (!isGenericCase(item.caseContext)) return item;
  if (HAND[item.id]) return item;

  if (item.pillar === "lecturaCritica") {
    if (!orig) {
      return {...item, caseContext: null, isCaseStudy: false};
    }
    return {
      ...item,
      caseContext: orig.caseContext || null,
      stem: orig.stem || item.stem,
      isCaseStudy: isRealCase(orig.caseContext),
      qualityHardened: true,
    };
  }

  if (item.pillar === "comportamental" && orig && orig.stem) {
    return {
      ...item,
      caseContext:
        `En una IE oficial, con presión de tiempo y varios actores, ocurre: ${orig.stem} ` +
        `Hay riesgo de escalar el conflicto, de simular o de vulnerar confidencialidad.`,
      qualityHardened: true,
      isCaseStudy: true,
    };
  }

  if (orig && isRealCase(orig.caseContext)) {
    let caseContext = String(orig.caseContext).trim();
    if (caseContext.length < 160) {
      caseContext +=
        " Un actor pide resolver por circular o por costumbre; otro exige criterio público y evidencia.";
    }
    const stem = isInvertedStem(orig.stem)
      ? orig.stem
      : (String(orig.stem || "").length >= 40 ? orig.stem : item.stem);
    return {
      ...item,
      caseContext,
      stem,
      isCaseStudy: true,
      qualityHardened: true,
    };
  }

  return wrapFromOptions(item, orig);
}

function polishMetaWrap(item) {
  const ctx = String(item.caseContext || "");
  if (!/el equipo discute /i.test(ctx)) return item;
  if (!META_STEM_RE.test(ctx)) return item;
  return wrapFromOptions(item, {stem: item.topic || item.module || ""});
}

function wrapFromOptions(item, orig) {
  const ci = Number(item.correctIndex);
  const opts = item.options || [];
  if (opts.length < 4) return item;
  const wrong = opts.filter((_, i) => i !== ci).map((o) => String(o).replace(/\s+/g, " ").trim().slice(0, 140));
  const topic = item.topic || item.module || "el referente del área";
  const buriedRaw = String(orig && orig.stem ? orig.stem : "").trim();
  const buried = META_STEM_RE.test(buriedRaw) ? "" : buriedRaw;
  const foco = buried && buried.length < 140 ? buried.replace(/:\s*$/, "") : topic;
  return {
    ...item,
    caseContext:
      `En una IE oficial el equipo discute ${foco}. ` +
      `Un actor propone: “${wrong[0]}”. Otro insiste: “${wrong[1]}”. ` +
      `Un tercero sugiere: “${wrong[2]}”. Se pide una decisión alineada al marco, con evidencia, no por circular.`,
    stem: isInvertedStem(item.stem)
      ? item.stem
      : isInvertedStem(buried)
        ? buried
        : (String(item.stem || "").length >= 80 &&
            !/episodio descrito|desacuerdo, ¿cuál lectura|ítem CNSC/i.test(item.stem)
          ? item.stem
          : "Con base en las propuestas en conflicto, ¿qué decisión es la más defendible pedagógica e institucionalmente?"),
    isCaseStudy: true,
    qualityHardened: true,
    distractorAnalysis: distFor(
        item,
        "Opción cercana o habitual que no articula el referente, la evidencia o la instancia del caso.",
    ),
  };
}

const gitOrig = loadGitOrig();
const payload = JSON.parse(fs.readFileSync(SEED, "utf8"));
const counts = {hand: 0, unstack: 0, fsped: 0, inverted: 0};

payload.items = payload.items.map((item) => {
  const orig = gitOrig.get(item.id);
  const before = JSON.stringify(item);
  let next = applyHand(item);
  if (JSON.stringify(next) !== before) counts.hand += 1;

  const afterHand = JSON.stringify(next);
  next = restoreInvertedStem(next, orig);
  if (JSON.stringify(next) !== afterHand) counts.inverted += 1;

  const afterInv = JSON.stringify(next);
  next = unstackWithGit(next, orig);
  if (JSON.stringify(next) !== afterInv) counts.unstack += 1;

  const afterUn = JSON.stringify(next);
  next = polishMetaWrap(next);
  if (JSON.stringify(next) !== afterUn) counts.unstack += 1;

  const afterMeta = JSON.stringify(next);
  next = repairFsPed(next);
  if (JSON.stringify(next) !== afterMeta) counts.fsped += 1;

  return next;
});

payload.version = 3.9;
payload.generatedAt = new Date().toISOString();
payload.contestUpgradeWave4 = {
  at: payload.generatedAt,
  ...counts,
  handIds: Object.keys(HAND).length,
};

fs.writeFileSync(SEED, JSON.stringify(payload, null, 2), "utf8");
console.log(
    `OK ola 4: HAND ${counts.hand}, invertidos ${counts.inverted}, destape ${counts.unstack}, fs-ped ${counts.fsped} → ${SEED}`,
);
