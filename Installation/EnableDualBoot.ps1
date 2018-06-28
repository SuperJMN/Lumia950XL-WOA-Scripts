. "$PSScriptRoot\Functions.ps1"

Step "Please, make sure you are in Mass Storage Mode before proceeding."
Write-Host "Enabling Dual Boot..."

$sysVolume = GetSystemVolume

Write-Host "Setting partition type to Basic..."
$sysVolume | Get-Partition | Set-Partition -GptType "{EBD0A0A2-B9E5-4433-87C0-68B6B72699C7}" 


$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\BCD"

$winPhoneBcdGuid = "{7619dcc9-fafe-11d9-b411-000476eba25f}"
& bcdedit /store $bcdFileName /set $winPhoneBcdGuid description "Windows 10 Phone"
& bcdedit /store $bcdFileName /displayorder $winPhoneBcdGuid /addlast

Write-Host "Done!"