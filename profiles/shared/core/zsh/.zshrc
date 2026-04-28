# Shared core profile for lab members.
# Safe defaults only: no host-specific network or SSH automation.

export PATH="/opt/homebrew/bin:$HOME/.local/bin:$HOME/bin:$PATH"

# Core aliases (safe to share).
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
alias ...='cd ../..'
alias r='source ~/.zshrc'

# Prefer eza for richer listing when available.
if command -v eza >/dev/null 2>&1; then
  alias ll='eza -la --git'
else
  alias ll='ls -lah'
fi

# Enable Starship prompt if installed.
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
