# Design Plone Versions

Repository con le versioni aggiornate delle dipendenze che servono per un sito agid con le nuove specifiche per il pnrr creato con backend Plone 6.0+ e https://github.com/italia/design-comuni-plone-theme (Frontend Volto/ReactJS).

Lo stesso tag serve **tre linee Plone**: 6.0, 6.1 e 6.2.

## Quale file estendere

| Linea | File da estendere | Versione Plone | Python minimo | Python supportati |
|-------|-------------------|----------------|---------------|-------------------|
| 6.0   | `plone60.cfg`     | 6.0.15         | **3.9**       | 3.9 → 3.13        |
| 6.1   | `plone61.cfg`     | 6.1.5          | **3.10**      | 3.10 → 3.13       |
| 6.2   | `plone62.cfg`     | 6.2.1 (sperimentale) | **3.10** | 3.10 → 3.14    |

Minimo e supportati sono quelli dichiarati da `Products.CMFPlone` per la versione pinnata.
La CI esegue il buildout di **tutte e tre le linee sia con Python 3.11 sia con 3.12**.

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
make buildout LINE=61              # opzionale: PYTHON=3.12
# equivalente a: bin/pip install -r requirements61.txt && bin/buildout -c development61.cfg
```

> Cambiando linea **va ricreato il venv**: ogni release Plone richiede una `zc.buildout` diversa
> (4.1.4 per la 6.0, 4.2.0 per la 6.1, 5.2.0 per la 6.2), che arriva dal `requirementsXX.txt`
> della release stessa, e cambia anche la versione di Python. Il target `make buildout` fa
> entrambe le cose da solo (`pyenv local` + venv nuovo).

### zope.interface 8 e i namespace package

Dalla 6.1 `zope.interface` usa i [native namespace package](https://peps.python.org/pep-0420/).
Con buildout gli egg finiscono in path separati, il namespace `zope` non si compone e l'istanza
muore con `ModuleNotFoundError: No module named 'zope.interface'`. La soluzione è
[horse-with-no-namespace](https://pypi.org/project/horse-with-no-namespace/), che **va installato
con pip nello stesso virtualenv di zc.buildout, non da buildout** (altrimenti il suo `.pth` non
viene caricato). Sulla 6.2 arriva già dal `requirements.txt` della release; sulla 6.1 lo
aggiungiamo noi (vedi `EXTRA_PINS_61` nel Makefile e la matrice in `buildout.yml`).
Il percorso docker non è interessato: lì pip installa tutto in un unico `site-packages`.

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

**Un pacchetto, un file**: lo stesso egg non deve comparire in due file di `versions/`. Buildout non
segnalerebbe nulla — a seconda dell'ordine degli `extends` vincerebbe l'uno o l'altro — quindi il
caso è intercettato da un controllo apposito, che fallisce anche quando le due versioni coincidono:

```bash
make lint     # scripts/lint-versions.sh, lo stesso che gira in CI
```

Il confronto usa i nomi normalizzati come fa pip (PEP 503: maiuscole e `-` `_` `.` equivalenti), così
cadono nella rete anche grafie diverse dello stesso pacchetto. Un pin presente sia in un file
condiviso sia nella `[versions]` di un `ploneXX.cfg` non viene invece segnalato: quello è l'override
per-linea, ed è voluto.

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

Questi file sono **generati**, non vanno modificati a mano:

- `dependabot/plone60/requirements.txt`, `dependabot/plone61/...`, `dependabot/plone62/...`
- `sbom/plone60.spdx.json`, `sbom/plone61.spdx.json`, `sbom/plone62.spdx.json`

Dopo aver toccato un pin, nella PR basta rigenerare i requirements — **gli SBOM li rigenera il
workflow al merge su `main`**:

```bash
make dependabot-update
```

Ci sono poi `make sbom-update` (solo gli SBOM) e `make generated-update`, che li rigenera entrambi
quando serve allinearli a mano.

I target girano **dentro un container** (`docker/Dockerfile.generator`): serve solo docker, non il
python o il virtualenv locale. La CI usa esattamente gli stessi comandi, quindi l'output è identico
ovunque e nei file non finiscono path della macchina che li ha prodotti (un check in CI lo verifica).

Gli SBOM sono generati con [syft](https://github.com/anchore/syft): legge i requirements offline
(nessuna chiamata di rete per nome/versione/purl) e usa la rete solo per arricchire le licenze
(`SYFT_PYTHON_SEARCH_REMOTE_LICENSES`), con una cache persistente per pacchetto — un bump di uno o
due pin richiede quindi solo qualche secondo di rete, non l'intera rigenerazione. In precedenza si
usava `sbom4python`, che per ogni pacchetto lanciava `pip show` più una query a PyPI: con ~600 pin
costava da 1,5 a oltre 10 minuti a linea secondo la rete, contro pochi secondi di syft a cache calda.
Lo script precedente resta commentato in `scripts/sbom-update.sh` per un eventuale ripristino.

Venv, wheel di pip, cfg remoti di buildout e cache delle licenze di syft sono tenuti in `.cache/`
(ignorata da git e ripristinata in CI): la prima esecuzione richiede alcuni minuti (soprattutto per
l'arricchimento licenze), le successive pochi secondi. `make clean-cache` la svuota.

**Nelle PR i file vengono solo verificati**: se sono obsoleti il job `requirements.txt` fallisce e
commenta la PR con il diff e il comando da lanciare. Il commit automatico avviene solo su push a
`main` — nelle PR non lo facciamo più perché un commit fatto con `GITHUB_TOKEN` non ri-triggera i
workflow, e l'head della PR restava senza i check veri facendola sembrare verde anche con la CI
rossa.

Dependabot apre le PR su questi file, uno stream per linea: **lo stesso bump può quindi generare
fino a tre PR**. La modifica va poi riportata a mano nel `versions/*.cfg` condiviso (o nel
`ploneXX.cfg` se riguarda una sola linea), altrimenti al giro successivo la rigenerazione la perde.

# Quando fare un nuovo tag

Quando si devono fare degli aggiornamenti in produzione, e tutto è pronto e testato, allora si può fare un nuovo tag per fissarle.

Creando anche una release, è possibile andare a descrivere le modifiche che ci sono in quel determinato tag.

Esempio di comando per il tag:

```shell
git tag -a 20211126-01 -m "versioni congelate al 2021-11-26"
```

Con il tag viene triggerata una pipeline all'interno di questo repo gitlab: https://gitlab.com/redturtle/io-comune/dist.backend.iocittadino, che aggiorna gli altri siti di test 
