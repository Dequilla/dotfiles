# Install dependencies

# Allow syntax highlighting in searches for fzf (syntax highlighting overall?)
# winget install sharkdp.bat

# Install FD for telescope.builtin.find_files
winget install sharkdp.fd

$install_path = "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])\nvim\"

# Copy config to correct location
xcopy /s .\nvim\ "$install_path"

# Lsp server for powershell
# Start-Process powershell -ArgumentList "-Command cd '$PWD'; .\Windows\InstallPowerShellLSP.ps1"
Invoke-Expression -Command $PSScriptRoot\Windows\InstallPowerShellLSP.ps1

# Update helppages tags
nvim --headless -c "lua vim.cmd('helptags ' .. vim.fn.stdpath('config') .. '/doc')" -c "qa"
