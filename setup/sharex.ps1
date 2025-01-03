param(
    [string]$sharexHotkeysPath = "$env:DOTFILES_PATH/sharex-hotkeys.json"
)

# Check for admin privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run ./setup/sharex.ps1 as administrator." -ForegroundColor Red
    exit 1
}

# Disable Windows + S hotkey
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force
}
Set-ItemProperty -Path $registryPath -Name "DisabledHotkeys" -Value "S" -Type String
Write-Host "Disabled default windows + S hotkey" -ForegroundColor Green

$folderPath = "$env:USERPROFILE/Documents/ShareX"
if (-not (Test-Path $folderPath)) {
    $folderPath = "$env:USERPROFILE/OneDrive/Documents/ShareX"
    if (-not (Test-Path $folderPath)) {
        Write-Host "Could not find ShareX config folder!" -ForegroundColor Red
        return
    }
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
