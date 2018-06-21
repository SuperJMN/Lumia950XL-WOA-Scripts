. "$PSScriptRoot\Functions.ps1"

Write-Host "NOTICE: To create the required partitions you can use Gparted (Linux) or GDisk (Windows)"
Write-Host "Also, take into account that partition names should be exactly the ones we require"
Write-Host "Lastly, remember that we have to set the PARTITION NAMES, NOT LABELS. That's why we require the aforementioned tools."
Write-Host
Write-Host "In the next steps, we will require you to create the partitions. Proceed to get the exact properties of each one."
Write-Host "Please, notice that the free space in which the partitions should be created is the space we took from the Data partition and it's will be located at the end of the Phones's partition layout."

Step "1: Please, create a partition named 'boot', unformatted (RAW), size=4MB inside the free space"
Step "2: Now create a partition named 'uefi_vars', unformatted (RAW), size=4MB inside the free space"
