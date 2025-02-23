#!/bin/bash

CONF_HOME=~/.config

# Prerequesits
sudo pacman -S --noconfirm bat the_silver_searcher ripgrep

# Ensure vim is installed
sudo pacman -S --noconfirm neovim

# Copy vimrc to correct location 
cp ./nvim/init.lua $CONF_HOME/nvim/init.lua
