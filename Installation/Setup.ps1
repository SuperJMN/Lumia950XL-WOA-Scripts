. "$PSScriptRoot\Functions.ps1"

Write-Host "Windows ARM 64 installation scripts" -ForegroundColor Green 
Write-Host "<< You can quit anytime pressing Control+C >>" -ForegroundColor Yellow 

Step "1. Please, switch to Mass Storage Mode."

EnsurePartitionsAreMounted

Scripted-Step "2. Data Partition Shrinking" "$($PSScriptRoot)\ResizeDataPartition.ps1"
Scripted-Step "3. EXT4 partitions: In the following 2 steps you should create EXT4 partitions. You can do it inside using Linux (a Virtual Machine is OK). We recommend using the application called 'GParted' for that." "$($PSScriptRoot)\CreateExt4Partitions.ps1"
Scripted-Step "4. Copy of Boot files" "$($PSScriptRoot)\CopyMbnAndEfi.ps1"
Scripted-Step "5. Setup of BCD" "$($PSScriptRoot)\ModifyBcd.ps1"
Scripted-Step "6. We're about to add the Developer Menu" "$($PSScriptRoot)\CreateDeveloperMenu.ps1"
Step "7. Please, reboot the phone (holding Power 10 seconds)"
Step "8. Your phone should show a Boot Menu. Choose the BootShim item. Then, your phone will show text on the screen. Wait until your PC detects Android device. "
Scripted-Step "9. We're about to flash UEFI.elf" "$($PSScriptRoot)\FlashUefi.ps1"
Step "10. Please, switch to Mass Storage Mode"
Scripted-Step "11. Create partitions for Windows 10 ARM installation" "$($PSScriptRoot)\CreateWindowsPartitions.ps1"
Scripted-Step "12. Windows 10 ARM image deployment" "$($PSScriptRoot)\DeployWindows.ps1"
Scripted-Step "13. Drivers deployment" "$($PSScriptRoot)\InstallDrivers.ps1"
Scripted-Step "14. We'll make the Windows partition bootable" "$($PSScriptRoot)\MakeWindowsBootable.ps1"
Step "15. Reboot your phone. Select BootShim. Windows 10 ARM Setup should begin!"

Write-Host "Setup completed ;)"

