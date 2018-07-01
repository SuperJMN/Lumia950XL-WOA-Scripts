. "$PSScriptRoot\Functions.ps1"

function GetAvailableSpace()
{
	param($disk) 

	return $disk.Size -$disk.AllocatedSize
}

function IsMoreSpaceNeeded() 
{
	Param ($disk)
	$requiredGBs = 18
	$availableSpace = GetAvailableSpace $disk
	$spaceNeeded = $requiredGBs * 1000000000

	Write-Verbose "Available space: $($availableSpace)" 
	Write-Verbose "Required space: $($spaceNeeded)" 
	
	return $availableSpace -lt $spaceNeeded
}

function AllocateSpaceIfNeeded() 
{
	param($disk)

	Write-Host "Checking for free space..."
	if (IsMoreSpaceNeeded $disk)
	{
		Write-Host "We need will to take space from the Data partition in order to install Windows"

		if (IsDataPartitionPresent)
		{			
			Write-Host "Data partition is present"
			ShrinkDataPartition
		} 
		else 
		{
			Write-Warning "Data partition not found. We can't take the necessary space!"
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

$mainOs = GetMainOS
$disk = $mainOs.Disk

AllocateSpaceIfNeeded $disk