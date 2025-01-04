Function Add-ToPath($path) {
    $pathString = ";$path"
    if ($env:PATH -notcontains $pathString) {
        $env:PATH += $pathString
        [Environment]::SetEnvironmentVariable("Path", $env:PATH, [System.EnvironmentVariableTarget]::User)
    }
}

Function Remove-FromPath($path) {
    $pathString = ";$path"
    if ($env:PATH -contains $pathString) {
        $env:PATH = $env:PATH -replace $pathString, ""
        [Environment]::SetEnvironmentVariable("Path", $env:PATH, [System.EnvironmentVariableTarget]::User)
    }
}

