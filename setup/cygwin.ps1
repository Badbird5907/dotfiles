. "$env:DOTFILES_PATH\utils.ps1" # import utils (this is stupid)

Write-Host "Installing Cygwin..." -ForegroundColor Yellow
winget install cygwin --silent --accept-package-agreements --accept-source-agreements

Write-Host "Adding Cygwin to PATH..." -ForegroundColor Yellow
Add-ToPath "C:\cygwin64\bin"

Write-Host "Done!" -ForegroundColor Green
