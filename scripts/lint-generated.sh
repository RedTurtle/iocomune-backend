#!/bin/sh
# I file generati e versionati (dependabot/, sbom/) non devono contenere path della
# macchina che li ha prodotti: sono rigenerati sia in locale sia in CI, e un path
# assoluto nell'header renderebbe il confronto sempre diverso, oltre a esporre
# informazioni inutili sul laptop di chi ha lanciato il comando.
set -eu

cd "$(dirname "$0")/.."

report_error() {
    if [ -n "${GITHUB_ACTIONS:-}" ]; then
        printf '::error::%s\n' "$1"
    else
        printf 'ERRORE: %s\n' "$1"
    fi
}

hits=$(grep -rnE '/(home|Users)/|/opt/hostedtoolcache/|[A-Z]:\\Users' \
       dependabot sbom 2>/dev/null | head -5 || true)

if [ -n "$hits" ]; then
    report_error "path locali nei file generati"
    echo "$hits"
    echo
    echo "Rigenerali con 'make dependabot-update', o 'make generated-update' se"
    echo "il path compare in sbom/."
    exit 1
fi

echo "dependabot/, sbom/: nessun path locale"
