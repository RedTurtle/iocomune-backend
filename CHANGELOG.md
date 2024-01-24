# Changelog

## 20240124-01
- Upgrade redturtle.prentoazioni version to 2.4.3
  - Remove the notifications allowing cross logic [folix-01]

## 20240116-02
- design.plone.contenttypes 6.1.9 -> 6.1.10
  - Added description to PDC fields [pnicolli]
  - Added upgrade step to update PDC fields description [lucabel]
  - Added new widget for event luoghi_correlati [pnicolli]
  - Added UID for all summary obj [eikichi18]

## 20240116-01
- redturtle.prenotazioni = 2.4.2 [cekk]
  - Change notification fields: now there are 3 different behaviors to manage email, appIO and SMS.
    There is an upgrade-step that enables the default one: email.
  - New notification messages defaults with better infos.
  - Added new fields (see redturtle.prenotazioni changelog for more infos).
  - Add notifications management: need a cron job in buildout to work properly (see redturtle.prenotazioni README).
  - Need volto-io-prenoto >= 1.14.0.
  
## 20240111-01
- redturtle.volto 5.4.1 -> 5.4.2
  - Fixed get obj from url in relateditems serializer [filippo]

- design.plone.contenttypes 6.1.8 -> 6.1.9
  - Add UID info to summary serializer of UO [filippo]

## 20231228-01
- redturtle.volto 5.4.0 -> 5.4.1
  - patch for start index of events [filippo]
  - patch for relatediteam [filippo]

## 20231222-01
- design.plone.contenttypes 6.1.7 -> 6.1.8
  - Add behavior argomento to Link CT
  - Removed maximumSelectionSize from all fields that had it greater than 0

## 20231220-01
- Update versions for pas.plugins.ldap dependencies [lucabel]
  - yafowil.plone = 5.0.0a1
  - yafowil.bootstrap = 2.0.0a1

- Merge two section with pas.plusings.ldap dependencies versions [lucabel]

- design.plone.contenttypes 6.1.6 -> 6.1.7
  - Improved "Check notizie" view [lucabel]
  - Fixed label for tassonomia_evento taxonomies [filippo] 

## 20231218-01
- Upgrade Plone 6.0.4 -> 6.0.8 [mamico]
- redturtle.prenotazioni 2.2.5 -> 2.3.0 [cekk]

## 20231215-01
- design.plone.contenttypes 6.1.5 -> 6.1.6
    - Improved "Buone pratiche" view for Event. [daniele]

## 20231213-01
- design.plone.contenttypes 6.1.4 -> 6.1.5
    - Allow reorder of data grid fields.

- design.plone.policy 5.0.6 -> 5.0.7
    - Update list of non searchable type in io-Comune
    - Do not return section children in @search-filters endpoint if they are types omitted from search results.

## 20231204-01
- design.plone.contenttypes 6.1.3 -> 6.1.4
    - Fix check_persone. When there are no relation. [mamico]

## 20231128-01
- design.plone.contenttypes 6.1.2 -> 6.1.3
    - "Buone pratiche" views: fixed check on Competenze field. Excluding expired events and news. [daniele]

## 20231127-01
- design.plone.contenttypes 6.1.0 -> 6.1.2
    - Added utility views: @@check-notizie and @@download-check-notizie. [daniele]
    - Fix event for obj parent update. [eikichi18]
    - Added utility views: @@check-eventi and @@download-check-eventi. [daniele]
    - Added utility views for Venue: @@check-luoghi and @@download-check-luoghi. [daniele]
    - Added utility view for Documento:  @@check-documenti and @@download-check-documenti. [daniele]
    - Added utils view for UO:  @@check-uo and @@download-check-uo. [daniele]
    - Added utility views for Persona: @@check-persone and @@download-check-persone. [daniele]


- plone.event 2.0.0 -> 2.0.1 [mamico]
    - fix gestione ricorrenze https://github.com/plone/plone.event/pull/23

- design.plone.contenttypes 6.0.21 -> 6.1.0 [mamico]
    - Optionally add image_scales and image_field in Summary serializer. [mamico]
    - Add @@design-utils view that shows all available utility views. [cekk]
    - Add user action that points to @@design-utils view. [cekk]
    - Add @@export-incarichi view that allows to download a csv file with all - Persona and their roles. [cekk]
    - Add tipologia_bando to summary serializer. [cekk]

- redturtle.volto 5.3.0 -> 5.4.0 [cekk]
  - Return error instead of raise Excpetion for BadRequest in querystringsearch [mamico]
  - Add upgrade step and setuphandler to fix robots.txt original rules adding 'Allow: /?expand' [lucabel]

## 20231030-02

- design.plone.contenttypes 6.0.20 -> 6.0.21 [cekk]
  - Fix Upgrade-step to set default value in "Costi" field.

## 20231030-01

- design.plone.contenttypes 6.0.19 -> 6.0.20 [cekk]
  - Upgrade-step to set default value in "Costi" field.

## 20231027-01

- redturtle.volto 5.2.4 -> 5.3.0 [cekk]

## 20231026-01

- design.plone.contenttypes 6.0.18 -> 6.0.19 [pnicolli]
  - Event field "Costi" is now required
  - Fix typo in field help text

## 20230926-01

 - redturtle.volto 5.2.3 -> redturtle.volto 5.2.4 [lucabel]
   - Fix the issue in the @translation GET endpoint: If this endpoint 
     is invoked, possibly by a bot, and plone.app.multilingual is not
     installed, the call will result in an empty search query on the catalog. 
     [lucabel]
   - backport https://github.com/plone/Products.CMFPlone/pull/3845 fix: avoid 
     searching all users when many_users is flagged [mamico] 

## 20230920-01

 - design.plone.contenttypes 6.0.17 -> design.plone.policy 6.0.18 [lucabel]
   - Add permission check to solve problem accessing private resources with anonymous user [lucabel]

## 20230829-01

 - design.plone.policy 5.0.5 -> design.plone.policy 5.0.6[folix-01]
   - Fix to 3001 upgrade step. [folix-01]

## 20230906-01

- Upgrade design.plone.contenttypes 6.0.16 -> 6.0.17 [eikichi18]
  - added dates for incarico persona [deodorhunter]


## 20230829-01
 - design.plone.policy 5.0.5 -> design.plone.policy 5.0.6[folix-01]
   - Fix to 3001 upgrade step. [folix-01]


## 20230824-01

  
- redturtle.volto 5.0.0 -> 5.0.1 [mamico]
  - Custom portal url in @@fix-links [mamico]

- collective.z3cform.datagridfield 3.0.0 -> 3.0.1 [mamico]

- redturtle.bandi 1.4.2 -> 1.4.3 [mamico]
  -  Fix workaround for Link bug (?) (remoteUrl in catalog) [mamico]
  -  Feat url dei file compleata con filename [mamico]
  -  Fix invalid tipologie_bando [mamico]

- redturtle.rssservice 2.0.0 -> 2.2.0 [mamico]
  - Allow configuring the User-Agent for the requests to get feeds, via the REQUESTS_USER_AGENT environment variable. [davisagli]
  - Customizable timeout. [cekk]
  - Return 404 if block not found instead BadRequest. [cekk]
  - Handle site root blocks in plone 6. [cekk]

- plone.restapi 8.37.0 -> 8.41.0 [cekk]
  -  Fix path2uid method, to handle suffix with non-traversable objects [cekk]

- Upgrade design.plone.contenttypes 6.0.15 -> 6.0.16 [eikichi18]
  - chaged migration of compensi and importi_di_viaggio field on Incaricto ct
    creation. [eikichi18]
  - Fixed relation between person and uo. [deodorhunter]

## 20230620-01

- Upgrade design.plone.contenttypes 6.0.10 -> 6.0.11 [eikichi18]
  - Added image_scales field in service of ScadenziarioDay

## 20230619-01

- Upgrade design.plone.contenttypes 6.0.9 -> 6.0.10 [eikichi18]
  - removed required from persone_struttura field
  - removed preview_caption

## 20230613-01

- Upgrade design.plone.policy 5.0.2 -> 5.0.3 [cekk]
  - Fix creation script: now set default blocks and blocks_layout.

## 20230525-01

- Upgrade Plone 6.0.3 -> 6.0.4
  [mamico]

- Upgrade design.plone.policy 5.0.0 -> 5.0.2 [mamico]
  - Fix setuphandlers' utils for robotframework
  - Add X-ForceAuth header and iw.rejectanonymous
  - Customize Access inactive portal content permission to allow access these contents also for not manager users.

- Upgrade design.plone.contenttypes 6.0.8 -> 6.0.9 [sabrina-bongiovanni]
  - Used isoformat for scadenziario-day time field in summary

## 20230504-02

- Upgrade design.plone.contenttypes 6.0.7 -> 6.0.8
  Fix bug in Persona summary serializer with "incarichi"
  field
  [lucabel]

## 20230504-01

- Upgrade design.plone.contenttypes 6.0.6 -> 6.0.7
   Made servizio/canale_fisico optional
   Update check_servizi
  [lucabel]

## 20230428-02

- Upgrade design.plone.contenttypes 6.0.5 -> 6.0.6
   Added images serialization to the summary serializer of the UO content type;
   If both the image and preview image are present, the 'image_field' attribute
   is forced to contain 'preview_image'.
  [lucabel]

## 20230428-01

- Upgrade design.plone.contenttypes 6.0.4 -> 6.0.5
    Remove address, city, zip_code, nome_sede, title,
    quartiere, circoscrizione, street from UO summary
    serializer and add sede in thery place in the
    UO summary serializer
  [lucabel]

- Upgrade Plone 6.0.1 -> 6.0.3
          plone.patternslib 1.1.1 -> 1.3.0
          plone.rest 2.0.0 -> 3.0.0
          z3c.unconfigure 1.1 -> 2.0
  [mamico] 

## 2023????-??

- Upgrade redturtle.volto 5.0.0a1 -> 5.0.0
  [mamico]

## 20230209-04 (2023/02/09)

- Removed update-image.yml
- Update build.yml
- Update github action

## 20230209-03 (2023/02/09)

## 20230209-02 (2023/02/09)

## 20230209-01 (2023/02/09)

- Update update-image.yml
  [eikichi18]
- Upgrade Plone 6.0.0.2 -> 6.0.1
  [mamico] 

## 20230208-03 (2023/02/08)

## 20230208-02 (2023/02/08)

## 20230208-01 (2023/02/08)

## 20230206-01 (2023/02/06)

## 20230202-01 (2023/02/02)

## 20230127-02 (2023/01/27)

## 20230127-01 (2023/01/27)
