---
type: Component
title: Executables
description: Binari principali prodotti dalla build di Wesnoth.
resource: /src/CMakeLists.txt
tags: [binaries, wesnoth, wesnothd, campaignd]
timestamp: 2026-06-29T00:00:00Z
---

# Binari

| Binario | Sorgente | Scopo |
|---------|----------|-------|
| `wesnoth` | `src/wesnoth.cpp` | Client: menu, campagne, MP, editor |
| `wesnothd` | `src/server/wesnothd/server.cpp` | Server multiplayer |
| `campaignd` | `src/server/campaignd/server.cpp` | Server add-on/campagne |
| `boost_unit_tests` | `source_lists/boost_unit_tests` | Test unitari C++ |

# Flusso client

```
wesnoth.cpp → game_launcher → menu / campagna / MP / editor
```

# Opzioni build

Definite in [`CMakeLists.txt`](../../CMakeLists.txt):

| Opzione | Default | Effetto |
|---------|---------|---------|
| `ENABLE_GAME` | ON | Compila il client |
| `ENABLE_SERVER` | ON | Compila `wesnothd` |
| `ENABLE_CAMPAIGN_SERVER` | — | Compila `campaignd` |
| `ENABLE_TESTS` | OFF | Compila test Boost |

# Collegamenti

* Architettura motore: [Engine](/architecture/engine.md)
* Istruzioni build: [Build](/development/build.md)
