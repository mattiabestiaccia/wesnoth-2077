# Memory footprint strategy for wesnoth-2077

> [!IMPORTANT]
> Handoff Anchor: future agents continuing implementation from this document should load `superpowers:using-git-worktrees` before editing and `superpowers:test-driven-development` before changing C++ behavior. If turning this strategy into a step-by-step implementation plan, load `superpowers:writing-plans`.

## Current evidence

Measured in the `feat/wesnoth-memory-footprint` worktree on 2026-06-29:

| Area | Size | Notes |
| --- | ---: | --- |
| `data/` | 608M | Main runtime/content tree |
| `data/core/` | 337M | Dominated by images and music |
| `data/core/images/` | 155M | Needed by normal rendering |
| `data/core/music/` | 172M | Avoidable for headless and maybe for the first light package |
| `data/campaigns/` | 255M | Loaded by the default `data/_main.cfg` |
| `data/campaigns/World_Conquest/` | 2.2M | The only built-in MP campaign found by `campaign_mp` metadata |
| `data/multiplayer/` | 1.2M | Tiny; not worth trimming first |
| `data/test/` | 4.6M | Can be absent from a runtime data profile |
| `po/` | 480M | Translation source; package/build footprint, not needed for headless agent loop |
| `src/` | 14M | C++ source size is not the footprint driver |

Build toggles already exist for large binaries and build cost:

- `ENABLE_GAME`
- `ENABLE_SERVER`
- `ENABLE_CAMPAIGN_SERVER`
- `ENABLE_NLS`
- `ENABLE_TESTS`
- `ENABLE_LTO`

There is no upstream CMake option for "multiplayer campaign only" or "no editor in the client".

## Recommendation

Do not start by deleting engine modes. Start with a light data profile and measurement harness.

The best first target is a separate `--data-dir` that keeps the normal client binary but loads only:

- core data required by the engine;
- multiplayer data;
- `World_Conquest`, because it is the built-in multiplayer campaign;
- AI data required by normal MP/campaign play;
- minimal shared files referenced from `data/_main.cfg`;
- no translations, tests, add-on server data, or unrelated campaigns.

This is likely to reduce:

- startup config parsing;
- config-cache size;
- runtime memory used by loaded WML/config trees;
- package size;
- test surface for agent automation.

It is unlikely to reduce much:

- C++ compile memory;
- base SDL/Boost/Lua/WML engine memory;
- memory needed for loaded core unit types and terrain;
- rendering memory while a full GUI map is active.

## Campaign multiplayer only

This is worth pursuing as a profile, not as a hard fork yet.

`World_Conquest` is currently the only mainline campaign with `campaign_mp` metadata found in the tree. It is only 2.2M, while all campaigns total 255M. A profile that includes only `World_Conquest` should be a high-signal experiment.

Expected benefit:

- large disk/package reduction from skipping unrelated campaigns;
- lower WML config load and cache pressure, because default `data/_main.cfg` includes all campaigns;
- smaller deterministic test matrix for agent experiments.

Expected limitation:

- the client still needs Lua, WML, unit types, terrain, GUI, network MP, save/load, and most core data;
- `data/core` remains the largest unavoidable tree unless we also create a deeper asset profile;
- `data/core/music` is 172M and should be disabled/omitted separately from the campaign decision.

## Optimization list

### Immediate and low-risk

- Run headless tests with `--nogui --nosound --nomusic --noaddons`.
- Always use isolated `--userdata-dir` and `--usercache-dir`.
- Build on VPS with `ENABLE_NLS=OFF`, `ENABLE_TESTS=OFF`, `ENABLE_CAMPAIGN_SERVER=OFF`, `ENABLE_LTO=OFF`.
- Prefer `CMAKE_BUILD_TYPE=MinSizeRel` or `Release`; avoid debug builds on the VPS.
- Keep build parallelism at `-j1` or `-j2`.
- Use a separate light `--data-dir` for agent experiments.

### Likely useful after baseline

- Add a first-class `wesnoth-2077` light profile that controls WML includes from `data/_main.cfg`.
- Make audio cache limits configurable. Current hardcoded limits are `music_cache_limit = 30` and `sound_cache_limit = 500` in `src/sound.cpp`.
- Add a memory measurement script that records max RSS for startup, MP smoke, and World Conquest scenario launch.
- Create a packaging profile that omits `po/`, unused campaigns, tests, docs, and optionally `data/core/music`.

### Risky or premature

- Removing editor C++ code from the client. Editor code is entangled with map/terrain/UI and is not the main footprint driver yet.
- Removing general campaign support from the engine. MP campaign uses the same campaign/scenario machinery.
- Trimming unit families from `data/core/units` before measuring World Conquest dependencies.
- Imposing global image-cache caps before observing actual cache behavior in a reproducible scenario.

## Experimental path

1. Generate a light data directory with `agent-layer/make-light-data-dir`.
2. Launch the normal binary with:

   ```sh
   wesnoth --data-dir <light-dir> --userdata-dir <tmp-userdata> --usercache-dir <tmp-cache> --noaddons --nomusic --nosound
   ```

3. Compare full data vs light data:

   ```sh
   /usr/bin/time -v wesnoth --data-dir <full-dir> --noaddons --nomusic --nosound --userdata-dir <tmp-userdata-full> --usercache-dir <tmp-cache-full>
   /usr/bin/time -v wesnoth --data-dir <light-dir> --noaddons --nomusic --nosound --userdata-dir <tmp-userdata-light> --usercache-dir <tmp-cache-light>
   ```

4. Use the same comparison for `--multiplayer --scenario ... --exit-at-end --nogui` once a Linux headless build exists.
5. Only after the measurement confirms a benefit, promote the data-dir profile into an engine-supported option or packaging target.

## Decision

Proceed with "multiplayer campaign only" as an experimental data/runtime profile.

Do not remove other modes from C++ yet. The first implementation should preserve upstream syncability and prove memory impact with measurements.
