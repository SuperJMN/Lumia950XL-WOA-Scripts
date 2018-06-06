. "$PSScriptRoot\Functions.ps1"

$mainOs = GetMainOS
$diskNumber = $mainOs.Disk.DiskNumber

Write-Host "We're going to create the partitions in the Disk number $($diskNumber). Please, verify this is OK."

New-Partition -DiskNumber $($diskNumber) -Size 100MB -GptType "{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}" -DriveLetter "S"
Format-Volume -FileSystem FAT32 -NewFileSystemLabel "SYSTEM" -DriveLetter "S" -Force

New-Partition -DiskNumber $($diskNumber) -UseMaximumSize -DriveLetter "W"
Format-Volume -FileSystem NTFS -NewFileSystemLabel "WindowsARM" -DriveLetter "W" -Force

Write-Host "Done!"