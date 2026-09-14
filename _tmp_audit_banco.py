# -*- coding: utf-8 -*-
"""Auditoría estructural del banco questions_v1.json."""
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")
path = ROOT / "assets" / "seed" / "questions_v1.json"
data = json.loads(path.read_text(encoding="utf-8"))
items = data["items"]

FORBIDDEN = re.compile(
    r"\b(siempre|nunca|solo|sólo|únicamente|unicamente|sin importar|totalmente)\b",
    re.IGNORECASE,
)
OBVIOUS = (
    "ignorar",
    "sin planear",
    "aunque rompa",
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
REQUIRED = {
    "id",
    "options",
    "correctIndex",
    "explanation",
    "pillar",
    "stem",
}

print("=== META ===")
print("version", data.get("version"))
print("generatedAt", data.get("generatedAt"))
print("count field", data.get("count"), "items", len(items))
print("goldHandcrafted", data.get("goldHandcrafted"))
print("quality block", json.dumps(data.get("quality"), ensure_ascii=False))
print("file_mb", round(path.stat().st_size / 1e6, 2))

print("\n=== WAVES ===")
for k, v in data.items():
    if k.startswith("contestUpgrade") or k in (
        "directivoAptitudes",
        "wave6CienciasSociales",
        "pedagogicalUpgrade",
    ):
        if isinstance(v, dict):
            slim = {kk: vv for kk, vv in v.items() if kk != "ids" and kk != "handIds"}
            print(k, slim)

print("\n=== INTEGRIDAD ===")
ids = [it.get("id") for it in items]
dup = [i for i, c in Counter(ids).items() if c > 1]
print("duplicados", len(dup), dup[:10])
missing_req = 0
bad_ci = 0
opt_len = Counter()
published = 0
hardened = 0
not_hardened = []
case_study = 0
empty_expl = 0
short_opts = 0
forbidden_hits = 0
obvious_hits = 0
garbage = 0
da_generic = 0
stem_trunc = 0
diff_mismatch = 0
for i, it in enumerate(items):
    if any(k not in it for k in REQUIRED):
        missing_req += 1
    opts = it.get("options") or []
    opt_len[len(opts)] += 1
    ci = it.get("correctIndex")
    if not isinstance(ci, int) or ci < 0 or ci >= len(opts):
        bad_ci += 1
    if it.get("published") is True:
        published += 1
    if it.get("qualityHardened") is True:
        hardened += 1
    else:
        not_hardened.append((i + 1, it.get("id")))
    if it.get("isCaseStudy"):
        case_study += 1
    if not (it.get("explanation") or "").strip():
        empty_expl += 1
    blob = json.dumps(it, ensure_ascii=False)
    if "</user_query>" in blob or "</user_query>" in blob:
        garbage += 1
    da = it.get("distractorAnalysis") or {}
    if isinstance(da, dict) and da:
        vals = list(da.values())
        if vals and all("Propuesta plausible" in str(v) or "Opción cercana" in str(v) for v in vals):
            da_generic += 1
    stem = it.get("stem") or ""
    if ". En el episodio" in stem or stem.rstrip().endswith("principalmente."):
        stem_trunc += 1
    d = it.get("difficulty")
    dn = it.get("dificultad")
    # difficulty may be int or string
    mapping = {"basico": 1, "básico": 1, "intermedio": 2, "avanzado": 3}
    if isinstance(d, str) and isinstance(dn, int):
        if mapping.get(d.lower()) and mapping[d.lower()] != dn:
            diff_mismatch += 1
    elif isinstance(d, int) and isinstance(dn, int) and d != dn:
        diff_mismatch += 1
    for oi, opt in enumerate(opts):
        if not isinstance(opt, str) or len(opt.strip()) < 40:
            short_opts += 1
        if oi != ci and isinstance(opt, str):
            if FORBIDDEN.search(opt):
                forbidden_hits += 1
            low = opt.lower()
            if any(x in low for x in OBVIOUS):
                obvious_hits += 1

print("missing required keys", missing_req)
print("bad correctIndex", bad_ci)
print("option counts", dict(opt_len))
print("published", published)
print("qualityHardened", hardened, "/", len(items))
print("not hardened count", len(not_hardened))
print("isCaseStudy", case_study)
print("empty explanation", empty_expl)
print("options <40 chars (any index)", short_opts)
print("forbidden words in incorrect options", forbidden_hits)
print("obvious-bad phrases in incorrect", obvious_hits)
print("garbage tags", garbage)
print("generic DA (plantilla)", da_generic)
print("stems truncated/awkward", stem_trunc)
print("difficulty vs dificultad mismatch", diff_mismatch)

print("\n=== PREFIJOS ID ===")
pref = Counter()
for it in items:
    iid = it.get("id") or ""
    m = re.match(r"^([a-z]+(?:-[a-z]+)*)-", iid)
    if m:
        # take first two segments typically
        parts = iid.split("-")
        key = "-".join(parts[:2]) if len(parts) >= 2 else parts[0]
        pref[key] += 1
    else:
        pref[iid.split("-")[0] if iid else "?"] += 1
for k, v in pref.most_common():
    print(f"  {k}: {v}")

print("\n=== PILAR ===")
for k, v in Counter(it.get("pillar") for it in items).most_common():
    print(f"  {k}: {v}")

print("\n=== TARGET CARGO ===")
for k, v in Counter(it.get("targetCargo") or "(vacío)").most_common():
    print(f"  {k}: {v}")

print("\n=== DIFFICULTY (raw) ===")
for k, v in Counter(
    str(it.get("difficulty")) for it in items
).most_common():
    print(f"  {k}: {v}")

print("\n=== DIFICULTAD num ===")
for k, v in sorted(Counter(it.get("dificultad") for it in items).items(), key=lambda x: str(x[0])):
    print(f"  {k}: {v}")

print("\n=== SPECIALTY TAGS ===")
st = Counter()
for it in items:
    tags = it.get("specialtyTags") or []
    if not tags:
        st["(sin tag)"] += 1
    for t in tags:
        st[str(t)] += 1
for k, v in st.most_common():
    print(f"  {k}: {v}")

print("\n=== SCHEMA KEYS (unión / faltantes frecuentes) ===")
all_keys = Counter()
for it in items:
    for k in it.keys():
        all_keys[k] += 1
for k, v in all_keys.most_common():
    missing = len(items) - v
    print(f"  {k}: {v}" + (f"  (falta en {missing})" if missing else ""))

print("\n=== NO HARDENED (si hay) ===")
for row in not_hardened[:30]:
    print(" ", row)
if len(not_hardened) > 30:
    print("  ...", len(not_hardened) - 30, "más")

print("\n=== CORRECT INDEX BALANCE ===")
print(dict(Counter(it.get("correctIndex") for it in items)))

print("\n=== MODULE (top) ===")
for k, v in Counter(it.get("module") or "(vacío)").most_common(15):
    print(f"  {k}: {v}")

print("\n=== LAST 5 ITEMS ===")
for it in items[-5:]:
    print(it["id"], "qh=", it.get("qualityHardened"), "ci=", it.get("correctIndex"),
          "diff=", it.get("difficulty"), it.get("dificultad"),
          "topic=", (it.get("topic") or "")[:50])
