. "$PSScriptRoot\Functions.ps1"

$winVolume = GetWindowsVolume
$sysVolume = GetSystemVolume

$windowsDriveLetter = $winVolume.DriveLetter
$systemDriveLetter = $sysVolume.DriveLetter

Write-Host "Working..."

bcdboot "$($windowsDriveLetter):\windows" /l en-US /f UEFI /s "$($systemDriveLetter):"
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} testsigning on
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} nointegritychecks on

"Done!"