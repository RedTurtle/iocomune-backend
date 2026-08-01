# LINE seleziona la linea Plone: 60 (default), 61 oppure 62.
# Cambiando linea il venv va ricreato: ogni release Plone richiede una zc.buildout diversa
# (4.1.4 / 4.2.0 / 5.2.0), che arriva dal requirements della release stessa.
LINE ?= 60

# XXX: solo sulla 6.0, per https://github.com/pypa/setuptools/pull/4856/files
EXTRA_PINS_60 = setuptools==75.8.2 zc.buildout==4.1.10
# zope.interface 8 usa i native namespace: con buildout gli egg stanno in path separati
# e il namespace "zope" non si compone. horse-with-no-namespace va installato con pip nel
# venv (NON da buildout). Sulla 6.2 arriva già dal requirements della release.
EXTRA_PINS_61 = horse-with-no-namespace
EXTRA_PINS_62 =

# la CI prova tutte le linee sia con 3.11 sia con 3.12; in locale si usa 3.11 salvo
# override esplicito (make buildout LINE=62 PYTHON=3.12)
PYTHON ?= 3.11

# i file generati e versionati (dependabot/, sbom/) si producono SEMPRE dentro un
# container: stesso comando in locale e in CI, nessuna dipendenza dal python o dal
# virtualenv della macchina, e nessun path locale che finisce nei file
GENERATOR_IMAGE ?= python:3.11-slim
DOCKER_RUN = docker run --rm -v "$(CURDIR)":/repo -w /repo \
	    -u "$$(id -u):$$(id -g)" -e HOME=/tmp $(GENERATOR_IMAGE) sh -c

help:
	@echo "make lint                # controlli sui file di versions/"
	@echo "make buildout [LINE=60|61|62] [PYTHON=3.11|3.12]"
	@echo "make dependabot-update   # rigenera dependabot/ (in docker)"
	@echo "make sbom-update         # rigenera sbom/ (in docker)"

# stessi controlli eseguiti dalla CI
lint:
	scripts/lint-versions.sh
	scripts/lint-generated.sh

buildout:
	rm -rf bin lib
	pyenv local $(PYTHON)
	python -m venv .
	bin/pip install -r requirements$(LINE).txt
	@test -z "$(EXTRA_PINS_$(LINE))" || bin/python -m pip install $(EXTRA_PINS_$(LINE))
	bin/buildout -c development$(LINE).cfg -N

# rigenera i requirements versionati; la CI delle PR verifica che siano allineati
dependabot-update:
	$(DOCKER_RUN) 'set -e; \
	    python -m venv /tmp/venv; \
	    /tmp/venv/bin/pip install --quiet --no-cache-dir -r requirements.txt; \
	    for l in 60 61 62; do \
	        mkdir -p dependabot/plone$$l; \
	        /tmp/venv/bin/python docker/create-constraints.py \
	            docker/constraints$$l.cfg dependabot/plone$$l/requirements.txt; \
	    done'

sbom-update:
	$(DOCKER_RUN) 'set -e; \
	    python -m venv /tmp/venv; \
	    /tmp/venv/bin/pip install --quiet --no-cache-dir sbom4python==0.12.5; \
	    mkdir -p sbom; \
	    for l in 60 61 62; do \
	        /tmp/venv/bin/sbom4python --requirement dependabot/plone$$l/requirements.txt \
	            --sbom spdx --format json --output sbom/plone$$l.spdx.json; \
	    done'
