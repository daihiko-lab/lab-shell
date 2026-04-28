#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/daihiko-lab/lab-shell.git}"
REPO_DIR="${REPO_DIR:-$HOME/lab-shell}"

install_git() {
  if command -v apt-get >/dev/null 2>&1; then
    if command -v sudo >/dev/null 2>&1; then
      sudo apt-get update
      sudo apt-get install -y git
    else
      apt-get update
      apt-get install -y git
    fi
    return
  fi

  if command -v dnf >/dev/null 2>&1; then
    if command -v sudo >/dev/null 2>&1; then
      sudo dnf install -y git
    else
      dnf install -y git
    fi
    return
  fi

  if command -v yum >/dev/null 2>&1; then
    if command -v sudo >/dev/null 2>&1; then
      sudo yum install -y git
    else
      yum install -y git
    fi
    return
  fi

  if command -v pacman >/dev/null 2>&1; then
    if command -v sudo >/dev/null 2>&1; then
      sudo pacman -Sy --noconfirm git
    else
      pacman -Sy --noconfirm git
    fi
    return
  fi

  echo "Could not install git automatically. Install git manually and rerun."
  exit 1
}

if ! command -v git >/dev/null 2>&1; then
  echo "git is not installed. Installing..."
  install_git
fi

if [[ -d "$REPO_DIR/.git" ]]; then
  git -C "$REPO_DIR" pull --ff-only
else
  git clone "$REPO_URL" "$REPO_DIR"
fi

DOTFILES_DIR="$REPO_DIR" bash "$REPO_DIR/.lab-shell/scripts/install-shared-core-linux.sh"
