$volume = Get-Volume | Where { $_.FileSystemType -eq 'NTFS' -and $_.FileSystemLabel -eq 'MainOS' } | Select -index 0
$driveLetter = $volume.DriveLetter

Write-Host "We are going copy the required files: BootShip.efi and emmc_appsboot.mbn to the appropriate folders in the $($driveLetter) drive"
Read-Host
Copy-Item -Path $PSScriptRoot\Files\Core\BootShim.efi -Destination "$($driveLetter):\EFIESP\EFI\boot"
Copy-Item -Path $PSScriptRoot\Files\Core\emmc_appsboot.mbn -Destination "$($driveLetter):\EFIESP"

Write-Host "Done!"

