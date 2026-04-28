# Shared core profile for lab members.
# Safe defaults only: no host-specific network or SSH automation.

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
alias ...='cd ../..'
alias r='source ~/.bashrc'

if command -v eza >/dev/null 2>&1; then
  alias ll='eza -la --git'
else
  alias ll='ls -lah'
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
