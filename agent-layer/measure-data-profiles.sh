#!/usr/bin/env bash
set -euo pipefail

# BRU-43-7-5: misura memoria full vs light data dir.
# Per ogni profilo esegue la stessa partita MP ai-vs-ai headless e riporta:
#   - VmHWM  (picco RSS del processo wesnoth, campionato da /proc)
#   - memory.peak del cgroup container (include page cache)
#   - wall time
# Il repo è montato allo STESSO path del host: il profilo light è fatto di
# symlink assoluti generati da make-light-data-dir.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
WESNOTH_ROOT="$(cd "$SCRIPT_DIR/.." &> /dev/null && pwd)"
IMAGE="${IMAGE:-wesnoth/wesnoth:2404-sdl3}"
LIGHT_DIR="${LIGHT_DIR:-$WESNOTH_ROOT/build/light-data}"

[ -e "$LIGHT_DIR" ] || "$SCRIPT_DIR/make-light-data-dir" "$LIGHT_DIR"

measure() {
  local label=$1; shift
  echo "=== profilo: $label ==="
  docker run --rm -i \
    --cpus=1.5 --memory=3g --memory-swap=4g \
    --user "$(id -u):$(id -g)" \
    -e HOME="$WESNOTH_ROOT/build/.home" \
    -e LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu \
    -e SDL_VIDEODRIVER=dummy \
    -v "$WESNOTH_ROOT:$WESNOTH_ROOT" -w "$WESNOTH_ROOT" \
    "$IMAGE" \
    bash -c '
      start=$(date +%s)
      ./build/wesnoth --nogui \
        --userdata-dir='"$WESNOTH_ROOT"'/build/userdata_test \
        --multiplayer --controller 1:ai --controller 2:ai --exit-at-end \
        '"$*"' > /dev/null 2>&1 &
      p=$!
      hwm=""
      while kill -0 $p 2>/dev/null; do
        h=$(grep VmHWM /proc/$p/status 2>/dev/null | awk "{print \$2}") && hwm=$h
        sleep 0.3
      done
      wait $p; ec=$?
      end=$(date +%s)
      peak=$(cat /sys/fs/cgroup/memory.peak 2>/dev/null || echo n/a)
      echo "exit=$ec  VmHWM=${hwm}kB  cgroup_peak=${peak}B  wall=$((end-start))s"
    '
}

measure "full (data/ completa)"
measure "light ($LIGHT_DIR)" --data-dir="$LIGHT_DIR"
