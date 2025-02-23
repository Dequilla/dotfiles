#!/bin/bash

CONF_HOME=~/.config

# Prerequesits
# fzf 
sudo apt install bat silversearcher-ag ripgrep

# Ensure vim is installed
sudo apt install -y neovim

# Copy vimrc to correct location 
cp -r ./nvim/init.lua $CONF_HOME/nvim/init.lua
