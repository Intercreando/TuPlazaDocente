# -*- coding: utf-8 -*-
import json
import re
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(831, 840), (841, 850), (851, 860), (861, 870), (871, 880)]
MUST = {
    "dir-apt-num-121": "1.332.000",
    "dir-apt-num-122": "5",
    "dir-apt-num-123": "12",
    "dir-apt-num-124": "75",
    "dir-apt-num-125": "408.000",
    "dir-apt-num-126": "24",
    "dir-apt-num-127": "20",
    "dir-apt-num-128": "4.500.000",
    "dir-apt-num-129": "399",
    "dir-apt-num-130": "880",
    "dir-apt-num-131": "4",
    "dir-apt-num-132": "300.000",
}
WEAK_DA = (
    "parece profesional o equitativa",
    "no se sostiene con el texto",
    "opcion cercana",
    "propuesta plausible (instancia",
)
TEMPLATE_OPT = (
    "aumentar el número de quizzes",
    "trámite de caritas",
    "adelantar contenidos de grados superiores",
)
FORB = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.I,
)
issues = []
for start, end in CHUNKS:
    srcs = json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8"))
    dsts = json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8"))
    assert [s["id"] for s in srcs] == [d["id"] for d in dsts]
    for src, dst in zip(srcs, dsts):
        cid = src["id"]
        ci = src["correctIndex"]
        opts = dst["options"]
        correct = opts[ci]
        must = MUST.get(cid)
        if must and must not in correct:
            issues.append(f"MISSING FIGURE {cid} {must!r} :: {correct[:140]}")
        da = " ".join((dst.get("distractorAnalysis") or {}).values()).lower()
        if any(w in da for w in WEAK_DA):
            issues.append(f"WEAK DA {cid}")
        blob = " ".join(opts).lower()
        if any(t in blob for t in TEMPLATE_OPT):
            issues.append(f"TEMPLATE {cid}")
        cruz = sum(
            1
            for v in dst["distractorAnalysis"].values()
            if "dominio cruzado" in v.lower()
        )
        if cruz != 1:
            issues.append(f"CRUZ {cid} {cruz}")
        for oi, opt in enumerate(opts):
            if oi != ci:
                m = FORB.search(opt)
                if m:
                    issues.append(f"FORB {cid} idx{oi} {m.group(0)}")
        safe = correct[:110].encode("ascii", "replace").decode("ascii")
        print(f"{cid}\tci={ci}\tcorr={safe}")
print("--- ISSUES ---")
for i in issues:
    print(i.encode("ascii", "replace").decode("ascii"))
print("issue count", len(issues))
