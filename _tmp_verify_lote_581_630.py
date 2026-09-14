# -*- coding: utf-8 -*-
import json
import random
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
data = json.loads((ROOT / "assets" / "seed" / "questions_v1.json").read_text(encoding="utf-8"))
lote = data["items"][580:630]
assert len(lote) == 50

originals = {}
for start, end in [(581, 590), (591, 600), (601, 610), (611, 620), (621, 630)]:
    for it in json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8")):
        originals[it["id"]] = it

errors = 0
for i, it in enumerate(lote):
    pos = 581 + i
    src = originals[it["id"]]
    for k in ("id", "correctIndex", "difficulty", "dificultad", "caseContext", "stem"):
        if it.get(k) != src.get(k):
            print("MISMATCH", pos, it["id"], k)
            errors += 1
    if it["options"] == src["options"]:
        print("OPTIONS UNCHANGED", pos, it["id"])
        errors += 1
    if len(it["options"]) != 4:
        print("OPT LEN", pos)
        errors += 1
    if it.get("explanation") == src.get("explanation"):
        print("EXPL UNCHANGED", pos, it["id"])
        errors += 1

print("integrity_errors", errors)
print("wave8", data.get("contestUpgradeWave8"))
print("count", data.get("count"), "items", len(data["items"]))

rng = random.Random(581630)
sample = rng.sample(lote, 5)
sample.sort(key=lambda x: x["id"])
out = []
for it in sample:
    src = originals[it["id"]]
    pos = next(581 + i for i, x in enumerate(lote) if x["id"] == it["id"])
    out.append(
        {
            "pos": pos,
            "id": it["id"],
            "topic": it.get("topic"),
            "correctIndex": it["correctIndex"],
            "caseContext": it.get("caseContext"),
            "stem": it.get("stem"),
            "options": it["options"],
            "explanation": it["explanation"],
            "distractorAnalysis": it["distractorAnalysis"],
        }
    )

(ROOT / "_tmp_qa_sample_581_630.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8"
)
print("sample ids", [x["id"] for x in out])
