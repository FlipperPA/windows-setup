# This script sets up Windows 10 the way I like it.
# It should be run in Administrator mode from PowerShell.

# Uninstall the crapware that comes with Windows 10 - leave the Store
Write-Output("Uninstalling all the packaged crapware; we will leave Windows Store so anything can be replaced...")
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename | % {$_ -replace("PackageName : ", "")} | select-string "^((?!WindowsStore).)*$" | ForEach-Object {Remove-AppxPackage -allusers -package $_}

Write-Host "Unpinning all the nonsense from the start menu..."
$start_menu_layout = @"
<?xml version="1.0" encoding="utf-8"?>
<LayoutModificationTemplate
    xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification"
    xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"
    xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout"
    xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout"
    Version="1">
  <LayoutOptions StartTileGroupCellWidth="6" StartTileGroupsColumnCount="1" />
  <DefaultLayoutOverride LayoutCustomizationRestrictionType="OnlySpecifiedGroups">
    <StartLayoutCollection>
      <defaultlayout:StartLayout GroupCellWidth="6" xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout">
         <start:Group Name="Main" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout">
           <start:DesktopApplicationTile Size="2x2" Column="0" Row="0" DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\Computer.lnk" />
           <start:Tile Size="2x2" Column="2" Row="0" AppUserModelID="Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" />
           <start:Tile Size="2x2" Column="4" Row="0" AppUserModelID="Microsoft.WindowsStore_8wekyb3d8bbwe!App" />
         </start:Group>
      </defaultlayout:StartLayout>
    </StartLayoutCollection>
  </DefaultLayoutOverride>
  <CustomTaskbarLayoutCollection PinListPlacement="Replace">
    <defaultlayout:TaskbarLayout>
      <taskbar:TaskbarPinList>
        <taskbar:UWA AppUserModelID="Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />
        <taskbar:DesktopApp DesktopApplicationLinkPath="%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk" />
      </taskbar:TaskbarPinList>
    </defaultlayout:TaskbarLayout>
  </CustomTaskbarLayoutCollection>
</LayoutModificationTemplate>
"@
Add-content $Env:TEMP\start_menu_layout.xml $start_menu_layout
Import-StartLayout -layoutpath $Env:TEMP\start_menu_layout.xml -mountpath $Env:SYSTEMDRIVE\
Remove-Item $Env:TEMP\start_menu_layout.xml

# Uninstall OneDrive - this is a bit of an adventure...
Write-Output("Uninstalling OneDrive... download it if you want it.")

taskkill.exe /F /IM "OneDrive.exe"

echo "Remove OneDrive"
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Value 1  2>&1 | out-null

Write-Output("Changing registry settings for taskbar, lockscreen, and more...")
# Set the Windows Taskbar to never combine items (Windows 7 style)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Value 2
# Set the Windows Taskbar to use small icons
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' -Value 1
# Disable Cortana Button
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowCortanaButton' -Value 0
# Disable Task View Button
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Value 0
# Don't track or show recent documents
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_TrackDocs' -Value 0
# Show hidden files and folders
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1
# Don't hide file extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 1
# No games shortcut
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_ShowMyGames' -Value 0
# Don't include public folders in search (faster)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_SearchFiles' -Value 1
# Don't show notifications/ads (OneDrive & new feature alerts) in Windows Explorer
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Value 1
# Disable Cortana
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortanaAboveLock' -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowSearchToUseLocation' -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'DisableWebSearch' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'ConnectedSearchUseWeb' -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'ConnectedSearchUseWebOverMeteredConnections' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion' -Name 'ShowSyncProviderNotifications' -Value 1

# Don't show ads / nonsense on the lockscreen
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'ContentDeliveryAllowed' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'RotatingLockScreenEnabled' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'RotatingLockScreenOverlayEnabled' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338387Enabled' -Value 0
# Remove OneDrive Icon
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace' -Name '{018D5C66-4533-4307-9B53-224DE2ED1FE6}'
Set-ItemProperty -Path 'HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Value 0
Set-ItemProperty -Path 'HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Value 0

# Finally, stop and restart explorer.
Get-Process -Name explorer | Stop-Process
start explorer.exe
