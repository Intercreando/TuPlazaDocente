# -*- coding: utf-8 -*-
"""Auditoría semántica del lote 631-680."""
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(631, 640), (641, 650), (651, 660), (661, 670), (671, 680)]
OBVIOUS = re.compile(
    r"(ignorar|sin planear|aunque rompa|para que se note liderazgo|actividad recreativa|"
    r"eliminar toda evidencia|hacerlo sin|aunque parezca|aunque ahorre|aunque se presente)",
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
    path = ROOT / f"_tmp_out_{start}_{end}.json"
    for dst in json.loads(path.read_text(encoding="utf-8")):
        src = originals[dst["id"]]
        ci = src["correctIndex"]
        old_c = src["options"][ci]
        new_c = dst["options"][ci]
        rows.append((src["pos"], src["id"], ci, src["topic"], old_c, new_c, dst["options"], dst))
        for i, o in enumerate(dst["options"]):
            key = re.sub(r"\s+", " ", o.strip().lower())[:90]
            opt_norm[key].append((src["id"], i, len(o)))

print("=== LONGITUDES opciones ===")
for pos, id_, ci, topic, old_c, new_c, opts, _ in rows:
    lens = [len(o) for o in opts]
    print(f"{pos} {id_} {lens} spread={max(lens)-min(lens)}")

print("\n=== CORRECTA original -> nueva (primeros 160) ===")
for pos, id_, ci, topic, old_c, new_c, opts, _ in rows:
    print(f"\n[{pos}] {id_} ({topic})")
    print("  OLD:", old_c[:160])
    print("  NEW:", new_c[:200])

print("\n=== DUPLICADOS prefijo 90 ===")
dups = 0
for k, locs in opt_norm.items():
    if len(locs) > 1:
        dups += 1
        print(len(locs), locs, k[:80])
print("dup groups", dups)

print("\n=== FLAGS ===")
for pos, id_, ci, topic, old_c, new_c, opts, dst in rows:
    for i, o in enumerate(opts):
        if i != ci and ABS.search(o):
            print("ABS", id_, i, ABS.search(o).group(0))
        if OBVIOUS.search(o):
            print("OBV", id_, i, OBVIOUS.search(o).group(0))
        if len(o) > 320:
            print("LONG", id_, i, len(o))
        if len(o) < 100:
            print("SHORTISH", id_, i, len(o))
    expl = dst["explanation"]
    if "condición" not in expl.lower() and "calidad" not in expl.lower():
        # soft: many start with la condición de calidad
        pass
    for k, v in (dst.get("distractorAnalysis") or {}).items():
        if "trampa" not in v.lower() and "dominio" not in v.lower():
            print("DA no nombra trampa", id_, k)

print("\n=== overlap 40-char stems of options across items ===")
prefix = defaultdict(list)
for pos, id_, ci, topic, old_c, new_c, opts, _ in rows:
    for i, o in enumerate(opts):
        p = re.sub(r"\s+", " ", o.strip().lower())[:50]
        prefix[p].append((id_, i))
n = 0
for k, locs in prefix.items():
    if len(locs) > 1:
        n += 1
        print(len(locs), locs, k)
print("prefix dup groups", n)
