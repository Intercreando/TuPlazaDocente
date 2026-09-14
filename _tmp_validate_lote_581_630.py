# -*- coding: utf-8 -*-
"""Valida salidas CNSC del lote 581-630 antes de parchear questions_v1.json."""
import json
import re
import sys
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)
KEYS_OK = {
    "id",
    "options",
    "explanation",
    "normativeJustification",
    "theoreticalJustification",
    "distractorAnalysis",
}
CHUNKS = [
    (581, 590),
    (591, 600),
    (601, 610),
    (611, 620),
    (621, 630),
]


def main() -> int:
    errors = 0
    all_out = []
    for start, end in CHUNKS:
        in_path = ROOT / f"_tmp_in_{start}_{end}.json"
        out_path = ROOT / f"_tmp_out_{start}_{end}.json"
        if not out_path.exists():
            print("MISSING", out_path.name)
            errors += 1
            continue
        src_items = json.loads(in_path.read_text(encoding="utf-8"))
        try:
            dst_items = json.loads(out_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError as exc:
            print("JSON ERROR", out_path.name, exc)
            errors += 1
            continue
        if not isinstance(dst_items, list) or len(dst_items) != len(src_items):
            print("COUNT", out_path.name, type(dst_items), getattr(dst_items, "__len__", lambda: "?")())
            errors += 1
        for i, src in enumerate(src_items):
            tag = f"{out_path.name}[{i}] {src['id']}"
            if i >= len(dst_items):
                print("NO ITEM", tag)
                errors += 1
                continue
            dst = dst_items[i]
            extra = sorted(set(dst.keys()) - KEYS_OK)
            if extra:
                print("EXTRA KEYS", tag, extra)
                errors += 1
            for k in KEYS_OK:
                if k not in dst:
                    print("MISSING KEY", tag, k)
                    errors += 1
            if dst.get("id") != src["id"]:
                print("ID MISMATCH", tag, "got", dst.get("id"))
                errors += 1
            opts = dst.get("options")
            if not isinstance(opts, list) or len(opts) != 4:
                print("OPTIONS LEN", tag, opts if not isinstance(opts, list) else len(opts))
                errors += 1
            else:
                ci = src["correctIndex"]
                lengths = [len(str(o)) for o in opts]
                if max(lengths) - min(lengths) > 220:
                    print("LEN SKEW", tag, lengths)
                    errors += 1
                for oi, opt in enumerate(opts):
                    if not isinstance(opt, str) or len(opt.strip()) < 80:
                        print("SHORT OPTION", tag, "idx", oi, len(opt) if isinstance(opt, str) else None)
                        errors += 1
                    if oi != ci and isinstance(opt, str) and FORBIDDEN.search(opt):
                        print("FORBIDDEN WORD", tag, "idx", oi, FORBIDDEN.search(opt).group(0))
                        errors += 1
                    low = (opt or "").lower()
                    if oi != ci and any(
                        x in low
                        for x in (
                            "ignorar",
                            "sin planear",
                            "aunque rompa",
                            "aunque se presente como",
                            "aunque ahorre",
                            "aunque parezca",
                        )
                    ):
                        print("OBVIOUS BAD", tag, "idx", oi)
                        errors += 1
            da = dst.get("distractorAnalysis") or {}
            expected = [str(n) for n in range(4) if n != src["correctIndex"]]
            if sorted(da.keys()) != expected:
                print("DA KEYS", tag, sorted(da.keys()), "expected", expected, "ci", src["correctIndex"])
                errors += 1
            else:
                for k, v in da.items():
                    if not isinstance(v, str) or len(v) < 80:
                        print("SHORT DA", tag, k, len(v) if isinstance(v, str) else None)
                        errors += 1
            expl = dst.get("explanation") or ""
            if len(expl) < 280:
                print("SHORT EXPLANATION", tag, len(expl))
                errors += 1
            for field in ("normativeJustification", "theoreticalJustification"):
                val = dst.get(field) or ""
                if len(val) < 80:
                    print("SHORT", field, tag, len(val))
                    errors += 1
            all_out.append((src, dst))
    print("---")
    print("items validated", len(all_out))
    print("errors", errors)
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
