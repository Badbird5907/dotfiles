function rmrf {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
        [string[]]$Path
    )

    foreach ($target in $Path) {
        if (-not (Test-Path -LiteralPath $target)) {
            Write-Error "Cannot find path '$target' because it does not exist."
            continue
        }

        if ($PSCmdlet.ShouldProcess($target, 'Remove recursively and forcefully')) {
            Remove-Item -LiteralPath $target -Recurse -Force -ErrorAction Stop
        }
    }
}
