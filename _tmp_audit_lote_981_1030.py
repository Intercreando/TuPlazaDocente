# -*- coding: utf-8 -*-
"""Auditoría de calidad extra del lote 981-1030."""
import json
import re
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(981, 990), (991, 1000), (1001, 1010), (1011, 1020), (1021, 1030)]
FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)

opt_norm = {}
for start, end in CHUNKS:
    srcs = json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8"))
    dsts = json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8"))
    assert len(srcs) == len(dsts)
    for src, dst in zip(srcs, dsts):
        ci = src["correctIndex"]
        nid = src["id"]
        opts = dst["options"]
        da = dst["distractorAnalysis"]
        print("=" * 72)
        print(f"{nid} ci={ci} expl={len(dst['explanation'])} nj={len(dst['normativeJustification'])} tj={len(dst['theoreticalJustification'])}")
        print("STEM:", src["stem"][:120])
        for i, o in enumerate(opts):
            mark = "*" if i == ci else " "
            fw = FORBIDDEN.search(o) if i != ci else None
            print(f" {mark}{i} [{len(o)}] {o[:110]}{'…' if len(o)>110 else ''}")
            if fw:
                print("   !! FORBIDDEN", fw.group(0))
        cruz = [k for k, v in da.items() if "dominio cruzado" in v.lower()]
        print(" cruzados", cruz)
        for k, v in da.items():
            print(f"  DA{k} [{len(v)}] {v[:100]}{'…' if len(v)>100 else ''}")
        for i, o in enumerate(opts):
            key = re.sub(r"\s+", " ", o.strip().lower())[:90]
            opt_norm.setdefault(key, []).append((nid, i))

print("=== DUPLICADOS prefijo 90 ===")
dups = 0
for k, locs in opt_norm.items():
    if len(locs) > 1:
        dups += 1
        print(len(locs), locs, k[:80])
print("dup groups", dups)
