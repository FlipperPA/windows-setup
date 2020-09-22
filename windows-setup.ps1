# This script sets up Windows 10 the way I like it.
# It should be run in Administrator mode from PowerShell.

# Uninstall the crapware that comes with Windows 10 - leave the Store
Write-Output("Uninstalling all the packaged crapware; we will leave Windows Store so anything can be replaced...")
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename | % {$_ -replace("PackageName : ", "")} | select-string "^((?!WindowsStore).)*$" | ForEach-Object {Remove-AppxPackage -allusers -package $_}

# Uninstall OneDrive - this is a bit of an adventure...
Write-Output("Uninstalling OneDrive... download it if you want it.")

taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"

echo "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive -Name DisableFileSyncNGSC -Value 1

Write-Output("Setting up the taskbar...")
# Set the Windows Taskbar to never combine items (Windows 7 style)
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarGlomLevel -Value 2
# Set the Windows Taskbar to use small icons
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarSmallIcons -Value 1
# Disable Cortana Button
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowCortanaButton -Value 0
# Disable Task View Button
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Value 0
# Don't track or show recent documents
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Start_TrackDocs -Value 0

Write-Output("Setting up the lockscreen...")
Set-ItemProperty -Path HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name ContentDeliveryAllowed -Value 1
Set-ItemProperty -Path HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name RotatingLockScreenEnabled -Value 1
Set-ItemProperty -Path HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name RotatingLockScreenOverlayEnabled -Value 0
Set-ItemProperty -Path HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SubscribedContent-338387Enabled -Value 0

# Finally, stop explorer; it will auto-restart
Get-Process -Name explorer | Stop-Process
