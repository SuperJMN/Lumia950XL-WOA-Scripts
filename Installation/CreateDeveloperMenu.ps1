. "$PSScriptRoot\Functions.ps1"

function SetupBcdEntry() 
{
	param([string]$bcdFileName)
	
	$index = 2;

	# FIXED : zh-cn Build OS should  set the index to 1(other East Asia country should also be 1 )
	$locale_array = 'zh-cn', 'zh-tw', 'ja-jp', 'ko-kr'
	if ($locale_array.Contains($locale)){
		$index = 1;
	}
	
	$output = & bcdedit /store $($bcdFileName) /create /d "Developer Menu" /application BOOTAPP
	$guid = $output|%{$_.split(' ')[$index]}

	$tmp = & bcdedit /store $bcdFileName /set $guid path \Windows\System32\BOOT\developermenu.efi

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
Copy-Item $source $destinationFolder -Recurse -Force

Write-Host Creating BCD entry...

$guid = SetupBcdEntry $bcdFileName

$bootMgrPartitionPath = GetBootMgrPartitionPath $bcdFileName
& bcdedit /store $bcdFileName /set $guid device partition=$bootMgrPartitionPath
& bcdedit /store $bcdFileName /displayorder $guid /addlast

Write-Host "Done!"