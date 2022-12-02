# Design Plone Versions

Repository con le versioni aggiornate delle dipendenze che servono per un sito agid creato con design.plone.policy.
## Come utilizzare questo file

## Staging e sviluppo

Il file **versions.cfg** che si trova nel branch __main__ è da utilizzare in sviluppo o per i siti di staging, in quanto potrebbe avere delle versioni che non sono ancora pronte per finire in produzione.

```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/dist.design.plone/main/versions.cfg
```

E' possibile eventualmente anche usare il buildout.cfg presnte in questo repository

```bash
python3.8 -m venv .
bin/pip install -r https://dist.plone.org/release/5.2.9/requirements.txt
bin/buildout
```

O il docker compose::

```bash
docker compose build
docker compose up
```

## Produzione

Nei buildout di produzione, va messo il file **versions.cfg** preso da un tag.
In questo modo si ha sempre una lista di versioni consistenti e immutabili.


```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/dist.design.plone/20211126-01/versions.cfg
```

# Docker images

Dal branch __main__ e dai tag vengono create automaticamente immagini Docker linux/amd64 e linux/arm64 rilasciate sul repository gihub

https://github.com/RedTurtle/dist.design.plone/pkgs/container/dist.design.plone

# Quando fare un nuovo tag

Quando si devono fare degli aggiornamenti in produzione, e tutto è pronto e testato, allora si può fare un nuovo tag per fissarle.

Creando anche una release, è possibile andare a descrivere le modifiche che ci sono in quel determinato tag.

Esempio di comando per il tag:

```shell
git tag -a 20211126-01 -m "versioni congelate al 2021-11-26"
```
