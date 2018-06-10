. "$PSScriptRoot\Functions.ps1"

Step "We are going enable Dual Boot"

Write-Host "Working..."

$sysVolume = GetSystemVolume

Write-Host "Setting partition type to ESP..."
$sysVolume | Set-Partition -GptType "{EBD0A0A2-B9E5-4433-87C0-68B6B72699C7}" 


$mainOs = GetMainOS
$volume = $mainOs.Volume
$driveLetter = $volume.DriveLetter

$bcdFileName = "$($driveLetter):\EFIESP\EFI\Microsoft\BOOT\BCD"

& bcdedit /store $bcdFileName /set `{default`} description "Windows Phone"
& bcdedit /store $bcdFileName /displayorder `{default`} /addlast

Write-Host "Done!"