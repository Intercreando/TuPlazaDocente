# -*- coding: utf-8 -*-
"""Valida salidas CNSC del lote 1131-1148 antes de parchear questions_v1.json."""
import json
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
sys.path.insert(0, str(ROOT))
from _tmp_cnsc_write_common import validate, KEYS_OK  # noqa: E402

CHUNKS = [(1131, 1140, 10), (1141, 1148, 8)]


def ci_map_from_src(src_items: list) -> dict:
    return {it["id"]: it["correctIndex"] for it in src_items}


def main() -> int:
    total = 0
    for start, end, n_items in CHUNKS:
        in_path = ROOT / f"_tmp_in_{start}_{end}.json"
        out_path = ROOT / f"_tmp_out_{start}_{end}.json"
        src_items = json.loads(in_path.read_text(encoding="utf-8"))
        try:
            dst_items = json.loads(out_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError as exc:
            print("JSON ERROR", out_path.name, exc)
            return 1
        ci_map = ci_map_from_src(src_items)
        errors = validate(dst_items, ci_map, n_items=n_items)
        # Congelar id/correctIndex respecto al extracto
        if [d["id"] for d in dst_items] != [s["id"] for s in src_items]:
            errors.append(f"ID ORDER {out_path.name}")
        extra = []
        for dst in dst_items:
            extra.extend(sorted(set(dst.keys()) - KEYS_OK))
        if extra:
            errors.append(f"EXTRA KEYS {out_path.name} {extra}")
        print(f"chunk {start}-{end} errors={len(errors)}")
        for e in errors:
            print(e)
            total += 1
    print("---")
    print("total errors", total)
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())
