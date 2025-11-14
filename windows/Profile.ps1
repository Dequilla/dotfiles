[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Installs for current user -> all hosts:
#   - Put this file: $HOME\Documents\PowerShell\Profile.ps1
#   (Already handle if Install.ps1 is used)

####################
# Visual Studio 2022
#   Allow the usage
#   of msbuild etc.
$vs_path = "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin"
if($env:PATH -notlike "*$vs_path*")
{
    $env:PATH += ";$vs_path"
}

###########################################################
# Compiler DB Generator for Clangd (compiler_commands.json)
#   Used for C++ via Visual Studio but using clangd as LSP
#   allowing any editor that supports clangd to be used
#   instead of Visual Studio.
$cdbg_path = "$env:LOCALAPPDATA\config\compiler-db-generator"
if($env:PATH -notlike "*$cdbg_path*")
{
    $env:PATH += ";$cdbg_path"
}

################################
# Aliases for useful commands

# Move quickly to develop folder
function Move-To-Dev
{ Set-Location -Path "C:\develop" 
}
Set-Alias -Name cddev -Value Move-To-Dev

# Generate compiler db for vs project
function Gen-Compiler-Db($solutiondir)
{
    if($solutiondir -eq "." -or -not $solutiondir)
    {
        $solutiondir = Get-Location
    }

    echo "Searching for solution file in $solutiondir"
    $solutionfile = Get-ChildItem "$solutiondir\*.sln"
    if($solutionfile)
    {
        echo "Found solution file $solutionfile"
        echo "This takes some time, grab some coffee and relax..."
        powershell $cdbg_path\clang-build.ps1 -export-jsondb -aSolutionsPath $solutionfile -aVisualStudioVersion 2022
    } else
    {
        echo "No solution file found in $solutiondir"
        
    }
}
Set-Alias -Name gencdb -Value Gen-Compiler-Db

################
# Custom scripts
$custom_script_path = "$env:LOCALAPPDATA\config\CustomScripts"
function ResetIconCache()
{
    # Stops explorer, deletes "iconcache*.db" files and starts explorer again
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File $custom_script_path\ResetIconCache.ps1" -Verb RunAs
}
Set-Alias -Name resicon -Value ResetIconCache

##########
# Jira-cli
$jira_cli_path = "C:\develop\jira-cli"
if( Test-Path -Path "$jira_cli_path" )
{
    if($env:PATH -notlike "*$jira_cli_path*")
    {
        $env:PATH += ";$jira_cli_path/bin"
    }
}

########################################
# Better tab completion (more unix-like)
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

################
# Terminal Icons
Import-Module -Name Terminal-Icons

#############################
# Oh-my-posh (has to be last)
$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/stelbent-compact.minimal.omp.json" | Invoke-Expression
