#!/bin/sh
# Genera gli SBOM delle tre linee, con syft (https://github.com/anchore/syft).
# Eseguito DENTRO il container del generatore (vedi docker/Dockerfile.generator).
#
# Perche' syft e non sbom4python: sbom4python lancia "pip show" + una query a pypi.org
# per OGNI pacchetto (serialmente), quindi con ~580-600 pin costava da 1,5 a oltre 10
# minuti a linea a seconda della rete. syft legge il requirements.txt offline (nessuna
# rete) per nome/versione/purl, e usa una cache persistente per l'arricchimento delle
# licenze via SYFT_PYTHON_SEARCH_REMOTE_LICENSES: un file per pacchetto sotto
# SYFT_CACHE_DIR (qui .cache/syft, TTL 7 giorni di default). Misurato:
#   - cache fredda, 582 pacchetti:            ~1m37s
#   - stesso requirements, cache calda:        ~4s
#   - requirements con 2 versioni cambiate:    ~5s (solo quelle 2 vanno in rete)
# Nota operativa: syft riconosce il parser Python dal NOME del file (deve chiamarsi
# letteralmente "requirements.txt"), non dal contenuto.
#
# Anche syft esce con 0 su un requirements vuoto (ma con 1 su uno mancante, a
# differenza di sbom4python che dava sempre 0): i controlli qui sotto restano necessari.
set -eu

LINES="60 61 62"

for l in $LINES; do
    req="dependabot/plone$l/requirements.txt"
    if [ ! -s "$req" ]; then
        echo "ERRORE: $req manca o e' vuoto; esegui prima 'make dependabot-update'" >&2
        exit 1
    fi
done

mkdir -p sbom

for l in $LINES; do
    syft "dependabot/plone$l/requirements.txt" \
        -o "spdx-json=sbom/plone$l.spdx.json"
done

# ogni SBOM deve descrivere all'incirca i pacchetti del requirements da cui nasce
for l in $LINES; do
    python3 - "$l" <<'PY'
import json
import sys

line = sys.argv[1]
sbom = f"sbom/plone{line}.spdx.json"
req = f"dependabot/plone{line}/requirements.txt"

with open(req) as fp:
    expected = sum(
        1 for row in fp if row.strip() and not row.lstrip().startswith("#")
    )
with open(sbom) as fp:
    found = len(json.load(fp).get("packages", []))

print(f"{sbom}: {found} pacchetti descritti su {expected} pinnati")
# la soglia e' larga: syft puo' saltare qualche pacchetto, ma un output quasi
# vuoto significa che qualcosa e' andato storto senza dirlo (es. il file non
# si chiamava letteralmente "requirements.txt" e non e' stato riconosciuto)
if found < expected / 2:
    sys.exit(f"ERRORE: {sbom} descrive troppi pochi pacchetti")
PY
done

# --- versione precedente, con sbom4python (~1,5-10 min a linea, licenze solo nel 41%
# dei pacchetti). Tenuta per un eventuale ripristino: per usarla, in
# docker/Dockerfile.generator serve di nuovo libmagic1 (gia' presente) e va installato
# "pip install sbom4python==0.12.5" nel venv prima di lanciare lo script.
#
# VENV=${VENV:-/cache/venv}
# pids=""
# for l in $LINES; do
#     "$VENV/bin/sbom4python" --requirement "dependabot/plone$l/requirements.txt" \
#         --sbom spdx --format json --output "sbom/plone$l.spdx.json" &
#     pids="$pids $!"
# done
# rc=0
# for p in $pids; do
#     wait "$p" || rc=1
# done
# [ "$rc" -eq 0 ] || exit "$rc"
