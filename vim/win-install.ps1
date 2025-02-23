# Install dependencies

# fzf (Fuzzy searching)
winget install "The Silver Searcher"
winget install BurntSushi.ripgrep.MSVC

# Allow syntax highlighting in searches for fzf (syntax highlighting overall?)
winget install sharkdp.bat

# Copy config to correct location
xcopy /s .\nvim\ "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])\nvim\"
