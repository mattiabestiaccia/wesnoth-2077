---
type: Reference
title: Repository Documentation Manifest
description: Policy obbligatoria per la creazione e la manutenzione di file Markdown in questo repository.
tags: [documentation, okf, policy, markdown]
timestamp: 2026-06-29T00:00:00Z
---

# Scopo

Questo manifest definisce come **tutti i nuovi file Markdown** creati in questo repository devono essere scritti. Il formato di riferimento è **Open Knowledge Format (OKF) v0.1**, pubblicato da Google Cloud Platform.

# Regole obbligatorie

Ogni nuovo file `.md` creato nel repository **DEVE** rispettare OKF v0.1:

1. **Frontmatter YAML** — blocco delimitato da `---` all'inizio del file.
2. **Campo `type`** — obbligatorio e non vuoto in ogni documento concetto.
3. **Corpo Markdown strutturato** — preferire titoli, elenchi, tabelle e blocchi di codice rispetto a prosa libera.
4. **Collegamenti** — usare link Markdown standard; per riferimenti interni al bundle OKF preferire percorsi assoluti dal root del bundle (es. `/architecture/engine.md`).
5. **File riservati** — `index.md` e `log.md` seguono la struttura definita dalla specifica OKF; non usarli come documenti concetto.

# Dove collocare la documentazione

| Tipo di contenuto | Percorso consigliato |
|-------------------|----------------------|
| Documentazione di progetto, architettura, guide | [`docs/okf/`](/index.md) |
| README locali di sottosistema | Convertire in concetti OKF sotto `/docs/okf/` oppure aggiungere frontmatter OKF in loco |
| Changelog release | `changelog.md` e `changelog_entries/` — **esclusi** dalla policy OKF |
| Codice di condotta / licenza legale | `CODE_OF_CONDUCT.md`, `COPYING` — **esclusi** dalla policy OKF |
| Submodule esterni | Contenuto dei submodule — **escluso** dalla policy OKF |

# Campi frontmatter consigliati

Oltre a `type` (obbligatorio), includere quando possibile:

| Campo | Uso |
|-------|-----|
| `title` | Nome leggibile del concetto |
| `description` | Una frase di riepilogo (usata negli `index.md`) |
| `resource` | URI dell'asset sottostante (percorso repo, URL wiki, binario) |
| `tags` | Lista YAML di etichette trasversali |
| `timestamp` | Data ISO 8601 dell'ultimo aggiornamento significativo |

# Tipi di documento

Usare valori `type` descrittivi e coerenti. Per questo repository vedi [Documentation Types](/reference/documentation-types.md).

# Sezioni convenzionali del corpo

Quando applicabile, usare queste intestazioni:

| Intestazione | Scopo |
|--------------|-------|
| `# Schema` | Struttura di directory, API, campi |
| `# Examples` | Esempi concreti (comandi, snippet) |
| `# Citations` | Fonti esterne |

# File legacy

I file Markdown esistenti prima dell'adozione di OKF possono restare senza frontmatter finché non vengono modificati in modo sostanziale. **Ogni modifica sostanziale** a un file legacy deve includere la migrazione al formato OKF.

# Validazione

Eseguire lo script di conformità prima di aprire una PR che aggiunge o modifica documentazione:

```bash
./utils/CI/check_okf.sh
```

# Citations

[1] [Open Knowledge Format v0.1 — SPEC.md](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
[2] [How the Open Knowledge Format can improve data sharing](https://cloud.google.com/blog/products/data-analytics/how-the-open-knowledge-format-can-improve-data-sharing)
