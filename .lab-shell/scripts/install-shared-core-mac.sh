#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/lab-shell}"
CORE_DIR="$DOTFILES_DIR/.lab-shell/core"

if [[ ! -d "$CORE_DIR" ]]; then
  echo "Core profile not found: $CORE_DIR"
  exit 1
fi

if ! command -v starship >/dev/null 2>&1; then
  echo "Installing starship..."
  if command -v brew >/dev/null 2>&1; then
    brew install starship
  else
    echo "Homebrew is not installed. Install starship manually:"
    echo "https://starship.rs/"
    exit 1
  fi
fi

mkdir -p "$HOME/.config"
ln -sf "$CORE_DIR/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$CORE_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "Shared core profile installed."
echo "Restart shell or run: exec zsh"
