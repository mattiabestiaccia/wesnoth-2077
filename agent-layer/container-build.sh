#!/usr/bin/env bash
set -euo pipefail

# Containerized build for wesnoth-2077 (BRU-43-1-1).
# Resource limits per BRU-43-7-3: --cpus=1.5 --memory=3g --memory-swap=4g,
# -j2, LTO off. Headless-oriented: game client only, no NLS, no tests.
# Output: ./build/wesnoth (bind mount, owned by the invoking user).
#
# Boost_DIR pins the *system* Boost 1.83: the image also ships a Boost in
# /usr/local built with _GLIBCXX_DEBUG (std::__debug::vector symbols) for CI
# debug jobs — linking against it fails with undefined boost::program_options
# references. Same reason headless-smoke-test.sh removes /usr/local/lib/libboost*
# at runtime. Full compile: ~35 min on 1.5 vCPU (measured 2026-07-12).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
WESNOTH_ROOT="$(cd "$SCRIPT_DIR/.." &> /dev/null && pwd)"
JOBS="${JOBS:-2}"
IMAGE="${IMAGE:-wesnoth/wesnoth:2404-sdl3}"

docker run --rm -i \
  --cpus=1.5 --memory=3g --memory-swap=4g \
  --user "$(id -u):$(id -g)" \
  -e HOME=/src/build/.home \
  -v "$WESNOTH_ROOT:/src" -w /src \
  "$IMAGE" \
  bash -c "
    mkdir -p /src/build/.home &&
    cmake --fresh -B build \
      -DCMAKE_BUILD_TYPE=Release \
      -DBoost_DIR=/usr/lib/x86_64-linux-gnu/cmake/Boost-1.83.0 \
      -DENABLE_GAME=ON \
      -DENABLE_SERVER=OFF \
      -DENABLE_CAMPAIGN_SERVER=OFF \
      -DENABLE_NLS=OFF \
      -DENABLE_TESTS=OFF \
      -DENABLE_LTO=OFF &&
    cmake --build build -j\"$JOBS\"
  "

echo "Build completata: $WESNOTH_ROOT/build/wesnoth"
