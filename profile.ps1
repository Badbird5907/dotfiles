param(
    [string]$DotfilesPath = $env:DOTFILES_PATH
)

if (-not $DotfilesPath) {
    throw "DOTFILES_PATH environment variable not set and no path provided as argument"
}

$macrosFile = "$DotfilesPath\macros.doskey" # load the legacy doskey macros
$macros = Get-Content $macrosFile
foreach ($macro in $macros) {
  $alias = $macro.Split("=")[0]
  $command = $macro.Split("=")[1]
  $command = $command.Replace("`$*", "").Trim()
  $command = $ExecutionContext.InvokeCommand.ExpandString($command)
  if ((Get-Alias $alias -ErrorAction SilentlyContinue)) {
    Remove-Alias -Name $alias
  }
  New-Alias -Name $alias -Value $command
}

oh-my-posh init pwsh --config "$env:DOTFILES_PATH\terminal-themes\bubblesextra.omp.json" | Invoke-Expression