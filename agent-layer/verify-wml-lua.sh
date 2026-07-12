#!/usr/bin/env bash
set -euo pipefail

# Verification for BRU-43-1-3:
#   1. `--validate` on a known WML scenario (core MP data).
#   2. `--plugin` with hello-plugin.lua printing a marker in the log.
# Requires ./build/wesnoth (see container-build.sh).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
WESNOTH_ROOT="$(cd "$SCRIPT_DIR/.." &> /dev/null && pwd)"
IMAGE="${IMAGE:-wesnoth/wesnoth:2404-sdl3}"

run_wesnoth() {
  # LD_LIBRARY_PATH: il binario linka la Boost di sistema, ma /usr/local/lib
  # (Boost _GLIBCXX_DEBUG della CI) la nasconderebbe a runtime.
  docker run --rm -i \
    --cpus=1.5 --memory=3g --memory-swap=4g \
    --user "$(id -u):$(id -g)" \
    -e HOME=/src/build/.home \
    -e LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu \
    -e SDL_VIDEODRIVER=dummy \
    -v "$WESNOTH_ROOT:/src" -w /src \
    "$IMAGE" \
    ./build/wesnoth --nogui --userdata-dir=/src/build/userdata_test "$@"
}

echo "=== 1/2 validate: data/_main.cfg ==="
run_wesnoth --validate=data/_main.cfg
echo "validate OK (exit 0)"

echo "=== 2/2 plugin: hello-plugin.lua su partita MP ai-vs-ai ==="
out="$(run_wesnoth \
  --plugin=agent-layer/lua/hello-plugin.lua \
  --multiplayer --controller 1:ai --controller 2:ai \
  --exit-at-end 2>&1)" || { echo "$out" | tail -20; exit 1; }
echo "$out" | grep -F "[wesnoth-2077] hello from agent-layer plugin" \
  && echo "plugin OK (marker trovato)" \
  || { echo "marker NON trovato"; echo "$out" | tail -20; exit 1; }
