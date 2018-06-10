. "$PSScriptRoot\Functions.ps1"

Step "Enabling Dual Boot..."

$sysVolume = GetSystemVolume

Write-Host "Setting partition type to Basic..."
$sysVolume | Get-Partition | Set-Partition -GptType "{EBD0A0A2-B9E5-4433-87C0-68B6B72699C7}" 


$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\BCD"

& bcdedit /store $bcdFileName /set `{default`} description "Windows Phone"
& bcdedit /store $bcdFileName /displayorder `{default`} /addlast

Write-Host "Done!"