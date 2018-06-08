. "$PSScriptRoot\Functions.ps1"

function SetupBcdEntry() 
{
	param([string]$bcdFileName)

	$output = & bcdedit /store $($bcdFileName) /create /d "Developer Menu" /application BOOTAPP
	$guid = $output|%{$_.split(' ')[2]}

	& bcdedit /store $bcdFileName /set $guid path \Windows\System32\BOOT\developermenu.efi

	return $guid
}

Step "We are going to add Developer Menu"

Write-Host "Working..."

$mainOs = GetMainOS
$driveLetter = $mainOs.Volume.DriveLetter
$destinationFolder= "$($driveLetter):\EFIESP\Windows\System32\BOOT"
$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\bcd"

Write-Host Copying binaries...
$source = "$($PSScriptRoot)\Files\Developer Menu\*"
Copy-Item $source $destinationFolder -Recurse

Write-Host Creating BCD entry...

$guid = SetupBcdEntry $bcdFileName

$bootMgrPartitionPath = GetBootMgrPartitionPath $bcdFileName
& bcdedit /store $bcdFileName /set $guid device partition=$bootMgrPartitionPath

Write-Host "Done!"

