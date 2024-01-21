# Function to display menu and get user choice
function Show-Menu {
    Clear-Host
    Write-Host "===== Computer State Change Menu ====="
    Write-Host "1. Lock the computer"
    Write-Host "2. Log off the current session"
    Write-Host "3. Shut down the computer"
    Write-Host "4. Restart the computer"
    Write-Host "5. Sleep"
    Write-Host "6. Hibernate"
    Write-Host "7. Exit"
    Write-Host "====================================="

    $choice = Read-Host "Enter your choice"

    return $choice
}

# Main script
do {
    $userChoice = Show-Menu

    switch ($userChoice) {
        "1" { rundll32.exe user32.dll,LockWorkStation }
        "2" { logoff }
        "3" { Stop-Computer -Force }
        "4" { Restart-Computer -Force }
        "5" { Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Application]::SetSuspendState("Suspend", $false, $true) }
        "6" { Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Application]::SetSuspendState("Hibernate", $false, $true) }
        "7" { break }
        default { Write-Host "Invalid choice. Please enter a valid option." }
    }

    # Pause to display the result and wait for user input
    Write-Host "Press Enter to continue..."
    $null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

} while ($userChoice -ne "7")
