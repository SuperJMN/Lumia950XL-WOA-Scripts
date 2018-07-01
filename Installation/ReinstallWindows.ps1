. "$PSScriptRoot\Functions.ps1"

Write-Host "Windows Reinstallation Script" -ForegroundColor Green 
Write-Host "<< You can quit anytime pressing Control+C >>" -ForegroundColor Yellow 

Step "Please, switch to Mass Storage Mode."

PerformSanityChecks

Function-Step "Removal of Previous Installation" { & $PSScriptRoot\RemovalOfPreviousWindowsInstallation.ps1 }
Function-Step "We will now Install Windows 10 ARM64" { & $PSScriptRoot\SetupWindows.ps1 }

Write-Host "Setup completed ;)"

