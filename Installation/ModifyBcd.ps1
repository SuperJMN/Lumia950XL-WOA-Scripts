. "$PSScriptRoot\Functions.ps1"

function SetupBootShimEntry() 
{
	param([string]$bcdFileName)

	$output = & bcdedit /store $($bcdFileName) /create /d ""BootShim"" /application BOOTAPP
	$guid = $output|%{$_.split(' ')[2]}

	$tmp = & bcdedit /store $bcdFileName /set $guid path \EFI\boot\BootShim.efi
	$tmp = & bcdedit /store $bcdFileName /set $guid device partition=$bootMgrPartitionPath
	$tmp = & bcdedit /store $bcdFileName /set $guid testsigning on 
	$tmp = & bcdedit /store $bcdFileName /set $guid nointegritychecks on

	return $guid
}

function SetupBootMgrEntry() 
{
	$bootMgrPartitionPath = GetBootMgrPartitionPath $bcdFileName

	$tmp = & bcdedit /store $bcdFileName /set `{bootmgr`} displaybootmenu on
	$tmp = & bcdedit /store $bcdFileName /deletevalue `{bootmgr`} customactions 
	$tmp = & bcdedit /store $bcdFileName /deletevalue `{bootmgr`} custom:54000001 
	$tmp = & bcdedit /store $bcdFileName /deletevalue `{bootmgr`} custom:54000002 	
}

Write-Host "Working..."

$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\BCD"

Step "We're going to modify the BCD file at $($bcdFileName)"

$guid = SetupBootShimEntry $bcdFileName
SetupBootMgrEntry

& bcdedit /store $bcdFileName /displayorder $guid