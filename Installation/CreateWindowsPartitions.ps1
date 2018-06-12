. "$PSScriptRoot\Functions.ps1"

function CreateEspPartition() 
{
	param([int] $diskNumber)

	$p = New-Partition -DiskNumber $($diskNumber) -Size 400MB -GptType '{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}'
	
	$p | Format-Volume -FileSystem FAT32 -NewFileSystemLabel "SYSTEM" -Force
	$p | Set-Partition -NewDriveLetter "S"
}

function CreateReservedPartition() 
{
	param([int] $diskNumber)	
		
	New-Partition -DiskNumber $($diskNumber) -Size 128MB -GptType '{e3c9e316-0b5c-4db8-817d-f92df00215ae}'
}

function CreateWindowsPartition() 
{
	param([int] $diskNumber)	

	$p = New-Partition -DiskNumber $($diskNumber) -UseMaximumSize
	$p | Format-Volume -FileSystem NTFS -NewFileSystemLabel "WindowsARM" -Force
	$p | Set-Partition -NewDriveLetter "W"
}

$mainOs = GetMainOS
$diskNumber = $mainOs.Disk.DiskNumber

Step "We're going to create the partitions in the Disk number $($diskNumber). Please, verify this is OK.`nSome windows will pop up automatically. Just close them when this happens."

Write-Host "Working..."

CreateEspPartition $diskNumber
CreateReservedPartition $diskNumber
CreateWindowsPartition $diskNumber

Write-Host "Done!"