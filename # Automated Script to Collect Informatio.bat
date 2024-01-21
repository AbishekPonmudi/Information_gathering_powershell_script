# Automated Script to Collect Information about the Computer

# Function to Get Information and Display in a Table
function Get-AndDisplayInformation {
    param (
        [string]$ClassName,
        [string]$PropertyFilter
    )

    $info = Get-CimInstance -ClassName $ClassName | Select-Object -Property $PropertyFilter
    Write-Host "$ClassName Information:"
    $info | Format-Table -AutoSize
    Write-Host "`n"
}

# Listing Desktop Settings
Get-AndDisplayInformation -ClassName "Win32_Desktop"

# Listing BIOS Information
Get-AndDisplayInformation -ClassName "Win32_BIOS"

# Listing Processor Information
Get-AndDisplayInformation -ClassName "Win32_Processor" -PropertyFilter *

# Listing Computer Manufacturer and Model
Get-AndDisplayInformation -ClassName "Win32_ComputerSystem"

# Listing Installed Hotfixes
Get-AndDisplayInformation -ClassName "Win32_QuickFixEngineering" -PropertyFilter HotFixId

# Listing Operating System Version Information
Get-AndDisplayInformation -ClassName "Win32_OperatingSystem" -PropertyFilter Build*,OSType,ServicePack*

# Listing Local Users and Owner
Get-AndDisplayInformation -ClassName "Win32_OperatingSystem" -PropertyFilter *user*

# Getting Available Disk Space
Get-AndDisplayInformation -ClassName "Win32_LogicalDisk" -PropertyFilter DeviceID,DriveType,ProviderName,VolumeName,Size,FreeSpace,PSComputerName

# Getting Logon Session Information
Get-AndDisplayInformation -ClassName "Win32_LogonSession"

# Getting the User Logged On to a Computer
Get-AndDisplayInformation -ClassName "Win32_ComputerSystem" -PropertyFilter UserName

# Getting Local Time from a Computer
Get-AndDisplayInformation -ClassName "Win32_LocalTime"

# Displaying Service Status
Get-AndDisplayInformation -ClassName "Win32_Service" -PropertyFilter Status,Name,DisplayName
