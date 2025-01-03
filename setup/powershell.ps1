if (-not (Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

$path = (Get-Item -Path $PROFILE).FullName
$lastLine = Get-Content -Path $path -Tail 1
if ($lastLine -ne ". `"$profilePath`"") {
    Add-Content -Path $path -Value "`n. `"$profilePath`"" # executes our profile after the profile is loaded
}
