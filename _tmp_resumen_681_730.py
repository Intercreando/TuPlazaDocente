# -*- coding: utf-8 -*-
import json
from pathlib import Path

root = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
lote = json.loads((root / "_tmp_lote_681_730.json").read_text(encoding="utf-8"))
out = []
for it in lote:
    lines = [
        "=" * 60,
        f"POS {it['pos']} | {it['id']} | ci={it['correctIndex']} | {it['topic']}",
        "CASE: " + (it.get("caseContext") or "").replace("\n", " ")[:320],
        "STEM: " + (it.get("stem") or ""),
    ]
    for i, o in enumerate(it["options"]):
        mark = "*" if i == it["correctIndex"] else " "
        lines.append(f"  {mark}{i}: {o[:160]}")
    out.append("\n".join(lines))
text = "\n".join(out)
(root / "_tmp_resumen_681_730.txt").write_text(text, encoding="utf-8")
print("wrote resumen, chars", len(text), "items", len(lote))
