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

# Security Log
$securityLogs = Get-WinEvent -LogName Security -MaxEvents 1000
$securityLogTempPath = [System.IO.Path]::Combine($tempDir, "SecurityLogFile.txt")
$securityLogCustomPath = [System.IO.Path]::Combine($customDir, "SecurityLogFile.txt")
Save-Logs -tempLogFilePath $securityLogTempPath -customLogFilePath $securityLogCustomPath -logType "Security" -logs $securityLogs

# Application Log
$applicationLogs = Get-WinEvent -LogName Application -MaxEvents 1000
$applicationLogTempPath = [System.IO.Path]::Combine($tempDir, "ApplicationLogFile.txt")
$applicationLogCustomPath = [System.IO.Path]::Combine($customDir, "ApplicationLogFile.txt")
Save-Logs -tempLogFilePath $applicationLogTempPath -customLogFilePath $applicationLogCustomPath -logType "Application" -logs $applicationLogs

# System Log
$systemLogs = Get-WinEvent -LogName System -MaxEvents 1000
$systemLogTempPath = [System.IO.Path]::Combine($tempDir, "SystemLogFile.txt")
$systemLogCustomPath = [System.IO.Path]::Combine($customDir, "SystemLogFile.txt")
Save-Logs -tempLogFilePath $systemLogTempPath -customLogFilePath $systemLogCustomPath -logType "System" -logs $systemLogs

# Windows Firewall Log
$firewallLogPath = "$env:SystemRoot\System32\LogFiles\Firewall\pfirewall.log"
$firewallLogs = Get-Content $firewallLogPath -Tail 1000
$firewallLogTempPath = [System.IO.Path]::Combine($tempDir, "FirewallLogFile.txt")
$firewallLogCustomPath = [System.IO.Path]::Combine($customDir, "FirewallLogFile.txt")
Save-Logs -tempLogFilePath $firewallLogTempPath -customLogFilePath $firewallLogCustomPath -logType "Firewall" -logs $firewallLogs

# Audit Log
$auditLogs = Get-WinEvent -LogName Security -FilterXPath "*[System[EventID=4663]]" -MaxEvents 1000
$auditLogTempPath = [System.IO.Path]::Combine($tempDir, "AuditLogFile.txt")
$auditLogCustomPath = [System.IO.Path]::Combine($customDir, "AuditLogFile.txt")
Save-Logs -tempLogFilePath $auditLogTempPath -customLogFilePath $auditLogCustomPath -logType "Audit" -logs $auditLogs

# DNS Log
$dnsLogs = Get-WinEvent -LogName Application -FilterXPath "*[System[Provider[@Name='Microsoft-Windows-DNS-Client']]]" -MaxEvents 1000
$dnsLogTempPath = [System.IO.Path]::Combine($tempDir, "DNSLogFile.txt")
$dnsLogCustomPath = [System.IO.Path]::Combine($customDir, "DNSLogFile.txt")
Save-Logs -tempLogFilePath $dnsLogTempPath -customLogFilePath $dnsLogCustomPath -logType "DNS" -logs $dnsLogs
