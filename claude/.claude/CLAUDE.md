# Global — applies to every Claude Code session on this machine

Machine context, quirks, and hard rules:
@~/dotfiles/MACHINE.md

- This machine's administrative root is ~/dotfiles (stow-managed).
  Config changes belong there, committed — never loose in ~/.config.
- System-level changes require a snapper snapshot first (`snap-now`);
  a PreToolUse hook enforces this.
