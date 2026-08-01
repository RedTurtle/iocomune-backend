# Design Plone Versions

Repository con le versioni aggiornate delle dipendenze che servono per un sito agid con le nuove specifiche per il pnrr creato con backend Plone 6.0+ e https://github.com/italia/design-comuni-plone-theme (Frontend Volto/ReactJS).

Lo stesso tag serve **tre linee Plone**: 6.0, 6.1 e 6.2.

## Quale file estendere

| Linea | File da estendere | Versione Plone |
|-------|-------------------|----------------|
| 6.0   | `plone60.cfg`     | 6.0.15         |
| 6.1   | `plone61.cfg`     | 6.1.5          |
| 6.2   | `plone62.cfg`     | 6.2.1 (sperimentale) |

`versions.cfg` esiste ancora ed è un **alias della linea di default (6.0)**: i buildout che lo
estendono già oggi continuano a funzionare senza modifiche. I progetti nuovi conviene che estendano
direttamente il file della linea che usano.

> **Attenzione**: `versions.cfg` e i `ploneXX.cfg` ora includono altri file con path relativi.
> Vanno **estesi via URL**, non copiati nel proprio repository: una copia isolata del solo
> `versions.cfg` non riesce a risolvere gli include.

## Staging e sviluppo

I file che si trovano nel branch __main__ sono da utilizzare in sviluppo o per i siti di staging, in quanto potrebbero avere delle versioni che non sono ancora pronte per finire in produzione.

```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/iocomune-backend/main/plone61.cfg
```

E' possibile eventualmente anche usare il buildout.cfg presente in questo repository

```bash
python3.11 -m venv .
bin/pip install -r requirements.txt
bin/buildout
```

Per lavorare su una linea diversa dalla default si usa il `make` con `LINE`:

```bash
make buildout LINE=61
# equivalente a: bin/pip install -r requirements61.txt && bin/buildout -c development61.cfg
```

> Cambiando linea **va ricreato il venv**: ogni release Plone richiede una `zc.buildout` diversa
> (4.1.4 per la 6.0, 4.2.0 per la 6.1, 5.2.0 per la 6.2), che arriva dal `requirementsXX.txt`
> della release stessa. Il target `make buildout` lo ricrea da solo.

O il docker compose::

```bash
docker compose build
docker compose up
```

## Produzione

Nei buildout di produzione, va estesa la linea Plone desiderata presa da un tag.
In questo modo si ha sempre una lista di versioni consistenti e immutabili.


```
[buildout]

extends =
    ...
    https://raw.githubusercontent.com/RedTurtle/iocomune-backend/*tag*/plone61.cfg
```

Estendere sempre un **tag** e non un branch: gli include sono risolti sullo stesso ref, e con
`extends-cache` attivo un branch può servire un mix di file cache-ati e freschi.

# Come si modificano le versioni

I pin sono divisi tra file condivisi da tutte le linee Plone e pin specifici di una linea.

| Cosa | Dove |
|------|------|
| `design.plone.*`, `collective.volto.*`, `redturtle.*`, `rer.*` | `versions/iocomune.cfg` |
| iocittadino, protocollo, pagamenti, notifiche App IO (bravado) | `versions/iocittadino.cfg` |
| io-segnalo | `versions/iosegnalo.cfg` |
| io-prenoto | `versions/ioprenoto.cfg` |
| souper, RelStorage, LDAP, wsgi, oidc, recipe di buildout, docx | `versions/infra.cfg` |
| `[iocomune] version`, pin comuni di sicurezza | `versions/base.cfg` |
| pacchetti volutamente non pinnati (`setuptools`, `zc.buildout`) | `versions/unpin.cfg` |

**La regola**: un pin sta in `versions/*.cfg` e si modifica **una volta sola** per tutte e tre le
linee. Va invece nella sezione `[versions]` di `ploneXX.cfg` **solo se** quella linea richiede un
valore diverso — tipicamente perché la release di Plone ne distribuisce già uno più nuovo. Esempio:
`collective.z3cform.datagridfield` è 3.0.1 sulla 6.0, 3.0.5 sulla 6.1 e 4.0.2 sulla 6.2, quindi vive
nei tre `ploneXX.cfg` e non nel file condiviso.

Due vincoli tecnici di buildout da tenere presenti:

- negli `extends` **non** funziona la sostituzione `${sezione:chiave}`: la versione Plone va scritta
  letteralmente, ed è il motivo per cui esiste un file per linea;
- per **togliere** un pin si usa `pkg =` (valore vuoto); `-=` non funziona sulle versioni.

## Cambiare la linea di default

Sono quattro one-liner: `versions.cfg`, `development.cfg`, `requirements.txt` e
`docker/constraints.cfg` sono tutti alias che puntano alla linea di default.

# Docker images

Dal branch __main__ e dai tag vengono create automaticamente immagini Docker linux/amd64 e linux/arm64 rilasciate sul repository gihub

https://github.com/RedTurtle/iocomune-backend/pkgs/container/iocomune-backend

Viene pubblicata **un'immagine per linea Plone**, con il suffisso nel tag:

| Tag | Contenuto |
|-----|-----------|
| `<tag>-plone60` | Plone 6.0 |
| `<tag>-plone61` | Plone 6.1 |
| `<tag>-plone62` | Plone 6.2 |
| `<tag>` | alias della linea di default (6.0) |

Lo stesso schema vale per le immagini di acceptance (`iocomune-backend-acceptance`) e per quelle di
sviluppo (`<branch>_development-plone61`, con `<branch>_development` come alias della default).

## Immagini di sviluppo

E' possibile generare delle immagini per demo con pacchetti in sviluppo non ancora rilasciati.

Per fare questo, basta creare un branch e modificare il file mx.ini (file di configurazione per [mxdev](https://pypi.org/project/mxdev)).

Nel file si possono impostare versioni custom e anche attivare pacchetti in sviluppo.

Non viene generata in automatico l'immagine (per evitare build inutili).
Per far partire una nuova build, basta far partire l'azione manualmente: https://github.com/RedTurtle/iocomune-backend/actions

Verrà creata un'immagine chiamata `nome_del_branch_development` (dove nome_del_branch è il nome del branch ovviamente) su https://ghcr.io/redturtle/iocomune-backend

# File generati

Questi file sono **prodotti dalla CI**, non vanno modificati a mano:

- `dependabot/plone60/requirements.txt`, `dependabot/plone61/...`, `dependabot/plone62/...`
- `sbom/plone60.spdx.json`, `sbom/plone61.spdx.json`, `sbom/plone62.spdx.json`

Dependabot apre le PR su questi file, uno stream per linea: **lo stesso bump può quindi generare
fino a tre PR**. La modifica va poi riportata a mano nel `versions/*.cfg` condiviso (o nel
`ploneXX.cfg` se riguarda una sola linea), altrimenti al giro successivo il workflow rigenera il file
e la perde.

# Quando fare un nuovo tag

Quando si devono fare degli aggiornamenti in produzione, e tutto è pronto e testato, allora si può fare un nuovo tag per fissarle.

Creando anche una release, è possibile andare a descrivere le modifiche che ci sono in quel determinato tag.

Esempio di comando per il tag:

```shell
git tag -a 20211126-01 -m "versioni congelate al 2021-11-26"
```

Con il tag viene triggerata una pipeline all'interno di questo repo gitlab: https://gitlab.com/redturtle/io-comune/dist.backend.iocittadino, che aggiorna gli altri siti di test 
