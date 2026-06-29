---
type: Reference
title: Continuous Integration
description: Workflow GitHub Actions, controlli di qualità e matrix di build.
resource: /.github/workflows/ci-main.yml
tags: [ci, github-actions, quality]
timestamp: 2026-06-29T00:00:00Z
---

# Workflow principale

File: [`.github/workflows/ci-main.yml`](../../.github/workflows/ci-main.yml)

# Job senza build

| Controllo | Script |
|-----------|--------|
| UTF-8 / BOM | `utils/CI/check_utf8.sh`, `utf8_bom_dog.sh` |
| Whitespace e WML indent | `utils/CI/fix_whitespace.sh` |
| Immagini WML mancanti | `utils/CI/check_wml_images.sh` |
| Lua static analysis | `luacheck .` |
| Doxygen | `doxygen doc/doxygen/Doxyfile` |
| Copyright audio | `update_copyrights` |
| OKF conformance | `utils/CI/check_okf.sh` |

# Matrix build Ubuntu

Container: `wesnoth/wesnoth:2404-sdl3`

| Config | Tool | Compiler | Std | Note |
|--------|------|----------|-----|------|
| debug | SCons | GCC | C++17 | — |
| release | CMake | GCC | C++20 | LTO |
| release | CMake | Clang | C++17 | System Lua |

# Altri workflow

| File | Scopo |
|------|-------|
| `android.yml` | Build Android |
| `codeql.yml` | Analisi sicurezza |
| `labeler.yml` | Etichette automatiche PR |

# Citations

[1] [CI workflow](../../.github/workflows/ci-main.yml)
