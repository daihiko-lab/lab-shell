#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/lab-shell}"
CORE_DIR="$DOTFILES_DIR/.lab-shell/core"
STARSHIP_CONFIG_DIR="$HOME/.config"
STARSHIP_CONFIG="$STARSHIP_CONFIG_DIR/starship.toml"
BASHRC_SOURCE="$CORE_DIR/bash/.bashrc"

if [[ ! -d "$CORE_DIR" ]]; then
  echo "Core profile not found: $CORE_DIR"
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git is required. Install git first."
  exit 1
fi

if ! command -v starship >/dev/null 2>&1; then
  echo "starship is not installed. Install from https://starship.rs/"
fi

mkdir -p "$STARSHIP_CONFIG_DIR"
if [[ -f "$CORE_DIR/starship.toml" ]]; then
  cp "$CORE_DIR/starship.toml" "$STARSHIP_CONFIG"
fi

cp "$BASHRC_SOURCE" "$HOME/.bashrc"

echo "Shared core profile installed for Linux (bash)."
echo "Restart shell or run: exec bash"
