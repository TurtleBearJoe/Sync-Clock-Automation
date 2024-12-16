# Define file paths
$scriptPath = "C:\Scripts\Sync-Clock.ps1"
$taskName = "Sync Clock Hourly"

# Ensure the folder for the script exists
if (!(Test-Path "C:\Scripts")) {
    New-Item -ItemType Directory -Path "C:\Scripts"
}

# Create the Sync-Clock.ps1 script file if it doesn't exist
if (!(Test-Path $scriptPath)) {
    $timeServer = "time.windows.com"
    $syncScript = @"
# PowerShell script to sync the clock
Write-Output 'Syncing time with $timeServer...'
w32tm /config /manualpeerlist:$timeServer /syncfromflags:manual /reliable:YES /update
Restart-Service w32time
w32tm /resync
Write-Output 'Time sync complete.'
"@
    Set-Content -Path $scriptPath -Value $syncScript
    Write-Output "Created Sync-Clock.ps1 at $scriptPath"
}

# Remove existing task with the same name if it exists
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Output "Existing scheduled task '$taskName' removed."
}

# Create a new scheduled task to run the script at startup and every 1 hour
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`""
$triggerAtStartup = New-ScheduledTaskTrigger -AtStartup
$triggerEveryHour = New-ScheduledTaskTrigger -Once -At (Get-Date).Date.AddMinutes(5) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 1)

Register-ScheduledTask -Action $action -Trigger $triggerAtStartup, $triggerEveryHour -TaskName $taskName -Description "Sync clock with time server every hour and at startup." -RunLevel Highest

Write-Output "Scheduled task '$taskName' created successfully."
