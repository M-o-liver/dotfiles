#!/bin/bash
# Brings the most-recently put-away window (see hyprland.conf, Super+C)
# back into the current workspace as a real tile, not a floating overlay.
set -euo pipefail

HOLDING_WS=9

current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
addr=$(hyprctl clients -j | jq -r --arg ws "$HOLDING_WS" \
  '[.[] | select(.workspace.id == ($ws | tonumber))] | sort_by(.focusHistoryID) | first | .address // empty')

if [ -n "$addr" ]; then
  hyprctl dispatch movetoworkspace "$current_ws,address:$addr"
  hyprctl dispatch focuswindow "address:$addr"
fi
