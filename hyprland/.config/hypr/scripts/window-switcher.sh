#!/bin/bash
# Lists every mapped window across all workspaces via hyprctl and jumps to
# whichever one is picked. Recovers windows that got buried/lost for any
# reason (wrong workspace, tiling, a dropped focus request) without having
# to find and kill the process.
sel=$(hyprctl clients -j | jq -r '.[] | select(.mapped==true) | "\(.address)\t[\(.workspace.name)] \(.class) — \(.title)"' \
    | wofi --dmenu --prompt "Windows" | cut -f1)
[ -n "$sel" ] && hyprctl dispatch focuswindow address:"$sel"
