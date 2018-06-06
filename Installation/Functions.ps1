function GetMainOS()
{
	foreach ($disk in Get-Disk) 
	{
		foreach ($partition in Get-Partition -Disk $disk) 	
		{
			foreach ($volume in Get-Volume -Partition $partition) 	
			{
				if ($volume.FileSystemType -eq 'NTFS' -and $volume.FileSystemLabel -eq 'MainOS') 
				{
					return New-Object PSObject -Property @{           
						Volume  = $volume
						Disk	= $disk        
					}  

					break
				}
			}	
		}
	}
	
	throw 'Could not obtain the MainOS Volume. Please, verify that your phone is in Mass Storage Mode'		
}

function GetVolume() 
{
	param([string]$label,[string]$fileSystemType) 

	$mainOs = GetMainOS
	$disk = $mainOs.Disk
	
	$vol = Get-Partition -Disk $disk | Get-Volume | Where { $_.FileSystemType -eq $fileSystemType -and $_.FileSystemLabel -eq $label } | Select -index 0

	if ($vol -eq $null)	
	{	
		throw $"Could not obtain the $label volume. Please, verify it is mounted and that your phone is in Mass Storage Mode"	
	}

	return $vol
}

function GetWindowsVolume()
{
	return GetVolume "WindowsARM" "NTFS"
}

function GetDataVolume()
{	
	return GetVolume "Data" "NTFS"
}

function GetSystemVolume()
{
	return GetVolume "System" "FAT32"
}

function GetImageLetter()
{
	foreach ($disk in Get-Disk) 
	{
		foreach ($volume in Get-Volume) 	
		{
			if ($volume.DriveLetter -ne $null)
			{
				$path ="$($volume.DriveLetter):\sources\install.wim"
				$pathExist = Test-Path $path

				if ($pathExist -eq $true)
				{
					return $volume.DriveLetter
				}
			}
		}	
	}

	throw 'Could find INSTALL.WIM in any of the mounted drives. Please, verify that you mounted the .ISO drive correctly.'		 
}

function Step
{
	param([string]$message) 	
	Write-Host $message
	Read-Host -Prompt $message 	
}

function Scripted-Step
{
	param([string]$message,[string]$script) 	
	Step $message
	& $script
}

