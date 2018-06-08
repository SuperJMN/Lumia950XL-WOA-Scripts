. "$PSScriptRoot\Functions.ps1"

Write-Host "Windows ARM 64 installation scripts" -ForegroundColor Green 
Write-Host "<< You can quit anytime pressing Control+C >>" -ForegroundColor Yellow 

Step "Please, switch to Mass Storage Mode."
Step "We're about to add the Developer Menu" "$($PSScriptRoot)\CreateDeveloperMenu.ps1"
Scripted-Step "Resizing Data Partition" "$($PSScriptRoot)\ResizeDataPartition.ps1"
Scripted-Step "In the following 2 steps you should create EXT4 partitions. You can do it inside using Linux (a Virtual Machine is OK). We recommend using the application called 'GParted' for that." "$($PSScriptRoot)\CreateExt4Partitions.ps1"
Scripted-Step "Copying required boot files" "$($PSScriptRoot)\CopyMbnAndEfi.ps1"
Scripted-Step "Modifying BCD" "$($PSScriptRoot)\ModifyBcd.ps1"
Step "Reboot the phone (holding Power 10 seconds). Enter when ready."
Step "Choose BootShim. Wait until your PC detects Android device."
Scripted-Step "Flashing UEFI.elf" "$($PSScriptRoot)\FlashUefi.ps1"
Step "Please, switch to Mass Storage Mode. Enter when ready."
Scripted-Step "Create partitions for Windows 10 ARM installation" "$($PSScriptRoot)\CreateWindowsPartitions.ps1"
Scripted-Step "Windows 10 ARM image deployment" "$($PSScriptRoot)\DeployWindows.ps1"
Scripted-Step "Applying the drivers" "$($PSScriptRoot)\InstallDrivers.ps1"
Scripted-Step "Making deployed Windows bootable" "$($PSScriptRoot)\MakeWindowsBootable.ps1"
Step "Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!"

