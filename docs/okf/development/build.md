---
type: Playbook
title: Building from Source
description: Prerequisiti, dipendenze e istruzioni per compilare Wesnoth con CMake o SCons.
resource: /INSTALL.md
tags: [build, cmake, scons, dependencies]
timestamp: 2026-06-29T00:00:00Z
---

# Prerequisiti

* Compilatore con supporto **C++17** (GCC 11+, Clang equivalente)
* **Submodule Lua**: `git submodule update --init --recursive`

# Dipendenze obbligatorie

| Libreria | Versione minima | Uso |
|----------|-----------------|-----|
| Boost | 1.70 | filesystem, locale, iostreams, regex, coroutine, graph, … |
| SDL3 | 3.4.0 | Grafica e input |
| SDL3_image | 3.2.0 | PNG, JPEG, WEBP |
| SDL3_mixer | 3.2.0 | Audio Ogg Vorbis |
| Pango/Cairo/Fontconfig | — | Rendering testo |
| OpenSSL | 1.0+ | TLS e crypto |
| libcurl | — | Download add-on |
| ICU | — | Internazionalizzazione |

# Dipendenze opzionali

* D-Bus — notifiche desktop Linux
* GNU readline — console Lua interattiva
* MySQL — server MP/add-on con database

# Build system

| Sistema | Minimo | Piattaforma preferita |
|---------|--------|----------------------|
| CMake | 3.21 | Windows (VS + vcpkg), macOS |
| SCons | 0.98.3 | Linux/BSD |

# Examples

## CMake (Linux)

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j$(nproc)
```

## SCons (Linux)

```bash
scons
```

## Submodule

```bash
git clone --recurse-submodules https://github.com/wesnoth/wesnoth.git
# oppure, se già clonato:
git submodule update --init --recursive
```

# Windows

Dipendenze gestite via [`vcpkg.json`](../../vcpkg.json). Visual Studio con CMake è il metodo preferito.

# Citations

[1] [INSTALL.md](../../INSTALL.md)
[2] [vcpkg.json](../../vcpkg.json)
[3] [Docker CI base image](https://github.com/wesnoth/wesnoth/blob/master/utils/dockerbuilds/CI/Dockerfile-base-2404-sdl3)
