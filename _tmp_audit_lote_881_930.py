# -*- coding: utf-8 -*-
"""Auditoría rápida de cifras y tesis del lote 881-930."""
import json
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(881, 890), (891, 900), (901, 910), (911, 920), (921, 930)]

NEEDLE = {
    "dir-apt-num-133": "216",
    "dir-apt-num-134": "87",
    "dir-apt-num-135": "4h 20min",
    "dir-apt-num-136": "72",
    "dir-apt-num-137": "59.400.000",
    "dir-apt-num-138": "84",
    "dir-apt-num-139": "91%",
    "dir-apt-num-140": "480.000",
}

errors = 0
for start, end in CHUNKS:
    srcs = json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8"))
    dsts = json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8"))
    for src, dst in zip(srcs, dsts):
        ci = src["correctIndex"]
        opt = dst["options"][ci]
        nid = src["id"]
        if nid in NEEDLE and NEEDLE[nid] not in opt:
            print("MISSING FIGURE", nid, NEEDLE[nid], opt[:80])
            errors += 1
        da = dst["distractorAnalysis"]
        if str(ci) in da:
            print("DA HAS CI", nid, ci)
            errors += 1
        print(f"OK {nid} ci={ci} fig={'yes' if nid not in NEEDLE else NEEDLE[nid] in opt}")

print("audit errors", errors)
