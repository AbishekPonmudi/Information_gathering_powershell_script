# Script to Display Service Status
$serviceStatus = Get-CimInstance -ClassName Win32_Service | Select-Object -Property Status, Name, DisplayName
Write-Output "Service Status:"
$serviceStatus

# Script to Get System Information
$systemInfo = Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber, OsArchitecture, OsManufacturer, CsName, CsUserName
Write-Output "$($systemInfo.WindowsProductName) $($systemInfo.WindowsVersion) Build $($systemInfo.OsBuildNumber) $($systemInfo.OsArchitecture) $($systemInfo.OsManufacturer) Computer: $($systemInfo.CsName) User: $($systemInfo.CsUserName)"

# Script to Get BIOS Information
$biosInfo = Get-CimInstance -ClassName Win32_BIOS
Write-Output "BIOS Information:"
$biosInfo

# Script to Get Processor Information
$processorInfo = Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*"
Write-Output "Processor Information:"
$processorInfo

# Script to Get System Drives
$drives = Get-Volume | Select-Object DriveLetter, FileSystemLabel, FileSystem, DriveType, SizeRemaining, Size
foreach ($drive in $drives) {
    Write-Output "$($drive.DriveLetter) $($drive.FileSystemLabel) $($drive.FileSystem) Type: $($drive.DriveType) Free: $($drive.SizeRemaining) Size: $($drive.Size)"
}

# Script to Get Running Processes
$processes = Get-Process | Select-Object Name, Id, CPU, Memory
foreach ($process in $processes) {
    Write-Output "$($process.Name) $($process.Id) CPU: $($process.CPU) Memory: $($process.Memory)"
}

# Script to Get Firewall Rules
$firewallRules = Get-NetFirewallRule | Select-Object DisplayName, Action, Direction, Enabled
foreach ($rule in $firewallRules) {
    Write-Output "$($rule.DisplayName) Action: $($rule.Action) Direction: $($rule.Direction) Enabled: $($rule.Enabled)"
}

# Script to Get System Environment Variables
$envVariables = Get-ChildItem Env: | Select-Object Name, Value
foreach ($envVar in $envVariables) {
    Write-Output "$($envVar.Name) $($envVar.Value)"
}

# Script to Get Scheduled Tasks
$scheduledTasks = Get-ScheduledTask | Select-Object TaskName, State, NextRunTime
foreach ($task in $scheduledTasks) {
    Write-Output "$($task.TaskName) State: $($task.State) Next Run Time: $($task.NextRunTime)"
}

# Script to Get Network Adapters
$networkAdapters = Get-NetAdapter | Select-Object Name, InterfaceDescription, MacAddress, Status
foreach ($adapter in $networkAdapters) {
    Write-Output "$($adapter.Name) $($adapter.InterfaceDescription) MAC: $($adapter.MacAddress) Status: $($adapter.Status)"
}

# Script to Get Last Reboot Time
$lastReboot = Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime
Write-Output "Last Reboot Time: $($lastReboot.LastBootUpTime)"

# Script to Get Windows Updates
$windowsUpdates = Get-HotFix | Select-Object Description, HotFixID, InstalledOn
foreach ($update in $windowsUpdates) {
    Write-Output "$($update.Description) $($update.HotFixID) Installed On: $($update.InstalledOn)"
}

# Script to Get Desktop Information
$desktopInfo = Get-CimInstance -ClassName Win32_Desktop | Select-Object -Property *user* -ExcludeProperty "Cim*"
Write-Output "Desktop Information:"
$desktopInfo

# Script to Get SystemType
$systemType = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType
Write-Output "System Type:"
$systemType

# Script to Get Computer Manufacturer and Model
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
Write-Output "Computer Manufacturer and Model:"
$computerSystem

# Script to List Installed Hotfixes
$hotfixes = Get-CimInstance -ClassName Win32_QuickFixEngineering | Select-Object -Property HotFixID
Write-Output "Installed Hotfixes:"
$hotfixes

# Script to List Operating System Version Information
$osVersionInfo = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property BuildNumber, BuildType, OSType, ServicePackMajorVersion, ServicePackMinorVersion
Write-Output "Operating System Version Information:"
$osVersionInfo

# Script to List Local Users and Owner
$localUsers = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property NumberOfLicensedUsers, NumberOfUsers, RegisteredUser
Write-Output "Local Users Information:"
$localUsers

# Script to Get Available Disk Space
$diskSpace = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
Write-Output "Available Disk Space:"
$diskSpace

$diskSpaceSum = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" |
    Measure-Object -Property FreeSpace, Size -Sum |
    Select-Object -Property Property, Sum
Write-Output "Total Disk Space:"
$diskSpaceSum

# Script to Get Logon Session Information
$logonSessions = Get-CimInstance -ClassName Win32_LogonSession
Write-Output "Logon Session Information:"
$logonSessions

# Script to Get User Logged On to the Computer
$userLoggedOn = Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName
Write-Output "User Logged On:"
$userLoggedOn

# Script to Get Local Time from a Computer
$localTime = Get-CimInstance -ClassName Win32_LocalTime
Write-Output "Local Time:"
$localTime
