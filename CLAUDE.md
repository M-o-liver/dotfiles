# CLAUDE.md — repo rules for ~/dotfiles

Machine context, quirks, and hard rules live in one place:
@MACHINE.md

## Repo-specific hygiene

- This repo is the administrative root of the machine — see MACHINE.md
  for system identity, package provenance, quirks, and safety rules.
- GNU Stow manages every top-level directory as a package mirroring
  `~/.config` or `~/.local`. Edit files in-repo; never delete-and-recreate
  at the home-directory path (severs the stow symlink).
- Commit after every meaningful change, with a message saying what changed
  and why.
- If a change is user-visible (keybinding, behavior), update CHEATSHEET.md
  in the same commit. The pre-commit hook rebuilds CHEATSHEET.pdf via
  pandoc — never hand-commit the PDF.
- If you learn something durable about the machine itself, update
  MACHINE.md (not this file) in the same commit.
