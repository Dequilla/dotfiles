# Install my windows dotfiles
# We do not add to path, instead Profile.ps1 will add paths to each session, much cleaner

# As similar to XDF_CONFIG_HOME as I could figure out
$install_path = "$env:LOCALAPPDATA"
$install_folder = "config"
$full_install_path = "$install_path\$install_folder"

##################################
# Compiler db generator for Clangd
echo "Installing Visual Studio compiler DB generator for clangd."
if(-not (Test-Path $full_install_path))
{
    New-Item -Path "$install_path" -Name "$install_folder" -ItemType Directory
    Copy-Item -Path "$PSScriptRoot\compiler-db-generator" -Recurse -Destination "$full_install_path" -Container
}

#########################################
# Installs for current user -> all hosts:
#   - Put this file at current-user->Profile.ps1
echo "Installing Profile.ps1 user file."
$profile_file = "Profile.ps1"
$profile_path = $PROFILE.CurrentUserAllHosts 
if(-not (Test-Path "$profile_path\$profile_file"))
{
    New-Item -ItemType File -Path $profile_path -Force
    Copy-Item -Path "$PSScriptRoot\$profile_file" -Destination "$profile_path" -Force
}

##################################
# WezTerm config
echo "Installing WezTerm and it's config."
if( winget list --exact wez.wezterm )
{
    echo "WezTerm is already installed, updating..."
    winget upgrade wez.wezterm
}
else
{
    echo "WezTerm needs to be installed, installing..."
    winget install wez.wezterm
}

$wez_path_dest = "$env:USERPROFILE\.wezterm.lua"
$wez_path_src = "$PSScriptRoot\.wezterm.lua"
Copy-Item -Path "$wez_path_src" -Destination "$wez_path_dest" -Force

##################################
# Posh git prereq. etc.
echo "Installing PoshGit for PowerShell."
if([version]$PSVersionTable.PSVersion -ge [version]5.1)
{
    $allowed_execution_policy = "Unrestricted RemoteSigned"
    $ep = Get-ExecutionPolicy
    if("$allowed_execution_policy" -like "*$ep*") 
    {

        if( -not (PowerShellGet\Get-InstalledModule -Name posh-git) | Out-Null )
        {
            echo "Installing posh git..."
            PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
        }
        else
        {
            echo "Updating posh git..."
            PowerShellGet\Update-Module posh-git 
        }
    }
    else
    {
        echo "Posh git will not install, requires execution policy to be set to 'Unrestricted' or 'RemoteSigned'"
        echo "More information: https://github.com/dahlbyk/posh-git?tab=readme-ov-file#prerequisites"
    }
}

####################
# Git
echo "Setting git default editor to NeoVim..."
git config --global core.editor "nvim"

##########################
# Oh-my-posh
winget install JanDeDobbeleer.OhMyPosh -s winget

################
# Terminal Icons
PowerShellGet\Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force

################
# Reload profile
. "$profile_path"
