. "$PSScriptRoot\Functions.ps1"

Step "We are going enable Dual Boot"

Write-Host "Working..."

$sysVolume = GetSystemVolume

Write-Host "Setting partition type to ESP..."
$sysVolume | Set-Partition -GptType "{EBD0A0A2-B9E5-4433-87C0-68B6B72699C7}" 

Write-Host "Done!"

