#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/lab-shell}"
CORE_DIR="$DOTFILES_DIR/profiles/shared/core"
CORE_ZSHRC="$CORE_DIR/zsh/.zshrc"
CORE_STARSHIP="$CORE_DIR/starship.toml"

if [[ -L "$HOME/.zshrc" ]]; then
  target="$(readlink "$HOME/.zshrc" || true)"
  if [[ "$target" == "$CORE_ZSHRC" ]]; then
    rm "$HOME/.zshrc"
    echo "Removed ~/.zshrc symlink to lab-shell."
  fi
fi

if [[ -f "$HOME/.config/starship.toml" ]]; then
  if cmp -s "$HOME/.config/starship.toml" "$CORE_STARSHIP" 2>/dev/null; then
    rm "$HOME/.config/starship.toml"
    echo "Removed ~/.config/starship.toml."
  fi
fi

echo "Uninstall complete."
echo "If needed, restore your own ~/.zshrc manually."
