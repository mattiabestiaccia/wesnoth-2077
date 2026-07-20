---
okf_version: "0.1"
---

# The Battle for Wesnoth — Knowledge Bundle

Documentazione strutturata del repository secondo [Open Knowledge Format v0.1](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md).

## Policy

* [Manifest](manifest.md) — regole obbligatorie per i file Markdown nel repository

## Panoramica

* [Overview](overview.md) — descrizione del progetto e funzionalità principali
* [Community](community.md) — canali di comunicazione e supporto
* [License](license.md) — licenze codice, arte e musica

## Architettura

* [Engine](architecture/engine.md) — motore C++, sottosistemi e librerie
* [Content Data](architecture/content-data.md) — WML, Lua e struttura `data/`
* [Executables](architecture/executables.md) — binari `wesnoth`, `wesnothd`, `campaignd`

## Sviluppo

* [Build](development/build.md) — prerequisiti, CMake, SCons e dipendenze
* [Contributing](development/contributing.md) — convenzioni codice, PR e test
* [Testing](development/testing.md) — test C++, WML e controlli CI
* [CI](development/ci.md) — workflow GitHub Actions e qualità del codice

## Riferimenti

* [OKF in questo repository](reference/okf-usage.md) — come adottiamo il formato OKF
* [Tipi di documento](reference/documentation-types.md) — valori `type` usati nel bundle
