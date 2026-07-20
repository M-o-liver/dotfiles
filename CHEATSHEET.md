# GNOME desktop cheat-sheet

Windows-like GNOME setup: dash-to-panel taskbar (bottom), ArcMenu start
menu, per-window Alt-Tab, edge snapping. All of it is applied by the
`gnome-nord` script -- re-run it and re-login if anything looks stock.

## Start menu & apps
| Key | Action |
|---|---|
| `Super` | Open start menu (ArcMenu, Windows layout) |
| Type after `Super` | Search apps/files, Enter to launch |
| `Alt + F2` | Run-command prompt (GNOME built-in) |
| Taskbar icon click | Focus/launch app (pin via right-click) |

There are no custom app-launch hotkeys anymore (the old `Super+Q` etc.
went with Hyprland). Add any you miss in Settings > Keyboard > Custom
Shortcuts.

## Windows
| Key | Action |
|---|---|
| `Alt + Tab` | Switch between windows (Windows-style, per window) |
| `Super + Tab` | Switch between applications (grouped) |
| `Super + Left/Right` | Snap window to half screen (or drag to edge) |
| `Super + Up` | Maximize (or drag to top edge) |
| `Super + Down` | Unmaximize / restore |
| `Super + H` | Minimize ("hide") |
| `Alt + F4` | Close window |
| `F11` | Fullscreen (app-dependent) |

## Workspaces
| Key | Action |
|---|---|
| `Super + Page Up / Page Down` | Previous / next workspace |
| `Super + Shift + Page Up / Page Down` | Move window to prev/next workspace |
| 3-finger touchpad swipe up | Overview (all windows + workspaces) |

## Media / system
Volume, brightness, and media keys are handled natively by GNOME.
System menu (network, bluetooth, battery, power off): top-right of the
taskbar. Lock screen: `Super + L`.

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
The login screen is SDDM (Nord-themed); GDM is installed but disabled as
the fallback display manager.

- **Login screen black/broken (SDDM greeter fails)**: switch to a TTY
  with `Ctrl+Alt+F3`, log in, run
  `sudo systemctl disable sddm && sudo systemctl enable gdm`, reboot.
  You're back on stock GDM; debug SDDM later from comfort.
- **GNOME session won't start / crashes at login**: from a TTY, check
  `journalctl --user -b -u org.gnome.Shell@wayland.service` (or
  `journalctl -b -p err`). `Ctrl+Alt+F1` (or F2) back to the graphical
  screen.
- **Session hung**: `loginctl terminate-user cross` from a TTY force-kills
  it and drops back to the login screen.
- **Theme/taskbar/start menu missing or stock-looking**: re-run
  `gnome-nord`, then log out/in. If ArcMenu is gone entirely (e.g. after a
  GNOME major upgrade breaks compatibility), reinstall the matching
  version from extensions.gnome.org (`gnome-extensions install <zip>`).
- **Desperate fallback session**: pick "GNOME Classic" at the login
  screen's session picker -- ugly but always works. Normal logins should
  use plain "GNOME"; Classic force-loads its own extensions and fights
  this setup.
