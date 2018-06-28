. "$PSScriptRoot\Functions.ps1"

Write-Host "Windows ARM 64 installation scripts" -ForegroundColor Green 
Write-Host "<< You can quit anytime pressing Control+C >>" -ForegroundColor Yellow 
Write-Host "Please, ensure that your PC is not using the drive letters S: and W:, since they're used by the scripts.`nIf they're used, unmount them temporarily." -ForegroundColor Red
Write-Host

Step "Now, please, switch to Mass Storage Mode."

Write-Host "Ensuring the required Phone partitions are mounted..."
EnsurePartitionsAreMounted

Function-Step "UEFI Deployment" { & $PSScriptRoot\DeployUefi.ps1 }
Function-Step "BCD Setup (EFIESP)" { & $PSScriptRoot\ModifyBcd.ps1 }
Function-Step "Creation of Developer Menu" { & $PSScriptRoot\CreateDeveloperMenu.ps1 }
Function-Step "Windows 10 ARM64 Setup" { & $PSScriptRoot\SetupWindows.ps1 }
Function-Step "Dual Boot" { & $PSScriptRoot\EnableDualBoot.ps1 }

Write-Host "Setup completed ;)"

