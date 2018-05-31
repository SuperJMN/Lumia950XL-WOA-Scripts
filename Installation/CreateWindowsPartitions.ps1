# THIS CODE IS AUTOMATIC, BUT DOESN'T WORK. 
$diskNumber = Read-Host "Enter the Disk Number associted with the phone"
New-Partition -DiskNumber $($diskNumber) -Size 100MB -GptType "{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}" -DriveLetter "S"
Format-Volume -FileSystem FAT32 -NewFileSystemLabel "SYSTEM" -DriveLetter "S" -Force

New-Partition -DiskNumber $($diskNumber) -UseMaximumSize -DriveLetter "W"
Format-Volume -FileSystem NTFS -NewFileSystemLabel "WindowsARM" -DriveLetter "W" -Force

#Write-Host "THESE ARE MANUAL STEPS"
#Write-Host "Execute DISKPART with Administrative rights"
#Read-Host
#Write-Host "System partition:"
#Write-Host "Execute: SELECT DISK x (x is Lumia's disk)"
#Write-Host "Execute: FORMAT FS=FAT32 QUICK LABEL=SYSTEM "
#Write-Host "Execute: ASSIGN LETTER=S"

#Write-Host "Windows partition:"
#Write-Host "Execute: CREATE PARTITION PRIMARY"
#Write-Host "Execute: FORMAT FS=NTFS QUICK LABEL=WIN_EMMC"
#Write-Host "Execute: ASSIGN LETTER=W"

Write-Host "Done!"