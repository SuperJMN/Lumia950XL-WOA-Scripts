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

function RemoveExistingWindowsPartitions() 
{
	RemoveReserved
	RemovePartition 'BOOT' 'FAT32'
	RemovePartition 'WindowsARM' 'NTFS'
}

function RemoveExistingWindowsPartitions() 
{
	RemoveReserved
	RemovePartition 'BOOT' 'FAT32'
	RemovePartition 'WindowsARM' 'NTFS'
}

function GetAvailableSpace()
{
	param($disk) 

	return $($disk.Size) -$($disk.AllocatedSize)		
}

function IsMoreSpaceNeeded() 
{
	Param ([switch]$verbose)
	$requiredGBs = 18
	$availableSpace = GetAvailableSpace $disk
	$spaceNeeded = $requiredGBs * 1000000000

	Write-Verbose "Available space: $($availableSpace)" 
	Write-Verbose "Required space: $($spaceNeeded)" 
	
	return $availableSpace -lt $spaceNeeded
}

function AllocateSpaceIfNeeded() 
{
	if (IsMoreSpaceNeeded)
	{
		if (IsDataPartitionPresent)
		{
			ShrinkDataPartition
		} 
		else 
		{
			throw "The Phone doesn't have available space to install Windows ARM 64"
		}
	}
}

function IsDataPartitionPresent()
{
	try 
	{
		GetDataVolume
		$true
	} 
	catch 
	{
		$false
	}
}

function ShrinkDataPartition()
{
	$volume = GetDataVolume
	$driveLetter = $volume.DriveLetter

	Step "We are going to resize the Data partition at drive $($driveLetter) to 7.5GB. Please, verify the drive letter is correct."

	Write-Host "Working..."

	Resize-Partition -DriveLetter $driveLetter -Size 7.5GB

	Write-Host "Done!"
}


AllocateSpaceIfNeeded