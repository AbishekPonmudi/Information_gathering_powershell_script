# Set the path for the log file
$logFilePath = "C:\\Users\Abishek\Pictures\LogFile.txt"

# Get the system logs
$systemLogs = Get-EventLog -LogName System -Newest 1000

# Save the logs to a text file
$systemLogs | Format-Table -AutoSize | Out-File -FilePath $logFilePath

Write-Host "System logs have been saved to: $logFilePath"
