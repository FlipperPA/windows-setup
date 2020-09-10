# windows-setup
A PowerShell script to set up a fresh Windows 10 install with the settings I prefer, and remove crapware.

## How to Use It

Start up PowerShell as an admin, then run the follow commands to run the script:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/master/windows-config.ps1 -OutFile windows-config.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-config.ps1
Set-ExecutionPolicy -Force RemoteSigned
```
