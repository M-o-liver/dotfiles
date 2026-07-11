# Hyprland keybinding cheat-sheet

Mod key = **Super** (Windows key)

## Apps
| Key | Action |
|---|---|
| `Super + Q` | Open terminal (Ghostty) |
| `Super + R` | App launcher (wofi) |
| `Super + E` | File manager (Nautilus, GUI) |
| `Super + Shift + E` | File manager (yazi, terminal) |
| `Super + L` | Lock screen (hyprlock) |

## Windows
| Key | Action |
|---|---|
| `Super + C` | Close focused window |
| `Super + V` | Toggle floating |
| `Super + F` | Toggle fullscreen |
| `Super + P` | Toggle pseudotile |
| `Super + J` | Toggle split direction |
| `Super + H/J/K/L` or arrows | Move focus between windows |
| `Super + drag` (left click) | Move window |
| `Super + drag` (right click) | Resize window |

## Workspaces
| Key | Action |
|---|---|
| `Super + 1..0` | Switch to workspace 1-10 |
| `Super + Shift + 1..0` | Move focused window to workspace 1-10 |
| `Super + scroll` | Cycle workspaces |
| 3-finger touchpad swipe | Switch workspaces |

## Media / system
| Key | Action |
|---|---|
| Volume up/down/mute keys | Adjust/mute volume (wpctl) |
| Brightness up/down keys | Adjust screen brightness |
| Play/next/prev media keys | playerctl control |

## Session
| Key | Action |
|---|---|
| `Super + M` | Exit Hyprland, back to GDM |

## Terminal apps
| Command | Action |
|---|---|
| `y` | yazi (in any terminal) — `cd`s to wherever you exited |
| `yazi` | yazi without the cd-on-exit behavior |

## Other apps (via `Super + R`)
- **qutebrowser** — keyboard-driven browser
- **Prism Launcher** — Minecraft (Flatpak); use `dgpu-run flatpak run org.prismlauncher.PrismLauncher` to force NVIDIA dGPU
- **Papers** — PDF viewer

## GPU offload
Run any app on the NVIDIA dGPU instead of the AMD iGPU (Hyprland always
runs on AMD, since it drives the panel):
```
dgpu-run <command>
# e.g.
dgpu-run flatpak run org.prismlauncher.PrismLauncher
```

## Recovery
- **Hyprland won't start / crashes at login**: at GDM, switch to a TTY with
  `Ctrl+Alt+F3`, log in, run `journalctl --user -b -u wayland-wm@hyprland.service`
  or check `~/.local/share/hyprland/` / `/run/user/$UID/hypr/*/hyprland.log`
  for the actual error. `Ctrl+Alt+F1` (or F2) back to the graphical screen.
- **Session hung**: `loginctl terminate-user cross` from a TTY force-kills
  it and drops GDM back to the login screen.
- **Just want GNOME back**: `Super + M` from inside Hyprland, or pick
  "GNOME" instead of "Hyprland" at the GDM session picker.
- **Config errors on screen**: `hyprctl configerrors` gives the exact
  file/line instead of guessing from the on-screen banner.
- **Cropped/shifted screen**: see Troubleshooting in README.md — almost
  always a fractional monitor scale.
