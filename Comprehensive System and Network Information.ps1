# Comprehensive System and Network Information Script

# System Information
$systemInfo = Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber, OsArchitecture, OsManufacturer, CsName, CsUserName
Write-Output "System Information:"
$systemInfo

# BIOS Information
$biosInfo = Get-CimInstance -ClassName Win32_BIOS
Write-Output "BIOS Information:"
$biosInfo

# Processor Information
$processorInfo = Get-CimInstance -ClassName Win32_Processor | Select-Object -Property *
Write-Output "Processor Information:"
$processorInfo

# Memory Information
$memoryInfo = Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object -Property *
Write-Output "Memory Information:"
$memoryInfo

# Disk Information
$diskInfo = Get-CimInstance -ClassName Win32_DiskDrive | Select-Object -Property *
Write-Output "Disk Information:"
$diskInfo

# Network Adapters Information
$networkAdapters = Get-NetAdapter | Select-Object Name, InterfaceDescription, MacAddress, Status
Write-Output "Network Adapters Information:"
$networkAdapters

# IP Configuration
$ipConfig = Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, PrefixLength, InterfaceIndex, AddressFamily
Write-Output "IP Configuration:"
$ipConfig

# DNS Client Settings
$dnsSettings = Get-DnsClient | Select-Object InterfaceAlias, ConnectionSpecificSuffix, ServerAddresses
Write-Output "DNS Client Settings:"
$dnsSettings

# Network Routing Table
$networkRoutes = Get-NetRoute | Select-Object ifIndex, DestinationPrefix, NextHop, RouteMetric
Write-Output "Network Routing Table:"
$networkRoutes

# ARP Table
$arpTable = Get-NetNeighbor | Select-Object ifIndex, IPAddress, LinkLayerAddress, State
Write-Output "ARP Table:"
$arpTable

# Active Network Connections
$networkConnections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
Write-Output "Active Network Connections:"
$networkConnections

# Firewall Rules
$firewallRules = Get-NetFirewallRule | Select-Object DisplayName, Action, Direction, Enabled
Write-Output "Firewall Rules:"
$firewallRules

# Processes Information
$processes = Get-Process | Select-Object Name, Id, CPU, Memory
Write-Output "Processes Information:"
$processes

# Service Status
$serviceStatus = Get-CimInstance -ClassName Win32_Service | Select-Object Status, Name, DisplayName
Write-Output "Service Status:"
$serviceStatus

# Last Reboot Time
$lastReboot = Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime
Write-Output "Last Reboot Time: $($lastReboot.LastBootUpTime)"

# Installed Hotfixes
$hotfixes = Get-CimInstance -ClassName Win32_QuickFixEngineering | Select-Object HotFixID
Write-Output "Installed Hotfixes:"
$hotfixes

# Operating System Version Information
$osVersionInfo = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object BuildNumber, BuildType, OSType, ServicePackMajorVersion, ServicePackMinorVersion
Write-Output "Operating System Version Information:"
$osVersionInfo

# Local Users Information
$localUsers = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object NumberOfLicensedUsers, NumberOfUsers, RegisteredUser
Write-Output "Local Users Information:"
$localUsers

# Available Disk Space
$diskSpace = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
Write-Output "Available Disk Space:"
$diskSpace

$diskSpaceSum = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Measure-Object -Property FreeSpace, Size -Sum |
    Select-Object -Property Property, Sum
Write-Output "Total Disk Space:"
$diskSpaceSum

# Logon Session Information
$logonSessions = Get-CimInstance -ClassName Win32_LogonSession
Write-Output "Logon Session Information:"
$logonSessions

# User Logged On
$userLoggedOn = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object UserName
Write-Output "User Logged On:"
$userLoggedOn

# Local Time
$localTime = Get-CimInstance -ClassName Win32_LocalTime
Write-Output "Local Time:"
$localTime


# Extended Network Information
Write-Output "-------------------------"
Write-Output "Extended Network Information"
Write-Output "-------------------------"

# Get Network Adapters
$networkAdapters = Get-NetAdapter | Select-Object Name, InterfaceDescription, MacAddress, Status
Write-Output "Network Adapters:"
$networkAdapters

# Get IP Configuration
$ipConfig = Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, PrefixLength, InterfaceIndex, AddressFamily
Write-Output "IP Configuration:"
$ipConfig

# Get DNS Client Settings
$dnsSettings = Get-DnsClient | Select-Object InterfaceAlias, ConnectionSpecificSuffix, ServerAddresses
Write-Output "DNS Client Settings:"
$dnsSettings

# Get Network Routing Table
$networkRoutes = Get-NetRoute | Select-Object ifIndex, DestinationPrefix, NextHop, RouteMetric
Write-Output "Network Routing Table:"
$networkRoutes

# Get ARP Table
$arpTable = Get-NetNeighbor | Select-Object ifIndex, IPAddress, LinkLayerAddress, State
Write-Output "ARP Table:"
$arpTable

# Get Active Network Connections
$networkConnections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
Write-Output "Active Network Connections:"
$networkConnections

# Get Network Statistics
$networkStatistics = Get-NetTCPConnection | Measure-Object
Write-Output "Network Statistics:"
$networkStatistics

# Get Network Firewall Rules
$firewallRules = Get-NetFirewallRule | Select-Object DisplayName, Action, Direction, Enabled
Write-Output "Firewall Rules:"
$firewallRules

# Get Network Interface Configuration
$interfaceConfig = Get-NetIPInterface | Select-Object InterfaceAlias, InterfaceDescription, AddressFamily, ConnectionState
Write-Output "Network Interface Configuration:"
$interfaceConfig

# Get Listening Network Ports
$listeningPorts = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' } | Select-Object LocalAddress, LocalPort
Write-Output "Listening Network Ports:"
$listeningPorts

# Get Network Interface Statistics
$interfaceStatistics = Get-NetAdapterStatistics | Select-Object Name, BytesReceived, BytesSent, UnicastPacketsReceived, UnicastPacketsSent
Write-Output "Network Interface Statistics:"
$interfaceStatistics
