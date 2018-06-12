. "$PSScriptRoot\Functions.ps1"

Step "Disabling Dual Boot..."

$sysVolume = GetSystemVolume

Write-Host "Setting partition type back to ESP..."
$sysVolume | Get-Partition | Set-Partition -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}'


$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\BCD"

& bcdedit /store $bcdFileName /displayorder `{default`} /remove

Write-Host "Done!"