---
type: Playbook
title: Testing
description: Test unitari C++, test WML/Lua e come eseguirli localmente.
tags: [testing, boost, wml, lua]
timestamp: 2026-06-29T00:00:00Z
---

# Test C++

| Strumento | Percorso test | Esecuzione |
|-----------|---------------|------------|
| Boost unit tests | `src/tests/` | `./boost_unit_tests` |
| Script aggregato | — | `./run_boost_tests` |

Abilitare in build: `-DENABLE_TESTS=ON` (CMake) o equivalente SCons.

# Test WML/Lua

| Strumento | Percorso test | Esecuzione |
|-----------|---------------|------------|
| WML tests | `data/test/` | `./run_wml_tests` |

# Controlli statici

| Strumento | Scope |
|-----------|-------|
| `luacheck` | Tutto il repository |
| `wmlindent` | File WML (via CI) |
| `check_okf.sh` | Documentazione OKF in `docs/okf/` |

# Collegamenti

* Pipeline CI: [CI](/development/ci.md)
* Linee guida PR: [Contributing](/development/contributing.md)
