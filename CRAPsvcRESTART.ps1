# Script to restart windows services that suck and stop randomly 
# OCULUX7


# Define service name & log path
$serviceName = "SET THE NAME OF THE SERVICE" 
$logFilePath = "SET THE PATH OF THE DIR WHERE YOU WANT TO LOG"

# Function to write output to log file
function Write-Log {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $Message"
    Add-Content -Path $logFilePath -Value $logMessage
}

# Check if log file exists, create if not
if (-not (Test-Path $logFilePath)) {
    New-Item -Path $logFilePath -ItemType File -Force
}

# Function to restart the service
function Restart-ServiceWithLogging {
    if ((Get-Service -Name $serviceName -ErrorAction SilentlyContinue).Status -eq "Stopped") {
        Write-Log "Service '$serviceName' is stopped. Restarting..."
        Restart-Service -Name $serviceName
        Write-Log "Service '$serviceName' restarted."
    }
}

# Monitor the service and restart if stopped
while ($true) {
    $serviceStatus = (Get-Service -Name $serviceName -ErrorAction SilentlyContinue).Status
    if ($serviceStatus -eq "Stopped") {
        Restart-ServiceWithLogging
    }
    Start-Sleep -Seconds 10
}
