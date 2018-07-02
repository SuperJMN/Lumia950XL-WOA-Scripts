. "$PSScriptRoot\Functions.ps1"

function RemovePartition() 
{
	param([string] $label, [string] $fileSytemFormat)

	try 
	{
		$vol = GetVolume $label $fileSytemFormat
		$vol | Get-Partition | Remove-Partition -Confirm:$false
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
		$part | Remove-Partition -Confirm:$false
	} 
	catch 
	{
		Write-Host "The Reserved partition couldn't be removed. It might not exist."
	}	
}

function RemoveExistingWindowsPartitions() 
{
	RemoveReserved
	RemovePartition 'BOOT' 'FAT32'
	RemovePartition 'WindowsARM' 'NTFS'
}

RemoveExistingWindowsPartitions
