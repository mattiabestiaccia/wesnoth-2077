---
type: Guide
title: Project Overview
description: Panoramica di The Battle for Wesnoth, gioco di strategia tattica a turni open source.
resource: https://github.com/wesnoth/wesnoth
tags: [overview, game, wesnoth]
timestamp: 2026-06-29T00:00:00Z
---

# Descrizione

**The Battle for Wesnoth** è un gioco di strategia tattica a turni open source con tema high fantasy. Supporta campagne single-player, multiplayer online/hotseat e un editor di mappe integrato.

# Versione corrente

| Campo | Valore |
|-------|--------|
| Versione sviluppo | `1.19.25+dev` (definita in `src/wesconfig.h`) |
| Branch principale | `master` |
| Branch stabile precedente | `1.18` |
| Standard C++ | C++17 |

# Funzionalità principali

* Campagne con difficoltà multiple e trame narrative
* Centinaia di unità, abilità e fazioni
* Editor di mappe con centinaia di tipi di terreno
* Altamente moddabile tramite add-on della community
* Multiplayer online e locale
* Playlist musicale originale

# Installazione

Il gioco è disponibile su Windows, macOS e Linux tramite Steam, itch.io, Flatpak, App Store e installer standalone. Per build da sorgente vedere [Build](/development/build.md).

# Struttura del repository

| Directory | Ruolo |
|-----------|-------|
| `src/` | Motore C++ |
| `data/` | Contenuti WML e Lua |
| `images/`, `sounds/`, `fonts/` | Asset UI C++ |
| `po/` | Traduzioni Gettext |
| `docs/okf/` | Documentazione OKF (questo bundle) |
| `utils/` | Script CI e strumenti di sviluppo |
| `packaging/` | Flatpak, Android, Windows, macOS |

# Citations

[1] [README.md del repository](../../README.md)
[2] [Sito ufficiale](https://www.wesnoth.org/)
[3] [Wiki Wesnoth](https://wiki.wesnoth.org/)
