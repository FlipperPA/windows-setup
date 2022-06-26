# windows-setup

A PowerShell script to set up a fresh Windows install with the settings I prefer, and remove crapware. You shouldn't run scripts like this without understanding what they do, or if you know and trust the author. This is mainly here for when I'm setting up Windows for a friend, and want a quick setup without the crapware.

## How to Use It

### Windows 11

Support is coming soon! If you are installing fresh, read about how to install with a local account only below.

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/main/windows-11-setup.ps1 -OutFile windows-setup.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-setup.ps1
Set-ExecutionPolicy -Force RemoteSigned
rm .\windows-setup.ps1
```

#### Installing With a Local Account

* During setup, you will come to the `Let's name your device` step; name your device and click `Next`.
* Press Shift + F10 on your keyboard to open the command prompt.
* Enter the command `taskkill /F /IM oobenetworkconnectionflow.exe`, and you should see a `SUCCESS` message.
* Since you have killed Microsoft's telemetry service, you should now be prompted to create a local account with a message, `Who's going to use this device?` Choose your desired username.

### Windows 10 - Legacy

Start up PowerShell as an admin, then run the follow commands to run the script:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/main/windows-10-setup.ps1 -OutFile windows-setup.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-setup.ps1
Set-ExecutionPolicy -Force RemoteSigned
rm .\windows-10-setup.ps1
```
