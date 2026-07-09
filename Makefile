help:
	@echo "TODO"

buildout:
	rm -rf bin lib
	pyenv local 3.11
	python -m venv .
	bin/pip install -r requirements.txt
	bin/python -m pip install zc.buildout==4.1.10
	bin/buildout -N

dependabot-update: docker/bin/python
	cd docker && bin/python create-constraints.py constraints.cfg ../dependabot/requirements.txt
