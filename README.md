# dotfiles

Hyprland rice for Fedora 44, managed with GNU Stow. Each top-level directory
is a stow "package" mirroring `~/.config` (or `~/.local`) layout.

## Usage

```
cd ~/dotfiles
mkdir -p ~/.claude/commands   # first time only, if ~/.claude doesn't exist yet
stow hyprland waybar foot ghostty starship fastfetch wofi \
    hyprpaper hypridle hyprlock wallpaper zsh scripts
stow --no-folding claude goose   # REQUIRED: plain `stow` would fold
                            # ~/.claude, ~/.config/goose into the
                            # repo, dragging each tool's own runtime state
                            # (history, sessions, cache) in with it.
stow -D hyprland   # unstow / remove symlinks for one package
```

## Bootstrap on a new machine

```
~/dotfiles/scripts/.local/bin/install-nerd-font   # after stow scripts, or run directly
```

## Cheat-sheet PDF

`CHEATSHEET.md` is the source of truth; `CHEATSHEET.pdf` (built via pandoc +
LaTeX, so Papers/any PDF viewer can read it) is regenerated automatically by
a pre-commit hook whenever `CHEATSHEET.md` changes -- `git config
core.hooksPath .githooks` wires that up (already set locally in this repo).
To rebuild by hand: `make` (needs `pandoc-cli` +
`texlive-collection-latexrecommended` + `texlive-mdwtools`).

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

## Troubleshooting

- **Cropped/shifted screen edge**: almost always a fractional monitor scale.
  Logical resolution (physical / scale) must come out to a whole number —
  see the comment on the `monitor =` line in `hyprland/.config/hypr/hyprland.conf`.
  Fix by editing the scale value and logging out/in (or `hyprctl reload` if
  only non-monitor lines changed). Do NOT try to fix this by toggling
  `hyprctl keyword monitor eDP-1,disable` live — on this machine that failed
  to bring the CRTC back and required a hard restart to recover.
- **Config errors on screen**: run `hyprctl configerrors` to see the exact
  file/line, rather than guessing from the banner text.
- **Tofu boxes / Ghostty crashes immediately on launch**: the Nerd Font is
  missing or broken. Re-run `~/dotfiles/scripts/.local/bin/install-nerd-font`.
  Font files are NOT stow-managed (too big for git) — if you ever delete
  `~/dotfiles/fonts` or similar, check `find ~/.local/share/fonts -xtype l`
  for dangling symlinks first.
- **Waybar battery always says "Not charging" while plugged in**: not a
  rice bug. The kernel's own `/sys/class/power_supply/BAT1/status` reports
  this (verify with `cat /sys/class/power_supply/BAT1/status` and
  `current_now`, both wrong even outside Hyprland/Waybar) — it's the stock
  `msi_wmi_platform` driver not fully decoding this MSI EC's charging
  state. The community `msi-ec` DKMS driver (COPR: `xabi08/MSI-EC`) fixes
  this on supported models, but this laptop's exact model (Crosshair A18 HX
  A8WGKG) wasn't confirmed on msi-ec's supported-device list as of
  2026-07-10, and it writes directly to EC registers, so we deliberately
  skipped installing it. Revisit if a supported-devices update covers this
  model.

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

## Conversational layer

This repo doubles as the machine's agent-aware administrative root, for
Claude Code sessions:

- `MACHINE.md` is the machine brain — system identity, package provenance,
  quirks, and safety rules. `CLAUDE.md` (repo root) holds repo-specific
  hygiene and imports `MACHINE.md`.
- The `claude/` package version-controls Claude Code's own configuration:
  `claude/.claude/settings.json` (permissions, hook wiring), a global
  `claude/.claude/CLAUDE.md` pointer (imports `~/dotfiles/MACHINE.md`, so
  every session on this machine loads the same machine context regardless
  of which directory it's opened in), and `claude/.claude/commands/`
  (`/sync`, `/verify`).
- The snapshot policy is enforced, not just requested: a PreToolUse hook
  (`agent-snapshot-guard`) blocks system-changing Bash commands unless a
  recent `snap-now` snapshot exists.
- Recovery is two-tier: snapper for system state (`snapper rollback`), git
  for userland config in this repo. Neither substitutes for the other.

`stow --no-folding claude` is required when deploying the `claude` package
(see Usage above) — plain `stow` would fold `~/.claude` into the repo and
pull Claude Code's runtime state (session history, cache) into version
control with it.
