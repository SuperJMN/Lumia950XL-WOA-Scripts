. "$PSScriptRoot\Functions.ps1"

function SetupBootShimEntry() 
{
	param([string]$bcdFileName)
	
	$locale = Get-SystemInfo
	
	$index = 2;

	# FIXED : zh-cn Build OS should set the index to 1 (other East Asia country should also be 1 )
	$locale_array = 'zh-cn', 'zh-tw', 'ja-jp', 'ko-kr'
	if ($locale_array.Contains($locale)){
		$index = 1;
	}

	$output = & bcdedit /store $($bcdFileName) /create /d ""BootShim"" /application BOOTAPP
	$guid = $output|%{$_.split(' ')[$index]}

	$tmp = & bcdedit /store $bcdFileName /set $guid path \EFI\boot\BootShim.efi

    $bootMgrPartitionPath = GetBootMgrPartitionPath $bcdFileName
	$tmp = & bcdedit /store $bcdFileName /set $guid device partition=$bootMgrPartitionPath
	$tmp = & bcdedit /store $bcdFileName /set $guid testsigning on 
	$tmp = & bcdedit /store $bcdFileName /set $guid nointegritychecks on

	return $guid
}

function SetupBootMgrEntry() 
{
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
& bcdedit /store $bcdFileName /default $guid
& bcdedit /store $bcdFileName /timeout 30