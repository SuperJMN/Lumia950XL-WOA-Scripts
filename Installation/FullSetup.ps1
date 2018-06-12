. "$PSScriptRoot\Functions.ps1"

Write-Host "Windows ARM 64 installation scripts" -ForegroundColor Green 
Write-Host "<< You can quit anytime pressing Control+C >>" -ForegroundColor Yellow 

Step "Please, switch to Mass Storage Mode."

Write-Host "Ensuring the required Phone partitions are mounted..."
EnsurePartitionsAreMounted

Scripted-Step "Data Partition Shrinking" "$($PSScriptRoot)\ResizeDataPartition.ps1"
Scripted-Step "EXT4 partitions: In the following 2 steps you should create EXT4 partitions. You can do it inside using Linux (a Virtual Machine is OK). We recommend using the application called 'GParted' for that." "$($PSScriptRoot)\CreateExt4Partitions.ps1"
Scripted-Step "Copy of Boot files" "$($PSScriptRoot)\CopyMbnAndEfi.ps1"
Scripted-Step "Setup of BCD" "$($PSScriptRoot)\ModifyBcd.ps1"
Scripted-Step "We're about to add the Developer Menu" "$($PSScriptRoot)\CreateDeveloperMenu.ps1"
Step "Please, reboot the phone (holding Power 10 seconds)"
Step "Your phone should show a Boot Menu. Choose the BootShim item. Then, your phone will show text on the screen. Wait until your PC detects Android device. "
Scripted-Step "We're about to flash UEFI.elf" "$($PSScriptRoot)\FlashUefi.ps1"

Scripted-Step "We will now Install Windows 10 ARM64" "$($PSScriptRoot)\SetupWindows.ps1"

Write-Host "Setup completed ;)"

