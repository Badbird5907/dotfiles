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
    Write-Host "Installing packages..." -ForegroundColor Yellow
    $packageIds = @(
        "Git.Git",
        "Neovim", 
        "Microsoft.VisualStudioCode",
        "Microsoft.PowerToys",
        "Microsoft.PowerShell",
        "JannDeDobbeleer.Oh-My-Posh",
        "sharkdp.bat",
        "jqlang.jq"
    )

    foreach ($packageId in $packageIds) {
        Write-Host "Installing package: $packageId"
        winget install $packageId --accept-package-agreements --silent

        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully installed: $packageId"
        } else {
            Write-Host "Failed to install (or already installed): $packageId" -ForegroundColor Red
        }
    }
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

Write-Host "Setup complete!" -ForegroundColor Green

. $PROFILE -DotfilesPath $env:DOTFILES_PATH