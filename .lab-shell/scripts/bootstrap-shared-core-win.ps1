$ErrorActionPreference = "Stop"

# Usage:
#   $env:REPO_URL="https://github.com/daihiko-lab/lab-shell.git"
#   pwsh -ExecutionPolicy Bypass -File .\bootstrap-shared-core-win.ps1
# Optional:
#   $env:REPO_DIR="$HOME\lab-shell"

$RepoUrl = if ($env:REPO_URL) { $env:REPO_URL } else { "https://github.com/daihiko-lab/lab-shell.git" }
$RepoDir = if ($env:REPO_DIR) { $env:REPO_DIR } else { "$HOME\lab-shell" }

function Test-IsWindowsAdmin {
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = New-Object Security.Principal.WindowsPrincipal($identity)
  return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Ensure-PowerShell7 {
  if ($PSVersionTable.PSVersion.Major -ge 7) {
    return "pwsh"
  }

  if (Get-Command pwsh -ErrorAction SilentlyContinue) {
    return "pwsh"
  }

  if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "PowerShell 7 is required, but pwsh was not found and winget is unavailable. Install from https://aka.ms/powershell-release"
  }

  Write-Host "PowerShell 7 is not installed. Installing with winget..."
  winget install --id Microsoft.PowerShell -e --accept-package-agreements --accept-source-agreements

  if (!(Get-Command pwsh -ErrorAction SilentlyContinue)) {
    throw "PowerShell 7 installation did not complete. Reopen the terminal and run this command again."
  }

  return "pwsh"
}

function Ensure-WSL {
  if (!(Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
    Write-Warning "WSL command is not available. Skip WSL setup."
    return
  }

  & wsl.exe -l -v 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) {
    Write-Host "WSL is available."
    return
  }

  if (!(Test-IsWindowsAdmin)) {
    Write-Warning "WSL is not ready. Run an elevated PowerShell and execute: wsl --install"
    return
  }

  Write-Host "WSL is not ready. Trying to enable WSL..."
  & wsl.exe --install --no-distribution 2>$null
  if ($LASTEXITCODE -ne 0) {
    & wsl.exe --install
  }

  if ($LASTEXITCODE -eq 0) {
    Write-Host "WSL install requested. Restart Windows if prompted, then run this bootstrap again."
  } else {
    Write-Warning "Could not enable WSL automatically. Run wsl --install manually in an elevated PowerShell."
  }
}

if (!(Get-Command git -ErrorAction SilentlyContinue)) {
  throw "git is required. Install Git first."
}

if (Test-Path (Join-Path $RepoDir ".git")) {
  git -C $RepoDir pull --ff-only
} else {
  git clone $RepoUrl $RepoDir
}

$shell = Ensure-PowerShell7
Ensure-WSL

$installer = Join-Path $RepoDir ".lab-shell\scripts\install-shared-core-win.ps1"
$env:DOTFILES_DIR = $RepoDir
if ($PSVersionTable.PSVersion.Major -ge 7) {
  & $installer
} else {
  & $shell -NoProfile -ExecutionPolicy Bypass -File $installer
}

Write-Host "Installed for PowerShell 7 (pwsh)."
Write-Host "Windows PowerShell 5.1 (powershell.exe) remains available for legacy scripts."
