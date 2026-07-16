# Hyprland keybinding cheat-sheet

Mod key = **Super** (Windows key)

## Apps
| Key | Action |
|---|---|
| `Super + Q` | Open terminal (Ghostty) |
| `Super + R` | App launcher (wofi) |
| Click `` (bar, bottom-left) | App launcher (wofi) — same as `Super + R` |
| `Super + E` | File manager (Nautilus, GUI) |
| `Super + Shift + E` | File manager (yazi, terminal) |
| `Super + Shift + L` | Lock screen (hyprlock) |
| `Super + O` | Toggle Ollama scratchpad (wide ghostty, `qwen2.5-coder:7b`) — hides, doesn't kill |

## Windows
| Key | Action |
|---|---|
| `Super + C` | Put away focused window (hides it, doesn't kill) |
| `Super + Shift + C` | Bring back the put-away window |
| `Super + Shift + Q` | Close (kill) focused window |
| `Super + V` | Toggle floating |
| `Super + F` | Toggle fullscreen |
| `Super + P` | Toggle pseudotile |
| `Super + J` | Toggle split direction |
| `Super + H/J/K/L` or arrows | Move focus between windows |
| `Super + drag` (left click) | Move window |
| `Super + drag` (right click) | Resize window |
| Video fullscreen in Chrome (e.g. YouTube `f`) | Fills the tile, not the monitor (window rule) |

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

## Bar (waybar — bottom of screen)
| Element | Click action |
|---|---|
| `` home button | App launcher (wofi) |
| Workspace numbers | Switch workspace |
| Network | nm-connection-editor |
| Bluetooth | blueman-manager |
| Volume | Toggle mute |
| CPU / Mem | btop |

## Desktop widgets
Three floating windows are launched at startup and pinned in place (wallpaper
owns the center of the screen):
| Widget | Position | Contents |
|---|---|---|
| System monitor | left | `btop` |
| System info | top-right | `fastfetch` |
| Ascii art | bottom-right | static art from `~/.config/hypr/ascii-art.txt` |

Close/move like any floating window (`Super + Shift + Q` to kill / `Super + drag`
to move) — they won't reappear positioned until the next Hyprland login.

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
- **Google Chrome** — web browser
- **Prism Launcher** — Minecraft (Flatpak); use `dgpu-run flatpak run org.prismlauncher.PrismLauncher` to force NVIDIA dGPU
- **Papers** — PDF viewer

## yazi keybinds
| Key | Action |
|---|---|
| `j` / `k` or arrows | Move down / up |
| `h` / `l` or arrows | Parent dir / enter dir |
| `H` / `L` | Back / forward in history |
| `gg` / `G` | Top / bottom |
| `gh` | Go home (`~`) |
| `gc` | Go to `~/.config` |
| `gd` | Go to `~/Downloads` |
| `<Space>` | Toggle selection on current file |
| `v` / `V` | Visual select mode / visual unset mode |
| `Ctrl+a` / `Ctrl+r` | Select all / invert selection |
| `y` / `x` / `p` / `P` | Yank (copy) / cut / paste / paste (overwrite) |
| `d` / `D` | Trash / permanently delete |
| `a` | Create file (end with `/` for a directory) |
| `r` | Rename |
| `o` / `Enter` | Open |
| `O` / `Shift+Enter` | Open interactively (pick app) |
| `.` | Toggle hidden files |
| `/` / `?` | Find next / previous |
| `s` / `S` | Search by name (fd) / by content (ripgrep) |
| `f` | Filter files |
| `tt` | New tab in current dir |
| `1`-`9` | Switch to tab N |
| `[` / `]` | Previous / next tab |
| `,` then `m`/`a`/`s`/`e`/`n` | Sort by mtime / alphabetical / size / extension / natural (Shift = reverse) |
| `w` | Task manager |
| `~` or `F1` | Help (full keymap, searchable) |
| `q` | Quit |

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
  "GNOME" instead of "Hyprland" at the GDM session picker. GNOME is
  Nord-themed with a bottom taskbar (dash-to-panel); if it ever looks
  stock or broken after an upgrade, re-run `gnome-nord`.
- **Config errors on screen**: `hyprctl configerrors` gives the exact
  file/line instead of guessing from the on-screen banner.
- **Cropped/shifted screen**: see Troubleshooting in README.md — almost
  always a fractional monitor scale.
