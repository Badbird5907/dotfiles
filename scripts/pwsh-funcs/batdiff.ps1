function batdiff {
    $files = git diff --name-only --relative --diff-filter=d
    if ($files) {
        $files | ForEach-Object { bat --diff $_ }
    } else {
        Write-Host "No files to display diff for."
    }
}

