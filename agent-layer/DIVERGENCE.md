# Divergence ledger — wesnoth-2077 vs upstream

> Every delta between this fork and [`wesnoth/wesnoth`](https://github.com/wesnoth/wesnoth)
> is recorded here. Policy: **sync-first** — upstream files stay untouched for as
> long as possible; all fork work lives in additive layers. A rebase onto
> upstream must replay cleanly through the entries below.
>
> Update this file in the same commit that introduces (or removes) a delta.

## Baseline

| | |
|---|---|
| Upstream base | `23986a0e` — "Xcode: use correct name for libSDL3" (master) |
| Fork dev branch | `agent/wesnoth-2077` |
| Last sync check | 2026-07-12 |

## Deltas

### 1. `agent-layer/` — additive directory (no upstream counterpart)

| Path | Kind | Since | Notes |
|---|---|---|---|
| `agent-layer/README.md` | doc | `1e171e2e` | project charter: direction, control surface, roadmap |
| `agent-layer/memory-footprint-strategy.md` | doc | `d97294c7` | light data profile strategy + measurements |
| `agent-layer/make-light-data-dir` | script | `d97294c7` | builds a trimmed `--data-dir` profile |
| `agent-layer/headless-smoke-test.sh` | script | `4ec52c8f` | containerized `--nogui` smoke test |
| `agent-layer/DIVERGENCE.md` | doc | `99e6190f` | this ledger |
| `agent-layer/container-build.sh` | script | this commit | containerized build, limits per BRU-43-7-3 |
| `agent-layer/lua/hello-plugin.lua` | script | this commit | minimal `--plugin` proof (BRU-43-1-3) |

### 2. Modified upstream files

*None.* This section must list file, reason, and upstream-conflict risk for
every future engine/data patch. A non-empty section here is an input to the
Phase 6 divergence decision.

### 3. Deliberately not carried

*None yet.* (Upstream files/directories we drop in our builds — e.g. via the
light data profile — are runtime profiles, not source deltas.)

## Rebase procedure

1. `git fetch upstream && git rebase upstream/master agent/wesnoth-2077`
2. Expected conflicts: none while §2 is empty.
3. After rebase: update **Baseline** above, re-run `agent-layer/headless-smoke-test.sh`.
