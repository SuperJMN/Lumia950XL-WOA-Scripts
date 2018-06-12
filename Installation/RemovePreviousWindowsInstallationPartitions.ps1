. "$PSScriptRoot\Functions.ps1"

function RemovePartition() 
{
	param([string] $label, [string] $fileSytemFormat)

	(GetVolume $label $fileSytemFormat) | Get-Partition | Remove-Partition
}

Step "We're going to delete the partitions of the previous Windows Installation. This will only affect the Windows 10 ARM installation."

Write-Host "Working..."

try 
{
	RemovePartition 'WindowsARM' 'NTFS'
} 
catch 
{

}

try 
{
	RemovePartition 'System' 'FAT32'
} 
catch 
{
}

Write-Host "Done!"