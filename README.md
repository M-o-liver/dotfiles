# dotfiles

Hyprland rice for Fedora 44, managed with GNU Stow. Each top-level directory
is a stow "package" mirroring `~/.config` (or `~/.local`) layout.

## Usage

```
cd ~/dotfiles
stow hyprland waybar foot ghostty starship fastfetch wofi \
    hyprpaper hypridle hyprlock wallpaper zsh scripts
stow -D hyprland   # unstow / remove symlinks for one package
```

## Bootstrap on a new machine

```
~/dotfiles/scripts/.local/bin/install-nerd-font   # after stow scripts, or run directly
```

Fonts aren't committed to git (JetBrainsMono Nerd Font is ~220MB) — the
script above pulls it from the upstream nerd-fonts GitHub release into
`~/.local/share/fonts`.

## Packages

- `hyprland/` — window manager config, keybindings, monitor/window rules,
  `scripts/dgpu-run` for NVIDIA PRIME offload
- `waybar/` — status bar (workspaces, clock, network, audio, cpu/mem, tray)
- `foot/` — lightweight fallback terminal (used during initial bootstrap)
- `ghostty/` — primary terminal
- `starship/`, `zsh/` — shell + prompt
- `fastfetch/` — system info fetch, detects both GPUs automatically
- `wofi/` — app launcher
- `hyprpaper/`, `hypridle/`, `hyprlock/` — wallpaper, idle, lock screen
- `wallpaper/` — generated gradient wallpaper matching the theme palette
- `scripts/` — `~/.local/bin` helpers (`dgpu-run`, `install-nerd-font`)

## Theme

Dark, purple/green accent. Palette: bg `#1a1625`, surface `#211d2e`,
fg `#e0def4`, muted `#6b6382`, purple `#a78bfa`, green `#4ade80`. Applied to
Hyprland borders, Waybar, Ghostty, wofi, hyprlock.

## Machine notes

- Fedora 44, Btrfs root, hybrid GPU: AMD Raphael (iGPU, drives the internal
  eDP panel) + NVIDIA RTX 5070 Max-Q (dGPU, PRIME-offload only via
  `dgpu-run`). Hyprland always runs on the AMD GPU — it owns the display.
- Hyprland itself comes from the `ashbuk/Hyprland-Fedora` COPR (vendored
  libs, avoids ABI breakage) — NOT `solopasha/hyprland`, which is broken on
  F44 as of mid-2026 (stale `aquamarine` build vs. system `libdisplay-info`).
  `solopasha/hyprland` COPR is still enabled for the satellite tools
  (hyprpaper, hyprpicker, hyprland-contrib) that don't depend on aquamarine.
- Ghostty comes from `scottames/ghostty` COPR (per ghostty.org's own docs).
- Starship is installed via its official install script to
  `/usr/local/bin`, not packaged.
- Hyprland 0.55+ moved to a Lua config format; this repo still uses the
  legacy hyprlang `.conf` syntax (works for now, deprecated long-term).
  `windowrulev2`/`dwindle:pseudotile`/`gestures:workspace_swipe` from older
  example configs no longer work as of 0.55 — see git log for what replaced
  them.
- GNOME/GDM kept as fallback session — do not remove.
- Pre-change Btrfs snapshot taken via snapper (`root` config) before any
  system package changes.
