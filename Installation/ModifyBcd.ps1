. "$PSScriptRoot\Functions.ps1"

$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\bcd"

Write-Host "We're going to modify the BCD file at $($bcdFileName)"
Read-Host

$x = & bcdedit /store $($bcdFileName) /create /d ""BootShim"" /application BOOTAPP
$guid = $x|%{$_.split(' ')[2]}

& bcdedit /store $bcdFileName /set $guid path \EFI\boot\BootShim.efi

Write-Host "Please, enter the path to the device partition where the {bootmgr} in the list. Enter to see the list."
Read-Host
& bcdedit /store $bcdFileName
$bootMgrPartitionPath = Read-Host -Prompt "Please, enter the path (the one after 'Device partition=')"

& bcdedit /store $bcdFileName /set $guid device partition=$bootMgrPartitionPath
& bcdedit /store $bcdFileName /set `{bootmgr`} displaybootmenu on
& bcdedit /store $bcdFileName /deletevalue `{bootmgr`} customactions 
& bcdedit /store $bcdFileName /deletevalue `{bootmgr`} custom:54000001 
& bcdedit /store $bcdFileName /deletevalue `{bootmgr`} custom:54000002 
& bcdedit /store $bcdFileName /displayorder $guid `{0ff5f24a-3785-4aeb-b8fe-4226215b88c4`} `{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b`}
& bcdedit /store $bcdFileName /set $guid testsigning on 
& bcdedit /store $bcdFileName /set $guid nointegritychecks on