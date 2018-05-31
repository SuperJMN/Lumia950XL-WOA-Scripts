$driverFolder = "$($PSScriptRoot)\Files\Drivers\Stable"
$windowsImageDrive = 'W:\'

Dism /Image:$($windowsImageDrive) /Add-Driver /Driver:$($driverFolotlder) /Recurse /ForceUnsigned