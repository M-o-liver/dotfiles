Sync ~/dotfiles: reconcile live config drift with the repo and commit.

Steps:

1. Run `git -C ~/dotfiles status --short` and `git -C ~/dotfiles diff` to see
   what changed. Summarize it in one or two sentences.
2. Detect severed stow symlinks: for any changed file under `~/.config` or
   `~/.local` that corresponds to a stow-managed path but is no longer a
   symlink into `~/dotfiles` (a tool wrote it by unlink-then-create), copy
   its content back into the repo at the matching path, delete the stray
   file, and re-run `stow <package>` (or `stow --no-folding claude` for the
   claude package) to restore the symlink.
3. If any change is user-visible (a keybinding or other user-facing
   behavior), update `CHEATSHEET.md` in the same commit. Never hand-edit or
   hand-commit `CHEATSHEET.pdf` — the pre-commit hook rebuilds it.
4. If you learned something durable about the machine during this session
   (a new quirk, a fixed bug, a changed decision), update `MACHINE.md` in
   the same commit.
5. Stage the relevant files and commit with a message describing what
   changed and why.
6. Never push without asking first.
