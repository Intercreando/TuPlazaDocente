# -*- coding: utf-8 -*-
"""Parche de questions_v1.json (981-1030) según reglas_cnsc.md."""
import json
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(981, 990), (991, 1000), (1001, 1010), (1011, 1020), (1021, 1030)]
PATCH_KEYS = [
    "options",
    "explanation",
    "normativeJustification",
    "theoreticalJustification",
    "distractorAnalysis",
]


def main():
    r = subprocess.run(
        [sys.executable, str(ROOT / "_tmp_validate_lote_981_1030.py")],
        cwd=ROOT,
    )
    if r.returncode != 0:
        raise SystemExit("validator failed")

    upgrades = {}
    for start, end in CHUNKS:
        for it in json.loads(
            (ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8")
        ):
            upgrades[it["id"]] = it

    seed_path = ROOT / "assets" / "seed" / "questions_v1.json"
    data = json.loads(seed_path.read_text(encoding="utf-8"))
    lote = data["items"][980:1030]
    assert len(lote) == 50, len(lote)

    expected_ids = []
    for start, end in CHUNKS:
        for it in json.loads(
            (ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8")
        ):
            expected_ids.append(it["id"])
    actual_ids = [src["id"] for src in lote]
    assert actual_ids == expected_ids, list(zip(actual_ids, expected_ids))

    touched = []
    for src in lote:
        dst_item = upgrades[src["id"]]
        frozen = {
            "correctIndex": src["correctIndex"],
            "difficulty": src["difficulty"],
            "dificultad": src.get("dificultad"),
            "caseContext": src.get("caseContext"),
            "stem": src.get("stem"),
        }
        for k in PATCH_KEYS:
            src[k] = dst_item[k]
        assert src["correctIndex"] == frozen["correctIndex"]
        assert src["difficulty"] == frozen["difficulty"]
        assert src.get("dificultad") == frozen["dificultad"]
        assert src.get("caseContext") == frozen["caseContext"]
        assert src.get("stem") == frozen["stem"]
        src["qualityHardened"] = True
        touched.append(src["id"])

    data["contestUpgradeWave16"] = {
        "at": datetime.now(timezone.utc).isoformat(),
        "itemsTouched": 50,
        "range": "981-1030",
        "note": "reglas_cnsc.md: options/explanation/justifications/distractorAnalysis",
    }
    seed_path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print("patched", len(touched))
    print(",".join(touched))


if __name__ == "__main__":
    main()
