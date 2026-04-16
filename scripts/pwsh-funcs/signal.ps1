# Don’t add plain "signal" lines to your PSReadLine history
Set-PSReadLineOption -AddToHistoryHandler {
  param($line)
  if ($line -eq 'signal') { return $false }
  return $true
}

# Define the signal function
function signal {
  Start-Process 'C:\Users\evanl\AppData\Local\Programs\signal-desktop\Signal.exe'
}
