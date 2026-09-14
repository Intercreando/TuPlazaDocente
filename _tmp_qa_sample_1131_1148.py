# -*- coding: utf-8 -*-
"""Verifica congelados y muestrea 3 ítems al azar del lote 1131-1148."""
import json
import random
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
seed = json.loads((ROOT / "assets" / "seed" / "questions_v1.json").read_text(encoding="utf-8"))
lote = seed["items"][1130:1148]
assert len(lote) == 18
assert len(seed["items"]) == 1148

src_all = []
for start, end in ((1131, 1140), (1141, 1148)):
    src_all.extend(json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8")))

assert [s["id"] for s in src_all] == [x["id"] for x in lote]

errors = []
for src, dst in zip(src_all, lote):
    tag = src["id"]
    for k in ("correctIndex", "difficulty", "dificultad", "caseContext", "stem"):
        if src.get(k) != dst.get(k):
            errors.append(f"FROZEN {tag} {k}")
    if dst.get("options") == src.get("options"):
        errors.append(f"OPTIONS UNCHANGED {tag}")
    if dst.get("explanation") == src.get("explanation"):
        errors.append(f"EXPL UNCHANGED {tag}")
    if "</user_query>" in json.dumps(dst, ensure_ascii=False):
        errors.append(f"GARBAGE {tag}")
    if dst.get("qualityHardened") is not True:
        errors.append(f"QH {tag}")

print("verify errors", len(errors))
for e in errors:
    print(e)
print("wave19", seed.get("contestUpgradeWave19"))
print("ids", [x["id"] for x in lote])

rng = random.Random(20260914)
sample = rng.sample(lote, 3)
out = []
for it in sample:
    out.append(
        {
            "id": it["id"],
            "correctIndex": it["correctIndex"],
            "difficulty": it["difficulty"],
            "dificultad": it["dificultad"],
            "caseContext": it["caseContext"],
            "stem": it["stem"],
            "options": it["options"],
            "explanation": it["explanation"],
            "distractorAnalysis": it["distractorAnalysis"],
        }
    )
(ROOT / "_tmp_qa_sample_1131_1148.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
)
print("sample ids", [x["id"] for x in out])
