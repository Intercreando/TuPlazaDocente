# -*- coding: utf-8 -*-
"""Valida salidas CNSC del lote 931-980 antes de parchear questions_v1.json."""
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
    (931, 940),
    (941, 950),
    (951, 960),
    (961, 970),
    (971, 980),
]
OBVIOUS = (
    "ignorar",
    "sin planear",
    "aunque rompa",
    "aunque se presente como",
    "aunque se presente",
    "aunque ahorre",
    "aunque parezca",
    "actividad recreativa",
    "eliminar toda evidencia",
    "para que se note liderazgo",
    "castigo del rincón",
    "acta genérica",
    "delegar el conflicto a familias",
    "familias o chats",
)
TEMPLATE = (
    "aplaazar la decisión con un acta genérica",
    "imponer una salida visible",
    "delegar el conflicto a familias o chats",
    "adelantar contenidos de grados superiores",
)
NEEDLE = {
    "dir-apt-num-221": "8",
    "dir-apt-num-222": "2h 20min",
    "dir-apt-num-223": "40%",
    "dir-apt-num-224": "3h 45min",
    "dir-apt-num-225": "16",
    "dir-apt-num-226": "9",
    "dir-apt-num-227": "15%",
    "dir-apt-num-228": "330.000",
    "dir-apt-num-229": "4.6",
    "dir-apt-num-230": "24",
    "dir-apt-num-231": "24%",
    "dir-apt-num-232": "30",
}


def validate_chunk(start: int, end: int) -> int:
    errors = 0
    in_path = ROOT / f"_tmp_in_{start}_{end}.json"
    out_path = ROOT / f"_tmp_out_{start}_{end}.json"
    if not out_path.exists():
        print("MISSING", out_path.name)
        return 1
    src_items = json.loads(in_path.read_text(encoding="utf-8"))
    try:
        dst_items = json.loads(out_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        print("JSON ERROR", out_path.name, exc)
        return 1
    if not isinstance(dst_items, list) or len(dst_items) != len(src_items):
        print(
            "COUNT",
            out_path.name,
            type(dst_items),
            getattr(dst_items, "__len__", lambda: "?")(),
        )
        return 1
    opt_norm = {}
    for i, src in enumerate(src_items):
        tag = f"{out_path.name}[{i}] {src['id']}"
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
        ci = src["correctIndex"]
        if not isinstance(opts, list) or len(opts) != 4:
            print("OPTIONS LEN", tag, opts if not isinstance(opts, list) else len(opts))
            errors += 1
        else:
            lengths = [len(str(o)) for o in opts]
            if max(lengths) - min(lengths) > 180:
                print("LEN SKEW", tag, lengths)
                errors += 1
            needle = NEEDLE.get(src["id"])
            if needle and needle not in opts[ci]:
                print("MISSING FIGURE", tag, needle, opts[ci][:90])
                errors += 1
            for oi, opt in enumerate(opts):
                if not isinstance(opt, str) or len(opt.strip()) < 80:
                    print(
                        "SHORT OPTION",
                        tag,
                        "idx",
                        oi,
                        len(opt) if isinstance(opt, str) else None,
                    )
                    errors += 1
                if isinstance(opt, str) and len(opt) > 340:
                    print("LONG OPTION", tag, "idx", oi, len(opt))
                    errors += 1
                if oi != ci and isinstance(opt, str) and FORBIDDEN.search(opt):
                    print(
                        "FORBIDDEN WORD",
                        tag,
                        "idx",
                        oi,
                        FORBIDDEN.search(opt).group(0),
                    )
                    errors += 1
                low = (opt or "").lower()
                if oi != ci and any(x in low for x in OBVIOUS):
                    print("OBVIOUS BAD", tag, "idx", oi)
                    errors += 1
                if any(x in low for x in TEMPLATE):
                    print("TEMPLATE DISTRACTOR", tag, "idx", oi)
                    errors += 1
                if oi != ci and ("no solo" in low or "no sólo" in low):
                    print("NO SOLO", tag, "idx", oi)
                    errors += 1
                key = re.sub(r"\s+", " ", (opt or "").strip().lower())[:90]
                opt_norm.setdefault(key, []).append((src["id"], oi))
        da = dst.get("distractorAnalysis") or {}
        expected = [str(n) for n in range(4) if n != ci]
        if sorted(da.keys()) != expected:
            print("DA KEYS", tag, sorted(da.keys()), "expected", expected, "ci", ci)
            errors += 1
        else:
            cruz = 0
            for k, v in da.items():
                if not isinstance(v, str) or len(v) < 80:
                    print("SHORT DA", tag, k, len(v) if isinstance(v, str) else None)
                    errors += 1
                if not (v or "").startswith("Trampa"):
                    print("DA NO TRAMPA", tag, k, (v or "")[:40])
                    errors += 1
                if "dominio cruzado" in (v or "").lower():
                    cruz += 1
            if cruz != 1:
                print("CRUZADOS", tag, cruz)
                errors += 1
        expl = dst.get("explanation") or ""
        if len(expl) < 280:
            print("SHORT EXPLANATION", tag, len(expl))
            errors += 1
        n_sent = expl.count(".") + expl.count("?") + expl.count("!")
        if n_sent < 4 or n_sent > 8:
            print("SENTENCES", tag, n_sent)
            errors += 1
        for field in ("normativeJustification", "theoreticalJustification"):
            val = dst.get(field) or ""
            if len(val) < 80:
                print("SHORT", field, tag, len(val))
                errors += 1
    print(f"chunk {start}-{end} errors={errors}")
    return errors


def main() -> int:
    total = 0
    for start, end in CHUNKS:
        total += validate_chunk(start, end)
    print("---")
    print("total errors", total)
    return 1 if total else 0


if __name__ == "__main__":
    if len(sys.argv) == 3:
        sys.exit(1 if validate_chunk(int(sys.argv[1]), int(sys.argv[2])) else 0)
    sys.exit(main())
