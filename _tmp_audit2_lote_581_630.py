# -*- coding: utf-8 -*-
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(581, 590), (591, 600), (601, 610), (611, 620), (621, 630)]
out = ROOT / "_tmp_audit_lote_581_630.txt"

originals = {}
for start, end in CHUNKS:
    for it in json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8")):
        originals[it["id"]] = it

lines = []
opt_norm = defaultdict(list)
first_person = re.compile(r"\b(Intervengo|Escucho|Me niego|Niego|Atiendo|Facilito|Modero|Diagnostico|Identifico|Como directivo)\b")

for start, end in CHUNKS:
    for dst in json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8")):
        src = originals[dst["id"]]
        ci = src["correctIndex"]
        lines.append(f"\n===== {src['pos']} {src['id']} ci={ci} {src['topic']} =====")
        lines.append(f"STEM: {src['stem']}")
        lines.append(f"CASE: {src['caseContext']}")
        for i, o in enumerate(dst["options"]):
            mark = ">>" if i == ci else "  "
            fp = " [1P]" if first_person.search(o) else ""
            lines.append(f"{mark} [{i}] ({len(o)}c){fp} {o}")
        lines.append("EXPL: " + dst["explanation"][:400])
        for k, v in dst["distractorAnalysis"].items():
            lines.append(f"DA{k}: {v[:280]}")
        for i, o in enumerate(dst["options"]):
            key = re.sub(r"\s+", " ", o.strip().lower())[:90]
            opt_norm[key].append((src["id"], i))

lines.append("\n===== DUPLICADOS =====")
dups = 0
for k, locs in sorted(opt_norm.items(), key=lambda x: -len(x[1])):
    if len(locs) > 1:
        dups += 1
        lines.append(f"{len(locs)} {locs} :: {k}")
lines.append(f"dup groups {dups}")

# voice mismatch: correct option person vs distractors
lines.append("\n===== VOZ (1P vs infinitivo) =====")
for start, end in CHUNKS:
    for dst in json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8")):
        src = originals[dst["id"]]
        flags = [bool(first_person.search(o)) for o in dst["options"]]
        if any(flags) and not all(flags):
            lines.append(f"MIXED VOICE {src['id']} ci={src['correctIndex']} flags={flags}")

out.write_text("\n".join(lines), encoding="utf-8")
print("wrote", out, "chars", out.stat().st_size)
