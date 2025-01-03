param(
    [Parameter(Mandatory=$true)]
    [string]$sharexHotkeysPath
)

$folderPath = "$env:USERPROFILE/Documents/ShareX"
if (-not (Test-Path $folderPath)) {
    $folderPath = "$env:USERPROFILE/OneDrive/Documents/ShareX"
    if (-not (Test-Path $folderPath)) {
        Write-Host "Could not find ShareX config folder!" -ForegroundColor Red
        return
    }

    # symlink hotkeys config
    try {
        if (-not $sharexHotkeysPath) {
            throw "ShareX hotkeys path parameter was not specified"
        }
        New-Item -ItemType SymbolicLink -Path "$folderPath/HotkeysConfig.json" -Target $sharexHotkeysPath -Force
        Write-Host "Symlinked ShareX hotkeys config file to $folderPath/HotkeysConfig.json" -ForegroundColor Green
    } catch {
        Write-Host "Failed to create symlink for ShareX hotkeys config: $_" -ForegroundColor Red
    }
}
