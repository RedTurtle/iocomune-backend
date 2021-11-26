# Design Plone Versions

Questo è un repository con le versioni aggiornate delle dipendenze che servono per un sito agid creato con design.plone.policy.

Ci sono due diversi tipi di file di versione:

- **latest.cfg** contiene tutte le versioni più aggiornate delle varie dipendenze
- **yyyymmdd.cfg** contiene le versioni più aggiornate delle dipendenze ad una data specifica

## Come utilizzare questi file

## Staging e sviluppo

__latest.cfg__ è da utilizzare in sviluppo o per i siti di staging, in quanto potrebbe avere delle versioni che non sono ancora pronte per finire in produzione.

```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/dist.design.plone/main/latest.cfg
```



## Produzione

Nei buildout di produzione, va messo uno dei file di versione con la data, in modo da non avere effetti indesiderati rilanciando il buildout.

```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/dist.design.plone/main/20211126.cfg
```


