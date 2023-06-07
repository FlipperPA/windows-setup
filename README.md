# windows-setup

A PowerShell script to set up a fresh Windows install with the settings I prefer, and remove crapware. You shouldn't run scripts like this without understanding what they do, or if you know and trust the author. This is mainly here for when I'm setting up Windows for a friend, and want a quick setup without the crapware.

[Here are some basic instructions on how to install Windows 11 fresh on a machine](README-windows-setup.md).

## How to Use It

### Windows 11

Be sure you have installed *all* Windows updates to be current. If you are installing fresh, read about how to install with a local account only below.

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/main/windows-11-setup.ps1 -OutFile windows-setup.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-setup.ps1
Set-ExecutionPolicy -Force RemoteSigned
rm .\windows-setup.ps1
```

#### Installing With a Local Account

* During setup, you will come to one of two screens:
    * A `Let's name your device` screen, in which case, name your device and click `Next`.
    * A connect to network screen, in which case, just proceed to the steps below.
* Press Shift + F10 on your keyboard to open the command prompt.
* Enter the command `taskkill /F /IM oobenetworkconnectionflow.exe`, and you should see a `SUCCESS` message.
* Since you have killed Microsoft's telemetry service, you should now be prompted to create a local account with a message, `Who's going to use this device?` Choose your desired username.

#### Taskbar

[This handy app](https://github.com/valinet/ExplorerPatcher) will restore the never-combine style Windows 10 taskbar. Highly recommended!

```
# TeamViewer
winget install "TeamViewer: Remote Control"
```

#### Telemetry and Data Collection

The PowerShell script above is a good start, but [the ShutUp application](https://www.oo-software.com/en/shutup10) is also HIGHLY recommend to shut off the rest of MSFT's Big Brother spyware.

### Windows 10 - Legacy

Start up PowerShell as an admin, then run the follow commands to run the script:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FlipperPA/windows-setup/main/windows-10-setup.ps1 -OutFile windows-setup.ps1
Set-ExecutionPolicy -Force Bypass
.\windows-setup.ps1
Set-ExecutionPolicy -Force RemoteSigned
rm .\windows-10-setup.ps1
```
