# -*- coding: utf-8 -*-
import json
import random
from pathlib import Path

root = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
data = json.loads((root / "assets" / "seed" / "questions_v1.json").read_text(encoding="utf-8"))
lote = data["items"][680:730]
assert len(lote) == 50
rng = random.Random(20260914)
sample = rng.sample(lote, 5)
out = []
for it in sample:
    pos = next(i for i, x in enumerate(lote) if x["id"] == it["id"]) + 681
    out.append(
        {
            "pos": pos,
            "id": it["id"],
            "correctIndex": it["correctIndex"],
            "difficulty": it["difficulty"],
            "dificultad": it.get("dificultad"),
            "caseContext": it.get("caseContext"),
            "stem": it.get("stem"),
            "options": it.get("options"),
            "explanation": it.get("explanation"),
            "distractorAnalysis": it.get("distractorAnalysis"),
        }
    )
path = root / "_tmp_qa_sample_681_730.json"
path.write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8")
print("wave10", data.get("contestUpgradeWave10"))
print("sample ids", [x["id"] for x in out])
# freeze check vs input
src = json.loads((root / "_tmp_lote_681_730.json").read_text(encoding="utf-8"))
ok = 0
for a, b in zip(src, lote):
    assert a["id"] == b["id"]
    assert a["correctIndex"] == b["correctIndex"]
    assert a["difficulty"] == b["difficulty"]
    assert a["dificultad"] == b["dificultad"]
    assert a["caseContext"] == b["caseContext"]
    assert a["stem"] == b["stem"]
    ok += 1
print("frozen ok", ok)
