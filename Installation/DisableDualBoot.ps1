. "$PSScriptRoot\Functions.ps1"

Step "Please, make sure you are in Mass Storage Mode before proceeding."
Write-Host "Disabling Dual Boot..."

$sysVolume = GetSystemVolume

$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\BCD"

$winPhoneBcdGuid = "{7619dcc9-fafe-11d9-b411-000476eba25f`}"

& bcdedit /store $bcdFileName /displayorder $winPhoneBcdGuid /remove

Write-Host "Setting partition type back to ESP..."
$sysVolume | Get-Partition | Set-Partition -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}'

Write-Host "Done!"