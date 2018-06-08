. "$PSScriptRoot\Functions.ps1"

$volume = GetDataVolume
$driveLetter = $volume.DriveLetter

Step "We are going to resize the Data partition at drive $($driveLetter) to 7.5GB. Please, verify the drive letter is correct."

Write-Host "Working..."

Resize-Partition -DriveLetter $driveLetter -Size 7.5GB

Write-Host "Done!"

