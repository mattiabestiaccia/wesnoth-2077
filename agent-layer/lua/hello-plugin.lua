-- hello-plugin.lua — minimal proof that `--plugin` works headless (BRU-43-1-3).
-- Loaded in the plugin context: prints a marker to stdout, then idles,
-- yielding control so the game can proceed and exit via --exit-at-end.

std_print("[wesnoth-2077] hello from agent-layer plugin")

while true do
  coroutine.yield()
end
