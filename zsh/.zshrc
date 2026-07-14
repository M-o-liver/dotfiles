export PATH="$HOME/.local/bin:$PATH"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

bindkey -e

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias grep='grep --color=auto'
alias dgpu='dgpu-run'

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

eval "$(starship init zsh)"
