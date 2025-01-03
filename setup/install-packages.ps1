Write-Host "Installing packages..." -ForegroundColor Yellow
$packageIds = @(
    "Git.Git",
    "Neovim", 
    "Microsoft.VisualStudioCode",
    "Microsoft.PowerToys",
    "Microsoft.PowerShell",
    "JannDeDobbeleer.Oh-My-Posh",
    "sharkdp.bat",
    "jqlang.jq",
    "ShareX.ShareX",
    "schollz.croc"
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