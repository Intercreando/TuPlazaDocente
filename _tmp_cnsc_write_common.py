# -*- coding: utf-8 -*-
"""Validador compartido para reescrituras CNSC (lotes por chunks de 10)."""
from __future__ import annotations

import json
import re
from pathlib import Path

FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)
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
    "aplazar la decisión con un acta genérica",
    "aplaazar la decisión con un acta genérica",
    "imponer una salida visible",
    "delegar el conflicto a familias o chats",
    "adelantar contenidos de grados superiores",
)
KEYS_OK = {
    "id",
    "options",
    "explanation",
    "normativeJustification",
    "theoreticalJustification",
    "distractorAnalysis",
}
FRASE_NUM = (
    "cifra coherente con los datos del caso y la operación, sin redondear ni cambiar la base"
)


def expected_da_keys(ci: int) -> list[str]:
    return sorted(str(i) for i in range(4) if i != ci)


def public_item(it: dict) -> dict:
    return {k: it[k] for k in KEYS_OK}


def validate(
    items: list,
    ci_map: dict,
    needle: dict | None = None,
    n_items: int = 10,
    require_frase_num: bool = True,
) -> list[str]:
    errors: list[str] = []
    needle = needle or {}
    if len(items) != n_items:
        errors.append(f"COUNT {len(items)}")
    ids = [it.get("id") for it in items]
    expected_ids = list(ci_map)
    if ids != expected_ids:
        errors.append(f"ORDER {ids}")
    for it in items:
        tag = it.get("id")
        extra = set(it) - KEYS_OK
        missing = KEYS_OK - set(it)
        if extra:
            errors.append(f"EXTRA KEYS {tag} {extra}")
        if missing:
            errors.append(f"MISSING KEYS {tag} {missing}")
        ci = ci_map[tag]
        opts = it["options"]
        if not isinstance(opts, list) or len(opts) != 4:
            errors.append(f"OPTIONS {tag}")
            continue
        lengths = [len(o) for o in opts]
        skew = max(lengths) - min(lengths)
        if skew > 180:
            errors.append(f"LEN SKEW {tag} {lengths} skew={skew}")
        fig = needle.get(tag)
        if fig and fig not in opts[ci]:
            errors.append(f"MISSING FIGURE {tag} {fig} {opts[ci][:90]}")
        for oi, opt in enumerate(opts):
            n = len(opt)
            if n < 80:
                errors.append(f"SHORT OPTION {tag} idx {oi} {n}")
            if n > 340:
                errors.append(f"LONG OPTION {tag} idx {oi} {n}")
            if oi != ci:
                m = FORBIDDEN.search(opt)
                if m:
                    errors.append(f"FORBIDDEN WORD {tag} idx {oi} {m.group(0)}")
                low = opt.lower()
                if any(x in low for x in OBVIOUS):
                    errors.append(f"OBVIOUS BAD {tag} idx {oi}")
                if any(x in low for x in TEMPLATE):
                    errors.append(f"TEMPLATE DISTRACTOR {tag} idx {oi}")
                if "no solo" in low or "no sólo" in low:
                    errors.append(f"NO SOLO {tag} idx {oi}")
        da = it["distractorAnalysis"]
        expected = expected_da_keys(ci)
        if sorted(da.keys()) != expected:
            errors.append(f"DA KEYS {tag} {sorted(da.keys())} expected {expected} ci={ci}")
        else:
            for k, v in da.items():
                if not isinstance(v, str) or len(v) < 80:
                    errors.append(f"SHORT DA {tag} {k} {len(v) if isinstance(v, str) else None}")
                if not str(v).startswith("Trampa"):
                    errors.append(f"DA PREFIX {tag} {k}")
        expl = it.get("explanation") or ""
        if len(expl) < 280:
            errors.append(f"SHORT EXPLANATION {tag} {len(expl)}")
        n_sent = expl.count(".") + expl.count("?") + expl.count("!")
        if n_sent < 4 or n_sent > 8:
            errors.append(f"SENTENCES {tag} {n_sent}")
        if require_frase_num and str(tag).startswith("dir-apt-num-") and FRASE_NUM not in expl:
            errors.append(f"MISSING QUALITY PHRASE {tag}")
        for field in ("normativeJustification", "theoreticalJustification"):
            val = it.get(field) or ""
            if len(val) < 80:
                errors.append(f"SHORT {field} {tag} {len(val)}")
            if "p. ej." in val.lower() or "p.ej." in val.lower():
                errors.append(f"P EJ {field} {tag}")
        n_cross = sum(1 for v in da.values() if "dominio cruzado" in v.lower())
        if n_cross != 1:
            errors.append(f"CROSS DOMAIN {tag} {n_cross}")
    return errors


def dump_and_report(
    out: Path,
    items: list,
    ci_map: dict,
    needle: dict | None = None,
    n_items: int = 10,
) -> int:
    public = [public_item(it) for it in items]
    errors = validate(public, ci_map, needle, n_items=n_items)
    print("=== longitudes opciones ===")
    for it in public:
        lens = [len(o) for o in it["options"]]
        ci = ci_map[it["id"]]
        fig = (needle or {}).get(it["id"], "")
        cruz = sum(
            1 for v in it["distractorAnalysis"].values() if "dominio cruzado" in v.lower()
        )
        print(
            it["id"],
            "ci",
            ci,
            "fig",
            fig,
            "in_ci",
            (fig in it["options"][ci]) if fig else "-",
            lens,
            "skew",
            max(lens) - min(lens),
            "expl",
            len(it["explanation"]),
            "sent",
            it["explanation"].count(".") + it["explanation"].count("?") + it["explanation"].count("!"),
            "NJ",
            len(it["normativeJustification"]),
            "TJ",
            len(it["theoreticalJustification"]),
            "DA",
            {k: len(v) for k, v in it["distractorAnalysis"].items()},
            "cruz",
            cruz,
        )
    if errors:
        print("=== ERRORES ===")
        for e in errors:
            print(e)
        print("errors", len(errors))
        return 1
    out.write_text(json.dumps(public, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    loaded = json.loads(out.read_text(encoding="utf-8"))
    errors2 = validate(loaded, ci_map, needle, n_items=n_items)
    if errors2:
        print("=== ERRORES POST-DUMP ===")
        for e in errors2:
            print(e)
        return 1
    print("WROTE", out)
    print("items", len(loaded))
    print("errors", 0)
    print("validation OK")
    return 0
