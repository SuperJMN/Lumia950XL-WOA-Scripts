. "$PSScriptRoot\Functions.ps1"

function RemovePartition() 
{
	param([string] $label, [string] $fileSytemFormat)

	try 
	{
		$vol = GetVolume $label $fileSytemFormat
		$vol | Get-Partition | Remove-Partition
	}
	catch 
	{
		Write-Host "The $($label) partition couldn't be removed. It might not exist."
	}
}

function RemoveReserved() 
{
	try 
	{
		$part = GetReservedPartition
		$part | Remove-Partition 
	} 
	catch 
	{
		Write-Host "The Reserved partition couldn't be removed. It might not exist."
	}	
}

Step "We're going to delete the partitions of the previous Windows Installation.`nThis will only affect the Windows 10 ARM installation."

Write-Host "Working..."

RemoveReserved
RemovePartition 'BOOT' 'FAT32'
RemovePartition 'WindowsARM' 'NTFS'

Write-Host "Done!"