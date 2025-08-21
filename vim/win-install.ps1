# Install dependencies

# fzf (Fuzzy searching)
# winget install "The Silver Searcher"
# winget install BurntSushi.ripgrep.MSVC

# Allow syntax highlighting in searches for fzf (syntax highlighting overall?)
# winget install sharkdp.bat

$install_path = "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])\nvim\"

# Copy config to correct location
xcopy /s .\nvim\ "$install_path"

# Install Astyle
# Start-Process powershell -Verb RunAs -ArgumentList "-Command cd '$PWD'; .\Windows\AStyle-Install.ps1"
