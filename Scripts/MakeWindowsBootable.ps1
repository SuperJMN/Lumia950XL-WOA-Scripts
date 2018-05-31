$volume = Get-Volume | Where { $_.FileSystemType -eq 'NTFS' -and $_.FileSystemLabel -eq 'WindowsARM' } | Select -index 0
$windowsDriveLetter = $volume.DriveLetter

$volume = Get-Volume | Where { $_.FileSystemType -eq 'FAT32' -and $_.FileSystemLabel -eq 'SYSTEM' } | Select -index 0
$systemDriveLetter = $volume.DriveLetter

bcdboot "$($windowsDriveLetter):\windows" /l en-US /f UEFI /s "$($systemDriveLetter):"
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} testsigning on
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} nointegritychecks on

"Done!"