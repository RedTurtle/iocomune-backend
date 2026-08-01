# LINE seleziona la linea Plone: 60 (default), 61 oppure 62.
# Cambiando linea il venv va ricreato: ogni release Plone richiede una zc.buildout diversa
# (4.1.4 / 4.2.0 / 5.2.0), che arriva dal requirements della release stessa.
LINE ?= 60

# XXX: solo sulla 6.0, per https://github.com/pypa/setuptools/pull/4856/files
EXTRA_PINS_60 = setuptools==75.8.2 zc.buildout==4.1.10
EXTRA_PINS_61 =
EXTRA_PINS_62 =

help:
	@echo "make buildout [LINE=60|61|62]"
	@echo "make dependabot-update"

buildout:
	rm -rf bin lib
	pyenv local 3.11
	python -m venv .
	bin/pip install -r requirements$(LINE).txt
	@test -z "$(EXTRA_PINS_$(LINE))" || bin/python -m pip install $(EXTRA_PINS_$(LINE))
	bin/buildout -c development$(LINE).cfg -N

dependabot-update: docker/bin/python
	for l in 60 61 62; do \
	    mkdir -p dependabot/plone$$l; \
	    cd docker && bin/python create-constraints.py constraints$$l.cfg ../dependabot/plone$$l/requirements.txt; \
	    cd ..; \
	done
