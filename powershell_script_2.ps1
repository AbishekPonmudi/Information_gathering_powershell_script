# Set the paths for the log directories
$tempDir = [System.IO.Path]::Combine($env:TEMP, "LogScripts")
$customDir = "C:\Users\Abishek\systemlogs"

# Create subdirectories in both locations
$null = New-Item -ItemType Directory -Force -Path $tempDir
$null = New-Item -ItemType Directory -Force -Path $customDir

# Function to save logs to file
function Save-Logs {
    param(
        [string]$tempLogFilePath,
        [string]$customLogFilePath,
        [string]$logType,
        [object]$logs
    )

    Write-Host "$logType logs have been saved to (temp): $tempLogFilePath"
    $logs | Format-Table -AutoSize | Out-File -FilePath $tempLogFilePath

    Write-Host "$logType logs have been saved to (custom): $customLogFilePath"
    $logs | Format-Table -AutoSize | Out-File -FilePath $customLogFilePath
}

# Function to get Computer Information
function Get-MyComputerInfo {
    $computerInfo = Get-ComputerInfo | Out-String
    return $computerInfo
}
# Function to get Authenticate code  
function Get-Authenticode {
    $authenticode = Get-ChildItem $PSHOME\*.* | ForEach-Object { Get-AuthenticodeSignature $_ } | Where-Object { $_.Status -eq "Valid" }
    return $authenticode
}

function Get-hardwareinfo {
    $hardware = Get-WmiObject win32_baseboard | Select-Object Manufacturer, Product, SerialNumber
    return $hardware
}


# Function to get Running Processes
function Get-RunningProcesses {
    $runningProcesses = Get-Process | Select-Object Name, Id, CPU, Memory
    return $runningProcesses
}

# Function to get Windows Updates
function Get-WindowsUpdates {
    $windowsUpdates = Get-HotFix | Select-Object Description, HotFixID, InstalledOn
    return $windowsUpdates
}

function Get-MyNetAdapter {
    $networkAdapterInfo = Get-NetAdapter -Name "*" -IncludeHidden | Format-List -Property "Name", "InterfaceDescription", "InterfaceName", "MacAddress"
    return $networkAdapterInfo
}

# Function to collect System Information
function Get-SystemInformation {
    $systemInfo = @()  # Initialize an empty array

    $systemInfo += Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_BIOS | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_Processor | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_Product | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_PnPEntity | Select-Object *
    $systemInfo += Get-CimInstance -ClassName Win32_DiskDrive | Select-Object *

    return $systemInfo
}

# Function to get Firewall Rules
function Get-FirewallRules {
    $firewallRules = Get-NetFirewallRule | Select-Object DisplayName, Action, Direction, Enabled
    return $firewallRules
}

# Function to get System Environment Variables
function Get-EnvironmentVariables {
    $envVariables = Get-ChildItem Env: | Select-Object Name, Value
    return $envVariables
}

# Function to get Scheduled Tasks
function Get-ScheduledTasks {
    $scheduledTasks = Get-ScheduledTask | Select-Object TaskName, State, NextRunTime
    return $scheduledTasks
}

# Function to get Last Reboot Time
function Get-LastRebootTime {
    $lastReboot = Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime
    
    return $lastReboot
}

# Function to get port information
function Portinfo {
    $openPorts = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } 
    Write-Output "Open Ports:"
    foreach ($port in $openPorts) {
        Write-Output "   Port $($port.LocalPort) is open."
    }
    $closedPorts = Get-NetTCPConnection | Where-Object { $_.State -ne 'Established' }
    Write-Output "Closed Ports:"
    foreach ($port in $closedPorts) {
        Write-Output "   Port $($port.LocalPort) is closed (State: $($port.State))."
    }
    return $openPorts, $closedPorts
} 

# Array of functions
$functions = @(
    'Get-RunningProcesses','Get-MyComputerInfo', 'Get-WindowsUpdates', 'Get-MyNetAdapter',
    'Get-SystemInformation','Get-FirewallRules', 'Get-EnvironmentVariables',
    'Get-ScheduledTasks', 'Get-LastRebootTime','Get-Authenticode','Get-hardwareinfo','Portinfo'
)

foreach ($functionName in $functions) {
    $functionResult = Invoke-Expression "$functionName"
    $tempLogPath = [System.IO.Path]::Combine($tempDir, "$functionName-LogFile.txt")
    $customLogPath = [System.IO.Path]::Combine($customDir, "$functionName-LogFile.txt")
    Save-Logs -tempLogFilePath $tempLogPath -customLogFilePath $customLogPath -logType $functionName -logs $functionResult
}

Write-Host "Script execution completed."
