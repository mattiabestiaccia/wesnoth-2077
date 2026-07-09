#!/usr/bin/env bash
set -e

# Headless smoke test per wesnoth-2077
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
WESNOTH_ROOT="$(cd "$SCRIPT_DIR/.." &> /dev/null && pwd)"

echo "Running headless smoke test in container..."
docker run --rm -i \
  -v "$WESNOTH_ROOT:/src" \
  -w /src/build \
  -e SDL_VIDEODRIVER=dummy \
  wesnoth/wesnoth:2404-sdl3 \
  bash -c "rm -rf /usr/local/lib/libboost* && ./wesnoth --nogui --multiplayer --controller 1:ai --controller 2:ai --userdata-dir=/src/build/userdata_test --exit-at-end"

echo "Smoke test completato con successo (exit code 0)."
