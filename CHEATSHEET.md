# GNOME desktop cheat-sheet

Stock Fedora 44 GNOME -- no theming, no extensions beyond Fedora's own
`background-logo`. Reverted to defaults 2026-07-23. The old Windows-like
rice (dash-to-panel, ArcMenu, Nord colors) is still in this repo behind
the `gnome-nord` script if it's ever wanted back; see Recovery.

## Overview & apps
| Key | Action |
|---|---|
| `Super` | Activities overview (windows + workspaces + search) |
| Type after `Super` | Search apps/files, Enter to launch |
| `Super + A` | Application grid |
| `Alt + F2` | Run-command prompt |
| Top-left hot corner | Overview (mouse) |

Favorites live in the dash on the left of the overview -- right-click an
app to pin. Add custom launch hotkeys in Settings > Keyboard > Custom
Shortcuts.

## Windows
| Key | Action |
|---|---|
| `Alt + Tab` | Switch between applications (grouped) |
| ``Alt + ` `` | Switch between windows of the current app |
| `Super + Left/Right` | Snap window to half screen (or drag to edge) |
| `Super + Up` | Maximize (or drag to top edge) |
| `Super + Down` | Unmaximize / restore |
| `Super + H` | Minimize ("hide") |
| `Alt + F4` | Close window |
| `Alt + F7` / `Alt + F8` | Move / resize with the keyboard |
| `F11` | Fullscreen (app-dependent) |

## Workspaces
| Key | Action |
|---|---|
| `Super + Page Up / Page Down` | Previous / next workspace |
| `Super + Shift + Page Up / Page Down` | Move window to prev/next workspace |
| `Ctrl + Alt + Left / Right` | Previous / next workspace (alternate) |
| 3-finger touchpad swipe up | Overview (all windows + workspaces) |
| 4-finger touchpad swipe left/right | Switch workspace |

## Media / system
Volume, brightness, and media keys are handled natively by GNOME.
System menu (network, bluetooth, battery, power off): top-right of the
top bar. Lock screen: `Super + Shift + L`.

## Terminal apps
| Command | Action |
|---|---|
| `y` | yazi (in any terminal) -- `cd`s to wherever you exited |
| `yazi` | yazi without the cd-on-exit behavior |

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
Run any app on the NVIDIA dGPU instead of the AMD iGPU (GNOME always runs
on AMD, since it drives the panel):
```
dgpu-run <command>
# e.g.
dgpu-run flatpak run org.prismlauncher.PrismLauncher
```

## WiFi
GNOME's system menu (top-right of the taskbar) lists and connects to
networks. The `wifi` script still works from any terminal:
```
wifi              # interactive picker
wifi "GC Public"  # connect straight to a named network
```
Saved networks reconnect without a prompt; new ones ask for a password.
On a captive portal you'll associate but have no route out until you open
any `http://` page and sign in.

## Recovery
The login screen is GDM, stock and unthemed (Fedora's default). SDDM and
its Nord theme are still installed but inactive.

- **GNOME session won't start / crashes at login**: from a TTY, check
  `journalctl --user -b -u org.gnome.Shell@wayland.service` (or
  `journalctl -b -p err`). `Ctrl+Alt+F1` (or F2) back to the graphical
  screen.
- **Session hung**: `loginctl terminate-user cross` from a TTY force-kills
  it and drops back to the login screen.
- **Want the old Windows-like rice back**: `stow gtk && gnome-nord`, then
  log out/in. That re-enables dash-to-panel, ArcMenu and appindicator,
  restores the Nord colors and the per-window Alt-Tab, and re-applies the
  generated wallpaper. If ArcMenu is gone entirely (e.g. after a GNOME
  major upgrade breaks compatibility), reinstall the matching version
  from extensions.gnome.org (`gnome-extensions install <zip>`).
- **Desperate fallback session**: pick "GNOME Classic" at the login
  screen's session picker -- ugly but always works. Normal logins should
  use plain "GNOME".
