# -*- coding: utf-8 -*-
import json
from pathlib import Path

root = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
with open(root / "assets" / "seed" / "questions_v1.json", encoding="utf-8") as f:
    data = json.load(f)

items = data["items"]
print("total items", len(items))
lote = items[1130:1148]  # 1-indexed 1131-1148
print("count", len(lote))

print("pos\tid\tci\tdiff\tdifn\topt\tda\tpillar\ttopic")
for i, it in enumerate(lote):
    pos = 1131 + i
    opts_len = len(it.get("options", []))
    da = it.get("distractorAnalysis", {})
    da_keys = ",".join(da.keys()) if isinstance(da, dict) else type(da).__name__
    topic = (it.get("topic") or "")[:60]
    print(
        f"{pos}\t{it['id']}\tci={it.get('correctIndex')}"
        f"\tdiff={it.get('difficulty')}\tdifn={it.get('dificultad')}"
        f"\topt={opts_len}\tda={da_keys}"
        f"\tpillar={it.get('pillar')}\ttopic={topic}"
        f"\tqh={it.get('qualityHardened')}"
    )

print("--- keys ---")
print(sorted(lote[0].keys()) if lote else None)

slim = []
for i, it in enumerate(lote):
    slim.append(
        {
            "pos": 1131 + i,
            "id": it["id"],
            "correctIndex": it["correctIndex"],
            "difficulty": it.get("difficulty"),
            "dificultad": it.get("dificultad"),
            "pillar": it.get("pillar"),
            "topic": it.get("topic"),
            "subtopic": it.get("subtopic"),
            "knowledgeTags": it.get("knowledgeTags"),
            "specialtyTags": it.get("specialtyTags"),
            "targetCargo": it.get("targetCargo"),
            "normativeRefs": it.get("normativeRefs"),
            "caseContext": it.get("caseContext"),
            "stem": it.get("stem"),
            "options": it.get("options"),
            "explanation": it.get("explanation"),
            "normativeJustification": it.get("normativeJustification"),
            "theoreticalJustification": it.get("theoreticalJustification"),
            "distractorAnalysis": it.get("distractorAnalysis"),
        }
    )

with open(root / "_tmp_lote_1131_1148.json", "w", encoding="utf-8") as f:
    json.dump(slim, f, ensure_ascii=False, indent=2)

chunks = [(0, 10, 1131, 1140), (10, 18, 1141, 1148)]
for a, b, start, end in chunks:
    chunk = slim[a:b]
    path = root / f"_tmp_in_{start}_{end}.json"
    with open(path, "w", encoding="utf-8") as f:
        json.dump(chunk, f, ensure_ascii=False, indent=2)
    print("wrote", path.name, "n=", len(chunk))
