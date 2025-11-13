#Requires -RunAsAdministrator

# Stop explorer
taskkill /f /im explorer.exe
start-sleep -Seconds 3

cd $env:localappdata/Microsoft/Windows/Explorer

del iconcache_*.db
start-sleep -Seconds 3

start explorer.exe
start-sleep -Seconds 3
exit
