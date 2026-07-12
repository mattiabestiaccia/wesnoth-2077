#!/usr/bin/env bash
set -e

# Headless smoke test per wesnoth-2077 (BRU-43-1-2)
# LD_LIBRARY_PATH: il binario linka la Boost di sistema, ma /usr/local/lib
# (Boost _GLIBCXX_DEBUG della CI) la nasconderebbe a runtime — v. container-build.sh.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
WESNOTH_ROOT="$(cd "$SCRIPT_DIR/.." &> /dev/null && pwd)"

echo "Running headless smoke test in container..."
docker run --rm -i \
  --cpus=1.5 --memory=3g --memory-swap=4g \
  --user "$(id -u):$(id -g)" \
  -e HOME=/src/build/.home \
  -e LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu \
  -e SDL_VIDEODRIVER=dummy \
  -v "$WESNOTH_ROOT:/src" \
  -w /src \
  wesnoth/wesnoth:2404-sdl3 \
  ./build/wesnoth --nogui --multiplayer --controller 1:ai --controller 2:ai --userdata-dir=/src/build/userdata_test --exit-at-end

echo "Smoke test completato con successo (exit code 0)."
