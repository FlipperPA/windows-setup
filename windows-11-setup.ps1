# This script sets up Windows 11 the way I like it.
# It should be run in Administrator mode from PowerShell.

# Uninstall the crapware that comes with Windows 10 - leave the Store
Write-Output("Uninstalling all the packaged crapware; we will leave Windows Store so anything can be replaced...")

# Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage
# Get-AppxPackage *Disney* | Remove-AppxPackage

DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename | % {$_ -replace("PackageName : ", "")} | select-string "^((?!WindowsStore).)*$" | ForEach-Object {Remove-AppxPackage -allusers -package $_}

# Uninstall other stuff with winget
winget uninstall onedrive

# Finally, stop and restart explorer.
Get-Process -Name explorer | Stop-Process
start explorer.exe
