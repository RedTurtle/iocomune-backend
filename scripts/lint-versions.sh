#!/bin/sh
# Un pacchetto, un file: verifica che nessun egg sia pinnato in piu' di un file
# di versions/.
#
# Serve perche' buildout non segnala il caso: se lo stesso pacchetto compare in
# due file con versioni diverse, vince l'ultimo letto secondo l'ordine degli
# extends, senza alcun errore. Il controllo guarda i file sorgente prima di
# qualsiasi risoluzione, e fallisce anche quando le due versioni coincidono.
#
# I nomi sono confrontati normalizzati come fa pip (PEP 503: maiuscole e i
# separatori - _ . equivalenti), cosi' cadono nella rete anche grafie diverse
# dello stesso pacchetto.
#
# Non riguarda i pin presenti sia in versions/*.cfg sia nella [versions] di un
# ploneXX.cfg: quello e' l'override per-linea, ed e' voluto.
set -eu

cd "$(dirname "$0")/.."

report_error() {
    if [ -n "${GITHUB_ACTIONS:-}" ]; then
        printf '::error::%s\n' "$1"
    else
        printf 'ERRORE: %s\n' "$1"
    fi
}

dups=$(grep -hoE '^[A-Za-z0-9._-]+[[:space:]]*=' versions/*.cfg \
       | tr -d ' =' | tr 'A-Z' 'a-z' | sed -E 's/[-_.]+/-/g' | sort | uniq -d)

if [ -n "$dups" ]; then
    report_error "lo stesso pacchetto e' pinnato in piu' file di versions/: $(echo $dups)"
    for d in $dups; do
        grep -inE "^$(echo "$d" | sed -E 's/-/[-_.]/g')[[:space:]]*=" versions/*.cfg || true
    done
    echo
    echo "Tieni il pin in un solo file di versions/. Se il valore deve cambiare da"
    echo "una linea Plone all'altra, mettilo nella [versions] del ploneXX.cfg."
    exit 1
fi

echo "versions/: nessun pacchetto pinnato in piu' file"
