# system/ — root-owned config (NOT a stow package)

Files here mirror their absolute filesystem paths (`system/etc/...` ->
`/etc/...`). Stow can't manage them (they live outside $HOME), so they are
deployed by copy, with sudo, after a `snap-now` snapshot:

```
sudo install -Dm644 system/etc/sddm.conf.d/10-theme.conf /etc/sddm.conf.d/10-theme.conf
```

This directory is the committed source of truth; if a file here and the
live copy in / disagree, the live copy has drifted (or was hand-edited —
reconcile, then recommit).

## Contents

- `etc/udev/rules.d/60-openrgb-msi-ms1603.rules` — uaccess for the MSI
  MysticLight MS-1603 keyboard (1462:1603) so OpenRGB can drive the
  keyboard backlight as the logged-in user. Fedora's packaged
  openrgb-udev-rules doesn't know this PID.
- `etc/sddm.conf.d/10-theme.conf` — selects the SDDM theme.
- `etc/systemd/zram-generator.conf` — zram swap. Keeps Fedora's stock 8G
  size but switches the compressor from `lzo-rle` to `zstd`. Replaces (does
  not merge with) the vendor file in `/usr/lib/systemd/`, so `zram-size`
  is restated there deliberately — dropping it would fall back to
  `min(ram / 2, 4096)`.
- `usr/share/sddm/themes/sddm-astronaut-theme/Themes/nord.conf` — our Nord
  preset for the sddm-astronaut-theme greeter (upstream:
  https://github.com/Keyitdev/sddm-astronaut-theme, GPLv3, Qt6). The theme
  itself is installed by copying the vetted upstream tree to
  `/usr/share/sddm/themes/sddm-astronaut-theme` with `metadata.desktop`
  pointed at `Themes/nord.conf`; only our preset is tracked here, not the
  ~16MB upstream tree.
