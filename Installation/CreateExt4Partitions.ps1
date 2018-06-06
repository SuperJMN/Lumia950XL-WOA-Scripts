. "$PSScriptRoot\Functions.ps1"

Write-Host "NOTICE: Patition names are not labels. You have to put the exact names!"

Step "1: Please, create a partition named 'boot', format ext4, size=4MB inside the allocated free space"
Step "2: Now create a partition named 'uefi_vars', format ext4, size=4MB inside the allocated free space"
