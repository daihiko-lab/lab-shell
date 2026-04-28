$ErrorActionPreference = "Stop"

# Usage:
#   $env:REPO_URL="https://github.com/daihiko-lab/lab-shell.git"
#   pwsh -ExecutionPolicy Bypass -File .\bootstrap-shared-core-win.ps1
# Optional:
#   $env:REPO_DIR="$HOME\lab-shell"

$RepoUrl = if ($env:REPO_URL) { $env:REPO_URL } else { "https://github.com/daihiko-lab/lab-shell.git" }
$RepoDir = if ($env:REPO_DIR) { $env:REPO_DIR } else { "$HOME\lab-shell" }

if (!(Get-Command git -ErrorAction SilentlyContinue)) {
  throw "git is required. Install Git first."
}

if (Test-Path (Join-Path $RepoDir ".git")) {
  git -C $RepoDir pull --ff-only
} else {
  git clone $RepoUrl $RepoDir
}

$installer = Join-Path $RepoDir ".lab-shell\scripts\install-shared-core-win.ps1"
$env:DOTFILES_DIR = $RepoDir
& $installer
