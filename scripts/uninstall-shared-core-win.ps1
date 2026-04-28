$ErrorActionPreference = "Stop"

$DotfilesDir = if ($env:DOTFILES_DIR) { $env:DOTFILES_DIR } else { "$HOME\lab-shell" }
$CoreDir = Join-Path $DotfilesDir "profiles\shared\core"
$CorePowerShellProfile = Join-Path $CoreDir "powershell\Microsoft.PowerShell_profile.ps1"
$StarshipConfig = Join-Path $HOME ".config\starship.toml"

if (Test-Path $PROFILE) {
  $profileContent = Get-Content $PROFILE -Raw
  $coreProfileContent = Get-Content $CorePowerShellProfile -Raw
  if ($profileContent -eq $coreProfileContent) {
    Remove-Item $PROFILE -Force
    Write-Host "Removed PowerShell profile installed by lab-shell."
  }
}

if (Test-Path $StarshipConfig) {
  $coreStarship = Get-Content (Join-Path $CoreDir "starship.toml") -Raw
  $currentStarship = Get-Content $StarshipConfig -Raw
  if ($coreStarship -eq $currentStarship) {
    Remove-Item $StarshipConfig -Force
    Write-Host "Removed ~/.config/starship.toml."
  }
}

Write-Host "Uninstall complete."
Write-Host "If needed, restore your own PowerShell profile manually."
