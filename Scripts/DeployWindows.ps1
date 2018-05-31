Write-Host "Mount Windows 10 ARM .ISO image"
$imageLetter = Read-Host "Please, enter the drive letter in which the .ISO has been mounted"
$deploymentDestination = "W:\"

& DISM.exe /Apply-Image /ImageFile:$($imageLetter):\sources\install.wim /Index:1 /ApplyDir:$($deploymentDestination)

Write-Host "Done!"