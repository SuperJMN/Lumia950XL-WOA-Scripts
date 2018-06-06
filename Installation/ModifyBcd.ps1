. "$PSScriptRoot\Functions.ps1"

function GetBootMgrPartitionPath()
{
	$match = & bcdedit /enum `{bootmgr`} | Select-String  "device\s*partition=(?<path>[\w*\\]*)"
	$bootMgrPartitionPath = $match.Matches[0].Groups[1].Value

	if ($bootMgrPartitionPath -eq $null)
	{
		throw "Could not get the partition path of the {bootmgr} BCD entry"
	}

	return $bootMgrPartitionPath
}

function CreateShimBcdEntry() 
{
	param([string]$bcdFileName)
	$output = & bcdedit /store $($bcdFileName) /create /d ""BootShim"" /application BOOTAPP
	$guid = $output|%{$_.split(' ')[2]}
	return $guid
}

$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\bcd"

Write-Host "We're going to modify the BCD file at $($bcdFileName)"
Read-Host

$guid = CreateShimBcdEntry $bcdFileName

$bootMgrPartitionPath = GetBootMgrPartitionPath

& bcdedit /store $bcdFileName /set $guid device partition=$bootMgrPartitionPath
& bcdedit /store $bcdFileName /set `{bootmgr`} displaybootmenu on
& bcdedit /store $bcdFileName /deletevalue `{bootmgr`} customactions 
& bcdedit /store $bcdFileName /deletevalue `{bootmgr`} custom:54000001 
& bcdedit /store $bcdFileName /deletevalue `{bootmgr`} custom:54000002 
& bcdedit /store $bcdFileName /displayorder $guid `{0ff5f24a-3785-4aeb-b8fe-4226215b88c4`} `{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b`}
& bcdedit /store $bcdFileName /set $guid testsigning on 
& bcdedit /store $bcdFileName /set $guid nointegritychecks on