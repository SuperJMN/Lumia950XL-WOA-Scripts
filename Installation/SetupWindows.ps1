. "$PSScriptRoot\Functions.ps1"

Step "Please, switch to Mass Storage Mode"
Scripted-Step "Creation of partitions for Windows 10 ARM installation" "$($PSScriptRoot)\CreateWindowsPartitions.ps1"
Scripted-Step "Windows 10 ARM image deployment" "$($PSScriptRoot)\DeployWindows.ps1"
Scripted-Step "Drivers deployment" "$($PSScriptRoot)\InstallDrivers.ps1"
Scripted-Step "We'll make the Windows partition bootable" "$($PSScriptRoot)\MakeWindowsBootable.ps1"
Step "Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!`nPlease, COMPLETE THE WINDOWS SETUP until it boots to the Desktop screen.`nAfter it boots to the Desktop, please REBOOT (from Windows) and go to Mass Storage Mode again."
Scripted-Step "We are going to enable Dual Boot.`nPlease, switch to Mass Storage Mode before proceeding." "$($PSScriptRoot)\EnableDualBoot.ps1"
