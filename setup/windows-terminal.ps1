$settingsFile = if ($env:WINDOWS_TERMINAL_SETTINGS) {
  $env:WINDOWS_TERMINAL_SETTINGS
} else {
  "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}

if (-Not (Test-Path $settingsFile)) {
  Write-Host "Windows Terminal settings file not found at $settingsFile." -ForegroundColor Red
  Write-Host "Please set the WINDOWS_TERMINAL_SETTINGS environment variable to the path of the settings.json file and re-run ./setup/windows-terminal.ps1" -ForegroundColor Yellow
  exit 1
}

$backupFile = "$settingsFile.bak"
Copy-Item -Path $settingsFile -Destination $backupFile -Force
Write-Host "Backup created at $backupFile." -ForegroundColor Yellow

try {
    $settings = Get-Content $settingsFile -Raw | ConvertFrom-Json

    if (-not $settings.profiles.defaults) {
        $settings.profiles.defaults = @{}
    }
    if (-not $settings.profiles.defaults.font) {
        $settings.profiles.defaults.font = @{}
    }
    $settings.profiles.defaults.font.face = "Hack Nerd Font"

    $psCoreProfile = $settings.profiles.list | Where-Object { $_.source -eq "Windows.Terminal.PowershellCore" } | Select-Object -First 1
    if ($psCoreProfile) {
        $settings.defaultProfile = $psCoreProfile.guid
    } else {
        Write-Host "PowerShell Core profile not found in Windows Terminal" -ForegroundColor Yellow
    }

    $settings | ConvertTo-Json -Depth 32 | Set-Content -Path $settingsFile -Encoding UTF8

    Write-Host "Windows Terminal settings updated successfully." -ForegroundColor Green
} catch {
    Write-Host "Failed to update Windows Terminal settings: $_" -ForegroundColor Red
    Write-Host "Restoring backup..." -ForegroundColor Yellow
    Copy-Item -Path $backupFile -Destination $settingsFile -Force
    exit 1
}