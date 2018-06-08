. "$PSScriptRoot\Functions.ps1"

Write-Host "Mount the Windows 10 ARM .ISO image you want to apply"
Read-Host "Press Enter when ready"

Write-Host "Working..."

$imageLetter = GetImageLetter

$deploymentDestination = "W:\"

& DISM.exe /Apply-Image /ImageFile:$($imageLetter):\sources\install.wim /Index:1 /ApplyDir:$($deploymentDestination)

Write-Host "Done!"