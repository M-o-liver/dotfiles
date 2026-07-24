export PATH="$HOME/.local/bin:$PATH"
export NPM_CONFIG_PREFIX="$HOME/.local"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey -e

# --- modern CLI tool hooks ---
# Each is guarded: a missing tool (or a minimal box we've SSHed into) is a
# no-op, never a broken shell. Must come after compinit.
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"   # `z <dir>` frecency jump
command -v direnv >/dev/null && eval "$(direnv hook zsh)"   # per-dir env from .envrc
command -v fzf    >/dev/null && source <(fzf --zsh)         # Ctrl-R / Ctrl-T / Alt-C

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dgpu='dgpu-run'

# eza-powered listings, with a coreutils fallback so these work anywhere
if command -v eza >/dev/null; then
	alias ll='eza -l --git --icons --group-directories-first'
	alias la='eza -la --git --icons --group-directories-first'
	alias lt='eza --tree --level=2 --icons'
else
	alias ll='ls -lh'
	alias la='ls -lha'
fi
command -v lazygit >/dev/null && alias lg='lazygit'

# ollama models, by speed/size: slow=qwen3:30b-a3b (18G), med=gemma3:12b (8.1G), fast=llama3.2:3b (2.0G)
alias slow='ollama run qwen3:30b-a3b'
alias med='ollama run gemma3:12b'
alias fast='ollama run llama3.2:3b'

# yazi: cd to wherever you were browsing when you quit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# fish-style autosuggestions from history (source before syntax highlighting)
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
	&& source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

# syntax highlighting MUST be sourced last — after every ZLE widget and the prompt
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
	&& source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
