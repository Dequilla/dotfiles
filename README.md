# My vim config

# Install
## Linux
- Run bash script

## Windows
- Add to vim directory (neovim: Users/{username}/AppData/Local/nvim/) 
- Follow directory structure and create files according to bash-script
### Context Menu (right click)
- Add the following to a .reg file and run to get neovim to right-click menu on Windows.
```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\Neovim]
@="Edit with Neovim"
"Icon"="C:\\Program Files\\Neovim\\bin\\nvim-qt.exe"

[HKEY_CLASSES_ROOT\*\shell\Neovim\command]
@="\"C:\\Program Files\\Neovim\\bin\\nvim.exe\" \"%1\""
```


## For all systems
- Open vim and run :PlugInstall to install and activate all plugins
