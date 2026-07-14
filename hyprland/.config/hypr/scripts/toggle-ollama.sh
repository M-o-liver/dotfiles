#!/bin/bash
# Toggle a landscape ghostty scratchpad (~693x368px, the original 368x690
# portrait shape rotated 90 degrees) running `ollama run qwen2.5-coder:7b`.
# Hides via Hyprland special workspace (process keeps running); does not kill it.
#
# Note: window-width/window-height are in CELLS, not pixels, and monospace
# cells are ~2.2x taller than wide -- so swapping 35/30 to 30/35 made it
# taller, not wider. 66x16 cells was measured to reproduce the original's
# pixel footprint rotated sideways.

if hyprctl clients -j | jq -e '.[] | select(.class=="com.ollama.scratch")' >/dev/null; then
    hyprctl dispatch togglespecialworkspace ollama
else
    ghostty --class=com.ollama.scratch --window-width=66 --window-height=16 -e ollama run qwen2.5-coder:7b &
fi
