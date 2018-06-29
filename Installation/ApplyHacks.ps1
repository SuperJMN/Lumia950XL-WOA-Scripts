function ImportRegistryFile
{
	param($regFileToImport, $registryPath)

	$prefix = "WOA"
	$hivePath = "HKEY_LOCAL_MACHINE\$prefix"
	$tempRegFile = "temp.reg"

	reg LOAD $hivePath $registryPath

	$p = Get-Content $regFileToImport
	$prefixed = $p -replace "HKEY_LOCAL_MACHINE\\SYSTEM", $hivePath
	$prefixed | Out-File $tempRegFile

	reg IMPORT $tempRegFile
	Remove-Item $tempRegFile

	reg UNLOAD $hivePath
}

function EnableBluetooth() 
{
	ImportRegistryFile "$PSScriptRoot\Files\Misc\BTService.reg" W:\Windows\System32\config\SYSTEM	
}

function EnableUsb() 
{
	$driveLetter = "W"
	Copy-Item -Path "$PSScriptRoot\Files\Misc\QcUsbFnSsFilter8994.sys" -Destination "$($driveLetter):\Windows\System32\Drivers"	
	ImportRegistryFile "$PSScriptRoot\Files\Misc\fnssfilter.reg" W:\Windows\System32\config\SYSTEM
}

EnableBluetooth
EnableUsb

Write-Host "Hacks applied!"