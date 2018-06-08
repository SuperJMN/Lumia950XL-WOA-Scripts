Write-Host "Working..."

$uefiFile="$($PSScriptRoot)\Files\Core\UEFI.elf"
$fastbootExe="$($PSScriptRoot)\Tools\Android\platform-tools\fastboot.exe"
& $fastbootExe flash boot $uefiFile

Write-Host "Done!"