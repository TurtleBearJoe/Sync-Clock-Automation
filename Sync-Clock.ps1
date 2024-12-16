# PowerShell script to sync the clock
Write-Output 'Syncing time with time.windows.com...'
w32tm /config /manualpeerlist:time.windows.com /syncfromflags:manual /reliable:YES /update
Restart-Service w32time
w32tm /resync
Write-Output 'Time sync complete.'
