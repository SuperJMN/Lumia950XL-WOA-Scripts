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

function GetBootMgrPartitionPath()
{
    param([string] $bcdFileName)

    $bootMgrPartitionPath = bcdedit /store $bcdFileName /enum `{bootmgr`} |
      Select-String -Pattern '\{bootmgr\}' -context 1|
        ForEach-Object { ($_.Context.PostContext.Split('=')[1]) }

    if ($bootMgrPartitionPath -eq $null)
	{
        throw "Could not get the partition path of the {bootmgr} BCD entry"
    }

    return $bootMgrPartitionPath
}

function Get-SystemInfo
{
  param($ComputerName = $env:COMPUTERNAME)
 
  $header = 'Hostname','OSName','OSVersion','OSManufacturer','OSConfiguration','OS Build Type','RegisteredOwner','RegisteredOrganization','Product ID','Original Install Date','System Boot Time','System Manufacturer','System Model','System Type','Processor(s)','BIOS Version','Windows Directory','System Directory','Boot Device','System Locale','Input Locale','Time Zone','Total Physical Memory','Available Physical Memory','Virtual Memory: Max Size','Virtual Memory: Available','Virtual Memory: In Use','Page File Location(s)','Domain','Logon Server','Hotfix(s)','Network Card(s)'
 
  $info = systeminfo.exe /FO CSV /S $ComputerName |
    Select-Object -Skip 1 | 
    ConvertFrom-CSV -Header $header
      
  $info.'System Locale'|%{$_.split(';')[0]}
}

function Step
{
	param([string]$message) 	
	Read-Host -Prompt "$($message). Press enter to continue."
}

function Scripted-Step
{
	param([string]$message,[string]$script) 	
	Step $message
	& $script
}

