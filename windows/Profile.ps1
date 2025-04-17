[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if( PowerShellGet\Get-InstalledModule posh-git )
{
    echo "Loading posh-git..."
    Import-Module posh-git
}

# Installs for current user -> all hosts:
# - Put this file: $HOME\Documents\PowerShell\Profile.ps1
# (Already handle if Install.ps1 is used)

####################
# Visual Studio 2022
$vs_path = "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin"
if($env:PATH -notlike "*$vs_path*")
{
    $env:PATH += ";$vs_path"
}

###########################################################
# Compiler DB Generator for Clangd (compiler_commands.json)
$cdbg_path = "$env:LOCALAPPDATA\config\compiler-db-generator"
if($env:PATH -notlike "*$cdbg_path*")
{
    $env:PATH += ";$cdbg_path"
}


