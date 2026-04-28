#!/bin/zsh
set -euo pipefail

# Usage:
#   REPO_URL="https://github.com/daihiko-lab/lab-shell.git" zsh bootstrap-shared-core-mac.sh
# Optional:
#   REPO_DIR="$HOME/lab-shell"

REPO_URL="${REPO_URL:-https://github.com/daihiko-lab/lab-shell.git}"
REPO_DIR="${REPO_DIR:-$HOME/lab-shell}"

if command -v git >/dev/null 2>&1; then
  if [[ -d "$REPO_DIR/.git" ]]; then
    git -C "$REPO_DIR" pull --ff-only
  else
    git clone "$REPO_URL" "$REPO_DIR"
  fi
else
  echo "git is required. Install git first."
  exit 1
fi

chmod +x "$REPO_DIR/scripts/install-shared-core-mac.sh"
DOTFILES_DIR="$REPO_DIR" "$REPO_DIR/scripts/install-shared-core-mac.sh"
