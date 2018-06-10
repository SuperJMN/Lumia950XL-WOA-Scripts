. "$PSScriptRoot\Functions.ps1"

Write-Host "Windows Reinstallation Script" -ForegroundColor Green 
Write-Host "<< You can quit anytime pressing Control+C >>" -ForegroundColor Yellow 

Step "Please, switch to Mass Storage Mode."

EnsurePartitionsAreMounted

Scripted-Step "First, we are going to delete the existing Windows partitions in the Phone." "$($PSScriptRoot)\RemovePreviousWindowsInstallationPartitions.ps1"
Scripted-Step "We will now Install Windows 10 ARM64" "$($PSScriptRoot)\SetupWindows.ps1"

Write-Host "Setup completed ;)"

