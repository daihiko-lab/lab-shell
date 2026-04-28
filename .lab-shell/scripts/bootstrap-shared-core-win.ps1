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
  $defaultPwshPath = Join-Path ${env:ProgramFiles} "PowerShell\7\pwsh.exe"

  if ($PSVersionTable.PSVersion.Major -ge 7) {
    return (Get-Command pwsh).Source
  }

  $pwshCommand = Get-Command pwsh -ErrorAction SilentlyContinue
  if ($pwshCommand) {
    return $pwshCommand.Source
  }

  if (Test-Path $defaultPwshPath) {
    return $defaultPwshPath
  }

  if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "PowerShell 7 is required, but pwsh was not found and winget is unavailable. Install from https://aka.ms/powershell-release"
  }

  Write-Host "PowerShell 7 is not installed. Installing with winget..."
  winget install --id Microsoft.PowerShell -e --accept-package-agreements --accept-source-agreements

  $pwshCommand = Get-Command pwsh -ErrorAction SilentlyContinue
  if ($pwshCommand) {
    return $pwshCommand.Source
  }

  if (Test-Path $defaultPwshPath) {
    return $defaultPwshPath
  }

  throw "PowerShell 7 installation did not complete. Reopen the terminal and run this command again."
}

function Ensure-Git {
  if (Get-Command git -ErrorAction SilentlyContinue) {
    return
  }

  if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "Git is required, but winget is unavailable. Install Git from https://git-scm.com/download/win"
  }

  Write-Host "Git is not installed. Installing with winget..."
  winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements

  if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git installation did not complete. Reopen the terminal and run this bootstrap again."
  }
}

function Ensure-WSL {
  if (!(Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
    Write-Warning "WSL command is not available. Skip WSL setup."
    return $false
  }

  $distros = @(& wsl.exe -l -q 2>$null | ForEach-Object { $_.Trim() } | Where-Object { $_ })
  if ($LASTEXITCODE -eq 0 -and $distros.Count -gt 0) {
    Write-Host "WSL is available."
    return $true
  }

  if (!(Test-IsWindowsAdmin)) {
    Write-Warning "WSL is not ready. Run an elevated PowerShell and execute: wsl --install -d Ubuntu"
    return $false
  }

  Write-Host "WSL is not ready. Trying to install WSL2 with Ubuntu..."
  & wsl.exe --install -d Ubuntu 2>$null
  if ($LASTEXITCODE -ne 0) {
    & wsl.exe --install
  }

  if ($LASTEXITCODE -eq 0) {
    Write-Host "WSL install requested. Restart Windows if prompted, then run this bootstrap again."
    return $false
  } else {
    Write-Warning "Could not enable WSL automatically. Run wsl --install -d Ubuntu manually in an elevated PowerShell."
    return $false
  }
}

function Invoke-WSLBootstrap {
  param(
    [Parameter(Mandatory = $true)]
    [string]$RepoUrl
  )

  Write-Host "Applying shared core in WSL (bash)..."
  $escapedRepo = $RepoUrl.Replace("'", "''")
  $command = "export REPO_URL='$escapedRepo'; curl -fsSL https://raw.githubusercontent.com/daihiko-lab/lab-shell/main/.lab-shell/scripts/bootstrap-shared-core-linux.sh | bash"
  & wsl.exe bash -lc $command
  if ($LASTEXITCODE -ne 0) {
    Write-Warning "WSL bootstrap failed. Open WSL and run Linux bootstrap manually."
  }
}

Ensure-Git

if (Test-Path (Join-Path $RepoDir ".git")) {
  git -C $RepoDir pull --ff-only
} else {
  git clone $RepoUrl $RepoDir
}

$shell = Ensure-PowerShell7
$wslReady = Ensure-WSL

$installer = Join-Path $RepoDir ".lab-shell\scripts\install-shared-core-win.ps1"
$env:DOTFILES_DIR = $RepoDir
if ($PSVersionTable.PSVersion.Major -ge 7) {
  & $installer
} else {
  & $shell -NoProfile -ExecutionPolicy Bypass -File $installer
}

Write-Host "Installed for PowerShell 7 (pwsh)."
Write-Host "Windows PowerShell 5.1 (powershell.exe) remains available for legacy scripts."
if ($wslReady) {
  Invoke-WSLBootstrap -RepoUrl $RepoUrl
}
