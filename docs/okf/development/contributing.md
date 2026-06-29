---
type: Playbook
title: Contributing Guidelines
description: Convenzioni di codice, documentazione OKF, pull request e processo di contribuzione.
resource: /CONTRIBUTING.md
tags: [contributing, pr, conventions, okf]
timestamp: 2026-06-29T00:00:00Z
---

# Contatti

* [Discord](https://discord.gg/battleforwesnoth)
* [Forum](https://forums.wesnoth.org/)
* IRC: `#wesnoth-dev` su Libera.Chat

# Motore C++

* Standard **C++17**
* Convenzioni: `#pragma once`, snake_case, stile documentato in [CONTRIBUTING.md](../../CONTRIBUTING.md)
* Formattazione C++ gestita in code review (clang-format disponibile)

# WML e Lua

* File UTF-8
* WML formattato con `wmlindent` (controllato in CI)
* Eccezioni: `data/gui/`, `data/schema/`, alcuni test

# Documentazione Markdown

**Tutti i nuovi file `.md` devono seguire OKF v0.1.** Vedere il [Manifest](/manifest.md) per i dettagli completi.

* Documentazione di progetto → [/index.md](/index.md)
* Validare con `./utils/CI/check_okf.sh` prima della PR

# Pull request

1. Fork di [wesnoth/wesnoth](https://github.com/wesnoth/wesnoth)
2. Branch descrittivo, commit chiari
3. Test inclusi quando possibile
4. Codice generato da AI: dichiararlo nel commit e saperne spiegare l'implementazione
5. Nessun uso di API WML/Lua deprecate

# Test

Vedere [Testing](/development/testing.md).

# Citations

[1] [CONTRIBUTING.md](../../CONTRIBUTING.md)
[2] [Coding Standards wiki](https://wiki.wesnoth.org/CodingStandards)
