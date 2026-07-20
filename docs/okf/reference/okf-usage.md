---
type: Reference
title: OKF Usage in Wesnoth
description: Come il repository adotta Open Knowledge Format v0.1 per la documentazione.
tags: [okf, documentation, format]
timestamp: 2026-06-29T00:00:00Z
---

# Bundle location

Il knowledge bundle OKF di questo repository risiede in [/index.md](/index.md).

# Versione

OKF **v0.1** dichiarata nel frontmatter del root `index.md`:

```yaml
---
okf_version: "0.1"
---
```

# Policy

Il [Manifest](/manifest.md) impone OKF per tutti i nuovi file Markdown. Eccezioni documentate:

* `changelog.md`, `changelog_entries/`
* `CODE_OF_CONDUCT.md`, `COPYING`
* Contenuto dei submodule git

# Convenzioni locali

| Convenzione | Dettaglio |
|-------------|-----------|
| Lingua corpo | Italiano o inglese (coerente per sezione) |
| Link interni | Percorsi assoluti dal root bundle: `/architecture/engine.md` |
| Link al repo | Percorsi assoluti dalla root repo: `/src/wesnoth.cpp` |
| `index.md` | Solo elenchi per progressive disclosure, senza frontmatter (eccetto root) |
| `log.md` | Cronologia aggiornamenti, date ISO 8601 |

# Validazione

```bash
./utils/CI/check_okf.sh
```

Lo script verifica:

1. Ogni `.md` non riservato in `docs/okf/` ha frontmatter YAML parseabile
2. Ogni frontmatter contiene `type` non vuoto
3. `index.md` e `log.md` non hanno frontmatter (eccetto `okf_version` nel root `index.md`)

# Citations

[1] [OKF SPEC.md](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
[2] [Manifest](/manifest.md)
