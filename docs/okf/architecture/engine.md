---
type: Component
title: C++ Engine
description: Motore C++ di Wesnoth con GUI, scripting Lua, serializzazione WML e networking.
resource: /src/
tags: [engine, cpp, architecture]
timestamp: 2026-06-29T00:00:00Z
---

# Panoramica

Il motore in `src/` interpreta configurazioni WML e script Lua 5.4, gestisce rendering SDL3, pathfinding, AI, multiplayer e replay.

# Librerie statiche

| Target | Contenuto |
|--------|-----------|
| `wesnoth-common` | Config WML, filesystem, gettext, serializzazione |
| `wesnoth-client` | Logica di gioco, display, rete client |
| `wesnoth-widgets` | Widget GUI2 |
| `lua` | Submodule Lua 5.4 in `src/modules/lua` |

# Sottosistemi principali

| Directory | Responsabilità |
|-----------|----------------|
| `scripting/` | Kernel Lua (`game_lua_kernel`), API `wesnoth.*` |
| `serialization/` | Parser WML, preprocessore, schema validator |
| `game_events/` | Eventi e azioni WML |
| `ai/` | Motore AI C++ e binding Lua |
| `gui/` | GUI2 (dialoghi e widget guidati da WML) |
| `editor/` | Map editor |
| `units/`, `map/`, `pathfind/`, `terrain/` | Meccaniche di gioco core |
| `server/` | `wesnothd` e `campaignd` |
| `sdl/` | Wrapper SDL3 |

# Schema

```
src/
├── wesnoth.cpp          # Entry point client
├── game_launcher.*      # Orchestrazione sessioni
├── config.hpp           # Struttura dati WML
├── scripting/           # Binding Lua
├── serialization/       # Parser WML
├── server/              # Server MP e add-on
└── modules/lua/         # Submodule Lua
```

# Collegamenti

* Binari prodotti: [Executables](/architecture/executables.md)
* Contenuti caricati dal motore: [Content Data](/architecture/content-data.md)
* Build: [Build](/development/build.md)
