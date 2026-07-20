# dotfiles

GNOME desktop config (Nord theme, Windows-like layout) for Fedora 44,
managed with GNU Stow. Each top-level directory is a stow "package"
mirroring `~/.config` (or `~/.local`) layout — except `system/`, which
holds root-owned config deployed by copy (see `system/README.md`).

Hyprland history: this repo was a Hyprland rice until 2026-07-19, when the
rice was retired in favor of plain GNOME with a Windows-like layout (see
git history for the old configs).

## Usage

```
cd ~/dotfiles
mkdir -p ~/.claude/commands   # first time only, if ~/.claude doesn't exist yet
stow btop fastfetch ghostty gtk scripts starship wallpaper yazi zsh
stow --no-folding claude goose   # REQUIRED: plain `stow` would fold
                            # ~/.claude, ~/.config/goose into the
                            # repo, dragging each tool's own runtime state
                            # (history, sessions, cache) in with it.
stow -D ghostty    # unstow / remove symlinks for one package
```

## Bootstrap on a new machine

```
~/dotfiles/scripts/.local/bin/install-nerd-font   # after stow scripts, or run directly
~/dotfiles/scripts/.local/bin/gnome-nord          # apply GNOME theme + layout (dconf)
```

GNOME Shell extensions: `gnome-shell-extension-dash-to-panel` and
`gnome-shell-extension-appindicator` come from the Fedora repos (dnf).
ArcMenu is not packaged for Fedora — install it user-level from
extensions.gnome.org (download the zip for the current GNOME Shell
version, then `gnome-extensions install <zip>`), then re-run `gnome-nord`
and re-login.

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

- `ghostty/` — primary terminal
- `starship/`, `zsh/` — shell + prompt
- `fastfetch/` — system info fetch, detects both GPUs automatically
- `btop/` — system monitor
- `yazi/` — terminal file manager
- `gtk/` — gtk-3.0/gtk-4.0 Nord color overrides for GNOME apps
- `wallpaper/` — generated gradient wallpaper matching the theme palette
- `scripts/` — `~/.local/bin` helpers (`dgpu-run`, `install-nerd-font`,
  `gnome-nord`, `snap-now`, `wifi`, ...)
- `claude/`, `goose/` — AI tooling config (see below)

GNOME appearance/behavior settings live in dconf (binary database), so the
`gnome-nord` script in `scripts/` is the committed source of truth for
them — re-run it after a GNOME upgrade if anything looks stock.

## Theme

Nord. Palette: bg `#2e3440`, bg-alt `#3b4252`, fg `#eceff4`, muted
`#4c566a`, primary accent frost cyan `#88c0d0`, secondary frost blue
`#81a1c1`, semantic aurora red `#bf616a`, yellow `#ebcb8b`, green
`#a3be8c`. Applied via `gnome-nord` (GNOME/dconf, dash-to-panel, ArcMenu)
and the `gtk` package's `gtk.css` overrides; Ghostty carries its own
matching colors.

## Troubleshooting

- **Tofu boxes / Ghostty crashes immediately on launch**: the Nerd Font is
  missing or broken. Re-run `~/dotfiles/scripts/.local/bin/install-nerd-font`.
  Font files are NOT stow-managed (too big for git).
- **GNOME looks stock after an upgrade**: re-run `gnome-nord`, then
  log out/in.
- **Battery says "Not charging" while plugged in**: not a config bug. The
  kernel's own `/sys/class/power_supply/BAT1/status` reports this — it's
  the stock `msi_wmi_platform` driver not fully decoding this MSI EC's
  charging state. The community `msi-ec` DKMS driver (COPR: `xabi08/MSI-EC`)
  fixes this on supported models, but this laptop's exact model (Crosshair
  A18 HX A8WGKG) wasn't confirmed on msi-ec's supported-device list as of
  2026-07-10, and it writes directly to EC registers, so we deliberately
  skipped installing it. Revisit if a supported-devices update covers this
  model.

## Machine notes

- Fedora 44, Btrfs root, hybrid GPU: AMD Raphael (iGPU, drives the internal
  eDP panel) + NVIDIA RTX 5070 Max-Q (dGPU, PRIME-offload only via
  `dgpu-run`). GNOME Shell (Mutter) always runs on the AMD GPU — it owns
  the display.
- Ghostty comes from `scottames/ghostty` COPR (per ghostty.org's own docs);
  yazi from `boobaa/yazi` COPR.
- Starship is installed via its official install script to
  `/usr/local/bin`, not packaged.
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
