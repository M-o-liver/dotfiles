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

## qutebrowser
Vim-style modal browser — `i` enters insert mode for typing into page
fields, `Esc` always returns to normal mode.

| Key | Action |
|---|---|
| `o` / `O` | Open URL (same tab / new tab) |
| `f` | Hint mode: click a link by typed label |
| `F` | Hint mode: open link in new tab |
| `d` / `Shift+D` | Close tab / close tab without losing focus |
| `u` | Reopen last closed tab |
| `J` / `K` or `gt` / `gT` | Next / previous tab |
| `1`-`9` `gt` after (e.g. `3gt`) | Jump to tab N |
| `r` | Reload page |
| `H` / `L` | Back / forward |
| `yy` | Yank current URL to clipboard |
| `pp` | Open clipboard content as URL |
| `/` | Search in page, `n`/`N` next/previous match |
| `m` | **Play current page's video in mpv** (via yt-dlp — smoother than embedded playback) |
| `M` | Hint a link, play it in mpv |
| `:` | Command mode (e.g. `:set`, `:bind`, `:open`) |
| `Ctrl+Shift+P` | Private browsing window |
| `ZZ` | Quit qutebrowser |

No extensions support (qutebrowser isn't a full Chromium shell, no
WebExtensions API) — but real ad blocking is built in via Brave's
adblock-rust engine using actual EasyList/EasyPrivacy filter lists, the same
lists uBlock Origin uses. Run `:adblock-update` once (and after that,
whenever you want fresh lists) to fetch them.

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
