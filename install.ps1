param(
    [switch]$NoInstallPackages
)
Write-Host "Script running from $PSScriptRoot" -ForegroundColor Yellow
Write-Host "Setting up environment variables..." -ForegroundColor Yellow
$currentPath = [System.Environment]::GetEnvironmentVariable("DOTFILES_PATH", "User")
$desiredPath = "$env:USERPROFILE\dotfiles"
$env:DOTFILES_PATH = $desiredPatht

if ($currentPath -ne $desiredPath) {
    [System.Environment]::SetEnvironmentVariable("DOTFILES_PATH", $desiredPath, "User")
}
Write-Host "DOTFILES_PATH environment variable set to $env:DOTFILES_PATH" -ForegroundColor Green

if (-not $NoInstallPackages) {
    . "$PSScriptRoot/setup/install-packages.ps1"
} else {
    Write-Host "Skipping package installation..." -ForegroundColor Yellow
}

# Oh-My-Posh Setup
Write-Host "Setting up Oh-My-Posh" -ForegroundColor Yellow
oh-my-posh font install Hack

# Windows Terminal Setup
Write-Host "Setting up Windows Terminal" -ForegroundColor Yellow
. "$PSScriptRoot/setup/windows-terminal.ps1"

# PowerShell Setup
Write-Host "Setting up PowerShell" -ForegroundColor Yellow
$profilePath = "$PSScriptRoot/profile.ps1"
. "$PSScriptRoot/setup/powershell.ps1" -profilePath $profilePath

# ShareX Setup
Write-Host "Setting up ShareX" -ForegroundColor Yellow
. "$PSScriptRoot/setup/sharex.ps1" -sharexHotkeysPath "$PSScriptRoot/sharex-hotkeys.json"

Write-Host "Setup complete!" -ForegroundColor Green

. $PROFILE -DotfilesPath $env:DOTFILES_PATH