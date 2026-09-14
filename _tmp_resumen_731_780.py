# -*- coding: utf-8 -*-
import json
from pathlib import Path

root = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
lote = json.loads((root / "_tmp_lote_731_780.json").read_text(encoding="utf-8"))
out = []
for it in lote:
    lines = [
        "=" * 60,
        f"POS {it['pos']} | {it['id']} | ci={it['correctIndex']} | diff={it['difficulty']}/{it['dificultad']} | {it['pillar']} | {it['topic']}",
        "CASE: " + (it.get("caseContext") or "").replace("\n", " ")[:500],
        "STEM: " + (it.get("stem") or ""),
        "EXPL: " + (it.get("explanation") or "")[:280],
    ]
    for i, o in enumerate(it["options"]):
        mark = "*" if i == it["correctIndex"] else " "
        lines.append(f"  {mark}{i} [{len(o)}]: {o}")
    da = it.get("distractorAnalysis") or {}
    for k in sorted(da.keys()):
        lines.append(f"  DA{k}: {str(da[k])[:220]}")
    out.append("\n".join(lines))
text = "\n".join(out)
(root / "_tmp_resumen_731_780.txt").write_text(text, encoding="utf-8")
print("wrote resumen, chars", len(text), "items", len(lote))
