. "$PSScriptRoot\Functions.ps1"

$volume = GetDataVolume
$driveLetter = $volume.DriveLetter

Write-Host "We are going to resize the Data partition at drive $($driveLetter) to 7.5GB. Press any key to proceed"
Read-Host
Resize-Partition -DriveLetter $driveLetter -Size 7.5GB

Write-Host "Done!"

