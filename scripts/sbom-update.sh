#!/bin/sh
# Genera gli SBOM delle tre linee. Eseguito DENTRO il container del generatore:
# ci pensa "make sbom-update" a prepararlo con il venv e sbom4python.
#
# Le tre linee girano in parallelo perche' sbom4python e' quasi tutto attesa di rete
# (per ogni pacchetto lancia "pip show" e interroga pypi.org), quindi il wall clock si
# divide per tre.
#
# Attenzione: sbom4python esce con 0 anche quando il requirements non esiste, e scrive
# comunque un file. Senza i controlli qui sotto un requirements mancante o vuoto
# produrrebbe SBOM degeneri, committati poi in silenzio dalla CI.
set -eu

VENV=${VENV:-/cache/venv}
LINES="60 61 62"

for l in $LINES; do
    req="dependabot/plone$l/requirements.txt"
    if [ ! -s "$req" ]; then
        echo "ERRORE: $req manca o e' vuoto; esegui prima 'make dependabot-update'" >&2
        exit 1
    fi
done

mkdir -p sbom

pids=""
for l in $LINES; do
    "$VENV/bin/sbom4python" --requirement "dependabot/plone$l/requirements.txt" \
        --sbom spdx --format json --output "sbom/plone$l.spdx.json" &
    pids="$pids $!"
done

rc=0
for p in $pids; do
    wait "$p" || rc=1
done
[ "$rc" -eq 0 ] || exit "$rc"

# ogni SBOM deve descrivere all'incirca i pacchetti del requirements da cui nasce
for l in $LINES; do
    "$VENV/bin/python" - "$l" <<'PY'
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
# la soglia e' larga: sbom4python puo' saltare qualche pacchetto, ma un output
# quasi vuoto significa che qualcosa e' andato storto senza dirlo
if found < expected / 2:
    sys.exit(f"ERRORE: {sbom} descrive troppi pochi pacchetti")
PY
done
