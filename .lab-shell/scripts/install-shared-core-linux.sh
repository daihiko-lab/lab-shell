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

install_starship_with_apt() {
  if ! command -v apt-get >/dev/null 2>&1; then
    return 1
  fi

  if command -v sudo >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y starship
  else
    apt-get update
    apt-get install -y starship
  fi
}

install_starship_with_script() {
  if ! command -v curl >/dev/null 2>&1; then
    if command -v apt-get >/dev/null 2>&1; then
      if command -v sudo >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y curl
      else
        apt-get update
        apt-get install -y curl
      fi
    else
      return 1
    fi
  fi

  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
}

if ! command -v starship >/dev/null 2>&1; then
  echo "starship is not installed. Installing..."
  if ! install_starship_with_apt; then
    if ! install_starship_with_script; then
      echo "Could not install starship automatically. Install manually: https://starship.rs/"
    fi
  fi
fi

mkdir -p "$STARSHIP_CONFIG_DIR"
if [[ -f "$CORE_DIR/starship.toml" ]]; then
  cp "$CORE_DIR/starship.toml" "$STARSHIP_CONFIG"
fi

cp "$BASHRC_SOURCE" "$HOME/.bashrc"

echo "Shared core profile installed for Linux (bash)."
echo "Restart shell or run: exec bash"
