. "$PSScriptRoot\Functions.ps1"

Step "Please, verify that your Phone is in Mass Storage Mode"
Function-Step "Creation of partitions for Windows 10 ARM installation" { & $PSScriptRoot\CreateWindowsPartitions.ps1 }
Function-Step "Windows 10 ARM image deployment" { & $PSScriptRoot\DeployWindows.ps1 }
Function-Step "Basic Drivers deployment" { InstallDrivers "$($PSScriptRoot)\Files\Drivers\Stable" }
Function-Step "We'll make the Windows partition bootable" { & $PSScriptRoot\MakeWindowsBootable.ps1 }
Step "Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!`nPlease, COMPLETE THE WINDOWS SETUP until you get into the Desktop.`nThen, Restart/Shut down (from Windows) and switch to Mass Storage Mode again."
Function-Step "Additional Drivers deployment" { InstallDrivers "$($PSScriptRoot)\Files\Drivers\Testing" }
Function-Step "We are going to enable Dual Boot.`nPlease, switch to Mass Storage Mode before proceeding." { & $PSScriptRoot\EnableDualBoot.ps1 }
