# Shared core profile for lab members.
# Safe defaults only: no host-specific network or SSH automation.

Set-Alias ll Get-ChildItem

function gs { git status }
function gd { git diff }
function ga { git add @Args }
function gc { git commit @Args }
function gp { git push @Args }

# Enable Starship prompt if installed.
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}
