#!/bin/zsh
set -euo pipefail

# Usage:
#   REPO_URL="https://github.com/daihiko-lab/lab-shell.git" zsh bootstrap-shared-core-mac.sh
# Optional:
#   REPO_DIR="$HOME/lab-shell"

REPO_URL="${REPO_URL:-https://github.com/daihiko-lab/lab-shell.git}"
REPO_DIR="${REPO_DIR:-$HOME/lab-shell}"

if ! command -v git >/dev/null 2>&1; then
  echo "git is not installed. Installing..."
  if command -v brew >/dev/null 2>&1; then
    brew install git
  elif command -v xcode-select >/dev/null 2>&1; then
    xcode-select --install || true
    echo "Command Line Tools installation was requested. Complete the installer, then rerun bootstrap."
    exit 1
  else
    echo "Could not install git automatically. Install git manually and rerun."
    exit 1
  fi
fi

if [[ -d "$REPO_DIR/.git" ]]; then
  git -C "$REPO_DIR" pull --ff-only
else
  git clone "$REPO_URL" "$REPO_DIR"
fi

DOTFILES_DIR="$REPO_DIR" zsh "$REPO_DIR/.lab-shell/scripts/install-shared-core-mac.sh"
