. "$PSScriptRoot\Functions.ps1"

$mainOs = GetMainOS
$driveLetter = $mainOs.Volume.DriveLetter

Step "We are going to deploy the UEFI to the $($driveLetter) drive."

Write-Host "Working..."

Copy-Item -Path $PSScriptRoot\Files\Core\UEFI.elf -Destination "$($driveLetter):\EFIESP\"
Copy-Item -Path $PSScriptRoot\Files\Core\emmc_appsboot.mbn -Destination "$($driveLetter):\EFIESP"
Copy-Item -Path $PSScriptRoot\Files\Core\BootShim.efi -Destination "$($driveLetter):\EFIESP\EFI\boot"

Write-Host "Done!"

