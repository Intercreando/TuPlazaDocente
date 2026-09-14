# -*- coding: utf-8 -*-
"""Auditoría cualitativa rápida del lote 1031-1080."""
import json
import re
from pathlib import Path
from collections import Counter

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(1031, 1040), (1041, 1050), (1051, 1060), (1061, 1070), (1071, 1080)]
FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)

starts = Counter()
opt_starts = Counter()
issues = []
for a, b in CHUNKS:
    src = json.loads((ROOT / f"_tmp_in_{a}_{b}.json").read_text(encoding="utf-8"))
    dst = json.loads((ROOT / f"_tmp_out_{a}_{b}.json").read_text(encoding="utf-8"))
    for s, d in zip(src, dst):
        tag = d["id"]
        ci = s["correctIndex"]
        for i, o in enumerate(d["options"]):
            first = o.split()[0].lower()
            opt_starts[first] += 1
            if i != ci:
                if FORBIDDEN.search(o):
                    issues.append(f"FORB {tag} {i} {FORBIDDEN.search(o).group(0)}")
        for k, v in d["distractorAnalysis"].items():
            w = v.split()[:3]
            starts[" ".join(w)] += 1
        # correct option too similar to original short if original was short?
        orig = s["options"][ci]
        new = d["options"][ci]
        if orig[:40] == new[:40] and len(new) < 100:
            issues.append(f"CORRECT BARELY CHANGED {tag}")

print("DA openings (top):")
for k, v in starts.most_common(15):
    print(f"  {v:3d}  {k}")
print("Option first words (top):")
for k, v in opt_starts.most_common(20):
    print(f"  {v:3d}  {k}")
print("issues", len(issues))
for x in issues[:40]:
    print(x)
