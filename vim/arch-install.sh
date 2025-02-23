#!/bin/bash

CONF_HOME=~/.config

# Prerequesits
sudo pacman -S --noconfirm bat the_silver_searcher ripgrep

# Ensure vim is installed
sudo pacman -S --noconfirm neovim

# Setup folders
mkdir -p $CONF_HOME/nvim/autoload $CONF_HOME/nvim/plugged $CONF_HOME/nvim/colors

# Install plugin for handling plugins
curl -fLo $CONF_HOME/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy vimrc to correct location 
cp ./nvim/init.vim $CONF_HOME/nvim/init.vim

nvim +'PlugInstall'
