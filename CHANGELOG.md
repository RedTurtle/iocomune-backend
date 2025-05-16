# Changelog

## YYYYMMDD-VV
- design.plone.iocittadino 1.2.3 -> 1.2.4
  - Fix: gestione date nell'history e nel report pdf, nel serializzatore della history forzato, anche in retrocompatibilità
    per tornare la data in iso senza millisecondi
    [mamico]

## 20250515-01
- redturtle.prenotazioni 2.8.6 -> 2.8.8
  - Fix get_busy_slots_in_period method to handle also borderline bookings (for example that starts inside a slot, but ends after). [cekk]
  - @bookings endpoint returns 400 if no search parameters are passed. [folix-01]

## 20250509-01
- redturtle.volto 5.5.9 -> 5.5.10
  - Fissato problema con ricerca eventi. c'è un override di querystring-search
    che sovrascrive la ricerca eventie cambia date timezon aware in utc.
    questo lo deve fare solo restapi quando serializza. l'effetto è che una ricerca
    per start date today@00:00 diventa start = today-1@22:00 
    [lucabel]

## 20250507-01
- design.plone.iocittadino 1.2.1 -> 1.2.3
  - Migliorata gestisce file nel report
    [mamico]
  - Implementa tipologia campo dropdown nei report pdf
    [mamico]
  - Convert pratica_model in str for json serialization.
    [cekk]
  - Extend praticas history + add it to serialized pratica data.
    [folix-01]
  - workaround: il vocabolario degli operatori non si rompe a fronte di eventuali disservizi (ad esempio
    LDAP che non risponde)
    [mamico]
  - Fix serilizzazione blob di campi non più presenti nello schema
    [ mamico]
  - Fix record eventi history legacy
    [mamico]


## 20250409-01
- redturtle.volto 5.5.8 -> 5.5.9
  - Make sure that the teaser block is not handled by the GenericResolveUIDDeserializer/Serializer. [lucabel]
- design.plone.contenttypes 6.3.5 -> 6.3.6
  - FIx upgrade step to upgrade persona ct [lucabel]

## 20250403-03
- collective.volto.sitesettings 1.0.4 -> 1.0.5
  - Add option to hide title. [cekk]

## 20250403-02
- design.plone.contenttypes 6.3.4 -> 6.3.5
  - Fix upgrade step; we can't update types due to customer customizations; we need to fix single parts of type profiles [lucabel]
  - Remove limit to "assessore_di_riferimento" in UO [lucabel]
  - Add upgrade-step to add missing metadata for image captions. [cekk]
  - Add "data fine effettiva" for events, to order listing correctly [lucabel]
  - Fix typo in Venue serializer that didn't return the right history version. [cekk]
  - Add "Emolumenti a carico della finanza pubblica" to Persona Add "Dichiarazioni di insussistenza e incompatibilità" to Persona [lucabel]

## 20250403-01
- redturtle.bandi 1.5.1 -> 1.6.0
  - Add new criteria for bando_state. [folix-01]
- pin delle versioni di oidc, precedentemente pinnate sulle singole installazioni che lo usano
- pas.plugins.jwt 1.0a4 -> 1.0.2
  - gestione ruolo Citizen [mamico]
  - aggiuntoa gestione chiave asimmetrica [mamico]
- redturtle.filesretriever 1.0.1 -> 1.0.3
  - Add custom Cipher adapter for requests session to allow download files from servers with old/wrong ssl certs. [cekk]

## 20250314-01
- collective.geolocationbehavior 1.7.1 -> 1.7.2
  - Updated collective.geolocationbehavior version to fix translation in geolocation. [daniele]

## 20250312-01
- redturtle.bandi 1.5.0 -> 1.5.1
  - Fix upgrade-step to not broke on missing values. [cekk]

## 20250310-01
- plone.autoinclude 2.0.1
  [pnicolli]

## 20250307-02
- collective.volto.formsupport 3.2.2 -> 3.2.3
  - Add current form columns to CSV export event if field are empty and export obsolete fields ordered after current ones.
    [folix-01]

## 20250307-01
- collective.volto.formsupport 3.1.5 -> 3.2.2
  - Format list values in format_fields as comma separated strings to improve readability on email messages. [cekk]
  - Adapt email subject templating functionality to different value types. [folix-01]
  - Added an adapter (IDataAdapter) to allow information to be added as a return value to the form-data expander. This allows addons that integrate information to be added rather than overwriting the expander each time. [mamico]
  - Add FormSubmittedEvent to handle the new compiled forms. [folix-01]
  - Add PostAdapter to predispose the customization of data handling by other add-ons. [folix-01]
- design.plone.policy 5.0.14 -> 5.0.15 [cekk]
  - Align formsupport patches with collective.volto.formsupport >= 3.2.0. [cekk]
- design.plone.contenttypes 6.3.3 -> 6.3.4
  - Added download xlsx of users in design-utils [mamico]
  - Change number of related assessore_riferimento [lucabel]
  - Add File to CT Documento but hide it from volto add menu [lucabel] 

## 20250305-01
- design.plone.iocittadino 1.2.0 -> 1.2.1
- design.plone.ioprenoto 1.2.9 -> 1.2.10
  gestione onceonly ioprenoto (campi email e telefono vengono mantenuti se l'utente è autenticato
  e iocittadino attivo)

## 20250303-01
- design.plone.iocittadino 1.1.5 -> 1.2.0
  - TODO: quando si porta questo su ioComune va valutato se mettere nella release.md di iocittadino
    le migliorie sul pdf e sulle notifiche email
  - molte modifiche relative alla formattazione delle mail e del pdf (vedere changelog) [mamico]
  - modifiche per la gestione del protocollo in uscita [lucabel]
- plone.restapi 9.9.0 -> 9.10.0
  https://github.com/plone/plone.restapi/blob/main/CHANGES.rst#9100-2025-01-27
  (in particolare problema di mimetype, che genera errori nell'endpoint navigation quando vengono
  usati file come pdf firmati, e lockinfo che generea errori se il servizio ldap non performa
  correttamente)
- design.plone.contenttypes 6.3.2 -> 6.3.3
  - dependency with redturtle.bandi >= 1.5.0 [cekk]
- redturtle.bandi 1.4.7 -> 1.5.0
  - [BREAKING..NEED UPGRADE-STEP] Do not use key/value pairs in tipologia_bando and destinatari.
  [cekk]
  - Refactor retrieveContentsOfFolderDeepening to be more pluggable and use hooks for content-types based additional data.
  [cekk]
- design.plone.contenttypes 6.3.2 -> 6.3.2.1 
  - Change max number of related assessore_riferimento from 1 to 2 [lucabel]
- collective.feedback 1.1.5 -> 1.2.0
  - Add feature to give feedback to view without context [eikichi18]

## 20250211-01
- collective.volto.sitesettings 1.0.3 -> 1.0.4
  - Add absolute_url method in registry-images view for compatibility with plone.namedfile >= 6.4.0. [cekk]

## 20250206-01
- design.plone.policy 5.0.13 -> 5.0.14 [eikichi18]
  - Fix volto.formsupport path to not alter returned data on POST (#74). [cekk]
- design.plone.contenttypes 6.3.0 -> 6.3.2 [eikichi18]
  - Update it translations [lucabel]
  - Removed moduli limitation on Documento CT serializer. [eikichi18]
  - Fix sorting in @scadenziario-day endpoint. [folix-01]
  - add SEO behavior to File [mamico]
  - Added the metadata preview_caption and image_caption. An upgrade step is not necessary because the metadata will primarily be used for new content. [mamico] 

## 20250129-02
- redturtle.prenotazioni 2.8.4 -> 2.8.6 [cekk]
  - Add also fiscalcode to stringinterp variables. [cekk]
  - Add booking code as qrcode attachment in email messages [mamico]

## 20250129-01
- Plone 6.0.13 -> Plone 6.0.14 [mamico]
- collective.feedback 1.1.3 -> 1.1.5
    - Feedbacks list update endpoint @@feedback-list. [folix-01]
    - Add feedback update endpoint. [folix-01]
    - Add read field to the comment. [folix-01]
- design.plone.iocittadino 1.1.2 -> 1.1.5
    - Forwarding pratica change state event to the message add method
      in order to handle events on the message itself
      [lucabel]
    - Add protocollo chiusura to pdf pratica
      [lucabel]
  
## 20252201-02
- pas.plugins.ldap 1.8.2 -> 1.8.3 [mamico]
  - Fix: use exact_match for searchUsers/searchGroups in getRolesForPrincipal/getPropertiesForUser to avoid unexpected results
- design.plone.ioprenoto 1.2.8 -> 1.2.9
  - update rolemap [cekk]

## 20241212-02
- redturtle.volto 5.5.7 -> 5.5.8 [lucabel]
  - update translations

## 20241212-01
- Remove eea.api.taxonomy dependency [cekk]
  - collective.taxonomy 3.0.1 -> 3.1.5
  - design.plone.contenttypes 6.2.24 -> 6.3.0
  - design.plone.policy 5.0.11 -> 5.0.13
- collective.volto.blocksfield 2.1.0 -> 2.2.0 [cekk]
- Upgrade for translations [lucabel]
 - plone.app.locales 6.0.25 -> 6.0.26 [lucabel]
 - collective.volto.dropdownmenu 1.3.1 -> 1.3.2
 - collective.volto.gdprcookie 1.0.3 -> 1.0.4
 - collective.volto.secondarymenu 1.1.0 -> 1.1.1
 - collective.volto.slimheader 1.0.1 -> 1.0.2
 - collective.volto.socialsettings 0.2.1 -> 0.2.2 
 - collective.volto.subfooter 1.1.0 -> 1.1.1
 - collective.volto.subsites 1.5.0 -> 1.5.1
 - redturtle.voltoplugin.editablefooter 1.3.3 -> 1.3.4
 - redturtle.bandi 1.4.6 -> 1.4.7
 - design.plone.contenttypes 6.3.0 -> 6.3.1

## 20241204-01
- redturtle.volto 5.6.1 -> 5.5.7
  - Downgrade to lose support to linkintegrity check in slate's block [eikichi18]

## 20241202-01
- redturtle.prenotazioni 2.8.2 -> 2.8.4
  - 2.8.3 (2024-11-28)
    - @bookings-export filters hotfix. [folix-01]
  - 2.8.4 (2024-12-02)
    - Change date validation order, if the validated day is vacation, it is not possibile to book. [folix-01]
    - Lower log level for AppIO exceptions [folix-01]

## 20241127-03
- redturtle.prenotazioni 2.8.1 -> 2.8.2
  - 2.8.2 (2024-11-27)
    - Fix translation mechanism for exceptions. [folix-01]
    - bookings-export remove default filter values. [folix-01]

## 20241127-02
- redturtle.prenotazioni 2.8.0 -> 2.8.1
  - 2.8.1 (2024-11-27)
    - Extend bookings-export filters. [folix-01]

## 20241127-01
- redturtle.prenotazioni 2.7.9 -> 2.8.0
  - 2.8.0 (2024-11-26)
    - Divide PrenotazioniFolder.week_table time choice by 5 minutes instead of 15. [folix-01]
  - 2.7.10 (2024-11-22)
    - Apply validity dates restrictions for the Bookings Manger if selected flag 'apply_date_restrictions_to_manager'. [folix-01]
    - Fixed missing validity dates check during the booking creation. [folix-01]


## 20241126-01
- design.plone.contenttypes 6.2.23 -> 6.2.24
  - Aggiunti i campi end e recurrence al serializer del summary dell'evento [eikichi18]

## 20241122-01
- redturtle.volto 5.5.6 -> 5.6.1
  - Add linkintegrity indexers for some custom blocks. [cekk]
- design.plone.contenttypes 6.2.20 -> 6.2.23
  - Fix tests: do not import collective.volto.cookieconsent. [cekk]
  - Aggiunto indice per gestire correttamente i confronti rispetto alla data di inizio; start viene trattato in modo customizzato [lucabel]
  - Override BandoView: in io-Comune we add new children on Folder Deepening content and we need to proper handle it [lucabel]
  - update serializer for documento ct adding more information about modulo children [lucabel]

## 20241112-01
- design.plone.iocittadino 1.1.0 -> 1.1.2
  - traduzioni + risolve bug introdotto in 1.0.5 [mamico]

## 20241106-01
- design.plone.iocittadino 1.0.5 -> 1.1.0
  - Revisione dei messaggi inviati per inviare messaggio al cambio di stato (l'api prende anche messaggio
    aggiuntivio e allegato) [mamico]
  - Revisione dei testi dei messaggi inviati [nicola/mamico]
  - Aggiunto campo nel modello pratica per gestire un etsto "firma" delle email inviate [mamico]
  - Restyling pdf [mamico]
  - Richiede volto-io-cittadiino >= 2.4.0 sul frontend

## 20241031-01
- design.plone.iocittadino 1.0.4 -> 1.0.5
  - Fixed radiogroup survey adapter.
    [folix-01]

- collective.volto.formsupport 3.1.4 -> 3.1.5
  - Fix otp verification logic: do not break if otp is not in POST call #72 
    [cekk]

## 20241022-01
- design.plone.ioprenoto = 1.2.6 -> 1.2.8
  - fix for add/get booking withoud gate (xidera addon)
    [mamico]
- rer.newsletter = 3.0.2 -> 3.1.1
  - Fixed shippable collection 
  [eikichi18]

## 20241017-02
- redturtle.volto 5.5.5 => 5.5.6
 - Remove dependency with collective.volto.cookieconsent. [cekk]
 - Add more block indexers for SearchableText. [cekk]

## 20241017-01
- collective.volto.formsupport 3.0.2 => 3.1.4 [cekk]
- design.plone.iocittadino 1.0.3 => 1.0.4
  - Do not break @pratiche endpoint if there are some pratiche with missing pratica_model. Skip download link generation.
 [cekk]
  - Do not break @pratiche endpoint (RecordsData serializer) when a Pratica does not have a related Service. [cekk]
  - Fix typo in permission checks: Manage Portal => Manage portal. [cekk]
  - Fix typo in user_can_access: right permission name is "design.plone.iocittadino: Manage Blobs". [cekk]
- redturtle.prenotazioni 2.7.8 -> 2.7.9
  - Booking additional fields. [folix-01]
- collective.volto.sitesettings 1.0.1 => 1.0.3
  - Do not override site_title in schema: we use site_title_translated and then keep it in sync with site_title. [cekk]
- design.plone.contenttypes 6.2.19 => 6.2.20
  - Fix upgrade step [lucabel]
  - Avoid acquisition problem in *onModify* event handler: now try to reindex children only if context is folderish [cekk]
  - Add sort_on sortable_title to event_location, uo_location, ufficio_responsabile vocabularies [lucabel]
- sentry-sdk 1.12.1 => 2.0.0 
  - upgrade to works with new plone version due to plone.recipe.zope2instance >= 7.0.0 [lucabel]

## 20240925-01
- redturtle.volto 5.5.2 => 5.5.5
  - Add find-broken-links view [cekk]
- design.plone.contenttypes 6.2.18 => 6.2.19
  - Add link to find-broken-links in utils view [cekk]
- collective.taxonomy 3.1.2 => 3.0.1
  pinned back to 3.0.1 due to conflict with
  eea.api.taxonomy 1.5
  [lucabel]

## 20240919-02
- upgrade to plone 6.0.13 [mamico]
- update node/node.ext.ldap/node.ext.ugm [mamico]
- dos_protection removed (there is a monkey in Products.CMFPlone that
  fix the issue) [mamico]

- collective.taxonomy 3.0.1 => 3.1.2 [cekk]
  - main fix is: Fix keywords comparison [mamico]
    
- redturtle.bandi 1.4.3 -> 1.4.6
  - Add effective and modified date to retrieveContentsOfFolderDeepening data. [cekk]
  - Added "tipologia_bando_label" metadata [daniele]
  - Changed translation for states "Open" and "Closed". [daniele]

- design.plone.ioprenoto = 1.2.5 -> 1.2.6
  - Added more information in the /@booking/<bookingid> service (e.g. booking_folder, booking_address, booking_office), already present in the /@bookings?fullobjects=1 service. #41 These changes will be moved in the future from here to redturtle.prenotazioni 2.3.x [mamico]

## 20240917-01
- redturtle.prenotazioni 2.7.7 -> 2.7.8
  - Remove csrf protection from send reminder endpoint. [folix-01]
- plone.recipe.varnish 6.0.11 -> 6.0.13
  - Add cookie-pass-not-exclude config. The default value has ++resource++zmi, which is needed for Zope 5.9+ (Plone 6.0.10+). [mamico]
  - Use Varnish 6.0.13 LTS [mamico]
  - Add vcl_synth options to insert arbitrary vcl. [mamico]

- design.plone.iocittadino 1.0.2 -> 1.0.3
  - Email logo as link (Gmail compatibility). [folix-01] 


## 20240909-01
- design.plone.contenttypes 6.2.15 -> 6.2.18
 - change serializer for canale_digitale_link adding /login to URL when user is anon
- design.plone.iocittadino 1.0.1 -> 1.0.2
 - add adapter for iocittadino canale_digitale_link custom serialization
   [lucabel]

## 20240904-02
- design.plone.polciy 5.0.10 -> 5.0.11
 - fixed translate on form block patch [eikichi18]
 - fixed check on saved value [eikichi18]

- redturtle.volto 5.5.1 -> 5.5.2
  - Fix SummarySerializer for collection exporting Links [lucabel]
  - remove newsitem template override, use default dexterity view for newsitem in backend [mamico]
  - Customize @@display-file to allow to download files with proper filename. [cekk]
  - Add "type" to EXCLUDE_KEYS in blocks serializer/deserializer to not convert this slate attribute. [cekk]

## 20240904-01
- design.plone.iocittadino 1.0.0b14 -> 1.0.1
  - 1.0.1 (2024-08-29)
    - Add option to set a default operator that will be automatically assigned to newly created ones. [folix-01]
    - Add pratica's next steps dates auto calculation. [folix-01]
  - 1.0.0 (2024-08-27)
    - Update user store ref [mamico]
- design.plone.contentypes 6.2.14 -> 6.2.15
  - Add design.plone.contenttypes.behavior.news_base behavior (news metadata, without blocks)
    [mamico]
  - Add folder creation (multimedia + allegati) for "ComunicatiStampa" CT (if exists)
    [mamico]
  - Add "Emolumenti a carico della finanza pubblica" to Persona
    Add "Dichiarazioni di insussistenza e incompatibilità" to Persona
    [lucabel]  
- design.plone.policy 5.0.9 -> 5.0.10
  - `search_sections` in IDesignPloneSettings has a new filed in each section:
    `expandItems` that is a boolean to decide if the items of the section should
    be expanded or not (default is True).
    [mamico]
  - Add a profile to limit addables on site root
    [lucabel]
  - Patch for collective.volto.formsupport
    [eikichi18] 

## 20240822-01
- redturtle.prenotazioni 2.7.4 -> 2.7.7
  - 2.7.7 (2024-08-22)
    - Bookings details help text in Tipologia prenotazione. [folix-01]
  - 2.7.6 (2024-06-27)
    - Add creator and creation date to bookings export [folix-01]
    - Fix notify_about_confirm service in according to last updates. [folix-01]
  - 2.7.5 (2024-06-26)
    - Accept email as an tuple in booking schema get. [folix-01]

## 20240819-01
- design.plone.iocittadino 1.0.0b13 -> 1.0.0b14
  - Multiple praticas support. [mamico]
  - Setup tests. [mamico]
  - Fix site logo in the email. [folix-01]

## 20240809-01
- collective.volto.blocksfield 2.0.0 -> 2.1.0 [cekk]
  - Add slate compatibility

## 20240723-01
- update redturtle.volto 5.5.0 -> 5.5.1
  - Allow to select which image miniature use in RSS [lucabel]

## 20240712-01
- update design.plone.contenttypes from 6.2.12 -> 6.2.14
  - Fix security problems for bandit. [cekk]
  - Fix `to_7306`` upgrade-step to be more specific on types configuration. [cekk]
  - Set file_principale field as primary, so we call @@download on the content,
    that file will be downloaded automatically. [cekk] 
  - Override listing.pt from plone.app.contenttypes due to error rendering event [lucabel]

## 20240711-01
- update redturtle.volto 5.4.9 -> 5.5.0
  - add depdendency with collective.volto.sitesettings [cekk]
- update rer.customersatisfaction from 2.0.0 -> 2.2.4 [mamico]

## 20240624-03
- update design.plone.contenttypes from 6.2.11 -> 6.2.12 [lucabel]

## 20240624-02
- Update redturtle.prenotazioni 2.7.3 -> 2.7.4
  - @@bookings-export view. [folix-01]

## 20240624-01
- update redturtle.filesretriever 1.0.0 -> 1.0.1
  - Better handle edge-cases in content-type ad disposition headers [cekk]
- update design.plone.contenttypes from 6.2.10 -> 6.2.11 [eikichi18]

## 20240611-01

- Update redturtle.prenotazioni 2.7.0 -> 2.7.1 [folix-01]
  - Hotfix missing permission [folix-01]
- Fix xidera.prenotazioni version because there are several profiles that need it.
  [cekk]
- update design.plone.contenttypes from 6.2.9 -> 6.2.10 [lucabel]

## 20240529-01
- update redturtle.prenotazioni 2.6.5 -> 2.7.0
 - Workarounds for external integration: search with tinit- prefixed user, 
   schema with some fields with only spaces [mamico]
 - Write to history the booking notifications log [folix-01]
 - Write to history if could not send booking notification [folix-01]
 - Booking canceled message + wf states translations BREAKING CHANGE:
   frontend uses booking_state_label insteat of booking_state, this change
   of translations requires a new release of the frontend
   (@redturtle/volto-io-prenoto >= 1.20.0) [folix-01]

## 20240521-02
- Update redturtle.faq 1.0.1 -> 1.0.2
    - Serialize returned blocks. [cekk]
- redturtle.voltoplugin.editablefooter 1.3.2 -> 1.3.3
  - Fix serializer/deserializer for footerTop blocks: use blocks handlers to fix data. [cekk]
- collective.volto.subsites 1.4.0 -> 1.5.0
  - add versioning [cekk]

## 20240521-01
- collective.volto.enhancedlinks 1.1.0 -> 1.1.1
  - prevent write-on-read [cekk]
- update redturtle.prenotazioni 2.6.3 -> 2.6.5
  - Package chore. [folix-01]
  - Fix reminder send view. [folix-01]
- collective.feedback 1.1.2 -> 1.1.3
  - add a plone2volto url converter [lucabel]
- collective.volto.gdprcookie 1.0.2 -> 1.0.3
  - Fix deserializer and save all data in registry. [cekk]
- collective.volto.formsupport 2.6.2 -> 3.0.2
  - Several changes..see changelog for details [cekk]
  - rer.newsletter = 3.0.2
  - It wasn't fixed before [cekk]
  - Disable resource for Plone6 [cekk]
- design.plone.contenttypes 6.2.8 -> 6.2.9
  - Add this folder "Altri Documenti" under "Persona pubblica" [lucabel]
  - Code porting to work with both plone 6.0.10.x and 6.0.11 [lucabel]

## 20240422-02
- design.plone.contenttypes 6.2.3 -> 6.2.8
  - converted some file and image fields as blob fields [mamico]
  - check-servizi: fixed check on relation title. [daniele]
  - improved check on relation. [daniele]
  - Fix change_news_type view; Taxonomy doesn't index values not present in the taxonomy vocabulary, so we had lot of old values not indexed and not listed as available type to change. [lucabel]
  - Do not break News serialzier if tipologia_notizia attribute is missing. [cekk]
  - Add start metadata to event summary serialization; useful when create event with children event: in items list we have subevents with missing start date [lucabel]

- redturtle.volto 5.4.8 -> 5.4.9
  - Limit event occurrences to 100. [mamico]
  - Customize INameChooser adapter to check also alias ids and disallow to create contents that could override aliases. [cekk]
  - Add flag in controlpanel to enable/disable INameChooser customization. [cekk]
  - Exclude bg_color from transformed fields in deserializer. [cekk]
  - Uninstall collective.volto.cookieconsent (deprecated). Will be removed from dependencies in next releases. [cekk]
  - Add dependency to collective.volto.gdprcookie and install it by default. [cekk]

## 20240422-01
- design.plone.ioprenoto 1.2.4 -> 1.2.5
  - Refactor rest service to simplify inheritance [lucabel]
  - Add redturtle.prenotazioni’s notify_upcoming_bookings script to console_scripts (allows it to be available in the buildout). 
    [folix-01]

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
