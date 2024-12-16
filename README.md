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
```bash
git clone https://github.com/your-username/TimeSync-Automation.git
cd TimeSync-Automation
