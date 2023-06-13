# Changelog

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
