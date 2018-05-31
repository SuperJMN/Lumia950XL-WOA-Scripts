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
Scripted-Step "Resizing Data Partition" .\PowerShellProject1\ResizeDataPartition.ps1
Step "a) Please, create partition named 'boot', format ext4, size=4MB inside allocated free space"
Step "b) Please, create partition named 'uefi_vars', format ext4, size=4MB inside allocated free space"
Scripted-Step "Copying required boot files" .\PowerShellProject1\CopyMbnAndEfi.ps1
Scripted-Step "Modifying BCD" .\PowerShellProject1\ModifyBcd.ps1
Step "Reboot the phone (holding Power 10 seconds). Enter when ready."
Step "Choose BootShim. Wait until your PC detects Android device."
Scripted-Step "Flashing UEFI.elf" .\PowerShellProject1\FlashUefi.ps1
Step "Switch to Mass Storage Mode. Enter when ready."
Scripted-Step "Create partitions for Windows 10 ARM installation" .\PowerShellProject1\CreateWindowsPartitions.ps1
Scripted-Step "Windows 10 ARM image deployment" .\PowerShellProject1\DeployWindows.ps1
Scripted-Step "Applying the drivers" .\PowerShellProject1\InstallDrivers.ps1
Scripted-Step "Making deployed Windows bootable" .\PowerShellProject1\MakeWindowsBootable.ps1
Step "Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!"

