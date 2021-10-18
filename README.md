# windows-setup

A PowerShell script to set up a fresh Windows 10 install with the settings I prefer, and remove crapware. You shouldn't run scripts like this without understanding what they do, or if you know and trust the author. This is mainly here for when I'm setting up Windows 10 for a friend, and want a quick setup without the crapware.

## How to Use It

### Windows 10

Start up PowerShell as an admin, then run the follow commands to run the script:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/main/windows-setup.ps1 -OutFile windows-setup.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-10-setup.ps1
Set-ExecutionPolicy -Force RemoteSigned
rm .\windows-10-setup.ps1
```

### Windows 11

Support is coming soon!

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/main/windows-setup.ps1 -OutFile windows-setup.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-11-setup.ps1
Set-ExecutionPolicy -Force RemoteSigned
rm .\windows-11-setup.ps1
```
