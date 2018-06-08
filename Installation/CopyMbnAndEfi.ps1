. "$PSScriptRoot\Functions.ps1"

$mainOs = GetMainOS
$driveLetter = $mainOs.Volume.DriveLetter

Step "We are going copy the required files: BootShip.efi and emmc_appsboot.mbn to the appropriate folders in the $($driveLetter) drive."

Write-Host "Working..."

Copy-Item -Path $PSScriptRoot\Files\Core\BootShim.efi -Destination "$($driveLetter):\EFIESP\EFI\boot"
Copy-Item -Path $PSScriptRoot\Files\Core\emmc_appsboot.mbn -Destination "$($driveLetter):\EFIESP"

Write-Host "Done!"

