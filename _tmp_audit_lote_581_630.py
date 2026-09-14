# -*- coding: utf-8 -*-
"""Auditoría semántica del lote 581-630: correcta vs original, duplicados, trampas obvias."""
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(581, 590), (591, 600), (601, 610), (611, 620), (621, 630)]
OBVIOUS = re.compile(
    r"(ignorar|sin planear|aunque rompa|para que se note liderazgo|actividad recreativa|"
    r"eliminar toda evidencia|hacerlo sin)",
    re.I,
)
ABS = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.I,
)

originals = {}
for start, end in CHUNKS:
    for it in json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8")):
        originals[it["id"]] = it

rows = []
opt_norm = defaultdict(list)
for start, end in CHUNKS:
    for dst in json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8")):
        src = originals[dst["id"]]
        ci = src["correctIndex"]
        old_c = src["options"][ci]
        new_c = dst["options"][ci]
        rows.append((src["pos"], src["id"], ci, src["topic"], old_c, new_c, dst["options"]))
        for i, o in enumerate(dst["options"]):
            key = re.sub(r"\s+", " ", o.strip().lower())[:80]
            opt_norm[key].append((src["id"], i))

print("=== CORRECTA original -> nueva ===")
for pos, id_, ci, topic, old_c, new_c, _ in rows:
    print(f"\n[{pos}] {id_} ci={ci} ({topic})")
    print("  OLD:", old_c)
    print("  NEW:", new_c[:220])

print("\n=== DUPLICADOS de opciones (prefijo 80) ===")
dups = 0
for k, locs in opt_norm.items():
    if len(locs) > 1:
        dups += 1
        print(len(locs), locs, k[:70])
print("dup groups", dups)

print("\n=== FLAGS ===")
for pos, id_, ci, topic, old_c, new_c, opts in rows:
    for i, o in enumerate(opts):
        if i != ci and ABS.search(o):
            print("ABS", id_, i, ABS.search(o).group(0))
        if OBVIOUS.search(o):
            print("OBV", id_, i, OBVIOUS.search(o).group(0))
        if len(o) > 320:
            print("LONG", id_, i, len(o))
        if len(o) < 100:
            print("SHORTISH", id_, i, len(o))
