# Changelog

## 20240417-01
- Update design.plone.contenttypes 6.2.3 -> 6.2.5
    - check-servizi: fixed check on relation title. [daniele]

## 20240416-01
- Update redturtle.prenotazioni 2.6.1 -> 2.6.3
    - avoid gate collision [mamico]
    - Bypass notBeforeDays when using the @available-slots to find the first bookable slot(used by BookingManager). [folix-01]
    - Fix day endpoint to show the available scheduling for the same day as start date. [folix-01]
    - Manage the user's phone attribute in booking-schema [mamico]
- Update design.plone.policy 5.0.7 -> 5.0.8
  [folix-01]
- Add collective.volto.slimheader version
  [folix-01]
- Update design.plone.contenttypes 6.2.2 -> 6.2.3
   - Image are no longer required in venue [lucabel]

- Update design.plone.policy 5.0.8 -> 5.0.9
   - Fix test [lucabel]


## 20240411-01

- Update design.plone.ioprenoto 1.2.3 -> 1.2.4
  b_size del vocabolario delle tipologie di prenotazione (usato per il pulsante
  delle prenotazioni) a 200, il default era 25
  [mamico]

## 20240405-01

- New dependency: collective.volto.gdprcookie
  [cekk]
- Upgrade collective.volto.enhancedlinks 1.0.0 -> 1.1.0
  - Add tool to manage infos, removed memoize machinery [mamico]
  
## 20240402-01

- Update redturtle.prenotazioni 2.5.2 -> 2.6.1
  - Return empty data from the @day endpoint if requested date is out of PrenotazioniFolder range [folix-01]
  - Fix double gate bug. [folix-01]
  - first_available flag for the @available-slots endpoint. [folix-01]
  - Fix double gate when it is repeated in more than one week table overrides. [folix-01

## 20240319-02
  - Upgrade collective.feedback 1.0.0 -> 1.1.2
    - Fix typo in actions.xml permission. [cekk]
    - 
## 20240319-01

- Update redturtle.prenotazioni 2.5.0 -> 2.5.2
  - Fix rolemap [lucabel]
  - Add manager notification on booking canceled [folix-01]
  - Add the years range configuration to week table overrides. [folix-01]
  - Bypass the today delete limit for the 'out-of-office' types. [folix-01]
  - Change the booking notification flag label. [folix-01]

- Update collective.feedback 1.0.0 -> 1.1.1
  - Only managers can access deleted feedbacks.
    [cekk]
  - Allow all authenticated users to access @feedback endpoint.
    The endpoint will return only feedbacks on objects that they can edit.
    [cekk]
  - Improve tests.
    [cekk]
  - Install souper.plone to have its control-panel in backend.
    [cekk]
  - Add `actions` infos in @feedback endpoint, to let the frontend know what the user can do.
    [cekk]

- redturtle.voltoplugin.editablefooter 1.1.2 -> 1.3.2
  - Serie di release inutili ma che non si potevano cancellare. Andiamo avanti per restare allineati. [cekk]

- update design.plone.contenttypes 6.2.0 -> 6.2.2
  - Added check for blocks field in check_luoghi view [eikichi18]
  - UnitaOrganizzativa.assessore_riferimento title internationalize. [folix-01]
  - @@check-servizi: provides also the full list of servizi. [daniele]

- update redturtle.volto 5.4.7 -> 5.4.8
  - Do not try to convert strings in internal paths for form blocks. [cekk]
  - Handle None values in link integrity blocks adapter. [cekk]
  - Patch in @querystring-search that avoid to search through all the
    site if there is an absolutePath criteria with non existing UID
    and b_size==1. See #99 for more details. [cekk]

- update design.plone.ioprenoto 1.2.2 -> 1.2.3
  - Fix problem with DefaultJSONSummarySerializer hineritance in
    prenotazioniFolder DefaultJSONSummarySerializer override. [lucabel]
  - Add the plone.restapi>=9.6.0 constaint. [folix-01]

## 20240306-03
- Upgrade collective.purgebyid 1.2.0 -> 1.2.2 
  - plone 6.0 / python 3.11, 3.12 support [mamico]

## 20240306-02
- Upgrade redturtle.volto 5.4.5 -> 5.4.6
  - Added check if value is a dict before using get method. [eikichi18]

## 20240306-01
- Upgrade design.plone.contenttypes 6.1.14 -> 6.1.15
- Upgrade redturtle.prenotazioni 2.4.9 -> 2.5.0

## 20240305-02
- Upgrade Plone 6.0.8 -> 6.0.10.1 [mamico]
- Added pin for bravado (App IO) [mamico]

## 20240305-01
- Upgrade redturtle.volto 5.4.4 -> 5.4.5 and pick plone.restapi version to 9.6.0 (early it was undirectly picked to 9.1.2)

## 20240222-01
- Upgrade redturtle.prenotazioni 2.4.8 -> 2.4.9
  - Improved check on fiscal code when booking considering max user limit. [daniele]

## 20240220-01
- Upgrade design.plone.contenttypes 6.1.13 -> 6.1.14
  - Fix in @scadenziario endpoint: return future events if afterToday criteria is set. [cekk]
  - Set base view to News Item, to do not break on Classic Plone. [cekk]
  - Change description for field sede in UnitaOrganizzativa CT.
  - Fixed typo in update_note field description. [eikichi18]

- Upgrade redturtle.volto 5.4.3 -> 5.4.4
  - Add adapters for link integrity for content-types with BlocksField fields. [cekk]
  - Fix: occurrences indexing [mamico]

## 20240216-01
- Upgrade redturtle.prenotazioni 2.4.7 -> 2.4.8
  - No cache per restapi available_slots, available_slots changes frequently and anonymous users need to see the updated data. [mamico]
  - Remove acquisition when getting version_id in on_modify event handler. [cekk]

## 20240212-02
- Upgrade redturtle.prenotazioni 2.4.6 -> 2.4.7
  - Permission for move bookings for booking managers [mamico]

## 20240212-01
- Upgrade redturtle.prenotazioni 2.4.5 -> 2.4.6
  - Permission for move bookings for booking managers [mamico]
  - Use the yaml file to configure the AppIO keys [folix-01]

## 20240608-01
- Upgrade design.plone.contenttypes 6.1.12 -> 6.1.13
  - Handle missing show_dynamic_folders_in_footer in registry entry. [cekk]

## 20240206-01
- Upgrade design.plone.contenttypes 6.1.10 -> 6.1.12
  - removed un-needed commit in upgrade-step [cekk]

## 20240201-01
- Upgrade redturtle.prenotazioni version to 2.4.5
  - sort_on/sort_order in restapi bookings and xlsx [mamico]

## 20240130-01
- Upgrade redturtle.volto 5.4.3
  - Upgrade step to remove all custom Googlebot rules from robots.txt [mamico]
  - Fix: add range_start to function for calculate recurrences in the right way [eikichi18]

## 20240129-01
- Upgrade design.plone.ioprenoto 1.2.2
  - Fix encoding booking_type vocab [mamico]

## 20240125-01
- Upgrade redturtle.prenotazioni version to 2.4.4 [folix-01]
  - Update the sms notifications behaviour's field label [folix-01]

## 20240124-01
- Upgrade redturtle.prentoazioni version to 2.4.3 [folix-01]
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
