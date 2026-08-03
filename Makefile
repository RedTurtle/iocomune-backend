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
GENERATOR_IMAGE ?= iocomune-generator
# cache riusata tra le run (e ripristinata in CI): venv, wheel scaricate da pip, cfg
# remoti di buildout (gli extends puntano a release immutabili, quindi cacharli e'
# sicuro) e metadati di syft per l'arricchimento delle licenze (un file per pacchetto,
# TTL 7 giorni: un bump di 1-2 pin risolve dalla rete solo quei pochi pacchetti).
CACHE_DIR ?= $(CURDIR)/.cache
DOCKER_RUN = mkdir -p "$(CACHE_DIR)" && docker run --rm \
	    -v "$(CURDIR)":/repo -w /repo -v "$(CACHE_DIR)":/cache \
	    -u "$$(id -u):$$(id -g)" -e HOME=/tmp \
	    -e PIP_CACHE_DIR=/cache/pip -e BUILDOUT_EXTENDS_CACHE=/cache/buildout-extends \
	    -e SYFT_CACHE_DIR=/cache/syft -e SYFT_PYTHON_SEARCH_REMOTE_LICENSES=true \
	    $(GENERATOR_IMAGE) sh -c

# crea il venv nella cache solo se manca o se non e' utilizzabile (es. cache ripristinata
# da un'immagine con un python diverso); pip install e' comunque rapido quando i requisiti
# sono gia' soddisfatti e le wheel sono in cache
VENV_SETUP = { /cache/venv/bin/python -c "" 2>/dev/null || rm -rf /cache/venv; }; \
	    test -x /cache/venv/bin/python || python -m venv /cache/venv

help:
	@echo "make lint                # controlli su versions/ e sui file generati"
	@echo "make buildout [LINE=60|61|62] [PYTHON=3.11|3.12]"
	@echo "make generated-update    # rigenera dependabot/ e sbom/ (in docker)"
	@echo "make dependabot-update   # solo dependabot/"
	@echo "make sbom-update         # solo sbom/"
	@echo "make clean-cache         # svuota la cache del generatore"

# la layer cache di docker rende questo target istantaneo dopo la prima volta
generator-image:
	@docker build -q -t $(GENERATOR_IMAGE) -f docker/Dockerfile.generator docker/ >/dev/null

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

# dopo aver toccato un pin vanno rigenerati entrambi gli artefatti versionati
generated-update: dependabot-update sbom-update

# rigenera i requirements versionati; la CI delle PR verifica che siano allineati
dependabot-update: generator-image
	$(DOCKER_RUN) 'set -e; \
	    $(VENV_SETUP); \
	    /cache/venv/bin/pip install --quiet -r requirements.txt; \
	    for l in 60 61 62; do \
	        mkdir -p dependabot/plone$$l; \
	        /cache/venv/bin/python docker/create-constraints.py \
	            docker/constraints$$l.cfg dependabot/plone$$l/requirements.txt; \
	    done'

sbom-update: generator-image
	$(DOCKER_RUN) 'set -e; scripts/sbom-update.sh'

clean-cache:
	rm -rf "$(CACHE_DIR)"
