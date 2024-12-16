# TimeSync Automation

A set of scripts to automate time synchronization on Windows systems. This project ensures accurate timekeeping by synchronizing the system clock with a time server (`time.windows.com`) via a scheduled task.

## Features

- Automatically checks for administrative privileges using a batch file.
- Configures and registers a scheduled task to:
  - Synchronize the clock at system startup.
  - Re-sync the clock every hour.
- Uses the Windows Time Service (`w32time`) for synchronization.
- Simple setup process with detailed steps.

## Project Structure

- **`Run-As-Admin.bat`**: A batch file to check for admin privileges and execute the setup script.
- **`Setup-TimeSync.ps1`**: A PowerShell script to create and configure the scheduled task for time synchronization.
- **`Sync-Clock.ps1`**: A PowerShell script to synchronize the system clock with `time.windows.com`.

## Prerequisites

- **Windows OS** with PowerShell installed.
- **Administrative Privileges** to configure the scheduled task.
- **Windows Task Scheduler** service must be enabled.

## Installation and Usage

### Step 1: Clone the Repository
git clone https://github.com/TurtleBearJoe/TimeSync-Automation.git
cd TimeSync-Automation

### Step 2:Run the Batch File
1. Locate the `Run-As-Admin.bat` file.
2. Double-click the file to execute it. If not already running with administrator privileges, the script will prompt for elevation.
3. The script will:
   - Create a PowerShell script for time synchronization.
   - Register a scheduled task named `Sync Clock Hourly` to:
     - Run the sync script at system startup.
     - Re-run the script every hour.
    

### Step 3: Verify Scheduled Task
- Open **Task Scheduler** on your Windows system.
- Look for a task named **"Sync Clock Hourly"** under **Task Scheduler Library**.

## How It Works

### Run-As-Admin.bat
- Checks for administrative privileges to ensure the setup script can execute.
- If not running as an administrator:
  - It restarts itself with elevated privileges using PowerShell.

### Setup-TimeSync.ps1
1. Ensures the `C:\Scripts` directory exists, creating it if necessary.
2. Checks if `Sync-Clock.ps1` exists:
   - If missing, creates the script to synchronize the system clock.
3. Removes any existing scheduled task named `Sync Clock Hourly` to avoid conflicts.
4. Registers a new scheduled task to:
   - Run `Sync-Clock.ps1` at system startup.
   - Repeat the synchronization every hour.

### Sync-Clock.ps1
- Configures the Windows Time Service (`w32time`) to sync with `time.windows.com`:
  ```powershell
  w32tm /config /manualpeerlist:time.windows.com /syncfromflags:manual /reliable:YES /update
- Restarts the Windows Time Service:
- 
