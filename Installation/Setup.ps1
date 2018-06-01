function Step
{
	param([string]$message) 	
	Write-Host $message
	Read-Host 
}

function Scripted-Step
{
	param([string]$message,[string]$script) 	
	Step($message)
	& $script
}

Step "Switch to Mass Storage Mode. Enter when ready."
Scripted-Step "Resizing Data Partition" "$($PSScriptRoot)\ResizeDataPartition.ps1"
Step "a) Please, create partition named 'boot', format ext4, size=4MB inside allocated free space"
Step "b) Please, create partition named 'uefi_vars', format ext4, size=4MB inside allocated free space"
Scripted-Step "Copying required boot files" "$($PSScriptRoot)\CopyMbnAndEfi.ps1"
Scripted-Step "Modifying BCD" "$($PSScriptRoot)\ModifyBcd.ps1"
Step "Reboot the phone (holding Power 10 seconds). Enter when ready."
Step "Choose BootShim. Wait until your PC detects Android device."
Scripted-Step "Flashing UEFI.elf" "$($PSScriptRoot)\FlashUefi.ps1"
Step "Switch to Mass Storage Mode. Enter when ready."
Scripted-Step "Create partitions for Windows 10 ARM installation" "$($PSScriptRoot)\CreateWindowsPartitions.ps1"
Scripted-Step "Windows 10 ARM image deployment" "$($PSScriptRoot)\DeployWindows.ps1"
Scripted-Step "Applying the drivers" "$($PSScriptRoot)\InstallDrivers.ps1"
Scripted-Step "Making deployed Windows bootable" "$($PSScriptRoot)\MakeWindowsBootable.ps1"
Step "Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!"

