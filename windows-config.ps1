# This script sets up Windows 10 the way I like it.
# It should be run in Administrator mode from PowerShell.

# Uninstall the crapware that comes with Windows 10 - leave the Store
Write-Output("Uninstalling all the packaged crapware; leaving the Windows Store...")
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename | % {$_ -replace("PackageName : ", "")} | select-string "^((?!WindowsStore).)*$" | ForEach-Object {Remove-AppxPackage -allusers -package $_}

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

# Finally, stop explorer; it will auto-restart
Get-Process -Name explorer | Stop-Process
