# CRAPsvcRestart
This script is to monitor those windows servies that are critical to applications but always stop for no reason. When it is stopped it will restart it and log the time & date of the restart. 
# Download script and change service name & path in rows 6&7
$serviceName = "SET THE NAME OF THE SERVICE" 

$logFilePath = "SET THE PATH OF THE DIR WHERE YOU WANT TO LOG"
# Create Scheduled task to run on start up
open Power Shell with admin rights and run command below to run script on start up (change file dir after -File)

schtasks /create /tn "CRAPsvcRestart" /sc onstart /delay 0000:30 /rl highest /ru system /tr "powershell.exe -File SET PATH WHERE SCRIPT IS STORED"
