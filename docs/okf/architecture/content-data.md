---
type: Component
title: Content Data Layer
description: Contenuti di gioco in WML e Lua nella directory data/, campagne e risorse condivise.
resource: /data/
tags: [wml, lua, content, campaigns]
timestamp: 2026-06-29T00:00:00Z
---

# Punto di ingresso

[`data/_main.cfg`](../../data/_main.cfg) carica in sequenza:

1. `english.cfg`, `themes/`, `core/`
2. `multiplayer/` (se `MULTIPLAYER`)
3. `internal/`
4. `{campaigns/}` — tutte le campagne ufficiali
5. Modifiche, configurazione AI, test

# Directory principali

| Percorso | Contenuto |
|----------|-----------|
| `data/core/` | Terreni, unità, macro, help, editor — risorse condivise |
| `data/campaigns/` | 21 campagne ufficiali |
| `data/multiplayer/` | Scenari ed ere multiplayer |
| `data/ai/` | Configurazioni AI e micro-AI Lua |
| `data/lua/` | Script Lua globali |
| `data/schema/` | Schema validazione WML |
| `data/gui/` | Temi interfaccia GUI2 |

# Struttura tipica di una campagna

```
data/campaigns/<Nome>/
├── _main.cfg
├── scenarios/
├── maps/
├── units/
├── lua/
└── images/
```

# Livelli di scripting Lua

1. **Globale** — `data/lua/` (caricato da `core/_main.cfg`)
2. **AI** — `data/ai/lua/`
3. **Per campagna** — `data/campaigns/<Nome>/lua/`
4. **Motore** — `src/scripting/` espone API a Lua 5.4

# Collegamenti

* Motore che interpreta i contenuti: [Engine](/architecture/engine.md)
* Wiki creazione contenuti: https://wiki.wesnoth.org/Create
