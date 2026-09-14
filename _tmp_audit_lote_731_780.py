# -*- coding: utf-8 -*-
"""Auditoría de contenido del lote 731-780 (no sustituye al validador estructural)."""
import json
import re
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
CHUNKS = [(731, 740), (741, 750), (751, 760), (761, 770), (771, 780)]

# Cifra o fragmento que DEBE aparecer en la opción correcta
MUST_IN_CORRECT = {
    "dir-apt-num-21": "294",
    "dir-apt-num-22": "15",
    "dir-apt-num-23": "3,92",
    "dir-apt-num-24": "5",
    "dir-apt-num-25": "36.000.000",
    "dir-apt-num-26": None,  # "3 turnos" — check below
    "dir-apt-num-27": "40",
    "dir-apt-num-28": "90",
    "dir-apt-num-29": "10%",
    "dir-apt-num-30": "24",
    "dir-apt-num-31": "1.440",
    "dir-apt-num-32": "60",
}

WEAK_DA = ("parece profesional o equitativa", "no se sostiene con el texto")
TEMPLATE_OPT = (
    "aumentar el número de quizzes",
    "trámite de caritas",
    "adelantar contenidos de grados superiores",
)

issues = []
stats = []

for start, end in CHUNKS:
    srcs = json.loads((ROOT / f"_tmp_in_{start}_{end}.json").read_text(encoding="utf-8"))
    dsts = json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8"))
    for src, dst in zip(srcs, dsts):
        cid = src["id"]
        ci = src["correctIndex"]
        opts = dst["options"]
        correct = opts[ci]
        lens = [len(o) for o in opts]
        stats.append((cid, ci, lens, max(lens) - min(lens)))
        must = MUST_IN_CORRECT.get(cid)
        if must and must not in correct:
            issues.append(f"MISSING FIGURE {cid} expected {must!r} in correct: {correct[:120]}")
        if cid == "dir-apt-num-26" and not re.search(r"\b3\b", correct):
            issues.append(f"MISSING 3 TURNOS {cid}: {correct[:120]}")
        da = " ".join((dst.get("distractorAnalysis") or {}).values()).lower()
        expl = (dst.get("explanation") or "").lower()
        if any(w in da for w in WEAK_DA):
            issues.append(f"WEAK DA {cid}")
        blob = " ".join(opts).lower()
        if any(t in blob for t in TEMPLATE_OPT):
            issues.append(f"TEMPLATE OPT {cid}")
        # numerical: wrong figure should not be in correct option as the reported number
        # reading: correct should not be obviously opposite
        print(f"{cid}\tci={ci}\tlens={lens}\tskew={max(lens)-min(lens)}\tcorr={correct[:90]}...")

print("--- ISSUES ---")
for i in issues:
    print(i)
print("issue count", len(issues))
