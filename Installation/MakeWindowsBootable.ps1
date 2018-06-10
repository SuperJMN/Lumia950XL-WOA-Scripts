. "$PSScriptRoot\Functions.ps1"

$winVolume = GetWindowsVolume
$sysVolume = GetSystemVolume

$windowsDriveLetter = $winVolume.DriveLetter
$systemDriveLetter = $sysVolume.DriveLetter

Write-Host "Working..."

bcdboot "$($windowsDriveLetter):\windows" /l en-US /f UEFI /s "$($systemDriveLetter):"
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} testsigning on
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} nointegritychecks on

Write-Host "Setting partition type to ESP..."
$sysVolume | Set-Partition -GptType "{C12A7328-F81F-11D2-BA4B-00A0C93EC93B}" 

"Done!"