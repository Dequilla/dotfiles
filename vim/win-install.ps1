# Install dependencies

# fzf (Fuzzy searching)
winget install "The Silver Searcher"
winget install BurntSushi.ripgrep.MSVC

# Allow syntax highlighting in searches for fzf (syntax highlighting overall?)
winget install sharkdp.bat

# Create directories
# New-Item -ItemType Directory -Force -Path "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/autoload/plug.vim"

# Copy config to correct location
xcopy /s .\nvim\ "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])\nvim\"

# Install Plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/autoload/plug.vim" -Force

# Install plugins
nvim +'PlugInstall'
