# Design Plone Versions

Questo è un repository con le versioni aggiornate delle dipendenze che servono per un sito agid creato con design.plone.policy.

Ci sono due diversi tipi di file di versione:

- **latest.cfg** contiene tutte le versioni più aggiornate delle varie dipendenze
- **yyyymmdd.cfg** contiene le versioni più aggiornate delle dipendenze ad una data specifica

__latest.cfg__ è da utilizzare in sviluppo o per i siti di staging, in quanto potrebbe avere delle versioni che non sono ancora pronte per finire in produzione.

Nei buildout di produzione, va messo uno dei file di versione con la data, in modo da non avere effetti indesiderati rilanciando il buildout.

## Come utilizzare questi file

In un buildout, aggiungere l'url tra gli extends:

```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/dist.design.plone/main/latest.cfg
```


