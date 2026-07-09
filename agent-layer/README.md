# agent-layer — wesnoth-2077 agentization

> This directory is the **agentic R&D layer** added on top of the upstream
> Battle for Wesnoth source tree. The engine code under `src/`, content under
> `data/`, etc. are unchanged from [`wesnoth/wesnoth`](https://github.com/wesnoth/wesnoth).

## What is wesnoth-2077?

A long-range research project: map, measure, and exploit the control surface
that Battle for Wesnoth exposes to an LLM / autonomous agent — and assess how
deeply the game can be driven, customized, and eventually re-versioned through
prompting.

Wesnoth is an ideal testbed: a deterministic C++ engine, a declarative and
prompt-friendly data language (**WML**), an embedded **Lua 5.4** API with full
game-state access, a **replaceable per-side AI framework**, and a **headless
CLI** for automated runs.

## Direction: explore-first, then specialize

1. Map the whole control surface; measure feasibility/cost.
2. Then specialize — candidates: **content/config via prompt**, a
   **game-playing agent**, or **headless orchestration**.

## Control surface (summary)

| Layer | What | Relevance |
|---|---|---|
| Lua API | `wesnoth.*` modules, `[lua]`, `--plugin`, `--script` | full read/write of game state — main canvas |
| CLI | `--nogui`, `--multiplayer`, `--controller`, `--algorithm`, `--exit-at-end` | headless, scriptable runs |
| MP server | `wesnothd` + fifo + `simple_wml` protocol | external agent as networked player |
| WML | declarative content/config (also savegame & protocol) | prompt-authorable, validatable offline |
| AI engine | composite RCA AI, Lua/Formula AI, per-side `--algorithm` | LLM as a faction's "brain" |

## Roadmap

0. **Foundations** — docs, control-surface map, tracking. ✅
1. Headless environment (build + smoke test).
2. Lua surface (read/dump/mutate state).
3. Content via prompt (prompt → WML → validate → run) — quick win.
4. Game-playing agent (Lua AI + LLM bridge; baseline vs RCA).
5. Dedicated tooling (`wesnoth` skill + MCP server).
6. Specialization & upstream-divergence decision.

## Relationship with upstream

Fork of `wesnoth/wesnoth`, **sync-first** (rebasable). Divergence toward "our
version" is intentional, documented, and gradual. This `wesnoth-2077/` folder
is the additive layer; upstream files are left untouched for as long as
possible.

## Status

🔬 Exploration / incubation. Not playable-different yet.

## License

Inherits **GNU GPL v2+** from Battle for Wesnoth. New contributions in this
layer remain GPL v2+ compatible.

## Credits

Built on the work of [The Battle for Wesnoth Project](https://wesnoth.org/) and
its community of volunteers since 2003.

## Headless Build & Smoke Test
To build Wesnoth headlessly using a Docker container with resource limits, use:
`./headless-build.sh`

This script mounts the repo and builds it using `wesnoth/wesnoth:2404-sdl3`, with limits (`--cpus=1.5`, `--memory=3g`, `--memory-swap=4g`), ensuring the host VPS does not run out of memory.

To run a headless smoke test:
`./headless-smoke-test.sh`
