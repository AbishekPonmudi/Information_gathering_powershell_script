# Changing Computer State Script

# Function to display action messages
function Display-ActionMessage($action) {
    Write-Host ("$action...") -ForegroundColor Green
}

# Function to perform Lock Workstation
# function Lock-Computer {
#     Display-ActionMessage "Locking the computer"
#     Start-Process rundll32.exe -ArgumentList "user32.dll,LockWorkStation" -Verb RunAs -Wait
# }

# Function to perform Logoff
# function Logoff-Session {
#     Display-ActionMessage "Logging off the current session"
#     Start-Process shutdown.exe -ArgumentList "-l" -NoNewWindow -Verb RunAs -Wait
# }

# Function to perform Shutdown
function ShutDown-Computer {
    Display-ActionMessage "Shutting down the computer"
    Stop-Computer -Force
}

# Function to perform Restart
# function Restart-Computer {
#     Display-ActionMessage "Restarting the computer"
#     Restart-Computer -Force
# }

# Main script

# Uncomment the action you want to perform
# Lock-Computer
# Logoff-Session
ShutDown-Computer
# Restart-Computer
