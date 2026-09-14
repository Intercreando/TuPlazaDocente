# -*- coding: utf-8 -*-
"""Compara banco local vs origin/main (IDs tocados)."""
import json
import subprocess
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
local = json.loads((ROOT / "assets" / "seed" / "questions_v1.json").read_text(encoding="utf-8"))
raw = subprocess.check_output(
    ["git", "show", "origin/main:assets/seed/questions_v1.json"],
    cwd=ROOT,
)
origin = json.loads(raw.decode("utf-8"))
print("origin count", origin.get("count"), len(origin["items"]))
print("local count", local.get("count"), len(local["items"]))
print("origin version", origin.get("version"), "local", local.get("version"))
print("origin waves", [k for k in origin if str(k).startswith("contestUpgrade")])
print("local waves", [k for k in local if str(k).startswith("contestUpgrade")])

oi = {it["id"]: it for it in origin["items"]}
li = {it["id"]: it for it in local["items"]}
print("origin ids", len(oi), "local ids", len(li))
print("only local", sorted(set(li) - set(oi))[:20], "n", len(set(li) - set(oi)))
print("only origin", sorted(set(oi) - set(li))[:20], "n", len(set(oi) - set(li)))

changed = []
for iid, lit in li.items():
    oit = oi.get(iid)
    if not oit:
        changed.append((iid, "added"))
        continue
    keys = (
        "options",
        "explanation",
        "distractorAnalysis",
        "normativeJustification",
        "theoreticalJustification",
        "correctIndex",
        "stem",
        "caseContext",
    )
    diffs = [k for k in keys if oit.get(k) != lit.get(k)]
    if diffs:
        changed.append((iid, ",".join(diffs)))
print("items with content diff vs origin", len(changed))
print("sample", changed[:25])
print("last 18 local", [it["id"] for it in local["items"][1130:1148]])
print("last 18 origin same options?", all(
    oi[it["id"]].get("options") == it.get("options") for it in local["items"][1130:1148]
))
