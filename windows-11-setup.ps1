# This script sets up Windows 11 the way I like it.
# It should be run in Administrator mode from PowerShell.

Write-Output("Uninstalling all the packaged crapware; we will leave Windows Store so anything can be replaced...")
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename | % {$_ -replace("PackageName : ", "")} | select-string "^((?!WindowsStore).)*$" | ForEach-Object {Remove-AppxPackage -allusers -package $_}

# Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage
# Get-AppxPackage *Disney* | Remove-AppxPackage

Write-Output("Installing Winget package manager...")
Invoke-WebRequest https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile ".\VCLibs.appx"
add-appxpackage -Path ".\VCLibs.appx"
Invoke-WebRequest https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile ".\Winget.msixbundle"
add-appxpackage -Path ".\Winget.msixbundle"

Write-Output("Uninstalling crap we probably don't want, like Teams and OneDrive...")
winget uninstall "Spotify Music"
winget uninstall "Disney+"
winget --accept-package-agreements uninstall onedrive

# Finally, stop and restart explorer.
Get-Process -Name explorer | Stop-Process
start explorer.exe
