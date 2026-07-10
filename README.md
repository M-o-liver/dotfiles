# dotfiles

Hyprland rice for Fedora 44, managed with GNU Stow. Each top-level directory
is a stow "package" mirroring `~/.config` layout.

## Usage

```
cd ~/dotfiles
stow hyprland     # symlinks hyprland/.config/hypr -> ~/.config/hypr
stow waybar
stow -D hyprland   # unstow / remove symlinks
```

## Packages

- `hyprland/` — window manager config, keybindings, monitor/window rules
- (more added per phase)

## Machine notes

- Fedora 44, Btrfs root, hybrid GPU: AMD Raphael (iGPU) + NVIDIA RTX 5070
  Max-Q (dGPU), proprietary NVIDIA driver via RPM Fusion.
- GNOME/GDM kept as fallback session — do not remove.
- Pre-change Btrfs snapshot taken via snapper (`root` config) before any
  system package changes.
