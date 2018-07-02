. "$PSScriptRoot\Functions.ps1"

Step "Please, verify that your Phone is in Mass Storage Mode"
Function-Step "Space allocation for Windows" { & $PSScriptRoot\AllocateSpaceIfNeeded.ps1 }
Function-Step "Creation of Windows partitions" { & $PSScriptRoot\CreateWindowsPartitions.ps1 }
Function-Step "Windows 10 ARM64 image deployment" { & $PSScriptRoot\DeployWindows.ps1 }
Function-Step "Basic Drivers deployment" { InstallDrivers "$($PSScriptRoot)\Files\Drivers\Stable" }
Function-Step "Windows Boot Configuration" { & $PSScriptRoot\MakeWindowsBootable.ps1 }
Step "Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!`nPlease, COMPLETE THE WINDOWS SETUP until you get into the Desktop.`nThen, Restart/Shut down (from Windows) and switch to Mass Storage Mode again."
Function-Step "Additional Drivers deployment" { InstallDrivers "$($PSScriptRoot)\Files\Drivers\Testing" }
Function-Step "Applying Hacks to Installation (enables additional features like Bluetooth and USB-C)" { & $PSScriptRoot\ApplyHacks.ps1 }
