Verify machine health. Report-only — fix nothing.

Run the diagnostic openers and quote the lines that matter:

```
journalctl -b -p err --no-pager | tail -50
hyprctl configerrors && hyprctl monitors
lspci -k | grep -A3 -Ei 'vga|3d'
nvidia-smi
dnf history | head
cat /sys/class/power_supply/BAT1/status
```

Also run `git -C ~/dotfiles status --short` to check for uncommitted drift
in the administrative root.

Cross-check GPU topology against MACHINE.md: Hyprland must be running on
the AMD iGPU (it owns the eDP display); the NVIDIA RTX 5070 must appear
only as a PRIME-offload target, never as the display driver. Flag any
deviation.

End with a one-paragraph verdict: healthy, drifted, or broken — and why.
Do not propose or apply fixes; that's a separate step.
