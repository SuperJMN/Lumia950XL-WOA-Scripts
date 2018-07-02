. "$PSScriptRoot\Functions.ps1"

Step "Please, mount the Windows 10 ARM .ISO image you want to apply. The path will be auto-discovered."

Write-Host "Working..."

$imageLetter = GetImageLetter

Step ".WIM image found in $($imageLetter) drive." 

$deploymentDestination = "W:\"

& "DISM.exe" /Apply-Image /ImageFile:$($imageLetter):\sources\install.wim /Index:1 /ApplyDir:$($deploymentDestination)

Write-Host "Done!"