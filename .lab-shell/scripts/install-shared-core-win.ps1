$ErrorActionPreference = "Stop"

if ($PSVersionTable.PSVersion.Major -lt 7) {
  throw "PowerShell 7 or later is required. Install from https://aka.ms/powershell-release"
}

$DotfilesDir = if ($env:DOTFILES_DIR) { $env:DOTFILES_DIR } else { "$HOME\lab-shell" }
$CoreDir = Join-Path $DotfilesDir ".lab-shell\core"
$StarshipConfigDir = Join-Path $HOME ".config"
$StarshipConfig = Join-Path $StarshipConfigDir "starship.toml"
$StarshipWindowsConfig = Join-Path $CoreDir "starship.windows.toml"
$PowerShellProfileSource = Join-Path $CoreDir "powershell\Microsoft.PowerShell_profile.ps1"

if (!(Test-Path $CoreDir)) {
  throw "Core profile not found: $CoreDir"
}

if (!(Get-Command starship -ErrorAction SilentlyContinue)) {
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id Starship.Starship -e --accept-package-agreements --accept-source-agreements
  } else {
    throw "starship is not installed and winget is unavailable. Install from https://starship.rs/"
  }
}

New-Item -ItemType Directory -Force -Path $StarshipConfigDir | Out-Null
if (Test-Path $StarshipWindowsConfig) {
  Copy-Item -Force $StarshipWindowsConfig $StarshipConfig
} else {
  Copy-Item -Force (Join-Path $CoreDir "starship.toml") $StarshipConfig
}

if (!(Test-Path (Split-Path -Parent $PROFILE))) {
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $PROFILE) | Out-Null
}
Copy-Item -Force $PowerShellProfileSource $PROFILE

Write-Host "Shared core profile installed."
Write-Host "Restart PowerShell."
