$volume = Get-Volume | Where { $_.FileSystemType -eq 'NTFS' -and $_.FileSystemLabel -eq 'WindowsARM' } | Select -index 0
$windowsDriveLetter = $volume.DriveLetter
if ($windowsDriveLetter -eq $null)
{
	throw "Cannot get Windows drive letter"
}

$volume = Get-Volume | Where { $_.FileSystemType -eq 'FAT32' -and $_.FileSystemLabel -eq 'SYSTEM' } | Select -index 0
$systemDriveLetter = $volume.DriveLetter

if ($systemDriveLetter -eq $null)
{
	throw "Cannot get System partition drive Letter"
}

bcdboot "$($windowsDriveLetter):\windows" /l en-US /f UEFI /s "$($systemDriveLetter):"
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} testsigning on
bcdedit /store "$($systemDriveLetter):\EFI\Microsoft\Boot\BCD" /set `{default`} nointegritychecks on

"Done!"